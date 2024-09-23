package sh.slb.dimthing;

import com.mojang.logging.LogUtils;

import net.minecraft.client.Minecraft;
import net.minecraft.client.gui.Font;
import net.minecraft.client.gui.components.EditBox;
import net.minecraft.client.gui.components.Button;
import net.minecraft.client.gui.screens.Screen;
import net.minecraft.network.chat.Component;
import net.minecraft.network.chat.CommonComponents;

import net.minecraftforge.fml.config.ModConfig;
import net.minecraftforge.fml.ModLoadingContext;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.eventbus.api.SubscribeEvent;
import net.minecraftforge.client.event.CustomizeGuiOverlayEvent;
import net.minecraftforge.client.ConfigScreenHandler;
import net.minecraftforge.common.MinecraftForge;
import net.minecraftforge.common.ForgeConfigSpec;
import net.minecraftforge.fml.IExtensionPoint;
import net.minecraftforge.network.NetworkConstants;

import com.mojang.blaze3d.vertex.PoseStack;
import net.minecraft.core.BlockPos;
import net.minecraft.util.Mth;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraftforge.client.gui.overlay.ForgeGui;

import java.util.ArrayList;
import java.util.function.Function;

import org.slf4j.Logger;

@Mod(DimThing.MODID)
public class DimThing {
   public static final String MODID = "dimthing";
   private static final Logger LOGGER = LogUtils.getLogger();

   public static final int COLOUR = 0xE0E0E0;

   @SuppressWarnings("removal")
   public DimThing() {
      ModLoadingContext.get().registerExtensionPoint(IExtensionPoint.DisplayTest.class, 
         () -> new IExtensionPoint.DisplayTest(() -> NetworkConstants.IGNORESERVERONLY, (remote, isServer) -> true)
      );
   }
   
   @Mod.EventBusSubscriber
   public static class PlayerEvents {
      static Minecraft inst = Minecraft.getInstance();

      @SubscribeEvent
      public static void renderGameOverlayEvent(CustomizeGuiOverlayEvent.DebugText event) {
         if (inst.options.renderDebug || inst.player == null) return;

         try {
            final var dim = inst.player.level.dimension().toString();

            inst.font.draw(event.getPoseStack(),
               String.format("X: %d, Y: %d, Z: %d", 
                  (int) Math.round(inst.player.getX()),
                  (int) Math.round(inst.player.getY() - get_offset(dim)),
                  (int) Math.round(inst.player.getZ())
               ),
               5, 5, DimThing.COLOUR
            );
         } catch (Exception ex) {
            LOGGER.error("Exception thrown: {}", ex.getMessage());
         }
      }

      static int get_offset(String dim) {
         return switch (dim) {
            case "aether:the_aether"            -> -320;
            case "minecraft:overworld"          -> 0;
            case "infinite_abyss:first_layer"   -> 64 + 128;
            case "undergarden:undergarden"      -> 64 + 128 + 128;
            case "infinite_abyss:second_layer"  -> 64 + 128 + 128 + 128;
            case "minecraft:the_nether"         -> 64 + 128 + 128 + 128 + 128;
            case "infinite_abyss:fourth_layer"  -> 64 + 128 + 128 + 128 + 128 + 128;
            case "theabyss:the_abyss"           -> 64 + 128 + 128 + 128 + 128 + 128 + 170;
            case "infinite_abyss:fifth_layer"   -> 64 + 128 + 128 + 128 + 128 + 128 + 170 + 64 + 128;
            case "infinite_abyss:sixth_layer"   -> 64 + 128 + 128 + 128 + 128 + 128 + 170 + 64 + 128 + 128;
            case "deeperdarker:otherside"       -> 64 + 128 + 128 + 128 + 128 + 128 + 170 + 64 + 128 + 128 + 128;
            case "infinite_abyss:seventh_layer" -> 64 + 128 + 128 + 128 + 128 + 128 + 170 + 64 + 128 + 128 + 128 + 128;
            case "ceilands:the_ceilands"        -> 64 + 128 + 128 + 128 + 128 + 128 + 170 + 64 + 128 + 128 + 128 + 128 + 256;
            case "minecraft:the_end"            -> 64 + 128 + 128 + 128 + 128 + 128 + 170 + 64 + 128 + 128 + 128 + 128 + 256 + 256;
            default                             -> 0;
         };
      }
   }
}
