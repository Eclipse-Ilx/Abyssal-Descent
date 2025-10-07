#include "/lib/all_the_libs.glsl"

uniform sampler2D lightmap;
uniform sampler2D gtexture;

varying vec2 texcoord;
varying vec4 glcolor;

#include "/global/lighting.fsh"

/* DRAWBUFFERS:0 */

void main() {
	gl_FragData[0] = texture2D(gtexture, texcoord) * glcolor;
	if (gl_FragData[0].a < 0.1) {
		discard; return;
	}
}
