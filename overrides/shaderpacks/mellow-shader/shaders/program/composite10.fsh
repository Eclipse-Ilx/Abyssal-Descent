#include "/lib/all_the_libs.glsl"
varying vec2 texcoord;
#include "/global/post/bloom.glsl"

// Blur on x direction

/* DRAWBUFFERS:1 */

void main() {
	gl_FragData[0].rgb = blur(colortex1, texcoord, vec2(1, 0), 0.0625, 0.375);
}
