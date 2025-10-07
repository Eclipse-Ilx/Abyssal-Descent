#include "/lib/all_the_libs.glsl"
#include "/global/post/smaa.glsl"

varying vec2 texcoord;

/* DRAWBUFFERS:2 */

void main() {
    ivec2 GlobalPos = ivec2(gl_FragCoord.xy);
    vec2 Pos = gl_FragCoord.xy;
    vec2 Texcoord = texcoord;

    vec2 Center = texelFetch2D(colortex2, GlobalPos, 0).rg;

    vec4 Color = vec4(0);

    vec4 PosOffset[3];
    PosOffset[0] = fma(resolutionInv.xyxy, vec4(-0.25, -0.125,  1.25, -0.125), Texcoord.xyxy);
    PosOffset[1] = fma(resolutionInv.xyxy, vec4(-0.125, -0.25, -0.125,  1.25), Texcoord.xyxy);

    PosOffset[2] = fma(resolutionInv.xxyy,
                    vec4(-1.0, 1.0, -1.0, 1.0) * float(SMAA_SEARCH_DISTANCE),
                    vec4(PosOffset[0].xz, PosOffset[1].yw));

    // Up
    if(Center.g > 0) {
        vec3 Coords; vec2 d;
        Coords.x = SMAASearchXLeft(PosOffset[0].xy, PosOffset[2].x);
        Coords.y = PosOffset[1].y;
        d.x = Coords.x;

        float eL = texture2D(colortex2, Coords.xy).r;

        Coords.z = SMAASearchXRight(PosOffset[0].zw, PosOffset[2].y);
        d.y = Coords.z;

        d = abs(round(fma(resolution.xx, d, -Pos.xx)));
        d = sqrt(d);

        float eR = texture2D(colortex2, Coords.zy + ivec2(1, 0) * resolutionInv).r;

        Color.rg = sample_area(d.x, d.y, eL, eR);
    }
    // Left
    if(Center.r > 0) {
        vec3 Coords; vec2 d;
        Coords.y = SMAASearchYUp(PosOffset[1].xy, PosOffset[2].z);
        Coords.x = PosOffset[0].x;
        d.x = Coords.y;

        float eL = texture2D(colortex2, Coords.xy).g;

        Coords.z = SMAASearchYDown(PosOffset[1].zw, PosOffset[2].w);
        d.y = Coords.z;

        d = abs(round(fma(resolution.yy, d, -Pos.yy)));
        d = sqrt(d);

        float eR = texture2D(colortex2, Coords.xz + ivec2(0, 1) * resolutionInv).g;

        Color.ba = sample_area(d.x, d.y, eL, eR);
    }

    gl_FragData[0] = Color;
}
