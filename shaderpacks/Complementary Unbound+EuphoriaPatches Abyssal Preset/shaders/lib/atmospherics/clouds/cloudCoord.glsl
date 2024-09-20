#ifndef INCLUDE_CLOUD_COORD
#define INCLUDE_CLOUD_COORD

// Thanks to SixthSurge
vec2 GetRoundedCloudCoord(vec2 pos, float cloudRoundness) { // cloudRoundness is meant to be 0.125 for clouds and 0.35 for cloud shadows
    vec2 coord = pos.xy + 0.5;
    vec2 signCoord = sign(coord);
    coord = abs(coord) + 1.0;
    vec2 i, f = modf(coord, i);
    f = smoothstep(0.5 - cloudRoundness, 0.5 + cloudRoundness, f);
    coord = i + f;
    return (coord - 0.5) * signCoord / 256.0;
}

vec3 ModifyTracePos(vec3 tracePos, int cloudAltitude) {
    #if CLOUD_SPEED_MULT == 100
        float wind = syncedTime;
    #else
        #define CLOUD_SPEED_MULT_M CLOUD_SPEED_MULT * 0.01
        float wind = frameTimeCounter * CLOUD_SPEED_MULT_M;
    #endif

    #if CLOUD_DIRECTION == 2
        tracePos.xz = tracePos.zx;
    #endif

    #if INCREASED_RAIN_STRENGTH == 1
        const float rainSpeedMultiplier = 2.5;
        float dryPos = wind;
        float wetPos = dryPos * (rainSpeedMultiplier * rainFactor + 1.0);

        int rainPhase = int(rainStrength > rainFactor) * 2 - 1; // determins whether the rain begins or ends
        float rainOffset = max0(mod((wetPos - dryPos) * rainPhase, 5120 * rainFactor)) * rainPhase;

        tracePos.x += dryPos + rainOffset;
    #else
        #if INCREASED_RAIN_STRENGTH == 2
            if (rainFactor > 0.01) wind *= 2.5;
        #endif
        tracePos.x += wind;
    #endif

    tracePos.z += cloudAltitude * 64.0;
    tracePos.xz *= CLOUD_NARROWNESS;
    return tracePos.xyz;
}

#endif