const vec2 poisson_disk_2d[] = vec2[8](
        vec2(-0.11995088205640914, 0.719751341508128),
        vec2(0.317022622719358, 0.22113273160666158),
        vec2(-0.26403670704884585, -0.3332036575870605),
        vec2(-0.4956967808947522, 0.1440260614790989),
        vec2(-0.2515255173617287, 0.4485353371596208),
        vec2(0.44577086115163955, 0.4954141319381722),
        vec2(0.18920463723666625, 0.7216180893153676),
        vec2(0.05891867438075504, -0.16082515533796937)
    );

vec3 ssao(vec3 Color, vec3 ViewPos, float Dither, bool IsDH) {
    float Depth = -ViewPos.z;
    float dx = dFdx(Depth);
    float dy = dFdy(Depth);
    
    vec3 Normal = normalize(vec3(dx, dy, (1-dx*dx-dy*dy)));

    float Factor = 0, Hits = 0;

    Dither *= 2 * PI;

    for (int i = 0; i < 8; i++) {
        const float DEPTH_BIAS = 0.00015; // (mostly) fixes AO when looking straight down
        vec3 Sample = vec3(rotate(poisson_disk_2d[i], Dither) * SSAO_SCALE * (1 + float(IsDH)), DEPTH_BIAS);
        Sample *= sign(dot(Normal, Sample));
        Sample += Normal * 0.05;
        Sample += ViewPos;
        vec3 ScreenSamplePos = view_screen(Sample, IsDH);
        if(ScreenSamplePos.xy != clamp(ScreenSamplePos.xy, 0, 1)) continue; // Don't sample if offscreen
        bool IsDH2;
        float RealDepth = get_depth(ScreenSamplePos.xy, IsDH2);
        if(IsDH != IsDH2) {
            ScreenSamplePos = view_screen(Sample, IsDH2);
        }
        if (RealDepth < 0.56) continue; // Skip hand
        Factor += step(RealDepth + 1e-5, ScreenSamplePos.z);
        Hits++;
    }
    Factor /= Hits == 0 ? 1 : Hits;
    return Color * (1 - Factor * SSAO_STRENGTH * (1 + float(IsDH)));
}
