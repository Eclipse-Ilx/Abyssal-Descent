// This file initializes the 4 varyings SKY_TOP, SKY_GROUND, SUN_AMBIENT and SUN_DIRECT
// Call init_colors() in the vertex stage if you need to use these

void get_sky_color() {
    const vec3 SKY_TOP_NOON = to_linear(vec3(f_NOON_SKY_T_R, f_NOON_SKY_T_G, f_NOON_SKY_T_B));
    const vec3 SKY_TOP_SUNRISE = to_linear(vec3(f_SUNRISE_SKY_T_R, f_SUNRISE_SKY_T_G, f_SUNRISE_SKY_T_B));
    const vec3 SKY_TOP_SUNSET = to_linear(vec3(f_SUNSET_SKY_T_R, f_SUNSET_SKY_T_G, f_SUNSET_SKY_T_B));
    const vec3 SKY_TOP_NIGHT = to_linear(vec3(f_NIGHT_SKY_T_R, f_NIGHT_SKY_T_G, f_NIGHT_SKY_T_B));

    const vec3 SKY_GROUND_NOON = to_linear(vec3(f_NOON_SKY_G_R, f_NOON_SKY_G_G, f_NOON_SKY_G_B));
    const vec3 SKY_GROUND_SUNRISE = to_linear(vec3(f_SUNRISE_SKY_G_R, f_SUNRISE_SKY_G_G, f_SUNRISE_SKY_G_B));
    const vec3 SKY_GROUND_SUNSET = to_linear(vec3(f_SUNSET_SKY_G_R, f_SUNSET_SKY_G_G, f_SUNSET_SKY_G_B));
    const vec3 SKY_GROUND_NIGHT = to_linear(vec3(f_NIGHT_SKY_G_R, f_NIGHT_SKY_G_G, f_NIGHT_SKY_G_B));

    SKY_TOP = SKY_TOP_SUNRISE * sunriseStrength + SKY_TOP_NOON * dayStrength + SKY_TOP_SUNSET * sunsetStrength + SKY_TOP_NIGHT * nightStrength;
    SKY_GROUND = SKY_GROUND_SUNRISE * sunriseStrength + SKY_GROUND_NOON * dayStrength + SKY_GROUND_SUNSET * sunsetStrength + SKY_GROUND_NIGHT * nightStrength;

    SKY_TOP = apply_saturation(SKY_TOP, 1 - rainStrength * RAIN_SKY_DESATURATION) * (1 - rainStrength * RAIN_SKY_DARKENING);
    SKY_GROUND = SKY_GROUND * (1 - rainStrength * 0.5);
}

void get_sun_color() {

    #ifdef DIMENSION_NETHER
    SUN_AMBIENT = to_linear(vec3(f_NETHER_AMBIENT_R, f_NETHER_AMBIENT_G, f_NETHER_AMBIENT_B));
    SUN_DIRECT = vec3(0);
    return;
    #elif defined DIMENSION_END
    SUN_AMBIENT = to_linear(vec3(f_END_AMBIENT_R, f_END_AMBIENT_G, f_END_AMBIENT_B));
    SUN_DIRECT = to_linear(vec3(f_END_DIRECT_R, f_END_DIRECT_G, f_END_DIRECT_B));
    return;
    #endif

    SUN_AMBIENT = vec3(f_SUNRISE_AMBIENT * sunriseStrength + f_NOON_AMBIENT * dayStrength + f_SUNSET_AMBIENT * sunsetStrength + f_NIGHT_AMBIENT * nightStrength);
    SUN_AMBIENT = to_linear(SUN_AMBIENT);
    //SUN_AMBIENT = mix(SUN_AMBIENT, mix(SKY_TOP, SKY_GROUND, 0.7), 0.4);

    float LHeight = sin(sunAngleAtHome * PI * 2); // to_player_pos(sunPosN).y;

    if (LHeight > 0) {
        const vec3 SUNRISE_SUN = to_linear(vec3(f_SUNRISE_RED, f_SUNRISE_GREEN, f_SUNRISE_BLUE));
        const vec3 NOON_SUN = to_linear(vec3(f_NOON_RED, f_NOON_GREEN, f_NOON_BLUE));
        const vec3 SUNSET_SUN = to_linear(vec3(f_SUNSET_RED, f_SUNSET_GREEN, f_SUNSET_BLUE));

        SUN_DIRECT = SUNRISE_SUN * sunriseStrength + NOON_SUN * dayStrength + SUNSET_SUN * sunsetStrength;
    }
    else {
        SUN_DIRECT = to_linear(vec3(f_MOON_RED, f_MOON_GREEN, f_MOON_BLUE));

        const float MPI_DIV2 = MOON_PHASE_INFLUENCE / 2;
        float MoonPhaseFactor = cos(float(worldDay % 8) / 8.0 * 2 * PI) * MPI_DIV2 + (1 - MPI_DIV2);
        SUN_DIRECT *= MoonPhaseFactor;
    }
    SUN_DIRECT *= smoothstep(0, 0.2, abs(LHeight)); // Fadeout to avoid harsh transition at sun rise/set
    SUN_DIRECT = apply_saturation(SUN_DIRECT, 1 - rainStrength / 2) * (1 - rainStrength * 0.5);
}

void init_colors() {
    get_sky_color();
    get_sun_color();
}
