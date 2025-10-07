#include "/lib/all_the_libs.glsl"
varying vec2 texcoord;

#include "/global/post/bloom.glsl"

/* DRAWBUFFERS:0 */

void main() {
    vec4 Color = texture2D(colortex0, texcoord);

    #ifdef BLOOM
    float Offset = 0;
    vec3 FinalBloom = vec3(0);
    for (int i = 2; i < 5; i++) {
        FinalBloom += texture2D(colortex1, texcoord / exp2(i) + Offset).xyz;
        Offset += 1 / exp2(i);
    }
    FinalBloom /= 3;

    float BloomFactor = pow(get_luminance(FinalBloom), BLOOM_CURVE);
    BloomFactor += 0.2 * rainStrength * isOutdoorsSmooth;
    vec2 EdgeFade = smoothstep(0.02, 0.05, texcoord) * (1 - smoothstep(0.95, 0.98, texcoord));
    BloomFactor *= EdgeFade.x * EdgeFade.y;

    Color.rgb = mix(Color.rgb, FinalBloom, BloomFactor * BLOOM_STRENGTH);
    #endif

    gl_FragData[0] = Color;
}
