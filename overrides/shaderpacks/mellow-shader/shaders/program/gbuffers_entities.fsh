#include "/lib/all_the_libs.glsl"

uniform sampler2D lightmap;
uniform sampler2D gtexture;

varying vec2 texcoord;
varying vec4 glcolor;

#include "/global/lighting.fsh"

/* DRAWBUFFERS:0 */

void main() {
    vec4 Color = texture2D(gtexture, texcoord) * glcolor;
    Color.rgb = to_linear(Color.rgb);

    if (entityId == 10101) {
        Color.a = 1.0;
    }
    else {
        Color.xyz = mix(Color.rgb, entityColor.rgb, entityColor.a);
        vec3 TweakedLM = tweak_lightmap();
        Color.xyz *= TweakedLM;
    }
    gl_FragData[0] = Color;
}
