#define max_const(x) ( x > 0.0 ? x : 0.0)

// Default
#if COLOR_SCHEME == 1

const float f_LM_RED = max_const(1.2 + LM_RED);
const float f_LM_GREEN = max_const(0.9 + LM_GREEN);
const float f_LM_BLUE = max_const(0.6 + LM_BLUE);

const float f_NOON_RED = max_const(1.2 + NOON_RED);
const float f_NOON_GREEN = max_const(1.1 + NOON_GREEN);
const float f_NOON_BLUE = max_const(1.0 + NOON_BLUE);

const float f_SUNRISE_RED = max_const(0.8 + SUNRISE_RED);
const float f_SUNRISE_GREEN = max_const(0.6 + SUNRISE_GREEN);
const float f_SUNRISE_BLUE = max_const(0.4 + SUNRISE_BLUE);

const float f_SUNSET_RED = max_const(0.8 + SUNSET_RED);
const float f_SUNSET_GREEN = max_const(0.5 + SUNSET_GREEN);
const float f_SUNSET_BLUE = max_const(0.2 + SUNSET_BLUE);

const float f_MOON_RED = max_const(0.4 + MOON_RED);
const float f_MOON_GREEN = max_const(0.4 + MOON_GREEN);
const float f_MOON_BLUE = max_const(0.5 + MOON_BLUE);

const float f_NOON_SKY_T_R = max_const(0.2 + NOON_SKY_T_R);
const float f_NOON_SKY_T_G = max_const(0.35 + NOON_SKY_T_G);
const float f_NOON_SKY_T_B = max_const(0.7 + NOON_SKY_T_B);

const float f_SUNRISE_SKY_T_R = max_const(0.0 + SUNRISE_SKY_T_R);
const float f_SUNRISE_SKY_T_G = max_const(0.25 + SUNRISE_SKY_T_G);
const float f_SUNRISE_SKY_T_B = max_const(0.5 + SUNRISE_SKY_T_B);

const float f_SUNSET_SKY_T_R = max_const(0.00 + SUNSET_SKY_T_R);
const float f_SUNSET_SKY_T_G = max_const(0.15 + SUNSET_SKY_T_G);
const float f_SUNSET_SKY_T_B = max_const(0.25 + SUNSET_SKY_T_B);

const float f_NIGHT_SKY_T_R = max_const(0.0 + NIGHT_SKY_T_R);
const float f_NIGHT_SKY_T_G = max_const(0.025 + NIGHT_SKY_T_G);
const float f_NIGHT_SKY_T_B = max_const(0.075 + NIGHT_SKY_T_B);

const float f_END_SKY_T_R = max_const(0.15 + END_SKY_T_R);
const float f_END_SKY_T_G = max_const(0.1 + END_SKY_T_G);
const float f_END_SKY_T_B = max_const(0.2 + END_SKY_T_B);

const float f_NOON_SKY_G_R = max_const(0.5 + NOON_SKY_G_R);
const float f_NOON_SKY_G_G = max_const(0.55 + NOON_SKY_G_G);
const float f_NOON_SKY_G_B = max_const(0.6 + NOON_SKY_G_B);

const float f_SUNRISE_SKY_G_R = max_const(0.5 + SUNRISE_SKY_G_R);
const float f_SUNRISE_SKY_G_G = max_const(0.4 + SUNRISE_SKY_G_G);
const float f_SUNRISE_SKY_G_B = max_const(0.4 + SUNRISE_SKY_G_B);

const float f_SUNSET_SKY_G_R = max_const(0.3 + SUNSET_SKY_G_R);
const float f_SUNSET_SKY_G_G = max_const(0.25 + SUNSET_SKY_G_G);
const float f_SUNSET_SKY_G_B = max_const(0.25 + SUNSET_SKY_G_B);

const float f_NIGHT_SKY_G_R = max_const(0.15 + NIGHT_SKY_G_R);
const float f_NIGHT_SKY_G_G = max_const(0.2 + NIGHT_SKY_G_G);
const float f_NIGHT_SKY_G_B = max_const(0.25 + NIGHT_SKY_G_B);

const float f_SUN_GLARE_R = max_const(0.8 + SUN_GLARE_R);
const float f_SUN_GLARE_G = max_const(0.45 + SUN_GLARE_G);
const float f_SUN_GLARE_B = max_const(0.0 + SUN_GLARE_B);

const float f_NETHER_AMBIENT_R = max_const(0.48 + NETHER_AMBIENT_R);
const float f_NETHER_AMBIENT_G = max_const(0.24 + NETHER_AMBIENT_G);
const float f_NETHER_AMBIENT_B = max_const(0.18 + NETHER_AMBIENT_B);

const float f_END_AMBIENT_R = max_const(0.2 + END_AMBIENT_R);
const float f_END_AMBIENT_G = max_const(0.17 + END_AMBIENT_G);
const float f_END_AMBIENT_B = max_const(0.25 + END_AMBIENT_B);

const float f_END_DIRECT_R = max_const(0.3 + END_DIRECT_R);
const float f_END_DIRECT_G = max_const(0.23 + END_DIRECT_G);
const float f_END_DIRECT_B = max_const(0.45 + END_DIRECT_B);

const float f_END_AURORA1_R = max_const(0.0 + END_AURORA1_R);
const float f_END_AURORA1_G = max_const(0.45 + END_AURORA1_G);
const float f_END_AURORA1_B = max_const(0.25 + END_AURORA1_B);

const float f_END_AURORA2_R = max_const(0.45 + END_AURORA2_R);
const float f_END_AURORA2_G = max_const(0.3 + END_AURORA2_G);
const float f_END_AURORA2_B = max_const(0.1 + END_AURORA2_B);

const float f_SUNRISE_AMBIENT = max_const(0.45 + SUNRISE_AMBIENT);
const float f_NOON_AMBIENT = max_const(0.5 + NOON_AMBIENT);
const float f_SUNSET_AMBIENT = max_const(0.5 + SUNSET_AMBIENT);
const float f_NIGHT_AMBIENT = max_const(0.2 + NIGHT_AMBIENT);

const float f_WATER_RED = max_const(0.0 + WATER_RED);
const float f_WATER_GREEN = max_const(0.35 + WATER_GREEN);
const float f_WATER_BLUE = max_const(0.25 + WATER_BLUE);
const float f_WATER_ALPHA = max_const(0.4 + WATER_ALPHA);

const float f_BIOME_WATER_CONTRIBUTION = max_const(0.5 + BIOME_WATER_CONTRIBUTION);

// Vanilla
#elif COLOR_SCHEME == 2

const float f_LM_RED = max_const(1.1 + LM_RED);
const float f_LM_GREEN = max_const(0.9 + LM_GREEN);
const float f_LM_BLUE = max_const(0.7 + LM_BLUE);

const float f_NOON_RED = max_const(1.05 + NOON_RED);
const float f_NOON_GREEN = max_const(1.0 + NOON_GREEN);
const float f_NOON_BLUE = max_const(1.0 + NOON_BLUE);

const float f_SUNRISE_RED = max_const(0.9 + SUNRISE_RED);
const float f_SUNRISE_GREEN = max_const(0.73 + SUNRISE_GREEN);
const float f_SUNRISE_BLUE = max_const(0.5 + SUNRISE_BLUE);

const float f_SUNSET_RED = max_const(0.9 + SUNSET_RED);
const float f_SUNSET_GREEN = max_const(0.73 + SUNSET_GREEN);
const float f_SUNSET_BLUE = max_const(0.5 + SUNSET_BLUE);

const float f_MOON_RED = max_const(0.4 + MOON_RED);
const float f_MOON_GREEN = max_const(0.4 + MOON_GREEN);
const float f_MOON_BLUE = max_const(0.5 + MOON_BLUE);

const float f_NOON_SKY_T_R = max_const(0.25 + NOON_SKY_T_R);
const float f_NOON_SKY_T_G = max_const(0.38 + NOON_SKY_T_G);
const float f_NOON_SKY_T_B = max_const(0.7 + NOON_SKY_T_B);

const float f_SUNRISE_SKY_T_R = max_const(0.22 + SUNRISE_SKY_T_R);
const float f_SUNRISE_SKY_T_G = max_const(0.37 + SUNRISE_SKY_T_G);
const float f_SUNRISE_SKY_T_B = max_const(0.67 + SUNRISE_SKY_T_B);

const float f_SUNSET_SKY_T_R = max_const(0.22 + SUNSET_SKY_T_R);
const float f_SUNSET_SKY_T_G = max_const(0.37 + SUNSET_SKY_T_G);
const float f_SUNSET_SKY_T_B = max_const(0.67 + SUNSET_SKY_T_B);

const float f_NIGHT_SKY_T_R = max_const(0.0 + NIGHT_SKY_T_R);
const float f_NIGHT_SKY_T_G = max_const(0.025 + NIGHT_SKY_T_G);
const float f_NIGHT_SKY_T_B = max_const(0.075 + NIGHT_SKY_T_B);

const float f_END_SKY_T_R = max_const(0.12 + END_SKY_T_R);
const float f_END_SKY_T_G = max_const(0.1 + END_SKY_T_G);
const float f_END_SKY_T_B = max_const(0.15 + END_SKY_T_B);

const float f_NOON_SKY_G_R = max_const(0.5 + NOON_SKY_G_R);
const float f_NOON_SKY_G_G = max_const(0.55 + NOON_SKY_G_G);
const float f_NOON_SKY_G_B = max_const(0.6 + NOON_SKY_G_B);

const float f_SUNRISE_SKY_G_R = max_const(0.47 + SUNRISE_SKY_G_R);
const float f_SUNRISE_SKY_G_G = max_const(0.52 + SUNRISE_SKY_G_G);
const float f_SUNRISE_SKY_G_B = max_const(0.55 + SUNRISE_SKY_G_B);

const float f_SUNSET_SKY_G_R = max_const(0.47 + SUNSET_SKY_G_R);
const float f_SUNSET_SKY_G_G = max_const(0.52 + SUNSET_SKY_G_G);
const float f_SUNSET_SKY_G_B = max_const(0.55 + SUNSET_SKY_G_B);

const float f_NIGHT_SKY_G_R = max_const(0.07 + NIGHT_SKY_G_R);
const float f_NIGHT_SKY_G_G = max_const(0.1 + NIGHT_SKY_G_G);
const float f_NIGHT_SKY_G_B = max_const(0.13 + NIGHT_SKY_G_B);

const float f_SUN_GLARE_R = max_const(0.75 + SUN_GLARE_R);
const float f_SUN_GLARE_G = max_const(0.5 + SUN_GLARE_G);
const float f_SUN_GLARE_B = max_const(0.0 + SUN_GLARE_B);

const float f_NETHER_AMBIENT_R = max_const(0.45 + NETHER_AMBIENT_R);
const float f_NETHER_AMBIENT_G = max_const(0.3 + NETHER_AMBIENT_G);
const float f_NETHER_AMBIENT_B = max_const(0.22 + NETHER_AMBIENT_B);

const float f_END_AMBIENT_R = max_const(0.3 + END_AMBIENT_R);
const float f_END_AMBIENT_G = max_const(0.3 + END_AMBIENT_G);
const float f_END_AMBIENT_B = max_const(0.35 + END_AMBIENT_B);

const float f_END_DIRECT_R = max_const(0.25 + END_DIRECT_R);
const float f_END_DIRECT_G = max_const(0.3 + END_DIRECT_G);
const float f_END_DIRECT_B = max_const(0.3 + END_DIRECT_B);

const float f_END_AURORA1_R = max_const(0.0 + END_AURORA1_R);
const float f_END_AURORA1_G = max_const(0.45 + END_AURORA1_G);
const float f_END_AURORA1_B = max_const(0.25 + END_AURORA1_B);

const float f_END_AURORA2_R = max_const(0.45 + END_AURORA2_R);
const float f_END_AURORA2_G = max_const(0.3 + END_AURORA2_G);
const float f_END_AURORA2_B = max_const(0.1 + END_AURORA2_B);

const float f_SUNRISE_AMBIENT = max_const(0.5 + SUNRISE_AMBIENT);
const float f_NOON_AMBIENT = max_const(0.5 + NOON_AMBIENT);
const float f_SUNSET_AMBIENT = max_const(0.5 + SUNSET_AMBIENT);
const float f_NIGHT_AMBIENT = max_const(0.3 + NIGHT_AMBIENT);

const float f_WATER_RED = max_const(0.0 + WATER_RED);
const float f_WATER_GREEN = max_const(0.35 + WATER_GREEN);
const float f_WATER_BLUE = max_const(0.25 + WATER_BLUE);
const float f_WATER_ALPHA = max_const(0.6 + WATER_ALPHA);

const float f_BIOME_WATER_CONTRIBUTION = clamp(0.7 + BIOME_WATER_CONTRIBUTION, 0, 1);

// Choc v7
#elif COLOR_SCHEME == 3

const float f_LM_RED = max_const(1.3 + LM_RED);
const float f_LM_GREEN = max_const(0.9 + LM_GREEN);
const float f_LM_BLUE = max_const(0.55 + LM_BLUE);

const float f_NOON_RED = max_const(1.2 + NOON_RED);
const float f_NOON_GREEN = max_const(1.1 + NOON_GREEN);
const float f_NOON_BLUE = max_const(0.95 + NOON_BLUE);

const float f_SUNRISE_RED = max_const(0.8 + SUNRISE_RED);
const float f_SUNRISE_GREEN = max_const(0.55 + SUNRISE_GREEN);
const float f_SUNRISE_BLUE = max_const(0.35 + SUNRISE_BLUE);

const float f_SUNSET_RED = max_const(0.8 + SUNSET_RED);
const float f_SUNSET_GREEN = max_const(0.55 + SUNSET_GREEN);
const float f_SUNSET_BLUE = max_const(0.35 + SUNSET_BLUE);

const float f_MOON_RED = max_const(0.2 + MOON_RED);
const float f_MOON_GREEN = max_const(0.25 + MOON_GREEN);
const float f_MOON_BLUE = max_const(0.35 + MOON_BLUE);

const float f_NOON_SKY_T_R = max_const(0.2 + NOON_SKY_T_R);
const float f_NOON_SKY_T_G = max_const(0.35 + NOON_SKY_T_G);
const float f_NOON_SKY_T_B = max_const(0.55 + NOON_SKY_T_B);

const float f_SUNRISE_SKY_T_R = max_const(0.1 + SUNRISE_SKY_T_R);
const float f_SUNRISE_SKY_T_G = max_const(0.25 + SUNRISE_SKY_T_G);
const float f_SUNRISE_SKY_T_B = max_const(0.4 + SUNRISE_SKY_T_B);

const float f_SUNSET_SKY_T_R = max_const(0.1 + SUNRISE_SKY_T_R);
const float f_SUNSET_SKY_T_G = max_const(0.25 + SUNRISE_SKY_T_G);
const float f_SUNSET_SKY_T_B = max_const(0.4 + SUNRISE_SKY_T_B);

const float f_NIGHT_SKY_T_R = max_const(0.0 + NIGHT_SKY_T_R);
const float f_NIGHT_SKY_T_G = max_const(0.025 + NIGHT_SKY_T_G);
const float f_NIGHT_SKY_T_B = max_const(0.075 + NIGHT_SKY_T_B);

const float f_END_SKY_T_R = max_const(0.15 + END_SKY_T_R);
const float f_END_SKY_T_G = max_const(0.12 + END_SKY_T_G);
const float f_END_SKY_T_B = max_const(0.17 + END_SKY_T_B);

const float f_NOON_SKY_G_R = max_const(0.57 + NOON_SKY_G_R);
const float f_NOON_SKY_G_G = max_const(0.6 + NOON_SKY_G_G);
const float f_NOON_SKY_G_B = max_const(0.63 + NOON_SKY_G_B);

const float f_SUNRISE_SKY_G_R = max_const(0.42 + SUNRISE_SKY_G_R);
const float f_SUNRISE_SKY_G_G = max_const(0.38 + SUNRISE_SKY_G_G);
const float f_SUNRISE_SKY_G_B = max_const(0.45 + SUNRISE_SKY_G_B);

const float f_SUNSET_SKY_G_R = max_const(0.42 + SUNSET_SKY_G_R);
const float f_SUNSET_SKY_G_G = max_const(0.38 + SUNSET_SKY_G_G);
const float f_SUNSET_SKY_G_B = max_const(0.45 + SUNSET_SKY_G_B);

const float f_NIGHT_SKY_G_R = max_const(0.17 + NIGHT_SKY_G_R);
const float f_NIGHT_SKY_G_G = max_const(0.2 + NIGHT_SKY_G_G);
const float f_NIGHT_SKY_G_B = max_const(0.25 + NIGHT_SKY_G_B);

const float f_SUN_GLARE_R = max_const(0.7 + SUN_GLARE_R);
const float f_SUN_GLARE_G = max_const(0.45 + SUN_GLARE_G);
const float f_SUN_GLARE_B = max_const(0.0 + SUN_GLARE_B);

const float f_NETHER_AMBIENT_R = max_const(0.25 + NETHER_AMBIENT_R);
const float f_NETHER_AMBIENT_G = max_const(0.2 + NETHER_AMBIENT_G);
const float f_NETHER_AMBIENT_B = max_const(0.22 + NETHER_AMBIENT_B);

const float f_END_AMBIENT_R = max_const(0.2 + END_AMBIENT_R);
const float f_END_AMBIENT_G = max_const(0.17 + END_AMBIENT_G);
const float f_END_AMBIENT_B = max_const(0.25 + END_AMBIENT_B);

const float f_END_DIRECT_R = max_const(0.12 + END_DIRECT_R);
const float f_END_DIRECT_G = max_const(0.1 + END_DIRECT_G);
const float f_END_DIRECT_B = max_const(0.2 + END_DIRECT_B);

const float f_END_AURORA1_R = max_const(0.0 + END_AURORA1_R);
const float f_END_AURORA1_G = max_const(0.45 + END_AURORA1_G);
const float f_END_AURORA1_B = max_const(0.25 + END_AURORA1_B);

const float f_END_AURORA2_R = max_const(0.45 + END_AURORA2_R);
const float f_END_AURORA2_G = max_const(0.3 + END_AURORA2_G);
const float f_END_AURORA2_B = max_const(0.1 + END_AURORA2_B);

const float f_SUNRISE_AMBIENT = max_const(0.4 + SUNRISE_AMBIENT);
const float f_NOON_AMBIENT = max_const(0.5 + NOON_AMBIENT);
const float f_SUNSET_AMBIENT = max_const(0.5 + SUNSET_AMBIENT);
const float f_NIGHT_AMBIENT = max_const(0.2 + NIGHT_AMBIENT);

const float f_WATER_RED = max_const(0.0 + WATER_RED);
const float f_WATER_GREEN = max_const(0.1 + WATER_GREEN);
const float f_WATER_BLUE = max_const(0.2 + WATER_BLUE);
const float f_WATER_ALPHA = max_const(0.6 + WATER_ALPHA);

const float f_BIOME_WATER_CONTRIBUTION = max_const(0.0 + BIOME_WATER_CONTRIBUTION);

// Visually Vibrant
#elif COLOR_SCHEME == 4

const float f_LM_RED = max_const(1.1 + LM_RED);
const float f_LM_GREEN = max_const(0.9 + LM_GREEN);
const float f_LM_BLUE = max_const(0.85 + LM_BLUE);

const float f_NOON_RED = max_const(1.0 + NOON_RED);
const float f_NOON_GREEN = max_const(0.85 + NOON_GREEN);
const float f_NOON_BLUE = max_const(0.7 + NOON_BLUE);

const float f_SUNRISE_RED = max_const(0.75 + SUNRISE_RED);
const float f_SUNRISE_GREEN = max_const(0.5 + SUNRISE_GREEN);
const float f_SUNRISE_BLUE = max_const(0.45 + SUNRISE_BLUE);

const float f_SUNSET_RED = max_const(0.65 + SUNSET_RED);
const float f_SUNSET_GREEN = max_const(0.45 + SUNSET_GREEN);
const float f_SUNSET_BLUE = max_const(0.3 + SUNSET_BLUE);

const float f_MOON_RED = max_const(0.35 + MOON_RED);
const float f_MOON_GREEN = max_const(0.35 + MOON_GREEN);
const float f_MOON_BLUE = max_const(0.5 + MOON_BLUE);

const float f_NOON_SKY_T_R = max_const(0.3 + NOON_SKY_T_R);
const float f_NOON_SKY_T_G = max_const(0.4 + NOON_SKY_T_G);
const float f_NOON_SKY_T_B = max_const(0.7 + NOON_SKY_T_B);

const float f_SUNRISE_SKY_T_R = max_const(0.23 + SUNRISE_SKY_T_R);
const float f_SUNRISE_SKY_T_G = max_const(0.35 + SUNRISE_SKY_T_G);
const float f_SUNRISE_SKY_T_B = max_const(0.6 + SUNRISE_SKY_T_B);

const float f_SUNSET_SKY_T_R = max_const(0.18 + SUNSET_SKY_T_R);
const float f_SUNSET_SKY_T_G = max_const(0.22 + SUNSET_SKY_T_G);
const float f_SUNSET_SKY_T_B = max_const(0.4 + SUNSET_SKY_T_B);

const float f_NIGHT_SKY_T_R = max_const(0.0 + NIGHT_SKY_T_R);
const float f_NIGHT_SKY_T_G = max_const(0.005 + NIGHT_SKY_T_G);
const float f_NIGHT_SKY_T_B = max_const(0.05 + NIGHT_SKY_T_B);

const float f_END_SKY_T_R = max_const(0.17 + END_SKY_T_R);
const float f_END_SKY_T_G = max_const(0.0 + END_SKY_T_G);
const float f_END_SKY_T_B = max_const(0.24 + END_SKY_T_B);

const float f_NOON_SKY_G_R = max_const(0.6 + NOON_SKY_G_R);
const float f_NOON_SKY_G_G = max_const(0.63 + NOON_SKY_G_G);
const float f_NOON_SKY_G_B = max_const(0.7 + NOON_SKY_G_B);

const float f_SUNRISE_SKY_G_R = max_const(0.5 + SUNRISE_SKY_G_R);
const float f_SUNRISE_SKY_G_G = max_const(0.49 + SUNRISE_SKY_G_G);
const float f_SUNRISE_SKY_G_B = max_const(0.55 + SUNRISE_SKY_G_B);

const float f_SUNSET_SKY_G_R = max_const(0.4 + SUNSET_SKY_G_R);
const float f_SUNSET_SKY_G_G = max_const(0.33 + SUNSET_SKY_G_G);
const float f_SUNSET_SKY_G_B = max_const(0.35 + SUNSET_SKY_G_B);

const float f_NIGHT_SKY_G_R = max_const(0.09 + NIGHT_SKY_G_R);
const float f_NIGHT_SKY_G_G = max_const(0.1 + NIGHT_SKY_G_G);
const float f_NIGHT_SKY_G_B = max_const(0.16 + NIGHT_SKY_G_B);

const float f_SUN_GLARE_R = max_const(0.7 + SUN_GLARE_R);
const float f_SUN_GLARE_G = max_const(0.35 + SUN_GLARE_G);
const float f_SUN_GLARE_B = max_const(0.0 + SUN_GLARE_B);

const float f_NETHER_AMBIENT_R = max_const(0.45 + NETHER_AMBIENT_R);
const float f_NETHER_AMBIENT_G = max_const(0.45 + NETHER_AMBIENT_G);
const float f_NETHER_AMBIENT_B = max_const(0.5 + NETHER_AMBIENT_B);

const float f_END_AMBIENT_R = max_const(0.2 + END_AMBIENT_R);
const float f_END_AMBIENT_G = max_const(0.2 + END_AMBIENT_G);
const float f_END_AMBIENT_B = max_const(0.2 + END_AMBIENT_B);

const float f_END_DIRECT_B = max_const(0.25 + END_DIRECT_B);
const float f_END_DIRECT_R = max_const(0.25 + END_DIRECT_R);
const float f_END_DIRECT_G = max_const(0.25 + END_DIRECT_G);

const float f_END_AURORA1_R = max_const(0.2 + END_AURORA1_R);
const float f_END_AURORA1_G = max_const(0.1 + END_AURORA1_G);
const float f_END_AURORA1_B = max_const(0.6 + END_AURORA1_B);

const float f_END_AURORA2_R = max_const(0.7 + END_AURORA2_R);
const float f_END_AURORA2_G = max_const(0.5 + END_AURORA2_G);
const float f_END_AURORA2_B = max_const(0.0 + END_AURORA2_B);

const float f_SUNRISE_AMBIENT = max_const(0.6 + SUNRISE_AMBIENT);
const float f_NOON_AMBIENT = max_const(0.6 + NOON_AMBIENT);
const float f_SUNSET_AMBIENT = max_const(0.5 + SUNSET_AMBIENT);
const float f_NIGHT_AMBIENT = max_const(0.25 + NIGHT_AMBIENT);

const float f_WATER_RED = max_const(0.33 + WATER_RED);
const float f_WATER_GREEN = max_const(0.2 + WATER_GREEN);
const float f_WATER_BLUE = max_const(0.03 + WATER_BLUE);
const float f_WATER_ALPHA = max_const(0.6 + WATER_ALPHA);

const float f_BIOME_WATER_CONTRIBUTION = max_const(0.7 + BIOME_WATER_CONTRIBUTION);

#endif
