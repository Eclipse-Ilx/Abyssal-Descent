## Balance
- Drastically increase loot table in ceilinglands village

## Sound
- Sounds for breaking separator blocks, and for shaped charge explosions
- Add audio to play alongside traveler's titles

## Textures
- Reskin the pink crystal generating in if1
    - Create a diamond ore embedded within the crystal

## Visual

## Progression
- create transition layers (10-20 blocks to mix biomes)
- Shift mining levels of blocks to make copper a separate one above stone
    - Make deepslate (and corresponding ores) mining level copper 

## Aesthetic
- Fix Aether skybox so the transition is less jarring when looking from the overworld
- Improve the vanilla non shader skybox for The Ceilands & all underground biomes
- Remove clouds from the Aether and Ceilands

## Worldgen
- Fill if 5 (prismarine layer) with water **or** replace with some other mod
- Diamond ores should spawn within the pink crystals on if1
- Improve Ceilands generation of some structures
- Increase the size of all biomes
- Drastically increase end island size and height variation
- Remove all structure spawns in infinite abyss dimensions
- Remove if1 (crystal layer) and if4 (mushroom layer)
- Replace if1 with a new dim consisting of all galosphere biomes + some quark shit (ie. ore turtle)
    - Remove overworld amethyst geode gen, and move it to new layer 1
    - Remove biomes added to layer from overworld so they're exclusive

## Mobs
- Populate the water layer with aquamarine mobs

## Other
- create a jeresources preset for new ore generation


-----
## Bugs/Issues

## Critical / Game-Breaking
- #11 Ceiland's ceiling cannot be broken and is transparent for some reason when coming from above.


## Visual
- Shader TAA causes artifacting when looking into a immersive portal portal  
- Potential shader related issues in the end on Linux, fuck nvidia
- fix all skyboxes for underground biomes (we want pitch black)

## Performance
- Inexplicit lag spikes lasting few seconds.

## Other
- It's possible to enter a gap between the portal and ceiling of the dimension

-----
## Wontfix
- RivaTuner Statistics Server (RTSS) is not compatible with Sodium/embeddium [Fix](https://github.com/CaffeineMC/sodium-fabric/wiki/Known-Issues#rtss-incompatible)  
- When a new layer comes into view with shaders you may get a lag spike. i.e mining a block revealing the new layers first block
- Sometimes a new dimension will just be transparent when you go to it. Press R to refresh shaders even if you have none toggled on
