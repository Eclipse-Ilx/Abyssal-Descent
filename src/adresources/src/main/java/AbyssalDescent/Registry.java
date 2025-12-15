package AbyssalDescent.adresources;

import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.world.item.BlockItem;
import net.minecraft.world.item.PickaxeItem;
import net.minecraft.world.item.Item;
import net.minecraft.world.InteractionResult;
import net.minecraft.world.InteractionHand;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.phys.BlockHitResult;
import net.minecraft.world.level.Level;
import net.minecraft.world.level.BlockGetter;
import net.minecraft.world.level.block.Block;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.state.BlockState;
import net.minecraft.world.level.block.state.BlockBehaviour;
import net.minecraft.world.level.material.MapColor;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.sounds.SoundSource;
import net.minecraft.core.BlockPos;

import net.minecraftforge.eventbus.api.IEventBus;
import net.minecraftforge.registries.DeferredRegister;
import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.registries.RegistryObject;

import java.util.function.Supplier;

public class Registry {
	public static final DeferredRegister<Block> BLOCKS = DeferredRegister.create(ForgeRegistries.BLOCKS, ADResources.MODID);
	public static final DeferredRegister<Item> ITEMS = DeferredRegister.create(ForgeRegistries.ITEMS, ADResources.MODID);

	public Registry(IEventBus bus) {
		BLOCKS.register(bus);
		ITEMS.register(bus);
	}

	public static final RegistryObject<SemaphoreBlock> BEDROCK1 = register_semaphore_block("bedrock1", 2);
	public static final RegistryObject<SemaphoreBlock> BEDROCK2 = register_semaphore_block("bedrock2", 3);
	public static final RegistryObject<SemaphoreBlock> BEDROCK3 = register_semaphore_block("bedrock3", 4);
	public static final RegistryObject<SemaphoreBlock> BEDROCK4 = register_semaphore_block("bedrock4", 5);
	public static final RegistryObject<SemaphoreBlock> BEDROCK5 = register_semaphore_block("bedrock5", 6);

	public static final RegistryObject<Block> RED_DEEPSTONE_IRON_ORE =
		register_block_with("reddeepstoneironore", () ->
			new Block(BlockBehaviour.Properties.copy(Blocks.DEEPSLATE_IRON_ORE).strength(6.0f)));

	// TODO: particles and sound :)
	public static final RegistryObject<Block> HARDENED_ROOT_BLOCK =
		register_block_with("hardened_root_block", () -> new HardenedRootBlock());


	public static final RegistryObject<Item> EMPTY_FORGOTTEN_BOTTLE =
		ITEMS.register("empty_forgotten_bottle", () -> new Item(new Item.Properties()));

	public static final RegistryObject<Item> ACID_BOTTLE =
		ITEMS.register("acid_bottle", () -> new Item(new Item.Properties().durability(32)));




	public static class HardenedRootBlock extends Block {
		public HardenedRootBlock() { 
			super(BlockBehaviour.Properties.copy(Blocks.BEDROCK)); 
		}

		@Override
		public InteractionResult use(BlockState state, Level level, BlockPos pos, Player player, InteractionHand hand, BlockHitResult hit) {
			var stack = player.getItemInHand(hand);

			if (!(level instanceof ServerLevel server)) return InteractionResult.PASS;
			if (stack.getItem() != Registry.ACID_BOTTLE.get()) return InteractionResult.PASS;

			stack.hurtAndBreak(1, player, p -> p.broadcastBreakEvent(hand));
			level.setBlock(pos, Registry.BEDROCK3.get().defaultBlockState(), 3);
			level.playSound(null, pos, SoundEvents.LAVA_EXTINGUISH, SoundSource.BLOCKS, 0.6f, 1.0f);
			server.sendParticles(
				ParticleTypes.SPIT,
				pos.getX() + 0.5, pos.getY() + 0.5, pos.getZ() + 0.5,
				12, 0.5, 0.5, 0.5, 0.06
			);

			return InteractionResult.sidedSuccess(false);
		}
	}

	public static class SemaphoreBlock extends Block {
		private int tier;

		public SemaphoreBlock(Properties properties, int tier) {
			super(properties);
			this.tier = tier;
		}

		@Override @SuppressWarnings("deprecation")
		public float getDestroyProgress(BlockState state, Player player, BlockGetter level, BlockPos pos) {
			return player.getInventory().getSelected().getItem() instanceof PickaxeItem item 
				&& item.getTier().getLevel() >= this.tier ? 0.02F : 0F;
		}
	}


	private static RegistryObject<Block> register_block_with(String name, Supplier<Block> fn) {
		var block = BLOCKS.register(name, fn);
		ITEMS.register(name, () -> new BlockItem(block.get(), new Item.Properties()));
		return block;
	}

	private static RegistryObject<SemaphoreBlock> register_semaphore_block(String name, int level) {
		var block = BLOCKS.register(name, () -> new SemaphoreBlock(
			BlockBehaviour.Properties.of()
				.mapColor(MapColor.STONE)
				.strength(50F, 36000F), level
		));
		ITEMS.register(name, () -> new BlockItem(block.get(), new Item.Properties()));
		return block;
	}
}
