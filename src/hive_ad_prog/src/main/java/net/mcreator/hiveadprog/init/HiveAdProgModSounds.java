
/*
 *    MCreator note: This file will be REGENERATED on each build.
 */
package net.mcreator.hiveadprog.init;

import net.minecraftforge.registries.RegistryObject;
import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.registries.DeferredRegister;

import net.minecraft.sounds.SoundEvent;
import net.minecraft.resources.ResourceLocation;

import net.mcreator.hiveadprog.HiveAdProgMod;

public class HiveAdProgModSounds {
	public static final DeferredRegister<SoundEvent> REGISTRY = DeferredRegister.create(ForgeRegistries.SOUND_EVENTS, HiveAdProgMod.MODID);
	public static final RegistryObject<SoundEvent> SAYITAINTSO = REGISTRY.register("sayitaintso", () -> SoundEvent.createVariableRangeEvent(new ResourceLocation("hive_ad_prog", "sayitaintso")));
}
