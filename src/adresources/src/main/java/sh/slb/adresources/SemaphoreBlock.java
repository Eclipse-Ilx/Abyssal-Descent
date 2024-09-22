package sh.slb.adresources;

import net.minecraft.core.BlockPos;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.PickaxeItem;
import net.minecraft.world.level.BlockGetter;
import net.minecraft.world.level.block.Block;
import net.minecraft.world.level.block.state.BlockState;

public class SemaphoreBlock extends Block {
   private final int tier;

   public SemaphoreBlock(Properties properties, int mine_tier) {
      super(properties);
      tier = mine_tier;
   }

   @Override @SuppressWarnings("deprecation")
   public float getDestroyProgress(BlockState state, Player player, BlockGetter level, BlockPos pos) {
      return player.getInventory().getSelected().getItem() instanceof PickaxeItem item 
         && item.getTier().getLevel() >= this.tier ? 0.02F : 0F;
   }
}
