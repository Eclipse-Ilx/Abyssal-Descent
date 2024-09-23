package sh.slb.adresources;

import net.minecraftforge.fml.common.Mod;
import sh.slb.adresources.SemaphoreBlock;

import net.minecraft.world.item.BlockItem;
import net.minecraft.world.item.Item;
import net.minecraft.world.level.block.Block;
import net.minecraft.world.level.block.state.BlockBehaviour;
import net.minecraft.world.level.material.Material;
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

   public ADResources(FMLJavaModLoadingContext ctx) {
      IEventBus modEventBus = ctx.getModEventBus();

      register_block("bedrock1", 3);
      register_block("bedrock2", 4);
      register_block("bedrock3", 5);
      register_block("bedrock4", 6);
      register_block("bedrock5", 7);

      BLOCKS.register(modEventBus);
      ITEMS.register(modEventBus);
   }

   private static void register_block(String name, int level) {
      var block = BLOCKS.register(name, () -> new SemaphoreBlock(
         BlockBehaviour.Properties.of(Material.STONE)
            .strength(50F, 36000F), level
      ));
      ITEMS.register(name, () -> new BlockItem(block.get(), new Item.Properties()));
   }
}
