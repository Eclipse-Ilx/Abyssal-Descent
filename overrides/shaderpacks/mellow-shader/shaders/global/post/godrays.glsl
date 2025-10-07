vec3 trace_godrays(vec3 ScreenPos, vec3 LightPos, vec3 LightColor, float Dither, bool IsDH) {
    vec3 LightPosScreen = view_screen(LightPos, IsDH);
    float Falloff = distance(LightPosScreen.xy, ScreenPos.xy);
    if (Falloff > 1) return vec3(0);
    Falloff = 1 - Falloff;

    LightColor *= pow4(Falloff);

    // Trace
    vec3 Step = (LightPosScreen - ScreenPos) / GODRAYS_QUALITY;
    float Att = length(Step);
    vec3 ExpectedPos = ScreenPos + Step * Dither;
    float LightFactor = 0;
    for (int i = 1; i <= GODRAYS_QUALITY; i++) {
        float RealDepth = get_depth(ExpectedPos.xy, IsDH);
        LightFactor += step(1.0, RealDepth);
        
        ExpectedPos += Step;
    }
    const float SettingsFactor = 1.0 / GODRAYS_QUALITY * GODRAYS_STRENGTH;
    return LightColor * LightFactor * SettingsFactor;
}

vec3 godrays(vec3 ScreenPos, float Dither, bool IsDH) {
    vec3 Scattering;
    if (sunPosN.z < 0) {
        const vec3 SUN_GLARE = to_linear(vec3(0.7, 0.45, 0.0));
        vec3 SunColor = (SUN_DIRECT * dayStrength / 4 + SUN_GLARE * (sunsetStrength + sunriseStrength));
        Scattering = trace_godrays(ScreenPos, sunPosN, SunColor, Dither, IsDH);
    }
    else { // Moon
        vec3 MoonColor = (SUN_DIRECT * nightStrength / 3);
        Scattering = trace_godrays(ScreenPos, -sunPosN, MoonColor, Dither, IsDH);
    }
    Scattering = tint_underwater(Scattering);
    Scattering *= 1 - max(darknessFactor, blindness);

    return Scattering;
}
