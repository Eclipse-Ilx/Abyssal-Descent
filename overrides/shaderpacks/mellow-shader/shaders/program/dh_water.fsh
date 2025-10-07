#define DH_TERRAIN

#include "/lib/all_the_libs.glsl"
uniform sampler2D lightmap;
uniform sampler2D gtexture;

varying vec2 texcoord;
varying vec4 glcolor;
varying vec2 LightmapCoords;

#include "/global/lighting.fsh"
#include "/global/sky.glsl"
#include "/global/fog.glsl"

flat varying mat3 TBN;
#include "/global/water.glsl"

vec4 get_translucent_basic(vec3 TweakedLM, vec3 ViewPos) {
    vec4 Color = glcolor * texture2D(gtexture, texcoord);
    
    if (Color.a < 0.1) {
        discard;
    }

    vec3 PlayerPos = to_player_pos(ViewPos);
    
    #ifdef DH_NOISE
        Color.rgb = dh_noise(PlayerPos, Color.rgb);
    #endif

    Color.rgb = to_linear(Color.rgb);
    Color.rgb *= TweakedLM;
    
    vec3 ViewPosN = normalize(ViewPos);
    vec3 SkyColor = get_sky_main(ViewPosN, normalize(PlayerPos), get_sun_glare(dot(ViewPosN, sunPosN)));
    Color.rgb = get_fog_main(PlayerPos, Color.rgb, gl_FragCoord.z, SkyColor);

    return Color;
}

/* DRAWBUFFERS:0 */

void main() {

    vec3 ScreenPos = vec3(gl_FragCoord.xy*resolutionInv, gl_FragCoord.z);
    vec3 ViewPos = to_view_pos(ScreenPos, true);
    vec3 PlayerPos = to_player_pos(ViewPos);

    float Dither = bayer8(gl_FragCoord.xy);
    if (!transition_to_dh(PlayerPos, true, Dither)) {
        discard;
        return;
    }

    float Depth = texture2D(depthtex0, ScreenPos.xy).x;

    if(Depth < 1) {
        discard; return;
    }

    vec3 TweakedLM = tweak_lightmap();
    vec4 Color;
    #ifndef FANCY_WATER
    Color = get_translucent_basic(TweakedLM, ViewPos);
    #else
    if(material == 10002) {
        Color = get_fancy_water(ScreenPos, ViewPos, vec4(glcolor.rgb*TweakedLM, glcolor.a), LightmapCoords.y, TBN, true);
    }
    else {
        Color = get_translucent_basic(TweakedLM, ViewPos);
    }
    #endif

    gl_FragData[0] = Color;

}
