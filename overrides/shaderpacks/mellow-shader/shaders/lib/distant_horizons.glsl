vec3 dh_noise(vec3 PlayerPos, vec3 Color) {
    vec3 WorldPos = PlayerPos + cameraPosition + gbufferModelViewInverse[3].xyz;
    vec3 NoisePos = floor(WorldPos * DH_NOISE_SIZE + 0.001) / DH_NOISE_SIZE;
    Color *= exp(-random3D(NoisePos) / 4) + 0.104;
    return Color;
}

bool transition_to_dh(vec3 PlayerPos, const bool IsDHPass, float Dither) {
    float Bias = float(IsDHPass) * far / 32; // Needed because of depth imprecision i think
    float Fade = float(!IsDHPass) * Dither * 8;
    return length(PlayerPos) > far - DH_CUTOFF - Bias + Fade;
}

float ld_exact(float depth, bool IsDH) {
    if (!IsDH)
        return (near * far) / (depth * (near - far) + far);
    else
        return (dhNearPlane * dhFarPlane) / (depth * (dhNearPlane - dhFarPlane) + dhFarPlane);
}

float get_depth(vec2 ScreenPos, out bool IsDH) {
    float Depth = texture2D(depthtex0, ScreenPos).x;
    IsDH = false;
    #ifdef DISTANT_HORIZONS
    if (Depth >= 1) {
        Depth = texture2D(dhDepthTex, ScreenPos).x;
        IsDH = true;
    }
    #endif
    return Depth;
}

float get_depth_solid(vec2 ScreenPos, out bool IsDH) {
    float Depth = texture2D(depthtex1, ScreenPos).x;
    IsDH = false;
    #ifdef DISTANT_HORIZONS
    if (Depth >= 1) {
        Depth = texture2D(dhDepthTex1, ScreenPos).x;
        IsDH = true;
    }
    #endif
    return Depth;
}