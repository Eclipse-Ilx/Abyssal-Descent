package AbyssalDescent.adhammers;

import net.minecraft.core.BlockPos;
import net.minecraft.server.level.ServerPlayer;

import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.event.level.BlockEvent;
import net.minecraftforge.eventbus.api.SubscribeEvent;

import java.util.*;

@Mod.EventBusSubscriber(modid = ADHammers.MODID, bus = Mod.EventBusSubscriber.Bus.FORGE)
public class HammerEvents {
	private static final List<BlockPos> HARVESTED = new ArrayList<>(9);

	@SubscribeEvent
	public static boolean on_hammer_break(BlockEvent.BreakEvent event) {
		var player = event.getPlayer();
		var hand = player.getMainHandItem();

		if (!(player instanceof ServerPlayer server)) return true;
		if (!(hand.getItem() instanceof Hammer hammer)) return true;
		if (HARVESTED.contains(event.getPos())) return true;

		HARVESTED.add(event.getPos());

		if (server.isCrouching() || server.isShiftKeyDown()) {
			HARVESTED.removeIf(e -> e == event.getPos());
			return true;
		}

		try {
			for (var target : Hammer.blocks_in_radius(event.getPos(), server)) {
				if (HARVESTED.contains(target)) continue;
				if (!hammer.isCorrectToolForDrops(hand, event.getLevel().getBlockState(target))) continue;

				HARVESTED.add(target);
				server.gameMode.destroyBlock(target);
				HARVESTED.removeIf(x -> x == target);
			}
		} finally { 
			HARVESTED.removeIf(e -> e == event.getPos());
		}

		return true;
	}
}
