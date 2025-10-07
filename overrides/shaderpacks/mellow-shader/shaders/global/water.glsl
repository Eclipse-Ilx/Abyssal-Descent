// Very simple and inaccurate, but it's better than nothing.
float water_fog() {
    vec2 ScreenPos = gl_FragCoord.xy * resolutionInv;
    float TerrainDepth = texture2D(depthtex1, ScreenPos).x;
    TerrainDepth = linearize_depth(TerrainDepth);
    float ScreenDepth = linearize_depth(gl_FragCoord.z);
    return smoothstep(0, 48, TerrainDepth - ScreenDepth) * WATER_FOG_STRENGTH;
}

vec3 tint_underwater(vec3 FinalColor) {
    if (isEyeInWater == 1) {
        vec3 WaterColor = to_linear(vec3(f_WATER_RED, f_WATER_GREEN, f_WATER_BLUE));
        WaterColor = mix_preserve_c1lum(WaterColor, fogColor, f_BIOME_WATER_CONTRIBUTION);
        float DistFromSurface = 1 - eyeBrightnessSmooth.y / 240.;
        vec3 Tinted = WaterColor * DistFromSurface;
        FinalColor = mix_preserve_c1lum(FinalColor, WaterColor, DistFromSurface);
    }
    return FinalColor;
}

float schlick(vec3 V, vec3 N) {
    const float R = 0.1;
    float Theta = clamp(1 - dot(-V, N), 0, 1);
    return R + (1 - R) * (pow(Theta, 5.0));
}

vec3 get_water_normal(vec2 Coords, vec3 WorldNormal) {
    if (abs(WorldNormal.y) < 0.99) {
        Coords -= frameTimeCounter * normalize(WorldNormal.xz) * 3;
    }
    vec2 N = noise_water(Coords);
    return normalize(vec3(N.x, N.y, 1 - (N.x * N.x + N.y * N.y)));
}

vec3 sky_reflection(vec3 ReflectedVec, float WNy, float Dist) {
    #ifdef DIMENSION_OVERWORLD
            vec3 SunGlare = get_sun_glare(Dist);
            vec3 Reflection = get_sky(ReflectedVec, SunGlare);
        #ifdef REFLECT_SUN
            if (WNy > 0.01) { // Prevent sun from being reflected on sides of blocks
                Reflection.rgb += round_sun(Dist) * 4 * isOutdoorsSmooth;
            }
    #endif
        return Reflection;
    #else
        return fogColor.rgb;
    #endif
}

vec3 ssr(vec3 RVec, float Dist, vec3 ViewPos, float Fresnel, float WNy, bool IsDH) {
    vec3 ScreenPos = vec3(gl_FragCoord.xy * resolutionInv, gl_FragCoord.z);
    // Convert RVec to screenspace
    vec3 Offset = normalize(view_screen(ViewPos + RVec, IsDH) - ScreenPos);
    vec3 Len = (step(0, Offset) - ScreenPos) / Offset;
    float MinLen = min(Len.x, min(Len.y, Len.z)) / SSR_STEPS;
    Offset *= MinLen;

    float Noise = dither(gl_FragCoord.xy);
    vec3 ExpectedPos = ScreenPos + Offset * Noise;
    for (int i = 1; i <= SSR_STEPS; i++) {
        float RealDepth = get_depth_solid(ExpectedPos.xy, IsDH);
        if (RealDepth < 0.56) {
            break;
        }

        if (ExpectedPos.z > RealDepth) {
            // Depth based rejection
            if (ExpectedPos.z - RealDepth > Offset.z * 4) {
                break;
            }

            // Binary refinement
            for (int j = 1; j <= int(round(Fresnel * 3)); j++) {
                Offset /= 2;
                vec3 EPos1 = ExpectedPos - Offset;
                float RDepth1 = get_depth_solid(EPos1.xy, IsDH);
                if (EPos1.z > RDepth1) {
                    ExpectedPos = EPos1;
                }
            }
            return texture2D(gaux1, ExpectedPos.xy).rgb;
        }
        ExpectedPos += Offset;
    }
    return sky_reflection(RVec, WNy, Dist);
}

vec3 flipped_image_ref(vec3 RVec, float Dist, vec3 ViewPos, float WNy, bool IsDH) {
    #ifdef DISTANT_HORIZONS
    float Offset = min(1000, 50 + dhRenderDistance / 4);
    #else
    float Offset = 50 + far / 4;
    #endif

    vec3 SamplePos = view_screen(ViewPos + RVec * Offset, IsDH);
    if(SamplePos.xy == clamp(SamplePos.xy, 0, 1)) {
        bool IsDH2;
        float RealDepth = get_depth_solid(SamplePos.xy, IsDH);
        if(SamplePos.z < 1 && SamplePos.z > 0.56 && RealDepth < SamplePos.z) {
            SamplePos.z = RealDepth;
            vec3 ViewPosReal = to_view_pos(SamplePos, IsDH);
            if(len2(ViewPosReal) + 25 > len2(ViewPos)) {
                return texture2D(gaux1, SamplePos.xy).rgb;
            }
        }
    }
    return sky_reflection(RVec, WNy, Dist);
}

vec4 get_fancy_water(vec3 ScreenPos, vec3 ViewPos, vec4 BaseColor, float SkyBrightness, mat3 TBN, bool IsDH) {
    #ifndef DISTANT_HORIZONS
        if (isEyeInWater == 0) {
            BaseColor.a = min(BaseColor.a + water_fog(), 1);
        }
    #endif
    vec3 ViewPosN = normalize(ViewPos);
    vec3 PlayerPos = to_player_pos(ViewPos);

    #if REFLECTIONS != 0
        vec3 WorldNormal = to_player_pos(TBN[2]);
        #ifdef WATER_NORMALS
            vec3 NormalMap = get_water_normal(PlayerPos.xz + cameraPosition.xz, WorldNormal);
            vec3 WaterNormal = TBN * NormalMap;
        #else
            vec3 WaterNormal = TBN[2];
        #endif

        vec3 ReflectedVec = reflect(ViewPosN, WaterNormal);
        float Dist = dot(ReflectedVec, sunPosN);
        float Fresnel = schlick(ViewPosN, WaterNormal) * SkyBrightness;

        if (WorldNormal.y > -0.01) { // Prevent reflections underwater and other weird scenarios
            #if REFLECTIONS == 1
                vec3 Reflection = sky_reflection(ReflectedVec, WorldNormal.y, Dist);
            #elif REFLECTIONS == 2
                vec3 Reflection = ssr(ReflectedVec, Dist, ViewPos, Fresnel, WorldNormal.y, IsDH);
            #else
                vec3 Reflection = flipped_image_ref(ReflectedVec, Dist, ViewPos, WorldNormal.y, IsDH);
            #endif
            BaseColor.rgb = mix(BaseColor.rgb, Reflection, Fresnel);
        }
    #endif

    vec3 SkyColor = get_sky(ViewPosN, get_sun_glare(dot(ViewPosN, sunPosN)));
    BaseColor.rgb = get_fog_main(PlayerPos, BaseColor.rgb, gl_FragCoord.z, SkyColor);
    return BaseColor;
}
