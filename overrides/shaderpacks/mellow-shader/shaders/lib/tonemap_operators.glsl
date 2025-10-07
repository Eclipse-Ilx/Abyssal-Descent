vec3 ACESFilm(vec3 x) {
    x *= 0.6;

    float a = 2.51f;
    float b = 0.03f;
    float c = 2.43f;
    float d = 0.59f;
    float e = 0.14f;
    vec3 r = (x * (a * x + b)) / (x * (c * x + d) + e);

    return r;
}

// https://64.github.io/tonemapping/

vec3 reinhard_jodie(vec3 v)
{
    float l = get_luminance(v);
    vec3 tv = v / (1.0f + v);
    return mix(v / (1.0f + l), tv, tv);
}

// https://github.com/TheRealMJP/BakingLab/blob/master/BakingLab/ACES.hlsl

// sRGB => XYZ => D65_2_D60 => AP1 => RRT_SAT
const mat3 ACESInputMat = mat3(
        0.59719, 0.07600, 0.02840,
        0.35458, 0.90834, 0.13383,
        0.04823, 0.01566, 0.83777
    );

// ODT_SAT => XYZ => D60_2_D65 => sRGB
const mat3 ACESOutputMat = mat3(
        1.60475, -0.10208, -0.00327,
        -0.53108, 1.10813, -0.07276,
        -0.07367, -0.00605, 1.07602
    );

vec3 RRTAndODTFit(vec3 v)
{
    vec3 a = v * (v + 0.0245786) - 0.000090537;
    vec3 b = v * (0.983729 * v + 0.4329510) + 0.238081;
    return a / b;
}

vec3 ACES_slow(vec3 color)
{
    color = pow(color, vec3(1 / 2.2));
    color = ACESInputMat * color;

    // Apply RRT and ODT
    color = RRTAndODTFit(color);

    color = ACESOutputMat * color;

    // Clamp to [0, 1]
    color = clamp(color, 0, 1);

    return color;
}

// https://twitter.com/jimhejl/status/633777619998130176?lang=en
vec3 Hejl2015(in vec3 hdr)
{
    hdr *= 0.6;
    vec4 vh = vec4(hdr, 3.25);
    vec4 va = (1.425 * vh) + 0.05;
    vec4 vf = ((vh * va + 0.004) / ((vh * (va + 0.55) + 0.0491))) - 0.0813;
    return vf.rgb / vf.www;
}

vec3 reinhard(vec3 x) {
    return x / (1 + x);
}

vec3 reinhard_inv(vec3 x) {
    return x / (1 - x);
}
