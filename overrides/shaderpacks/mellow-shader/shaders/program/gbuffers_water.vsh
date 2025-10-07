#include "/lib/all_the_libs.glsl"
#include "/global/lighting.vsh"

flat varying mat3 TBN;
attribute vec4 at_tangent;

void main() {
    init_generic();

    #if WATER_TEXTURE_MODE == 1 || WATER_TEXTURE_MODE == 2
    // transfer water color through glcolor. should be faster
    if(material == 10002) {
        const vec4 BaseColor = vec4(f_WATER_RED, f_WATER_GREEN, f_WATER_BLUE, f_WATER_ALPHA);
        glcolor.rgb = mix_preserve_c1lum(BaseColor.rgb, glcolor.rgb, f_BIOME_WATER_CONTRIBUTION);
        glcolor.rgb = to_linear(glcolor.rgb);
        glcolor.a = BaseColor.a;
    }
    #else
    glcolor.rgb = to_linear(glcolor.rgb);
    #endif

    #ifdef WAVY_PLANTS
    if (ViewPos.z > -64 && material == 10002) {
        vec3 WorldPos = to_player_pos(ViewPos);
        WorldPos += cameraPosition;

        if (fract(WorldPos.y + 0.005) > 0.15) {
            vec3 WavePos = WorldPos / WAVE_SIZE + frameTimeCounter * WAVE_SPEED;
            WavePos = sin(WavePos);
            float Noise = WavePos.x * WavePos.y * WavePos.z;
            Noise *= 0.05 + rainStrength * 0.1;

            WorldPos.y += Noise;

            WorldPos -= cameraPosition;
            WorldPos = mat3(gbufferModelView) * WorldPos;
            gl_Position = gl_ProjectionMatrix * vec4(WorldPos, 1);
        }
    }
    #endif

    vec3 binormal = normalize(gbufferModelView[2].xyz);
    vec3 tangent = normalize(gbufferModelView[0].xyz);
    TBN = mat3(tangent, binormal, Normal);

    #if TAA_MODE >= 2
    gl_Position.xy += taaJitter * gl_Position.w;
    #endif
}
