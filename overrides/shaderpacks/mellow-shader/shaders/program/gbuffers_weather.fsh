#include "/lib/all_the_libs.glsl"
uniform sampler2D lightmap;
uniform sampler2D gtexture;

varying vec2 texcoord;
varying vec4 glcolor;

#include "/global/lighting.fsh"

/* DRAWBUFFERS:0 */

void main() {
	vec4 Color = texture2D(gtexture, texcoord) * glcolor;
	if (Color.a < 0.1) {
		discard; return;
	}
	Color.rgb = to_linear(Color.rgb);

	vec3 TweakedLM = tweak_lightmap();
	Color.xyz *= TweakedLM;
	

	Color = vec4(apply_saturation(Color.rgb, 0.2), 0.15);
	gl_FragData[0] = Color;
}
