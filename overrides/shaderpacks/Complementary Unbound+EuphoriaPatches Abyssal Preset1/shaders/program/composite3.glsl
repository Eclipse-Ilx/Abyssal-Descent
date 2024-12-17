/////////////////////////////////////
// Complementary Shaders by EminGT //
// With Euphoria Patches by SpacEagle17 and isuewo //
/////////////////////////////////////

//Common//
#include "/lib/common.glsl"

//////////Fragment Shader//////////Fragment Shader//////////Fragment Shader//////////
#ifdef FRAGMENT_SHADER

#if WORLD_BLUR > 0 || TILT_SHIFT != 0 || TILT_SHIFT2 != 0
    noperspective in vec2 texCoord;

    flat in vec3 upVec, sunVec;
#endif

//Pipeline Constants//
#if WORLD_BLUR > 0 || TILT_SHIFT != 0 || TILT_SHIFT2 != 0
    const bool colortex0MipmapEnabled = true;
#endif

//Common Variables//
#if WORLD_BLUR > 0 || TILT_SHIFT != 0 || TILT_SHIFT2 != 0
    #if (WORLD_BLUR == 2 || TILT_SHIFT != 0 || TILT_SHIFT2 != 0) && WB_DOF_FOCUS >= 0
        #if WB_DOF_FOCUS == 0
            uniform float centerDepthSmooth;
        #else
            float centerDepthSmooth = (far * (WB_DOF_FOCUS - near)) / (WB_DOF_FOCUS * (far - near));
        #endif
    #endif
#endif

#if WORLD_BLUR > 0 || TILT_SHIFT != 0 || TILT_SHIFT2 != 0
    float SdotU = dot(sunVec, upVec);
    float sunFactor = SdotU < 0.0 ? clamp(SdotU + 0.375, 0.0, 0.75) / 0.75 : clamp(SdotU + 0.03125, 0.0, 0.0625) / 0.0625;

    vec2 dofOffsets[18] = vec2[18](
        vec2( 0.0    ,  0.25  ),
        vec2(-0.2165 ,  0.125 ),
        vec2(-0.2165 , -0.125 ),
        vec2( 0      , -0.25  ),
        vec2( 0.2165 , -0.125 ),
        vec2( 0.2165 ,  0.125 ),
        vec2( 0      ,  0.5   ),
        vec2(-0.25   ,  0.433 ),
        vec2(-0.433  ,  0.25  ),
        vec2(-0.5    ,  0     ),
        vec2(-0.433  , -0.25  ),
        vec2(-0.25   , -0.433 ),
        vec2( 0      , -0.5   ),
        vec2( 0.25   , -0.433 ),
        vec2( 0.433  , -0.2   ),
        vec2( 0.5    ,  0     ),
        vec2( 0.433  ,  0.25  ),
        vec2( 0.25   ,  0.433 )
    );
#endif

//Common Functions//
#if WORLD_BLUR > 0 || TILT_SHIFT != 0 || TILT_SHIFT2 != 0
    void DoWorldBlur(inout vec3 color, float z1, float lViewPos0) {
        if (z1 < 0.56) return;
        vec3 dof = vec3(0.0);
        vec3 cocColor = vec3(1, 0, 0.8) * 10.0;
        vec2 dofScale = vec2(1.0, aspectRatio);

        #if WORLD_BLUR == 1 // Distance Blur
            #ifdef OVERWORLD
                float dbMult;
                if (isEyeInWater == 0) {
                    dbMult = mix(WB_DB_NIGHT_I, WB_DB_DAY_I, sunFactor * eyeBrightnessM);
                    dbMult = mix(dbMult, WB_DB_RAIN_I, rainFactor * eyeBrightnessM);
                } else dbMult = WB_DB_WATER_I;
            #elif defined NETHER
                float dbMult = WB_DB_NETHER_I;
            #elif defined END
                float dbMult = WB_DB_END_I;
            #endif
            float coc = clamp(lViewPos0 * 0.001, 0.0, 0.1) * dbMult * 0.03;
        #elif WORLD_BLUR == 2 || TILT_SHIFT != 0 || TILT_SHIFT2 != 0 // Depth Of Field
            #if TILT_SHIFT != 0
                float tiltOffset = texCoord.y * 2.0 - 1.0;
                tiltOffset *= 0.0007 * TILT_SHIFT;
            #else
                float tiltOffset = 0.0;
            #endif
            #if TILT_SHIFT2 != 0
                float shiftOffset = texCoord.x * 2.0 - 1.0;
                shiftOffset *= 0.0007 * TILT_SHIFT2;
            #else
                float shiftOffset = 0.0;
            #endif
            #if WB_DOF_FOCUS >= 0
                float coc = max(abs(z1 - centerDepthSmooth + tiltOffset + shiftOffset) * 0.125 * WB_DOF_I - 0.0001, 0.0);
            #elif WB_DOF_FOCUS == -1
                float coc = clamp(abs(lViewPos0 * 0.005 - pow2(vsBrightness) + tiltOffset + shiftOffset), 0.0, 0.1) * WB_DOF_I * 0.03;
            #endif
        #endif
        #ifdef DOF_VIEW_FOCUS
            float cocView = float(coc < 0.005 + 0.001 * abs(max(float(TILT_SHIFT), float(TILT_SHIFT2))) && coc > 0 && hideGUI == 0);
        #endif
        #if TILT_SHIFT == 0 && TILT_SHIFT2 == 0
            coc = coc / sqrt(coc * coc + 0.1);
        #endif

        #ifdef WB_FOV_SCALED
            coc *= gbufferProjection[1][1] * 0.8;
        #endif
        #ifdef WB_CHROMATIC
            float midDistX = texCoord.x - 0.5;
            float midDistY = texCoord.y - 0.5;
            vec2 chromaticScale = vec2(midDistX, midDistY);
            chromaticScale = sign(chromaticScale) * sqrt(abs(chromaticScale));
            chromaticScale *= vec2(1.0, viewHeight / viewWidth);
            vec2 aberration = (15.0 / vec2(viewWidth, viewHeight)) * chromaticScale * coc;
        #endif
        #ifdef WB_ANAMORPHIC
            dofScale *= vec2(0.5, 1.5);
        #endif

        if (coc * 0.5 > 1.0 / max(viewWidth, viewHeight)) {
            for (int i = 0; i < 18; i++) {
                vec2 offset = dofOffsets[i] * coc * 0.0085 * dofScale;
                float lod = log2(viewHeight * aspectRatio * coc * 0.75 / 320.0);
                #ifndef WB_CHROMATIC
                    dof += texture2DLod(colortex0, texCoord + offset, lod).rgb;
                #else
                    dof += vec3(texture2DLod(colortex0, texCoord + offset + aberration, lod).r,
                                texture2DLod(colortex0, texCoord + offset             , lod).g,
                                texture2DLod(colortex0, texCoord + offset - aberration, lod).b);
                #endif
            }
            dof /= 18.0;
            #ifdef WORLD_BLUR_SNEAK
                color = mix(color, dof, isSneaking);
            #else
                color = dof;
            #endif
        }
        #ifdef DOF_VIEW_FOCUS
            #ifdef WORLD_BLUR_SNEAK
                color = mix(color, cocColor, cocView * isSneaking);
            #else
                color = mix(color, cocColor, cocView);
            #endif
        #endif
    }
#endif

//Includes//
#if (WORLD_BLUR > 0 || TILT_SHIFT != 0 || TILT_SHIFT2 != 0) && defined BLOOM_FOG_COMPOSITE3
    #include "/lib/atmospherics/fog/bloomFog.glsl"
#endif

//Program//
void main() {
    vec3 color = texelFetch(colortex0, texelCoord, 0).rgb;

    #if WORLD_BLUR > 0 || TILT_SHIFT != 0 || TILT_SHIFT2 != 0
        float z1 = texelFetch(depthtex1, texelCoord, 0).r;
        float z0 = texelFetch(depthtex0, texelCoord, 0).r;

        vec4 screenPos = vec4(texCoord, z0, 1.0);
        vec4 viewPos = gbufferProjectionInverse * (screenPos * 2.0 - 1.0);
        viewPos /= viewPos.w;
        float lViewPos = length(viewPos.xyz);

        #if defined DISTANT_HORIZONS && defined NETHER
            float z0DH = texelFetch(dhDepthTex, texelCoord, 0).r;
            vec4 screenPosDH = vec4(texCoord, z0DH, 1.0);
            vec4 viewPosDH = dhProjectionInverse * (screenPosDH * 2.0 - 1.0);
            viewPosDH /= viewPosDH.w;
            lViewPos = min(lViewPos, length(viewPosDH.xyz));
        #endif

        // #ifdef WORLD_BLUR_SNEAK
            // if (isSneaking > 0.01) {
        // #endif
            DoWorldBlur(color, z1, lViewPos);
        // #ifdef WORLD_BLUR_SNEAK
            // }
        // #endif

        #ifdef BLOOM_FOG_COMPOSITE3
            color *= GetBloomFog(lViewPos); // Reminder: Bloom Fog can move between composite1-2-3
        #endif
    #endif

    /* DRAWBUFFERS:0 */
    gl_FragData[0] = vec4(color, 1.0);
}

#endif

//////////Vertex Shader//////////Vertex Shader//////////Vertex Shader//////////
#ifdef VERTEX_SHADER

#if WORLD_BLUR > 0 || TILT_SHIFT != 0 || TILT_SHIFT2 != 0
    noperspective out vec2 texCoord;

    flat out vec3 upVec, sunVec;
#endif

//Attributes//

//Common Variables//

//Common Functions//

//Includes//

//Program//
void main() {
    gl_Position = ftransform();

    #if WORLD_BLUR > 0 || TILT_SHIFT != 0 || TILT_SHIFT2 != 0
        texCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
        upVec = normalize(gbufferModelView[1].xyz);
        sunVec = GetSunVector();
    #endif
}

#endif
