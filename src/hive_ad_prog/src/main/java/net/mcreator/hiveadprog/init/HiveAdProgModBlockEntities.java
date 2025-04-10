
/*
 *    MCreator note: This file will be REGENERATED on each build.
 */
package net.mcreator.hiveadprog.init;

import net.minecraftforge.registries.RegistryObject;
import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.registries.DeferredRegister;

import net.minecraft.world.level.block.entity.BlockEntityType;
import net.minecraft.world.level.block.Block;

import net.mcreator.hiveadprog.block.entity.UnderbloomsBlockEntity;
import net.mcreator.hiveadprog.block.entity.Underbloom4BlockEntity;
import net.mcreator.hiveadprog.block.entity.Underbloom3BlockEntity;
import net.mcreator.hiveadprog.block.entity.Underbloom2BlockEntity;
import net.mcreator.hiveadprog.block.entity.UnderblightBlockEntity;
import net.mcreator.hiveadprog.block.entity.Underblight3BlockEntity;
import net.mcreator.hiveadprog.block.entity.Underblight2BlockEntity;
import net.mcreator.hiveadprog.block.entity.Underblight1BlockEntity;
import net.mcreator.hiveadprog.block.entity.SpikerootBlockEntity;
import net.mcreator.hiveadprog.block.entity.Spikeroot3BlockEntity;
import net.mcreator.hiveadprog.block.entity.Spikeroot2BlockEntity;
import net.mcreator.hiveadprog.block.entity.Spikeroot1BlockEntity;
import net.mcreator.hiveadprog.block.entity.PoisonousSpikerootBlockEntity;
import net.mcreator.hiveadprog.block.entity.PoisonousSpikeroot3BlockEntity;
import net.mcreator.hiveadprog.block.entity.PoisonousSpikeroot2BlockEntity;
import net.mcreator.hiveadprog.block.entity.PoisonousSpikeroot1BlockEntity;
import net.mcreator.hiveadprog.block.entity.CropCrosserBlockEntity;
import net.mcreator.hiveadprog.HiveAdProgMod;

public class HiveAdProgModBlockEntities {
	public static final DeferredRegister<BlockEntityType<?>> REGISTRY = DeferredRegister.create(ForgeRegistries.BLOCK_ENTITY_TYPES, HiveAdProgMod.MODID);
	public static final RegistryObject<BlockEntityType<?>> UNDERBLIGHT = register("underblight", HiveAdProgModBlocks.UNDERBLIGHT, UnderblightBlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> UNDERBLIGHT_1 = register("underblight_1", HiveAdProgModBlocks.UNDERBLIGHT_1, Underblight1BlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> UNDERBLIGHT_2 = register("underblight_2", HiveAdProgModBlocks.UNDERBLIGHT_2, Underblight2BlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> UNDERBLIGHT_3 = register("underblight_3", HiveAdProgModBlocks.UNDERBLIGHT_3, Underblight3BlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> SPIKEROOT_3 = register("spikeroot_3", HiveAdProgModBlocks.SPIKEROOT_3, Spikeroot3BlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> SPIKEROOT_2 = register("spikeroot_2", HiveAdProgModBlocks.SPIKEROOT_2, Spikeroot2BlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> SPIKEROOT_1 = register("spikeroot_1", HiveAdProgModBlocks.SPIKEROOT_1, Spikeroot1BlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> SPIKEROOT = register("spikeroot", HiveAdProgModBlocks.SPIKEROOT, SpikerootBlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> POISONOUS_SPIKEROOT = register("poisonous_spikeroot", HiveAdProgModBlocks.POISONOUS_SPIKEROOT, PoisonousSpikerootBlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> POISONOUS_SPIKEROOT_1 = register("poisonous_spikeroot_1", HiveAdProgModBlocks.POISONOUS_SPIKEROOT_1, PoisonousSpikeroot1BlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> POISONOUS_SPIKEROOT_2 = register("poisonous_spikeroot_2", HiveAdProgModBlocks.POISONOUS_SPIKEROOT_2, PoisonousSpikeroot2BlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> POISONOUS_SPIKEROOT_3 = register("poisonous_spikeroot_3", HiveAdProgModBlocks.POISONOUS_SPIKEROOT_3, PoisonousSpikeroot3BlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> CROP_CROSSER = register("crop_crosser", HiveAdProgModBlocks.CROP_CROSSER, CropCrosserBlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> UNDERBLOOMS = register("underblooms", HiveAdProgModBlocks.UNDERBLOOMS, UnderbloomsBlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> UNDERBLOOM_2 = register("underbloom_2", HiveAdProgModBlocks.UNDERBLOOM_2, Underbloom2BlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> UNDERBLOOM_3 = register("underbloom_3", HiveAdProgModBlocks.UNDERBLOOM_3, Underbloom3BlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> UNDERBLOOM_4 = register("underbloom_4", HiveAdProgModBlocks.UNDERBLOOM_4, Underbloom4BlockEntity::new);

	// Start of user code block custom block entities
	// End of user code block custom block entities
	private static RegistryObject<BlockEntityType<?>> register(String registryname, RegistryObject<Block> block, BlockEntityType.BlockEntitySupplier<?> supplier) {
		return REGISTRY.register(registryname, () -> BlockEntityType.Builder.of(supplier, block.get()).build(null));
	}
}
