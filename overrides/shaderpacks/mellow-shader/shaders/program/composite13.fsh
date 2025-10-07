#include "/lib/all_the_libs.glsl"
#include "/global/post/smaa.glsl"

varying vec2 texcoord;

/* DRAWBUFFERS:2 */

void main() {
    ivec2 GlobalPos = ivec2(gl_FragCoord.xy);

    vec3 Center = texelFetch2D(colortex0, GlobalPos, 0).rgb;
    vec3 Left = texelFetch2D(colortex0, GlobalPos + ivec2(-1, 0), 0).rgb;
    vec3 Up = texelFetch2D(colortex0, GlobalPos + ivec2(0, -1), 0).rgb;

    vec2 D = vec2(redmean(Center, Left), redmean(Center, Up));

    float Threshold = SMAA_THRESHOLD;
    Threshold /= 2 - isOutdoorsSmooth; // Needs to be more sensitive underground
    

    vec2 Edges = step(Threshold, D);

    if(all(lessThan(Edges, vec2(0.01)))) {
        gl_FragData[0] = vec4(0);
        return;
    }

    vec3 Right = texelFetch2D(colortex0, GlobalPos + ivec2(1, 0), 0).rgb;
    vec3 Down = texelFetch2D(colortex0, GlobalPos + ivec2(0, 1), 0).rgb;

    vec3 Left2 = texelFetch2D(colortex0, GlobalPos + ivec2(-2, 0), 0).rgb;
    vec3 Up2 = texelFetch2D(colortex0, GlobalPos + ivec2(0, -2), 0).rgb;

    vec2 Dp = vec2(redmean(Center, Right), redmean(Center, Down));
    vec2 MaxD = max(D, Dp);

    vec2 Dp2 = vec2(redmean(Center, Left2), redmean(Center, Up2));
    MaxD = max(MaxD, Dp2);

    Edges *= step(max(MaxD.x, MaxD.y), D * 2);

    gl_FragData[0] = vec4(Edges, 0, 0);
}
