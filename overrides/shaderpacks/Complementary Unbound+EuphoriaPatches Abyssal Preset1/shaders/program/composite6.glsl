/////////////////////////////////////
// Complementary Shaders by EminGT //
// With Euphoria Patches by SpacEagle17 and isuewo //
/////////////////////////////////////

//Common//
#include "/lib/common.glsl"

//////////Fragment Shader//////////Fragment Shader//////////Fragment Shader//////////
#ifdef FRAGMENT_SHADER

noperspective in vec2 texCoord;

//Pipeline Constants//
#include "/lib/pipelineSettings.glsl"

const bool colortex3MipmapEnabled = true;

//Common Variables//
vec2 view = vec2(viewWidth, viewHeight);

//Common Functions//
float GetLinearDepth(float depth) {
    return (2.0 * near) / (far + near - depth * (far - near));
}

//Includes//
#ifdef TAA
    #include "/lib/antialiasing/taa.glsl"
#endif

//Program//
void main() {
    vec3 color = texelFetch(colortex3, texelCoord, 0).rgb;

    #ifdef RENKO_CUT
        float cutData = texelFetch(colortex1, texelCoord, 0).a;
    #else
        #define cutData 1.0
    #endif

    vec3 temp = vec3(0.0);
    float z1 = 0.0;

    #ifdef TEMPORAL_FILTER
        z1 = texelFetch(depthtex1, texelCoord, 0).r;
    #endif

    #ifdef TAA
        DoTAA(color, temp, z1);
    #endif

    /* DRAWBUFFERS:321 */
    gl_FragData[0] = vec4(color, 1.0);
    gl_FragData[1] = vec4(temp, z1);
    gl_FragData[2] = vec4(texture2D(colortex1, texCoord).rgb, ivec2(texCoord * vec2(viewWidth, viewHeight)) == ivec2(0) ? texture2D(colortex1, texCoord).a : cutData);
}

#endif

//////////Vertex Shader//////////Vertex Shader//////////Vertex Shader//////////
#ifdef VERTEX_SHADER

noperspective out vec2 texCoord;

//Attributes//

//Common Variables//

//Common Functions//

//Includes//

//Program//
void main() {
    gl_Position = ftransform();

    texCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}

#endif
