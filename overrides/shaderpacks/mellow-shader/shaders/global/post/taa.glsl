// In shaderlabs discord: https://discord.com/channels/237199950235041794/525510804494221312/955506913834070016
vec2 toPrevScreenPos(vec2 currScreenPos, float depth, bool isDH) {
    mat4 ProjInv = isDH ? dhProjectionInverse : gbufferProjectionInverse;
    mat4 ModelViewInv = gbufferModelViewInverse;
    mat4 PrevModelView = gbufferPreviousModelView;
    mat4 PrevProj = isDH ? dhPreviousProjection : gbufferPreviousProjection;
    vec3 currViewPos = vec3(vec2(ProjInv[0].x, ProjInv[1].y) * (currScreenPos.xy * 2.0 - 1.0) + ProjInv[3].xy, ProjInv[3].z);
    currViewPos /= (ProjInv[2].w * (depth * 2.0 - 1.0) + ProjInv[3].w);
    vec3 currFeetPlayerPos = mat3(ModelViewInv) * currViewPos + ModelViewInv[3].xyz;

    vec3 prevFeetPlayerPos = depth > 0.56 ? currFeetPlayerPos + cameraPosition - previousCameraPosition : currFeetPlayerPos;
    vec3 prevViewPos = mat3(PrevModelView) * prevFeetPlayerPos + PrevModelView[3].xyz;
    vec2 finalPos = vec2(PrevProj[0].x, PrevProj[1].y) * prevViewPos.xy + PrevProj[3].xy;
    return (finalPos / -prevViewPos.z) * 0.5 + 0.5;
}

// https://discord.com/channels/237199950235041794/525510804494221312/955458285367066654
vec3 clipAABB(vec3 prevColor, vec3 minColor, vec3 maxColor) {
    vec3 pClip = 0.5 * (maxColor + minColor); // Center
    vec3 eClip = 0.5 * (maxColor - minColor); // Size

    vec3 vClip = prevColor - pClip;
    vec3 aUnit = abs(vClip / eClip);
    float denom = max(aUnit.x, max(aUnit.y, aUnit.z));

    return denom > 1.0 ? pClip + vClip / denom : prevColor;
}

// From filmic SMAA presentation: https://research.activision.com/publications/archives/filmic-smaasharp-morphological-and-temporal-antialiasing
vec3 texture_catmullrom_fast(sampler2D colorTex, vec2 texcoord) {
    vec2 position = resolution * texcoord;
    vec2 centerPosition = floor(position - 0.5) + 0.5;
    vec2 f = position - centerPosition;
    vec2 f2 = f * f;
    vec2 f3 = f * f2;

    float c = 0.65;
    vec2 w0 = -c * f3 + 2.0 * c * f2 - c * f;
    vec2 w1 = (2.0 - c) * f3 - (3.0 - c) * f2 + 1.0;
    vec2 w2 = -(2.0 - c) * f3 + (3.0 - 2.0 * c) * f2 + c * f;
    vec2 w3 = c * f3 - c * f2;

    vec2 w12 = w1 + w2;
    vec2 tc12 = (centerPosition + w2 / w12) * resolutionInv;
    vec3 centerColor = texture2D(colorTex, vec2(tc12.x, tc12.y)).rgb;

    vec2 tc0 = (centerPosition - 1.0) * resolutionInv;
    vec2 tc3 = (centerPosition + 2.0) * resolutionInv;
    vec4 color = vec4(texture2D(colorTex, vec2(tc12.x, tc0.y)).rgb, 1.0) * (w12.x * w0.y) +
            vec4(texture2D(colorTex, vec2(tc0.x, tc12.y)).rgb, 1.0) * (w0.x * w12.y) +
            vec4(centerColor, 1.0) * (w12.x * w12.y) +
            vec4(texture2D(colorTex, vec2(tc3.x, tc12.y)).rgb, 1.0) * (w3.x * w12.y) +
            vec4(texture2D(colorTex, vec2(tc12.x, tc3.y)).rgb, 1.0) * (w12.x * w3.y);
    return color.rgb / color.a;
}

vec3 get_closest_depth(ivec2 FragCoord, float Depth) {
    vec3 MinDepth = vec3(FragCoord, Depth);
    for (int i = -1; i <= 1; i += 2) {
        for (int j = -1; j <= 1; j += 2) {
            ivec2 OffsetCoords = FragCoord + ivec2(i, j);
            float NewDepth = texelFetch2D(depthtex1, OffsetCoords, 0).x;
            if (NewDepth < MinDepth.z) MinDepth = vec3(OffsetCoords, NewDepth);
        }
    }
    MinDepth.xy /= resolution;
    return vec3(MinDepth);
}

vec3 neighbourhoodClipping(sampler2D currTex, vec3 CurrentColor, vec3 prevColor, out vec3 maxColor) {
    vec3 minColor = CurrentColor;
    maxColor = CurrentColor;

    for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++) {
            if (x == y && x == 0) continue;
            vec3 color = texelFetch2D(currTex, ivec2(gl_FragCoord.xy + vec2(x, y)), 0).rgb;
            minColor = min(minColor, color);
            maxColor = max(maxColor, color);
        }
    }
    return clipAABB(prevColor, minColor, maxColor);
}

vec3 TAA(inout vec3 Color, vec3 CurrentPos, vec2 PrevCoordCenter, bool IsDH) {
    #if TAA_MODE == 3
    vec3 ClosestSample = get_closest_depth(ivec2(gl_FragCoord.xy), CurrentPos.z);
    vec2 PrevCoord = CurrentPos.xy + toPrevScreenPos(ClosestSample.xy, ClosestSample.z, IsDH).xy - ClosestSample.xy;
    #else
    vec2 PrevCoord = PrevCoordCenter;
    #endif

    if (clamp(PrevCoord + resolutionInv, 0, 1) != PrevCoord + resolutionInv)
        return Color;

    #if TAA_MODE != 2
    vec3 PrevColor = texture_catmullrom_fast(gaux1, PrevCoord).rgb;
    #else
    vec3 PrevColor = texture2D(gaux1, PrevCoord).rgb;
    #endif

    if (PrevColor == vec3(0)) {
        return Color;
    }

    vec3 ClippingMaxColor;
    vec3 ClampedColor = neighbourhoodClipping(colortex0, Color, PrevColor, ClippingMaxColor);

    #if TAA_MODE != 1
    float blendFactor = TAA_BLEND_FACTOR;
    #else
    // Reduce ghosting in motion
    vec2 velocity = (texcoord - PrevCoord.xy) * resolution;
    float blendFactor = exp(-len2(velocity)) * 0.2 + 0.5;
    #endif

    // Jessie's offcenter rejection (reduce ghosting)
    vec2 pixelOffset = 1.0 - abs(2.0 * fract(PrevCoord * resolution) - 1.0);
    float OffcenterRejection = sqrt(pixelOffset.x * pixelOffset.y) * TAA_OFFCENTER_REJECTION + (1 - TAA_OFFCENTER_REJECTION);
    blendFactor *= OffcenterRejection;

    #if TAA_MODE != 1
    // Flicker reduction
    blendFactor = clamp(blendFactor + pow2(get_luminance((PrevColor - Color) / ClippingMaxColor)) * 0.15, 0, 1);
    #endif

    Color = mix(Color, ClampedColor, blendFactor);
    return Color;
}
