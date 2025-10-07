#include "/lib/all_the_libs.glsl"

#include "/global/sky.glsl"

#ifdef FANCY_CLOUDS
void main() {
	discard;
}
#else
uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
	vec3 ScreenPos = vec3(gl_FragCoord.xy*resolutionInv, gl_FragCoord.z);

	#ifdef DISTANT_HORIZONS
		float DhDepth = texture2D(dhDepthTex, ScreenPos.xy).x;
		if(DhDepth < 1) {
			discard;
			return;
		}
	#endif

	vec4 Color = texture2D(texture, texcoord) * glcolor;
	Color.rgb = to_linear(Color.rgb) * SKY_GROUND * 1.5;

	#ifdef BORDER_FOG
	vec3 ViewPos = to_view_pos(ScreenPos, false);
	vec3 PlayerPos = to_player_pos(ViewPos);

	// No need to do length() here
	float HorizontalDist = len2(PlayerPos.xz);

	// Simplified fog, it doesn't need all of the fogs anyways
	#if MC_VERSION >= 12106
	HorizontalDist /= pow2(VANILLA_CLOUD_DISTANCE * 16);
	#else
	HorizontalDist /= pow2(far);
	#endif
	Color.a *= exp(-3.0 * HorizontalDist);
	Color.a *= 1-max(darknessFactor, blindness);
	#endif

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = Color;
}
#endif
