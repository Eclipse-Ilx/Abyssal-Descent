
package net.mcreator.hiveadprog.item;

import net.minecraftforge.registries.ForgeRegistries;

import net.minecraft.world.item.RecordItem;
import net.minecraft.world.item.Rarity;
import net.minecraft.world.item.Item;
import net.minecraft.resources.ResourceLocation;

public class SayItAintSoItem extends RecordItem {
	public SayItAintSoItem() {
		super(0, () -> ForgeRegistries.SOUND_EVENTS.getValue(new ResourceLocation("hive_ad_prog:sayitaintso")), new Item.Properties().stacksTo(1).rarity(Rarity.EPIC), 5200);
	}
}
