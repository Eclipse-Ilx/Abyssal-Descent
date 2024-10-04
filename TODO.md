## High Priority
- Replace infinite abyss layer 1 with a new dimension consisting of all galosphere cave biomes, spelunkers charm II "the mantle" at the bottom of the dimension and some quark biomes and shiiii. (ie. ore turtle, corundum, etc...)
    - Remove overworld amethyst geode gen, and move it to new layer 1
    - Remove biomes added to layer 1 from overworld so they're exclusive to layer 1
- make [forlorn hollows](https://alexscaves.wiki.gg/wiki/Forlorn_Hollows) generate in the current layer 2 magma cave aka infernal crossing

## Balance
- Drastically increase loot table in ceilinglands structures

## Sound
- Sounds for breaking layer separator blocks, and for shaped charge explosions
- Add audio to play alongside traveler's titles
- Add sounds for new diamond crystal block; it will be encased within the crystals shown below
    [picture1](https://cdn.discordapp.com/attachments/1285851264684523591/1291489661885222933/2024-10-03_12.46.55.png?ex=670048fa&is=66fef77a&hm=6c61ca509377ec9bd80bf70b0689f27d3e572a225677ae7256c1052e984d1c01&) 
    [picture2](https://media.discordapp.net/attachments/1285851264684523591/1291489662606639175/2024-10-03_12.46.59.png?ex=670048fa&is=66fef77a&hm=9a3ee5d0645c42180274fab128a6cbf920614740d98e035c8c2e65bbd5d40b40&=&format=webp&quality=lossless&width=1708&height=897) 
    [picture3](https://media.discordapp.net/attachments/1285851264684523591/1291489663164350546/2024-10-03_12.47.02.png?ex=670048fa&is=66fef77a&hm=aed53e6dfc3b9da148ae8530ad4230e61975bb99f6592a3d2e8e79a4abf7c693&=&format=webp&quality=lossless&width=1708&height=897) 
    [diamond_crystal_block](https://media.discordapp.net/attachments/1285851264684523591/1291489663625990276/2024-10-03_12.56.22.png?ex=670048fa&is=66fef77a&hm=19da090594fb20e45c0bb53c32c853f684f3d178c65096eaf8d02116101c93c1&=&format=webp&quality=lossless&width=1708&height=897)

## Textures

## Visual
- make adresources:bedrock2 emit particles similar to [corundum](https://media.discordapp.net/attachments/1285851264684523591/1291495321469190235/2024-10-03_13.21.06.png?ex=67004e3f&is=66fefcbf&hm=d28e13401c8d4f9254583492be917e7305a016e752d3e98a58c9ba65dc006595&=&format=webp&quality=lossless&width=1708&height=897) from quark
- create low, medium, high and ultra shader presets while keeping the current shader settings and look intact
- add deeper darker plants to block.properties for shader side advanced colored lighting

## Progression
- create transition layers (10-20 blocks to mix biomes)
- Shift mining levels of blocks to make copper a separate one above stone
    - Make deepslate (and corresponding ores) mining level copper 

## Aesthetic
- Fix Aether skybox so the transition is less jarring when looking from the overworld
- Improve the vanilla non shader skybox for The Ceilands & all underground biomes
- Remove clouds from the Aether and Ceilands

## Worldgen
- Improve Ceilands generation of some structures
- Increase the size of all biomes
- Drastically increase end island size and height variation
- Remove/disable infinite abyss structure spawns
- Remove infinite abyss layer (crystal layer) and infinite abyss layer 4 (mushroom layer) from dimension stack

## Mobs
- make some alex's mobs spawn exclusively in the magma cave biome on layer 2 i.e [cave centipede](https://alexs-mobs-unofficial.fandom.com/wiki/Cave_Centipede) as it is lacking in content.

## Other
- create a jeresources preset for new ore generation
- remove the spelunkery dimensional tears from the bottom of the end


-----
## Bugs/Issues

## Critical / Game-Breaking
- #11 Ceiland's ceiling cannot be broken and is transparent for some reason when coming from above.

## Visual
- Shader TAA causes artifacting when looking into a immersive portal portal  
- Potential shader related issues in the end on Linux, fuck nvidia
- fix all skyboxes for underground biomes (we want pitch black)
- shader bug in top left of screen when irradiated

## Performance
- Inexplicit lag spikes lasting few seconds.

## Other
- It's possible to enter a gap between the portal and ceiling of the dimension
- Possible issue when you get to the end your ears will be destroyed by an unknown sound

-----
## Wontfix
- RivaTuner Statistics Server (RTSS) is not compatible with Sodium/embeddium [Fix](https://github.com/CaffeineMC/sodium-fabric/wiki/Known-Issues#rtss-incompatible)  
- When a new layer comes into view with shaders you may get a lag spike. i.e mining a block revealing the new layers first block
- Sometimes a new dimension will just be transparent when you go to it. Press R to refresh shaders even if you have none toggled on
