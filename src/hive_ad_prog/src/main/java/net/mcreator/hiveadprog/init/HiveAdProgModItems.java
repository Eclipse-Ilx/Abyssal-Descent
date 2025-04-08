
/*
 *    MCreator note: This file will be REGENERATED on each build.
 */
package net.mcreator.hiveadprog.init;

import net.minecraftforge.registries.RegistryObject;
import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.registries.DeferredRegister;

import net.minecraft.world.level.block.Block;
import net.minecraft.world.item.Item;
import net.minecraft.world.item.BlockItem;

import net.mcreator.hiveadprog.HiveAdProgMod;

public class HiveAdProgModItems {
	public static final DeferredRegister<Item> REGISTRY = DeferredRegister.create(ForgeRegistries.ITEMS, HiveAdProgMod.MODID);
	public static final RegistryObject<Item> UNDERBLIGHT = block(HiveAdProgModBlocks.UNDERBLIGHT);
	public static final RegistryObject<Item> UNDERBLIGHT_1 = block(HiveAdProgModBlocks.UNDERBLIGHT_1);
	public static final RegistryObject<Item> UNDERBLIGHT_2 = block(HiveAdProgModBlocks.UNDERBLIGHT_2);
	public static final RegistryObject<Item> UNDERBLIGHT_3 = block(HiveAdProgModBlocks.UNDERBLIGHT_3);
	public static final RegistryObject<Item> SPIKEROOT_3 = block(HiveAdProgModBlocks.SPIKEROOT_3);
	public static final RegistryObject<Item> SPIKEROOT_2 = block(HiveAdProgModBlocks.SPIKEROOT_2);
	public static final RegistryObject<Item> SPIKEROOT_1 = block(HiveAdProgModBlocks.SPIKEROOT_1);
	public static final RegistryObject<Item> SPIKEROOT = block(HiveAdProgModBlocks.SPIKEROOT);
	public static final RegistryObject<Item> POISONOUS_SPIKEROOT = block(HiveAdProgModBlocks.POISONOUS_SPIKEROOT);
	public static final RegistryObject<Item> POISONOUS_SPIKEROOT_1 = block(HiveAdProgModBlocks.POISONOUS_SPIKEROOT_1);
	public static final RegistryObject<Item> POISONOUS_SPIKEROOT_2 = block(HiveAdProgModBlocks.POISONOUS_SPIKEROOT_2);
	public static final RegistryObject<Item> POISONOUS_SPIKEROOT_3 = block(HiveAdProgModBlocks.POISONOUS_SPIKEROOT_3);
	public static final RegistryObject<Item> CROP_CROSSER = block(HiveAdProgModBlocks.CROP_CROSSER);

	// Start of user code block custom items
	// End of user code block custom items
	private static RegistryObject<Item> block(RegistryObject<Block> block) {
		return REGISTRY.register(block.getId().getPath(), () -> new BlockItem(block.get(), new Item.Properties()));
	}
}
