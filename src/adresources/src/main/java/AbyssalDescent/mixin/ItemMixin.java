package AbyssalDescent.adresources.mixin;

import net.minecraft.world.item.Item;
import net.minecraft.world.item.Items;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.TieredItem;
import net.minecraft.world.item.Tiers;
import net.minecraft.world.item.Tier;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.Block;
import net.minecraft.world.level.block.state.BlockState;
import net.minecraft.world.level.block.state.BlockBehaviour;
import net.minecraft.core.BlockPos;
import net.minecraft.world.level.Level;
import net.minecraft.world.entity.player.Player;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.Shadow;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfoReturnable;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;
import net.minecraft.world.item.PickaxeItem;

@Mixin(ItemStack.class)
public abstract class ItemMixin {
	@Shadow
	private Item getItem() { return Items.AIR; }

	@Inject(method = "isCorrectToolForDrops", at = @At("HEAD"), cancellable = true)
	private void onIsCorrectToolForDrops(BlockState state, CallbackInfoReturnable<Boolean> ci) {
		if (state.is(Blocks.COPPER_ORE) || state.is(Blocks.DEEPSLATE_COPPER_ORE)) {
			if (this.getItem() instanceof TieredItem tiered && tiered.getTier().getLevel() >= Tiers.WOOD.getLevel()) {
				ci.setReturnValue(true);
				ci.cancel();
			}
		}
	}
}
