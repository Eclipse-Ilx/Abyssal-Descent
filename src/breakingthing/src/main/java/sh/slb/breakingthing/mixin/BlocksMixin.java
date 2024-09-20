package sh.slb.breakingthing.mixin;

import sh.slb.breakingthing.SemaphoreBlock;
import net.minecraft.world.level.block.Block;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.state.BlockBehaviour.Properties;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Redirect;
import org.spongepowered.asm.mixin.injection.Slice;

@Mixin(Blocks.class)
public abstract class BlocksMixin {
   @Redirect(method = "<clinit>", at = @At(value = "NEW", target = "net/minecraft/world/level/block/Block", ordinal = 0), slice = @Slice(from = @At(value = "CONSTANT", args = "stringValue=bedrock")))
   private static Block breakingthing$replaceStone(Properties properties) {
      return new SemaphoreBlock(properties, 4);
   }
}
