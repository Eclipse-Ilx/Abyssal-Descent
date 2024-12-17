if (blockEntityId < 60028) {
    if (blockEntityId < 60012) {
        if (blockEntityId < 60004) {
            if (blockEntityId == 10548) { // Enchanting Table:Book
                smoothnessG = pow2(color.g) * 0.35;

                if (color.b < 0.0001 && color.r > color.g) {
                    emission = color.g * 4.0;
                }
                overlayNoiseIntensity = 0.3;
            } else if (blockEntityId == 60000) { //

            }
        } else {
            if (blockEntityId == 60004) { // Signs
                noSmoothLighting = true;

                if (glColor.r + glColor.g + glColor.b <= 2.99 || lmCoord.x > 0.999) { // Sign Text
                    #include "/lib/materials/specificMaterials/others/signText.glsl"
                }

                #ifdef COATED_TEXTURES
                    noiseFactor = 0.66;
                #endif
            } else if (blockEntityId == 60008) { // Chest
                noSmoothLighting = true;

                smoothnessG = pow2(color.g);

                #ifdef COATED_TEXTURES
                    noiseFactor = 0.66;
                #endif
                redstoneIPBR(color.rgb, emission);
            }
        }
    } else {
        if (blockEntityId < 60020) {
            if (blockEntityId == 60012) { // Ender Chest
                noSmoothLighting = true;

                float factor = min(pow2(color.g), 0.25);
                smoothnessG = factor * 2.0;

                if (color.g > color.r || color.b > color.g)
                    emission = pow2(factor) * 20.0;
                emission += 0.35;
                #if SEASONS == 1 || SEASONS == 4 || defined MOSS_NOISE_INTERNAL || defined SAND_NOISE_INTERNAL
                    overlayNoiseIntensity = 0.7;
                    if (dot(normal, upVec) > 0.99) {
                        #if SNOW_CONDITION < 2 && SNOW_CONDITION != 0
                            emission = mix(emission, emission * 0.8, inSnowy);
                        #elif SNOW_CONDITION == 0
                            emission = mix(emission, emission * 0.8, rainFactor * inSnowy);
                        #else
                            emission *= 0.8;
                        #endif
                    }
                #endif

                #ifdef COATED_TEXTURES
                    noiseFactor = 0.66;
                #endif
            } else /*if (blockEntityId == 60016)*/ { // Shulker Box+, Banner+, Head+, Bed+
                noSmoothLighting = true;
                #ifdef COATED_TEXTURES
                    noiseFactor = 0.2;
                #endif
            }
        } else {
            if (blockEntityId == 60020) { // Conduit
                noSmoothLighting = true;
                lmCoordM.x = 0.9;

                if (color.b > color.r) { // Conduit:Wind, Conduit:Blue Pixels of The Eye
                    emission = color.r * 16.0;
                } else if (color.r > color.b * 2.5) { // Conduit:Red Pixels of The Eye
                    emission = 20.0;
                    color.rgb *= vec3(1.0, 0.25, 0.1);
                }
                overlayNoiseIntensity = 0.3;
            } else /*if (blockEntityId == 60024)*/ { // End Portal, End Gateway
                #if END_PORTAL_VARIATION != 2
                    #include "/lib/materials/specificMaterials/others/endPortalEffect.glsl"
                #endif
                overlayNoiseIntensity = 0.0;
            }
        }
    }
} else {
    if (blockEntityId < 60044) {
        if (blockEntityId < 60036) {
            if (blockEntityId == 60028) { //

            } else /*if (blockEntityId == 60032)*/ { // Bell
                if (color.r + color.g > color.b + 0.5) { // Bell:Golden Part
                    #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                } else {
                    #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                }
            }
        } else {
            if (blockEntityId == 60036) { // 
            
            } else /*if (blockEntityId == 60040)*/ { //

            }
        }
    } else {
        if (blockEntityId < 60052) {
            if (blockEntityId == 60044) { //

            } else /*if (blockEntityId == 60048)*/ { //

            }
        } else {
            if (blockEntityId == 60052) { //

            } else if (blockEntityId == 60056) { //

            }
        }
    }
}