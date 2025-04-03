
/*
 *    MCreator note: This file will be REGENERATED on each build.
 */
package net.mcreator.hiveadprog.init;

import net.minecraftforge.registries.RegistryObject;
import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.registries.DeferredRegister;

import net.minecraft.world.level.block.entity.BlockEntityType;
import net.minecraft.world.level.block.Block;

import net.mcreator.hiveadprog.block.entity.UnderblightBlockEntity;
import net.mcreator.hiveadprog.block.entity.Underblight3BlockEntity;
import net.mcreator.hiveadprog.block.entity.Underblight2BlockEntity;
import net.mcreator.hiveadprog.block.entity.Underblight1BlockEntity;
import net.mcreator.hiveadprog.HiveAdProgMod;

public class HiveAdProgModBlockEntities {
	public static final DeferredRegister<BlockEntityType<?>> REGISTRY = DeferredRegister.create(ForgeRegistries.BLOCK_ENTITY_TYPES, HiveAdProgMod.MODID);
	public static final RegistryObject<BlockEntityType<?>> UNDERBLIGHT = register("underblight", HiveAdProgModBlocks.UNDERBLIGHT, UnderblightBlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> UNDERBLIGHT_1 = register("underblight_1", HiveAdProgModBlocks.UNDERBLIGHT_1, Underblight1BlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> UNDERBLIGHT_2 = register("underblight_2", HiveAdProgModBlocks.UNDERBLIGHT_2, Underblight2BlockEntity::new);
	public static final RegistryObject<BlockEntityType<?>> UNDERBLIGHT_3 = register("underblight_3", HiveAdProgModBlocks.UNDERBLIGHT_3, Underblight3BlockEntity::new);

	// Start of user code block custom block entities
	// End of user code block custom block entities
	private static RegistryObject<BlockEntityType<?>> register(String registryname, RegistryObject<Block> block, BlockEntityType.BlockEntitySupplier<?> supplier) {
		return REGISTRY.register(registryname, () -> BlockEntityType.Builder.of(supplier, block.get()).build(null));
	}
}
