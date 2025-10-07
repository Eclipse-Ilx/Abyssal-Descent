#include "/lib/all_the_libs.glsl"

varying vec2 texcoord;
void main() {
	gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}
