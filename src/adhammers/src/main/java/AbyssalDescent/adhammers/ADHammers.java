package AbyssalDescent.adhammers;

import net.minecraft.world.item.Item;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.entity.BlockEntityType;

import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.javafmlmod.FMLJavaModLoadingContext;
import net.minecraftforge.common.MinecraftForge;
import net.minecraftforge.registries.DeferredRegister;
import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.registries.RegistryObject;

import java.util.*;

@Mod(ADHammers.MODID)
public class ADHammers {
	public static final String MODID = "adhammers";

	public static final DeferredRegister<Item> ITEMS = 
		DeferredRegister.create(ForgeRegistries.ITEMS, MODID);
	public static final DeferredRegister<BlockEntityType<?>> BLOCK_ENTITY_TYPES =
		DeferredRegister.create(ForgeRegistries.BLOCK_ENTITY_TYPES, MODID);

	public static final RegistryObject<BlockEntityType<AnvilBE>> ANVILBE =
		BLOCK_ENTITY_TYPES.register("anvilbe", () -> 
			BlockEntityType.Builder.of(AnvilBE::new, 
				Blocks.ANVIL, Blocks.CHIPPED_ANVIL, Blocks.DAMAGED_ANVIL).build(null));


	// TODO: fix these values
	public static final RegistryObject<Hammer> IRON_HAMMER = ITEMS.register("iron_hammer", () ->
		new Hammer(new Hammer.Material(2, 250, 5.0f, Items.IRON_INGOT), 6));

	public static final RegistryObject<Hammer> DIAMOND_HAMMER = ITEMS.register("diamond_hammer", () ->
		new Hammer(new Hammer.Material(3, 500, 6.0f, Items.DIAMOND), 8));

	public static final RegistryObject<Hammer> NETHERITE_HAMMER = ITEMS.register("netherite_hammer", () ->
		new Hammer(new Hammer.Material(4, 800, 7.0f, Items.DIAMOND), 9));


	public static final RegistryObject<Item> COPPER_PLATE       = item("copper_plate"      );
	public static final RegistryObject<Item> IRON_PLATE         = item("iron_plate"        );
	public static final RegistryObject<Item> GOLD_PLATE         = item("gold_plate"        );
	public static final RegistryObject<Item> SILVER_PLATE       = item("silver_plate"      );
	public static final RegistryObject<Item> DIAMOND_PLATE      = item("diamond_plate"     );
	public static final RegistryObject<Item> CLOGGRUM_PLATE     = item("cloggrum_plate"    );
	public static final RegistryObject<Item> FROSTSTEEL_PLATE   = item("froststeel_plate"  );
	public static final RegistryObject<Item> UTHERIUM_PLATE     = item("utherium_plate"    );
	public static final RegistryObject<Item> NETHERITE_PLATE    = item("netherite_plate"   );
	public static final RegistryObject<Item> NETHER_RUBY_PLATE  = item("nether_ruby_plate" );
	public static final RegistryObject<Item> CINCINNASITE_PLATE = item("cincinnasite_plate");


	private static RegistryObject<Item> item(String name) {
		return ITEMS.register(name, () -> new Item(new Item.Properties()));
	}

	public ADHammers() {
		var bus = FMLJavaModLoadingContext.get().getModEventBus();
		MinecraftForge.EVENT_BUS.register(new AnvilEvents());
		ITEMS.register(bus);
		BLOCK_ENTITY_TYPES.register(bus);
	}
}
