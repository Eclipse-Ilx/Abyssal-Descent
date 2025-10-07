#include "/lib/all_the_libs.glsl"

varying vec2 texcoord;
void main() {
    gl_Position = ftransform();
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    gl_Position = gl_Position * 0.5 + 0.5;
    gl_Position.xy = gl_Position.xy * 0.0625 + 0.375;
    gl_Position = gl_Position * 2 - 1;
}
