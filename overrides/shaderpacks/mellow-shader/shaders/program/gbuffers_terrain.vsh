#include "/lib/all_the_libs.glsl"

#include "/global/lighting.vsh"

void main() {
    init_generic();

    #ifdef WAVY_PLANTS
    if (ViewPos.z > -64) {
        vec3 WorldPos = to_player_pos(ViewPos);
        WorldPos += cameraPosition;
        vec3 WavePos = WorldPos / WAVE_SIZE + frameTimeCounter * WAVE_SPEED;
        WavePos = sin(WavePos);
        float Noise = WavePos.x * WavePos.y * WavePos.z;
        Noise *= WAVE_AMPLITUDE + rainStrength * 0.1;
        #ifdef WAVE_LEAVES
        if (material == 10003) {
            WorldPos.x += Noise / 2;
            WorldPos.zy -= Noise / 2;
        }
        else
        #endif
        if (material == 10004) {
            if (gl_MultiTexCoord0.t < mc_midTexCoord.t)
                WorldPos += Noise;
        }
        else if (material == 10005) {
            if (gl_MultiTexCoord0.t < mc_midTexCoord.t)
                WorldPos += Noise / 2;
        }
        else if (material == 10006) {
            if (gl_MultiTexCoord0.t > mc_midTexCoord.t)
                WorldPos += Noise / 2;
            else
                WorldPos += Noise;
        }

        WorldPos -= cameraPosition;
        WorldPos = mat3(gbufferModelView) * WorldPos;
        gl_Position = gl_ProjectionMatrix * vec4(WorldPos, 1);
    }
    #endif

    #if TAA_MODE >= 2
    gl_Position.xy += taaJitter * gl_Position.w;
    #endif
}
