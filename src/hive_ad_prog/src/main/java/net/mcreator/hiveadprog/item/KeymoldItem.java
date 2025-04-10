
package net.mcreator.hiveadprog.item;

import net.minecraft.world.item.Rarity;
import net.minecraft.world.item.Item;

public class KeymoldItem extends Item {
	public KeymoldItem() {
		super(new Item.Properties().stacksTo(1).rarity(Rarity.RARE));
	}
}
