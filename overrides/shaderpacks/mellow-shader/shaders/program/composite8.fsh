#include "/lib/all_the_libs.glsl"
#include "/global/post/bloom.glsl"

varying vec2 texcoord;

/* DRAWBUFFERS:1 */

void main() {
	gl_FragData[0].xyz = texture2D(colortex1, texcoord * 0.125 + 0.25).xyz;
}
