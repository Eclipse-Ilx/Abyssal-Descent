
/*
 *    MCreator note: This file will be REGENERATED on each build.
 */
package net.mcreator.hiveadprog.init;

import net.minecraftforge.registries.RegistryObject;
import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.registries.DeferredRegister;

import net.minecraft.world.level.block.Block;

import net.mcreator.hiveadprog.block.UnderblightBlock;
import net.mcreator.hiveadprog.block.Underblight3Block;
import net.mcreator.hiveadprog.block.Underblight2Block;
import net.mcreator.hiveadprog.block.Underblight1Block;
import net.mcreator.hiveadprog.block.Spikeroot3Block;
import net.mcreator.hiveadprog.HiveAdProgMod;

public class HiveAdProgModBlocks {
	public static final DeferredRegister<Block> REGISTRY = DeferredRegister.create(ForgeRegistries.BLOCKS, HiveAdProgMod.MODID);
	public static final RegistryObject<Block> UNDERBLIGHT = REGISTRY.register("underblight", () -> new UnderblightBlock());
	public static final RegistryObject<Block> UNDERBLIGHT_1 = REGISTRY.register("underblight_1", () -> new Underblight1Block());
	public static final RegistryObject<Block> UNDERBLIGHT_2 = REGISTRY.register("underblight_2", () -> new Underblight2Block());
	public static final RegistryObject<Block> UNDERBLIGHT_3 = REGISTRY.register("underblight_3", () -> new Underblight3Block());
	public static final RegistryObject<Block> SPIKEROOT_3 = REGISTRY.register("spikeroot_3", () -> new Spikeroot3Block());
	// Start of user code block custom blocks
	// End of user code block custom blocks
}
