float fogify(float x, float w) {
    return w / (x * x + w);
}

vec3 round_sun(float Dist) {
    Dist = Dist * 0.5 + 0.5;
    const vec3 SUN_COLOR = vec3(5, 3.5, 0.8);
    const vec3 MOON_COLOR = vec3(1, 1.5, 2.5);
    float What = sunriseStrength + sunsetStrength;
    vec3 Color = SUN_COLOR * (1 - smoothstep(0., 0.0015, 1 - Dist)) * (dayStrength + What);
    Color += MOON_COLOR * (smoothstep(0.9995, 1., 1 - Dist)) * (nightStrength + What);
    return Color;
}

vec3 get_sun_glare(float Dist) {
    const vec3 SUN_GLARE = to_linear(vec3(f_SUN_GLARE_R, f_SUN_GLARE_G, f_SUN_GLARE_B));

    vec3 SunGlare = SUN_GLARE * (1 - rainStrength * RAIN_SKY_DARKENING);
    float Visibility = sunsetStrength + sunriseStrength;

    return SunGlare * (Dist * 0.5 + 0.5) * Visibility;
}


vec3 get_clouds(vec3 ViewPosN, vec3 PlayerPos, vec3 PlayerPosN, vec3 SunGlare, vec3 SkyColor) {
    vec2 CloudPos = PlayerPos.xz / (PlayerPos.y + length(PlayerPos.xz) / 6);

    const float ACTUAL_CLOUD_SPEED = CLOUD_SPEED / 100.;
    float Animation = float(frameTimeCounter) * ACTUAL_CLOUD_SPEED;
    CloudPos += cameraPosition.xz / 512;
    CloudPos = (CloudPos + Animation) * 32;

    float Noise = fbm_clouds(CloudPos, CLOUD_QUALITY);
    float CloudAmount = CLOUD_AMOUNT / 100.0 + rainStrength / 10;
    Noise *= smoothstep(0, 0.4 - CLOUD_OPACITY, Noise - 0.55 + CloudAmount);
    Noise *= smoothstep(0.0, 0.2, PlayerPosN.y);

    // Ultimate RTX raytraced ptgi 2000 cloud lighting
    const float DENSITY = 1.5;
    float Transmittance = exp(-Noise * DENSITY);
    float Absorbtion = fbm_clouds(CloudPos + to_player_pos(sunOrMoonPosN).xz * 8, 2);
    Absorbtion = pow4(Absorbtion * 2);

    float LHeight = sin(sunAngleAtHome * PI * 2);
    vec3 CloudColorRaw = (SKY_GROUND * 2 + SunGlare);
    vec3 CloudColor = CloudColorRaw * 0.25 / PI;

    float VdotL = dot(ViewPosN, sunOrMoonPosN);
    float MiePhase = max(xlf_phase(VdotL, 0.8) * 1.5, 1 / PI);
    CloudColor += SUN_DIRECT * MiePhase * exp(-Absorbtion * DENSITY);

    return SkyColor * Transmittance + CloudColor * Noise * DENSITY;
}

vec3 get_sky(vec3 ViewPosN, vec3 SunGlare) {
    float upDot = dot(ViewPosN, gbufferModelView[1].xyz) + 0.1; //not much, what's up with you?

    vec3 MixedColor = mix(SKY_TOP, SKY_GROUND + SunGlare, fogify(max(upDot, 0.0), 0.03));
    return MixedColor;
}

float get_stars(vec3 PlayerPos) {
    vec3 StarCoord = PlayerPos / (PlayerPos.y + length(PlayerPos.xz));
    StarCoord.x += frameTimeCounter * 0.001;
    const float ACTUAL_STAR_SIZE = STAR_SIZE * 512;
    StarCoord = floor(StarCoord * ACTUAL_STAR_SIZE) / ACTUAL_STAR_SIZE;

    float Visibility = smoothstep(0, 0.1, StarCoord.y); // Smoothly fade out stars near the bottom of the sky
    #ifdef DIMENSION_OVERWORLD
    Visibility *= nightStrength;
    #endif
    return max(0, random(StarCoord.xz) - 0.996) * 50 * Visibility * STAR_STRENGTH;
}

vec3 get_aurora(vec3 PlayerPosN, float Dither) {
    float AuroraStrength = AURORA_STRENGTH * nightStrength;
    #ifndef AURORA_EVERYWHERE
        AuroraStrength *= precipitationSmooth - 1;
    #endif
    if(precipitationSmooth <= 0.01) return vec3(0);

    const vec3 COLOR_TOP = pow(vec3(28, 255, 218) / 255.0, vec3(2.2));
    const vec3 COLOR_BOTTOM = pow(vec3(122, 255, 28) / 255.0, vec3(2.2));

    // Calculate intersection with aurora plane
    const float PLANE_TOP = 10.0 + AURORA_HEIGHT;
    const float PLANE_BOTTOM = 10.0;

    vec3 StartPos = PLANE_BOTTOM / PlayerPosN.y * PlayerPosN; 
    vec3 EndPos = PLANE_TOP / PlayerPosN.y * PlayerPosN;

    const int SAMPLE_COUNT = 2;

    vec3 Step = (EndPos - StartPos) / SAMPLE_COUNT;
    vec3 Pos = Step * Dither + StartPos;

    vec2 Wind = frameTimeCounter * vec2(0.25, 0.33);

    vec3 AuroraColor = vec3(0);
    for(int i = 1; i <= SAMPLE_COUNT; i++) {
        float Noise = texture2D(noisetex, (Pos.xz - Wind) / vec2(100, 200)).r;

        Noise = pow2(pow4(Noise));
        Noise *= smoothstep(0.0, 0.2, PlayerPosN.y);
        AuroraColor += Noise * mix(COLOR_BOTTOM, COLOR_TOP, smoothstep(0, 1, Dither));

        Pos += Step;
    }

    return AuroraColor * AuroraStrength / SAMPLE_COUNT;
}

vec3 get_end_sky(vec3 pos, vec3 PlayerPos) {
    const vec3 SkyT = to_linear(vec3(f_END_SKY_T_R, f_END_SKY_T_G, f_END_SKY_T_B));
    const vec3 SkyG1 = to_linear(vec3(f_END_AURORA1_R, f_END_AURORA1_G, f_END_AURORA1_B));
    const vec3 SkyG2 = to_linear(vec3(f_END_AURORA2_R, f_END_AURORA2_G, f_END_AURORA2_B));
    float upDot = dot(pos, gbufferModelView[1].xyz); //not much, what's up with you?
    vec2 RotPos1 = rotate(PlayerPos.xz, frameTimeCounter * 0.02);
    vec2 RotPos2 = rotate(PlayerPos.xz, -frameTimeCounter * 0.007);
    float Noise1 = fbm_fast(RotPos1 * 160, 2) * (1 - abs(upDot));
    float Noise2 = fbm_fast(RotPos2 * 280, 2) * (1 - abs(upDot));
    float Noise = (Noise1 + Noise2);
    vec3 SkyG = SkyG1 * Noise1 + SkyG2 * Noise2;
    vec3 Final = SkyT + SkyG * (fogify(upDot + 0.2, 0.05));
    Final *= max(1 - fogify(max(upDot + 0.3, 0), 0.02), 0.01);
    return Final;
}

vec3 get_sky_main(vec3 ViewPosN, vec3 PlayerPosN, vec3 SunGlare) {
    #ifdef DIMENSION_OVERWORLD
        vec3 SkyColor = get_sky(ViewPosN, SunGlare);
    #elif defined DIMENSION_END
        vec3 SkyColor = get_end_sky(ViewPosN, PlayerPosN);
    #else
        vec3 fogColorL = to_linear(fogColor.rgb);
        vec3 SkyColor = mix(fogColorL, normalize(fogColorL), 0.4) / 3;
    #endif

    return SkyColor;
}
