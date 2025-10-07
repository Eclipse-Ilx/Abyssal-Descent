#include "/lib/all_the_libs.glsl"
#include "/global/lighting.vsh"

flat varying mat3 TBN;
attribute vec4 at_tangent;

void main() {
    init_generic();

    if(dhMaterialId == DH_BLOCK_WATER) {
        material = 10002;

        #ifdef FANCY_WATER
        // transfer water color through glcolor. should be faster
        const vec4 BaseColor = vec4(f_WATER_RED, f_WATER_GREEN, f_WATER_BLUE, f_WATER_ALPHA);
        glcolor.rgb = mix_preserve_c1lum(BaseColor.rgb, glcolor.rgb, f_BIOME_WATER_CONTRIBUTION);
        glcolor.rgb = to_linear(glcolor.rgb);
        glcolor.a = BaseColor.a;
        #endif
    }

    vec3 binormal = normalize(gbufferModelView[2].xyz);
    vec3 tangent  = normalize(gbufferModelView[0].xyz);
    TBN = mat3(tangent, binormal, Normal);

    #if TAA_MODE >= 2
    gl_Position.xy += taaJitter * gl_Position.w;
    #endif
}
