package AbyssalDescent.adhammers.mixin;

import AbyssalDescent.adhammers.AnvilBE;

import net.minecraft.core.BlockPos;
import net.minecraft.world.InteractionResult;
import net.minecraft.world.InteractionHand;
import net.minecraft.world.phys.BlockHitResult;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.level.Level;
import net.minecraft.world.level.block.AnvilBlock;
import net.minecraft.world.level.block.EntityBlock;
import net.minecraft.world.level.block.entity.BlockEntity;
import net.minecraft.world.level.block.state.BlockState;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfoReturnable;

@Mixin(AnvilBlock.class)
public abstract class AnvilBlockMixin implements EntityBlock {
	@Override
	public BlockEntity newBlockEntity(BlockPos pos, BlockState state) {
		return new AnvilBE(pos, state);
	}

	@Inject(method = "use", at = @At("HEAD"), cancellable = true)
	private void no_gui(BlockState p1, Level p2, BlockPos p3, Player player, 
		InteractionHand p4, BlockHitResult p5, CallbackInfoReturnable<InteractionResult> cir
	) {
		if (player.isCrouching() || player.isShiftKeyDown()) {
			cir.setReturnValue(InteractionResult.SUCCESS);
			cir.cancel();
		};
	}
}
