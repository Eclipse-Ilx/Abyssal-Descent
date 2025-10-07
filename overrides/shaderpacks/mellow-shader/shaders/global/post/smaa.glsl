float redmean(vec3 a, vec3 b) {
	float r = step(0.5, mix(a.r, b.r, 0.5));
	vec3 d = a - b;

	return sqrt(dot(d*d, vec3(
		2.0 + r,
		4.0,
		3.0 - r
	)));
}

float fma(float a, float b, float c) {
    return a * b + c;
}

vec2 fma(vec2 a, vec2 b, vec2 c) {
    return a * b + c;
}

vec4 fma(vec4 a, vec4 b, vec4 c) {
    return a * b + c;
}

float search_length(vec2 Sample, const float Offset) {
    const vec2 SEARCH_TEX_SIZE = vec2(66, 33);

    vec2 Scale = SEARCH_TEX_SIZE * vec2(0.5, -1.0) + vec2(-1, 1);
    vec2 Bias = SEARCH_TEX_SIZE * vec2(Offset, 1) + vec2(0.5, -0.5);

    Scale /= vec2(64, 16);
    Bias /= vec2(64, 16);

    return texture2D(colortex5, Sample * Scale + Bias).r;
}

float SMAASearchXLeft(vec2 texcoord, float end) {
    vec2 e = vec2(0.0, 1.0);
    while (texcoord.x > end && 
           e.g > 0.8281 && // Is there some edge not activated?
           e.r == 0.0) { // Or is there a crossing edge that breaks the line?
        e = texture2D(colortex2, texcoord).rg;
        texcoord = fma(-vec2(2.0, 0.0), resolutionInv.xy, texcoord);
    }

    float offset = fma(-(255.0 / 127.0), search_length( e, 0.0), 3.25);
    return fma(resolutionInv.x, offset, texcoord.x);
}

float SMAASearchXRight(vec2 texcoord, float end) {
    vec2 e = vec2(0.0, 1.0);
    while (texcoord.x < end && 
           e.g > 0.8281 && // Is there some edge not activated?
           e.r == 0.0) { // Or is there a crossing edge that breaks the line?
        e = texture2D(colortex2, texcoord).rg;
        texcoord = fma(vec2(2.0, 0.0), resolutionInv.xy, texcoord);
    }
    float offset = fma(-(255.0 / 127.0), search_length(e, 0.5), 3.25);
    return fma(-resolutionInv.x, offset, texcoord.x);
}

float SMAASearchYUp(vec2 texcoord, float end) {
    vec2 e = vec2(1.0, 0.0);
    while (texcoord.y > end && 
           e.r > 0.8281 && // Is there some edge not activated?
           e.g == 0.0) { // Or is there a crossing edge that breaks the line?
        e = texture2D(colortex2, texcoord).rg;
        texcoord = fma(-vec2(0.0, 2.0), resolutionInv.xy, texcoord);
    }
    float offset = fma(-(255.0 / 127.0), search_length(e.gr, 0.0), 3.25);
    return fma(resolutionInv.y, offset, texcoord.y);
}

float SMAASearchYDown(vec2 texcoord, float end) {
    vec2 e = vec2(1.0, 0.0);
    while (texcoord.y < end && 
           e.r > 0.8281 && // Is there some edge not activated?
           e.g == 0.0) { // Or is there a crossing edge that breaks the line?
        e = texture2D(colortex2, texcoord).rg;
        texcoord = fma(vec2(0.0, 2.0), resolutionInv.xy, texcoord);
    }
    float offset = fma(-(255.0 / 127.0), search_length(e.gr, 0.5), 3.25);
    return fma(-resolutionInv.y, offset, texcoord.y);
}

vec2 sample_area(float d1, float d2, float e1, float e2) {
    vec2 Coord = 16 * round(4 * vec2(e1, e2)) + vec2(d1, d2) + 0.5;
    return texture2D(colortex3, Coord / vec2(160, 560)).rg;
}
