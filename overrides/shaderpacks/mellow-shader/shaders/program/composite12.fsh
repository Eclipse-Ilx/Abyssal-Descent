#include "/lib/all_the_libs.glsl"

varying vec2 texcoord;

#include "/global/post/taa.glsl"

#if TAA_MODE != 0 || REFLECTIONS >= 2
/* DRAWBUFFERS:04 */
#else
/* DRAWBUFFERS:0 */
#endif

// Color grading, Bloom final, TAA final

vec3 motion_blur(vec3 Color, vec2 PrevCoord, vec2 CurrentCoord) {
    vec2 Velocity = PrevCoord - CurrentCoord;
    vec2 Offset = Velocity / 4 * MOTION_BLUR_STRENGTH;
    Offset *= 0.01666 / frameTime; // Adjust based on framerate. 60 fps is the baseline
    vec3 Blur = Color;

    float Noise = bayer8(gl_FragCoord.xy);
    CurrentCoord += Offset * Noise;

    for (int i = 1; i < 4; i++) {
        Blur += texture2D(colortex0, CurrentCoord).rgb;
        CurrentCoord += Offset;
    }
    return Blur / 4;
}

void main() {
    vec4 Color = texture2D(colortex0, texcoord);

    #if TAA_MODE != 0 || defined MOTION_BLUR
    bool IsDH;
    float Depth = get_depth_solid(texcoord, IsDH);
    vec2 PrevCoord = toPrevScreenPos(texcoord, Depth, IsDH);
    #endif

    #ifdef MOTION_BLUR
    if (Depth >= 0.56) {
        Color.rgb = motion_blur(Color.rgb, PrevCoord, texcoord);
    }
    #endif

    #if TAA_MODE != 0
    gl_FragData[1].xyz = TAA(Color.rgb, vec3(texcoord, Depth), PrevCoord, IsDH);
    #elif REFLECTIONS >= 2
    gl_FragData[1] = Color;
    #endif

    Color.rgb *= EXPOSURE;
    Color.rgb = apply_tonemap(Color.rgb);

    #if TONEMAP_OPERATOR != 3
    Color.rgb = pow(Color.rgb, vec3(1 / 2.2)); // Gamma correction
    #endif

    #if DEBUG_SHOW_BUFFER == 0
    gl_FragData[0] = Color;
    #elif DEBUG_SHOW_BUFFER == 1
    gl_FragData[0] = texelFetch2D(colortex1, ivec2(gl_FragCoord.xy), 0);
    #elif DEBUG_SHOW_BUFFER == 2
    gl_FragData[0] = texelFetch2D(noisetex, ivec2(gl_FragCoord.xy), 0);
    #elif DEBUG_SHOW_BUFFER == 3
    gl_FragData[0] = texelFetch2D(depthtex0, ivec2(gl_FragCoord.xy), 0);
    #else
    gl_FragData[0] = texelFetch(gaux1, ivec2(gl_FragCoord.xy), 0);
    #endif
}