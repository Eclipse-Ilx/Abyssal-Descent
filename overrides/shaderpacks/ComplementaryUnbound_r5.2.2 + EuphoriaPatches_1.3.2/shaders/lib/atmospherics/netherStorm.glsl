vec4 GetNetherStorm(vec3 color, vec3 translucentMult, vec3 nPlayerPos, vec3 playerPos, float lViewPos, float lViewPos1, float dither) {
    if (isEyeInWater != 0) return vec4(0.0);
    vec4 netherStorm = vec4(1.0, 1.0, 1.0, 0.0);

    #ifdef BORDER_FOG
        float maxDist = min(renderDistance, NETHER_VIEW_LIMIT); // consistency9023HFUE85JG
    #else
        float maxDist = renderDistance;
    #endif

    #ifndef LOW_QUALITY_NETHER_STORM
        int sampleCount = int(maxDist / 8.0 + 0.001);

        vec3 traceAdd = nPlayerPos * maxDist / sampleCount;
        vec3 tracePos = cameraPosition;
        tracePos += traceAdd * dither;
    #else
        int sampleCount = int(maxDist / 16.0 + 0.001);

        vec3 traceAdd = 0.75 * nPlayerPos * maxDist / sampleCount;
        vec3 tracePos = cameraPosition;
        tracePos += traceAdd * dither;
        tracePos += traceAdd * sampleCount * 0.25;
    #endif

    vec3 translucentMultM = pow(translucentMult, vec3(1.0 / sampleCount));

    for (int i = 0; i < sampleCount; i++) {
        tracePos += traceAdd;

        vec3 tracedPlayerPos = tracePos - cameraPosition;
        float lTracePos = length(tracedPlayerPos);
        if (lTracePos > lViewPos1) break;

        vec3 wind = vec3(frameTimeCounter * 0.002);

        vec3 tracePosM = tracePos * 0.001;
        tracePosM.y += tracePosM.x;
        tracePosM += Noise3D(tracePosM - wind) * 0.01;
        tracePosM = tracePosM * vec3(2.0, 0.5, 2.0);

        float traceAltitudeM = abs(tracePos.y - NETHER_STORM_LOWER_ALT);
        if (tracePos.y < NETHER_STORM_LOWER_ALT) traceAltitudeM *= 10.0;
        traceAltitudeM = 1.0 - min1(abs(traceAltitudeM) / NETHER_STORM_HEIGHT);

        for (int h = 0; h < 4; h++) {
            float stormSample = pow2(Noise3D(tracePosM + wind));
            stormSample *= traceAltitudeM;
            stormSample = pow2(pow2(stormSample));
            stormSample *= sqrt1(max0(1.0 - lTracePos / maxDist));

            netherStorm.a += stormSample;
            tracePosM *= 2.0;
            wind *= -2.0;
        }

        #ifdef EPIC_THUNDERSTORM
            vec3 lightningPos = getLightningPos(tracePos - cameraPosition, lightningBoltPosition.xyz, false);
            vec2 lightningAdd = lightningFlashEffect(lightningPos, vec3(1.0), 150.0, 0.0, 0) * isLightningActive() * 8.0;
            netherStorm.rgb += lightningAdd.y;
        #endif

        if (lTracePos > lViewPos) netherStorm.rgb *= translucentMultM;
    }

    #ifdef LOW_QUALITY_NETHER_STORM
        netherStorm.a *= 1.8;
    #endif

    netherStorm.a = min1(netherStorm.a * NETHER_STORM_I);

    netherStorm.rgb *= netherColor * 3.0 * (1.0 - maxBlindnessDarkness);

    //if (netherStorm.a > 0.98) netherStorm.rgb = vec3(1,0,1);
    //netherStorm.a *= 1.0 - max0(netherStorm.a - 0.98) * 50.0;

    return netherStorm;
}