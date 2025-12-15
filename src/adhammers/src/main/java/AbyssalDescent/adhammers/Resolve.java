package AbyssalDescent.adhammers;

import net.minecraft.world.item.Item;
import net.minecraft.world.item.ItemStack;
import net.minecraft.core.registries.BuiltInRegistries;
import net.minecraft.resources.ResourceLocation;

public class Resolve {
	public static Item item(String ns, String path) {
		return BuiltInRegistries.ITEM.get(new ResourceLocation(ns, path));
	}

	public static ItemStack itemstack(String ns, String path, int count) {
		return new ItemStack(BuiltInRegistries.ITEM.get(new ResourceLocation(ns, path)), count);
	}
}
