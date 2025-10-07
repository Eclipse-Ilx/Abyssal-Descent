// 6 texture samples instead of 25, but it's 2 pass
// https://github.com/Experience-Monks/glsl-fast-gaussian-blur
vec3 blur(sampler2D image, vec2 texcoord, vec2 direction, float Scale, float Offset) {
    vec3 color = vec3(0.0);
    vec2 off1 = vec2(1.3333333333333333) * direction * resolutionInv;

    texcoord *= Scale;
    texcoord += Offset;

    float BoundLower = Offset;
    float BoundUpper = Offset + Scale;

    color += texture2D(image, texcoord).rgb * 0.29411764705882354;
    if (clamp(texcoord + off1 * 2, BoundLower, BoundUpper) == texcoord + off1 * 2)
        color += texture2D(image, texcoord + off1).rgb * 0.35294117647058826;
    if (clamp(texcoord - off1 * 2, BoundLower, BoundUpper) == texcoord - off1 * 2)
        color += texture2D(image, texcoord - off1).rgb * 0.35294117647058826;
    return color;
}

// 5 texture samples instead of 9
vec3 blur3x3(sampler2D image, vec2 texcoord) {
    vec3 Color = vec3(0);
    vec2 Off1 = vec2(-0.33, 1.0) * resolutionInv;
    vec2 Off2 = vec2(1.0, 0.33) * resolutionInv;
    Color += texture2D(image, texcoord).rgb * 0.25;
    Color += texture2D(image, texcoord + Off1).rgb * 0.1875;
    Color += texture2D(image, texcoord - Off1).rgb * 0.1875;
    Color += texture2D(image, texcoord + Off2).rgb * 0.1875;
    Color += texture2D(image, texcoord - Off2).rgb * 0.1875;
    return Color;
}
