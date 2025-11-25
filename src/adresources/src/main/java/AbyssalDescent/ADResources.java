package sh.slb.adresources;

import net.minecraftforge.fml.common.Mod;
import sh.slb.adresources.SemaphoreBlock;

import net.minecraft.core.registries.Registries;
import net.minecraft.world.item.BlockItem;
import net.minecraft.world.item.Item;
import net.minecraft.world.level.block.Block;
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
      register_block("bedrock1", 2);
      register_block("bedrock2", 3);
      register_block("bedrock3", 4);
      register_block("bedrock4", 5);
      register_block("bedrock5", 6);

		register_non_semaphore_block("ore0");
		register_non_semaphore_block("ore1");
		register_non_semaphore_block("ore2");
		register_non_semaphore_block("ore3");
		register_non_semaphore_block("ore4");
		register_non_semaphore_block("ore5");
		register_non_semaphore_block("ore6");
		register_non_semaphore_block("ore7");
		register_non_semaphore_block("ore8");
		register_non_semaphore_block("ore9");

      BLOCKS.register(modEventBus);
      ITEMS.register(modEventBus);
   }

	// TODO: prob invert naming cause sanity
	private static void register_non_semaphore_block(String name) {
		var block = BLOCKS.register(name, () -> new Block(
			BlockBehaviour.Properties.of()
				.mapColor(MapColor.STONE)
				// .strength(50F, 36000F) // FIXME: idk what tf u want @eclipse
		));
		ITEMS.register(name, () -> new BlockItem(block.get(), new Item.Properties()));
	}

   private static void register_block(String name, int level) {
      var block = BLOCKS.register(name, () -> new SemaphoreBlock(
         BlockBehaviour.Properties.of()
            .mapColor(MapColor.STONE)
            .strength(50F, 36000F), level
      ));
      ITEMS.register(name, () -> new BlockItem(block.get(), new Item.Properties()));
   }
}
