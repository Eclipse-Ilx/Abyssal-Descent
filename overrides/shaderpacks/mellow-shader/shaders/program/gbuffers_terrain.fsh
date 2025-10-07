#include "/lib/all_the_libs.glsl"

uniform sampler2D lightmap;
uniform sampler2D gtexture;

varying vec2 texcoord;
varying vec4 glcolor;

#include "/global/lighting.fsh"

/* DRAWBUFFERS:0 */

void main() {

    #ifdef DISTANT_HORIZONS
    vec3 ScreenPos = vec3(gl_FragCoord.xy*resolutionInv, gl_FragCoord.z);
	vec3 ViewPos = to_view_pos(ScreenPos, false);
    vec3 PlayerPos = to_player_pos(ViewPos);

    float Dither = bayer8(gl_FragCoord.xy);
    if (transition_to_dh(PlayerPos, false, Dither)) {
        discard;
        return;
    }
    #endif

    vec4 Color = texture2D(gtexture, texcoord) * glcolor;
    Color.rgb = to_linear(Color.rgb);

    vec3 TweakedLM = tweak_lightmap();
    Color.xyz *= TweakedLM;
    gl_FragData[0] = Color;
}
