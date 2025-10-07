#include "/lib/all_the_libs.glsl"

#include "/global/lighting.vsh"

flat varying vec4 glcolor_flat;
void main() {
	
	init_generic();
	#if TAA_MODE >= 2
    gl_Position.xy += taaJitter * gl_Position.w;
    #endif
    glcolor_flat = glcolor;    
}
