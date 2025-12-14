package AbyssalDescent.adhammers.mixin;

import AbyssalDescent.adhammers.Hammer;

import net.minecraft.client.renderer.LevelRenderer;
import net.minecraft.client.Camera;
import net.minecraft.client.Minecraft;
import net.minecraft.client.renderer.*;
import net.minecraft.core.BlockPos;
import net.minecraft.core.Direction;
import net.minecraft.tags.BlockTags;
import net.minecraft.world.phys.AABB;
import net.minecraft.world.phys.BlockHitResult;

import com.mojang.blaze3d.systems.RenderSystem;
import com.mojang.blaze3d.vertex.PoseStack;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

import org.joml.Matrix4f;

import java.util.stream.*;

@Mixin(LevelRenderer.class)
public class HammerRendererMixin {
	@Inject(method = "renderLevel", at = @At("TAIL"))
	private void render_level_post(
		PoseStack ps, float ticks, long p1, boolean p2,
		Camera camera, GameRenderer p3, LightTexture p4,
		Matrix4f projection, CallbackInfo ci
	) {
		var mc = Minecraft.getInstance();
		if (mc.level == null || mc.player == null) return;
		if (mc.player.isShiftKeyDown()) return;

		var held = mc.player.getMainHandItem();
		if (!(held.getItem() instanceof Hammer hammer)) return;
		if (!(mc.hitResult instanceof BlockHitResult hit)) return;

		var origin = hit.getBlockPos();
		if (!mc.level.getBlockState(origin).is(BlockTags.MINEABLE_WITH_PICKAXE)) return;

		var box = selection_box(hammer.RADIUS, hit.getDirection(), origin);
		var cam = camera.getPosition();
		var shifted = box.move(-cam.x, -cam.y, -cam.z);

		ps.pushPose();

		var matrix = ps.last().pose();

		RenderSystem.depthMask(false);
		RenderSystem.disableDepthTest();
		RenderSystem.enableBlend();
		RenderSystem.defaultBlendFunc();
		RenderSystem.lineWidth(2.0f);

		var lines = mc.renderBuffers().bufferSource().getBuffer(RenderType.LINES);

		LevelRenderer.renderLineBox(ps, lines, shifted, 0f, 0f, 0f, 0.5f);

		mc.renderBuffers().bufferSource().endBatch(RenderType.LINES);

		RenderSystem.enableDepthTest();
		RenderSystem.depthMask(true);

		ps.popPose();
	}

	private static AABB selection_box(int range, Direction side, BlockPos origin) {
		int min_x = Integer.MAX_VALUE, min_y = Integer.MAX_VALUE, min_z = Integer.MAX_VALUE;
		int max_x = Integer.MIN_VALUE, max_y = Integer.MIN_VALUE, max_z = Integer.MIN_VALUE;

		for (var x = -range; x <= range; x++) {
			for (var y = -range; y <= range; y++) {
				var pos = switch (side.getAxis()) {
					case Y -> origin.offset(x, 0, y);
					case X -> origin.offset(0, y, x);
					case Z -> origin.offset(x, y, 0);
				};

				min_x = Math.min(min_x, pos.getX());
				min_y = Math.min(min_y, pos.getY());
				min_z = Math.min(min_z, pos.getZ());
				max_x = Math.max(max_x, pos.getX() + 1);
				max_y = Math.max(max_y, pos.getY() + 1);
				max_z = Math.max(max_z, pos.getZ() + 1);
			}
		}

		return new AABB(min_x, min_y, min_z, max_x, max_y, max_z);
	}
}
