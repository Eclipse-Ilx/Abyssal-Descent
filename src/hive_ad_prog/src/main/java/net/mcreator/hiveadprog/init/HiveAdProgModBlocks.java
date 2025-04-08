
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
import net.mcreator.hiveadprog.block.SpikerootBlock;
import net.mcreator.hiveadprog.block.Spikeroot3Block;
import net.mcreator.hiveadprog.block.Spikeroot2Block;
import net.mcreator.hiveadprog.block.Spikeroot1Block;
import net.mcreator.hiveadprog.block.PoisonousSpikerootBlock;
import net.mcreator.hiveadprog.block.PoisonousSpikeroot3Block;
import net.mcreator.hiveadprog.block.PoisonousSpikeroot2Block;
import net.mcreator.hiveadprog.block.PoisonousSpikeroot1Block;
import net.mcreator.hiveadprog.block.CropCrosserBlock;
import net.mcreator.hiveadprog.HiveAdProgMod;

public class HiveAdProgModBlocks {
	public static final DeferredRegister<Block> REGISTRY = DeferredRegister.create(ForgeRegistries.BLOCKS, HiveAdProgMod.MODID);
	public static final RegistryObject<Block> UNDERBLIGHT = REGISTRY.register("underblight", () -> new UnderblightBlock());
	public static final RegistryObject<Block> UNDERBLIGHT_1 = REGISTRY.register("underblight_1", () -> new Underblight1Block());
	public static final RegistryObject<Block> UNDERBLIGHT_2 = REGISTRY.register("underblight_2", () -> new Underblight2Block());
	public static final RegistryObject<Block> UNDERBLIGHT_3 = REGISTRY.register("underblight_3", () -> new Underblight3Block());
	public static final RegistryObject<Block> SPIKEROOT_3 = REGISTRY.register("spikeroot_3", () -> new Spikeroot3Block());
	public static final RegistryObject<Block> SPIKEROOT_2 = REGISTRY.register("spikeroot_2", () -> new Spikeroot2Block());
	public static final RegistryObject<Block> SPIKEROOT_1 = REGISTRY.register("spikeroot_1", () -> new Spikeroot1Block());
	public static final RegistryObject<Block> SPIKEROOT = REGISTRY.register("spikeroot", () -> new SpikerootBlock());
	public static final RegistryObject<Block> POISONOUS_SPIKEROOT = REGISTRY.register("poisonous_spikeroot", () -> new PoisonousSpikerootBlock());
	public static final RegistryObject<Block> POISONOUS_SPIKEROOT_1 = REGISTRY.register("poisonous_spikeroot_1", () -> new PoisonousSpikeroot1Block());
	public static final RegistryObject<Block> POISONOUS_SPIKEROOT_2 = REGISTRY.register("poisonous_spikeroot_2", () -> new PoisonousSpikeroot2Block());
	public static final RegistryObject<Block> POISONOUS_SPIKEROOT_3 = REGISTRY.register("poisonous_spikeroot_3", () -> new PoisonousSpikeroot3Block());
	public static final RegistryObject<Block> CROP_CROSSER = REGISTRY.register("crop_crosser", () -> new CropCrosserBlock());
	// Start of user code block custom blocks
	// End of user code block custom blocks
}
