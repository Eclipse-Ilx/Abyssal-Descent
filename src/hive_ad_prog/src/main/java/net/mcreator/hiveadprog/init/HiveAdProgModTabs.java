
/*
 *    MCreator note: This file will be REGENERATED on each build.
 */
package net.mcreator.hiveadprog.init;

import net.minecraftforge.registries.RegistryObject;
import net.minecraftforge.registries.DeferredRegister;

import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.CreativeModeTab;
import net.minecraft.network.chat.Component;
import net.minecraft.core.registries.Registries;

import net.mcreator.hiveadprog.HiveAdProgMod;

public class HiveAdProgModTabs {
	public static final DeferredRegister<CreativeModeTab> REGISTRY = DeferredRegister.create(Registries.CREATIVE_MODE_TAB, HiveAdProgMod.MODID);
	public static final RegistryObject<CreativeModeTab> ADSTUFFFROMHIVE = REGISTRY.register("adstufffromhive",
			() -> CreativeModeTab.builder().title(Component.translatable("item_group.hive_ad_prog.adstufffromhive")).icon(() -> new ItemStack(HiveAdProgModBlocks.UNDERBLIGHT_3.get())).displayItems((parameters, tabData) -> {
				tabData.accept(HiveAdProgModBlocks.UNDERBLIGHT.get().asItem());
				tabData.accept(HiveAdProgModBlocks.SPIKEROOT.get().asItem());
			}).build());
}
