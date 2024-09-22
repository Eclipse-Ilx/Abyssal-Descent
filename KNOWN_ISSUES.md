## Known Bugs & Issues
- Shader TAA causes artifacting when looking into a immersive portal portal  
- Traveling too quickly through dimensions with shaders on causes a crash (without shaders this does not occur typically)  
- RivaTuner Statistics Server (RTSS) is not compatible with Sodium/embeddium [Fix](https://github.com/CaffeineMC/sodium-fabric/wiki/Known-Issues#rtss-incompatible)  
- Sometimes a new dimension will just be transparent when you go to it. Press R to refresh shaders even if you have none toggled on
- Potential shader related issues in the end on Linux
- Ceiland's ceiling cannot be broken and is transparent for some reason when coming from above.
- It's possible to enter a gap between the portal and ceiling of the dimension
- Inexplicit lag spikes lasting few seconds.
- Intel CPU's only: Instant crash (chunk loading overallocated memory) when falling into a portal too fast