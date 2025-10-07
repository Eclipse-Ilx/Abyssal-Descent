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
	Color.rgb = to_linear(Color.rgb);
	if (Color.a < 0.1) {
		discard;
	}
	Color.rgb *= TweakedLM;
	vec3 PlayerPos = to_player_pos(ViewPos);
	vec3 ViewPosN = normalize(ViewPos);
	vec3 SkyColor = get_sky_main(ViewPosN, normalize(PlayerPos), get_sun_glare(dot(ViewPosN, sunPosN)));
    Color.rgb = get_fog_main(PlayerPos, Color.rgb, gl_FragCoord.z, SkyColor);

	return Color;
}

/* DRAWBUFFERS:0 */

void main() {
	vec3 ScreenPos = vec3(gl_FragCoord.xy*resolutionInv, gl_FragCoord.z);
	vec3 ViewPos = to_view_pos(ScreenPos, false);

	#ifdef DISTANT_HORIZONS
    vec3 PlayerPos = to_player_pos(ViewPos);

	float Dither = bayer8(gl_FragCoord.xy);
    if (transition_to_dh(PlayerPos, false, Dither)) {
        discard;
        return;
    }
    #endif

	vec3 TweakedLM = tweak_lightmap();

	vec4 Color;
	#ifndef FANCY_WATER
	Color = get_translucent_basic(TweakedLM, ViewPos);
	#else
	if(material == 10002) {
		// glcolor gets set to water color in vsh
		#if WATER_TEXTURE_MODE == 2
		vec4 BaseColor = vec4(glcolor.rgb*TweakedLM, glcolor.a);
		#else
		Color = texture2D(gtexture, texcoord);
		Color.rgb = to_linear(Color.rgb);
		#if WATER_TEXTURE_MODE == 1
		Color.rgb += 0.5;
		Color.a = 1; 
		#endif
		Color.rgb *= TweakedLM;
		vec4 BaseColor = Color * glcolor;
		#endif
		Color = get_fancy_water(ScreenPos, ViewPos, BaseColor, LightmapCoords.y, TBN, false);
	}
	else {
		Color = get_translucent_basic(TweakedLM, ViewPos);
	}
	#endif
	gl_FragData[0] = Color;
}
