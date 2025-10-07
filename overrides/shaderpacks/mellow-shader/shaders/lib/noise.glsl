// https://github.com/Experience-Monks/glsl-fast-gaussian-blur
float noise(vec2 Coords) {
    float color = texture2D(noisetex, Coords/(noiseTextureResolution*0.5)).x * 0.2;
	color += texture2D(noisetex, Coords/(noiseTextureResolution*1)).x * 0.3;
	color += texture2D(noisetex, Coords/(noiseTextureResolution*2)).x * 0.5;
    return color;
}

vec2 noise_normal(vec2 Coords) {
	vec2 color = (texture2D(noisetex, Coords/(noiseTextureResolution*0.5)).yz * 2 - 1) * 0.2;
	color += (texture2D(noisetex, Coords/(noiseTextureResolution*1)).yz * 2 - 1) * 0.3;
	color += (texture2D(noisetex, Coords/(noiseTextureResolution*2)).yz * 2 - 1) * 0.5;
	return color;
}

vec2 noise_water(vec2 Coords) {
	Coords /= WATER_NORMAL_SIZE;
    vec2 color = (texture2D(noisetex, (Coords+frameTimeCounter*0.2*WATER_NORMAL_SPEED)/24).yz * 2 - 1) * 0.05;
	color += (texture2D(noisetex,(Coords-frameTimeCounter*0.8*WATER_NORMAL_SPEED)/64).yz * 2 - 1) * 0.1;
    return color * WATER_NORMAL_STRENGTH;
}

float fbm_clouds(vec2 x, int detail) {
	float v = 0.0;
	float a = 0.5;
	vec2 shift = vec2(100);
	// Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));
	for (int i = 0; i < detail; ++i) {
		v += a * noise(x);
		x = rot * x * 2.0 + shift;
		a *= 0.5;
	}
	return v;
}

vec2 fbm_clouds_normal(vec2 x, int detail) {
	vec2 v = vec2(0.0);
	float a = 0.5;
	vec2 shift = vec2(100);
	// Rotate to reduce axial bias
	mat2 rot = mat2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));
	for (int i = 0; i < detail; ++i) {
		v += a * noise_normal(x);
		x = rot * x * 2.0 + shift;
		a *= 0.5;
	}
	return v;
}

float fbm_fast(vec2 x, int detail) {
	float v = 0.0;
	float a = 0.5;
	vec2 shift = vec2(100);
	// Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));
	for (int i = 0; i < detail; ++i) {
		v += a * texture2D(noisetex, x/noiseTextureResolution).x;
		x = rot * x * 2.0 + shift;
		a *= 0.5;
	}
	return v;
}

// https://www.shadertoy.com/view/4ssfWM
float bayer8(vec2 a) {
    uvec2 b = uvec2(a);
    uint c = (b.x^b.y)<<1u;
    return float(
        ((c&8u|b.y&4u)>>2u)|
        ((c&4u|b.y&2u)<<1u)|
        ((c&2u|b.y&1u)<<4u)  //15 ops
    )/8./8.;
}

float dither(vec2 Pos) {
	// Interleaved gradient noise
    #if TAA_MODE != 0
	float FrameMod = frameCounter % 64;
    Pos += 5.588238f * FrameMod;
    return fract(52.9829189 * fract(0.06711056*Pos.x + 0.00583715*Pos.y));
	#endif
	// Use bayer dither when TAA is disabled because it's more visually pleasing
	return bayer8(Pos);
}
