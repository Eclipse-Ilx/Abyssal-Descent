#include "/lib/all_the_libs.glsl"
#include "/global/lighting.vsh"

void main() {
	
	init_generic();
	vec3 ViewPos = (gl_ModelViewMatrix * gl_Vertex).xyz;
	vec3 WorldPos = mat3(gbufferModelViewInverse) * ViewPos;
	WorldPos += cameraPosition;

	WorldPos.xz += sin(WorldPos.y/WAVE_SIZE * frameTimeCounter*WAVE_SPEED/100)*RAIN_TILT_STRENGTH;
	
	WorldPos -= cameraPosition;
	WorldPos = mat3(gbufferModelView) * WorldPos;
	gl_Position = gl_ProjectionMatrix * vec4(WorldPos, 1);
}

