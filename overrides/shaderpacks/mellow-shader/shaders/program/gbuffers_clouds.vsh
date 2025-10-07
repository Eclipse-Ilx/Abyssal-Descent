#include "/lib/all_the_libs.glsl"
#include "/global/light_colors.vsh"

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
	#ifdef FANCY_CLOUDS
		gl_Position = vec4(-1);
	#else
		gl_Position = ftransform();
		init_colors();
		texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
		glcolor = gl_Color;
		#if TAA_MODE >= 2
		gl_Position.xy += taaJitter * gl_Position.w;
		#endif
	#endif
}
