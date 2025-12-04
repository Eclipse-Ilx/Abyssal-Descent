package AbyssalDescent.adresources;

import net.minecraftforge.fml.common.Mod;
import AbyssalDescent.adresources.SemaphoreBlock;

import net.minecraft.core.registries.Registries;
import net.minecraft.world.item.BlockItem;
import net.minecraft.world.item.Item;
import net.minecraft.world.level.block.Block;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.state.BlockBehaviour;
import net.minecraft.world.level.material.MapColor;
import net.minecraftforge.eventbus.api.IEventBus;
import net.minecraftforge.fml.javafmlmod.FMLJavaModLoadingContext;
import net.minecraftforge.registries.DeferredRegister;
import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.registries.RegistryObject;

@Mod(ADResources.MODID)
public class ADResources {
	public static final String MODID = "adresources";

	public static DeferredRegister<Block> BLOCKS = DeferredRegister.create(ForgeRegistries.BLOCKS, MODID);
	public static DeferredRegister<Item> ITEMS = DeferredRegister.create(ForgeRegistries.ITEMS, MODID);

	public ADResources() {
		IEventBus modEventBus = FMLJavaModLoadingContext.get().getModEventBus();

		// TODO: wtf clean this up
		register_semaphore_block("bedrock1", 2);
		register_semaphore_block("bedrock2", 3);
		register_semaphore_block("bedrock3", 4);
		register_semaphore_block("bedrock4", 5);
		register_semaphore_block("bedrock5", 6);

		register_block_with("reddeepstoneironore", () -> 
			BlockBehaviour.Properties.copy(Blocks.DEEPSLATE_IRON_ORE)
				.strength(6.0f));

		// TODO: particles and sound :)
		register_block_with("hardened_root_block", () -> 
			BlockBehaviour.Properties.copy(Blocks.BEDROCK));

		// TODO: hardened_root_block + right-click with item -> bedrock3

		register_item_with("empty_forgotten_bottle", () -> new Item.Properties());
		register_item_with("acid_bottle", () -> new Item.Properties());

		BLOCKS.register(modEventBus);
		ITEMS.register(modEventBus);
	}


	interface ItemFn {
		Item.Properties apply();
	}

	private static void register_item_with(String name, ItemFn fn) {
		ITEMS.register(name, () -> new Item(fn.apply()));
	}


	interface BlockFn {
		BlockBehaviour.Properties apply();
	}

	private static void register_block_with(String name, BlockFn fn) {
		var block = BLOCKS.register(name, () -> new Block(fn.apply()));
		ITEMS.register(name, () -> new BlockItem(block.get(), new Item.Properties()));
	}

	private static void register_semaphore_block(String name, int level) {
		var block = BLOCKS.register(name, () -> new SemaphoreBlock(
			BlockBehaviour.Properties.of()
				.mapColor(MapColor.STONE)
				.strength(50F, 36000F), level
		));
		ITEMS.register(name, () -> new BlockItem(block.get(), new Item.Properties()));
	}
}
