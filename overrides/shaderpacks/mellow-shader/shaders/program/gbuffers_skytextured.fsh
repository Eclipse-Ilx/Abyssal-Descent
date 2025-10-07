#include "/lib/all_the_libs.glsl"
uniform sampler2D gtexture;

varying vec2 texcoord;
varying vec4 glcolor;

/* DRAWBUFFERS:0 */

void main() {
	#ifndef CUSTOM_SKYBOXES
		#ifdef ROUND_SUN
		discard; return;
		#endif
	#endif	
	vec4 Color = texture2D(gtexture, texcoord) * glcolor;

	Color.rgb = to_linear(Color.rgb);


	#ifdef CUSTOM_SKYBOXES
		Color.rgb *= CUSTOM_SKYBOX_BRIGHTNESS;
	#else
		Color.a = 1-rainStrength/2;
	#endif
	
	gl_FragData[0] = Color;
}
