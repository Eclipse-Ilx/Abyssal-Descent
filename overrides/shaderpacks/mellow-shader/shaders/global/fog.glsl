vec3 get_lava_fog(float dist, vec3 color) {
    const vec3 LAVA_FOG_COLOR = to_linear(vec3(0.65, 0.35, 0.125));
    const vec3 PSNOW_FOG_COLOR = to_linear(vec3(0.5, 0.6, 0.8));

    if (isEyeInWater == 1) {
        vec3 UnderwaterCol = to_linear(vec3(f_WATER_RED, f_WATER_GREEN, f_WATER_BLUE))*(SKY_GROUND+SKY_TOP);
        UnderwaterCol = mix_preserve_c1lum(UnderwaterCol, fogColor, f_BIOME_WATER_CONTRIBUTION);
        dist = clamp(dist / 64, 0, 1);
        return mix(color, UnderwaterCol, dist);
    }
    else if (isEyeInWater == 2) {
        dist = clamp(dist / 2, 0, 1);
        return mix(color, LAVA_FOG_COLOR, dist);
    }
    else if (isEyeInWater == 3) {
        dist = clamp(dist / 2, 0, 1);
        return mix(color, PSNOW_FOG_COLOR, dist);
    }
    return color;
}

vec3 get_border_fog(float strength, vec3 color, vec3 SkyColor) {
    strength *= strength;
    #ifndef DIMENSION_NETHER
    strength *= strength;
    strength *= strength;
    #endif
    strength = exp(-3.0 * strength);
    return mix(SkyColor, color, strength);
}

vec3 get_blindness_fog(float Dist, vec3 Color) {
    Dist = clamp(1.0 - exp(-3.0 * Dist / 10), 0, 1) * max(darknessFactor, blindness);
    return Color * (1 - Dist);
}

vec3 get_atm_fog(float Dist, vec3 Color, vec3 WorldPos, vec3 FogColor) {
    Dist = min(Dist / 256, 1);
    Dist = 1.0 - exp(-3.0 * Dist);
    float Visibility = sunriseStrength * 0.5 + nightStrength;
    Visibility = max(Visibility, rainStrength) * isOutdoorsSmooth;
    Visibility *= ATM_FOG_STRENGTH;

    Visibility *= 1 - fbm_fast(WorldPos.xz, 1);

    float HeightFalloff = WorldPos.y >= 50 ? smoothstep(50, 70, WorldPos.y) - smoothstep(70, 120, WorldPos.y) : 0;

    float Factor = Dist * HeightFalloff * Visibility;
    vec3 FinalC = mix(Color, FogColor, Factor);
    return FinalC;
}

vec3 get_fog_main(vec3 PlayerPos, vec3 Color, float Depth, vec3 SkyColor) {
    float Dist = length(PlayerPos);

    if (Depth < 1) {
        #if defined DIMENSION_OVERWORLD && defined ATMOSPHERIC_FOG
        if(isEyeInWater == 0)
            Color.rgb = get_atm_fog(Dist, Color.rgb, PlayerPos + cameraPosition, SkyColor);
        #endif
        #if defined BORDER_FOG && !defined CUSTOM_SKYBOXES
            #ifdef DISTANT_HORIZONS
                Color.rgb = get_border_fog(Dist / dhRenderDistance, Color.rgb, SkyColor);
            #else
                Color.rgb = get_border_fog(Dist / far, Color.rgb, SkyColor);
            #endif
        #endif
    }
    Color.rgb = get_lava_fog(Dist, Color.rgb);
    Color.rgb = get_blindness_fog(Dist, Color.rgb);
    return Color;
}
