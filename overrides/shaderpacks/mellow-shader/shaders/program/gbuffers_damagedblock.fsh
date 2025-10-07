#include "/lib/all_the_libs.glsl"

uniform sampler2D gtexture;

varying vec2 texcoord;
varying vec4 glcolor;

#include "/global/lighting.fsh"

/* DRAWBUFFERS:0 */

void main() {
    vec4 Color = glcolor * texture2D(gtexture, texcoord);
    Color.rgb = to_linear(Color.rgb);

    gl_FragData[0] = Color;
}
