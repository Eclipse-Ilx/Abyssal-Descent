#include "/lib/all_the_libs.glsl"
#include "/global/post/smaa.glsl"

varying vec2 texcoord;

/* DRAWBUFFERS:0 */

void main() {
    ivec2 Coords = ivec2(gl_FragCoord.xy);
    float L = texelFetch2D(colortex2, Coords, 0).b;
    float R = texelFetch2D(colortex2, Coords + ivec2(1, 0), 0).a;
    float U = texelFetch2D(colortex2, Coords, 0).r;
    float D = texelFetch2D(colortex2, Coords + ivec2(0, 1), 0).g;

    float Sum = L + U + R + D;
    if(Sum > 0.01) {
        bool h = max(L, R) > max(D, U);
        vec4 Offsets = h ? vec4(-L, 0, R, 0) : vec4(0, -U, 0, D);
        vec2 BlendFactor = h ? vec2(L, R) : vec2(U, D);
        BlendFactor /= dot(BlendFactor, vec2(1));

        vec3 FinalColor = vec3(0);
        FinalColor += texture2DLod(colortex0, texcoord + Offsets.xy * resolutionInv, 0).rgb * BlendFactor.x;
        FinalColor += texture2DLod(colortex0, texcoord + Offsets.zw * resolutionInv, 0).rgb * BlendFactor.y;

        gl_FragData[0].rgb = FinalColor;
    }
    else {
        gl_FragData[0] = texture2DLod(colortex0, texcoord, 0);
    }

    // gl_FragData[0] = texture2D(colortex2, texcoord);
}
