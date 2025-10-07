
#define to_linear(sRGB) ( sRGB * (sRGB * (sRGB * 0.305306011 + 0.682171111) + 0.012522878) )

vec3 apply_tonemap(vec3 X) {
    #if TONEMAP_OPERATOR == 1
    return ACESFilm(X);
    #elif TONEMAP_OPERATOR == 2
    return reinhard_jodie(X);
    #elif TONEMAP_OPERATOR == 3
    return ACES_slow(X);
    #elif TONEMAP_OPERATOR == 4
    return Hejl2015(X);
    #endif
}

vec3 apply_saturation(vec3 Color, float Sat) {
    float luminance = get_luminance(Color);
    return mix(vec3(luminance), Color, Sat);
}

vec3 apply_vibrance(vec3 color, float intensity) {
    float mn = min(color.r, min(color.g, color.b));
    float mx = max(color.r, max(color.g, color.b));
    float sat = (1.0 - clamp(mx - mn, 0, 1)) * clamp(1.0 - mx, 0, 1) * get_luminance(color) * 5.0;
    vec3 lightness = vec3((mn + mx) * 0.5);

    return mix(color, mix(lightness, color, intensity), sat);
}

vec3 apply_contrast(vec3 color, float contrast) {
    return (color - 0.5) * contrast + 0.5;
}

// Mix colors, preserving the luminance of c1
vec3 mix_preserve_c1lum(vec3 C1, vec3 C2, float Weight) {
    float L1 = get_luminance(C1);

    vec3 CMixed = mix(C1, C2, Weight);
    float L = get_luminance(CMixed);

    float Scale = L1 / L;

    return CMixed * Scale;
}
