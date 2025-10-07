#include "/lib/all_the_libs.glsl"

uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
    color *= ENCHANT_GLINT_OPACITY;

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}
