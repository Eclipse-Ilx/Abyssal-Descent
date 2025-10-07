flat varying float material;
varying vec3 MixedLights;
flat varying vec3 Normal;

vec3 tweak_lightmap() {
    return MixedLights;
}
