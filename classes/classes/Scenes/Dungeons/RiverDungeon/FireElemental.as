/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons.RiverDungeon 
{

import classes.*;
import classes.internals.*;
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

public class FireElemental extends Monster
	{
		public function baseElementalAttack():void {
			outputText(""+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Ifrit":"Fire elemental")+" concentrates flames on its fist before launching a punch toward you.");
			var damage:Number = inte + wis;
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 0.3;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 2);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise punch!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" It hits you square in the chest. ");
				damage = player.takeFireDamage(damage, true);
			}
		}
		
		public function fluffyOfPunches():void {
			outputText(""+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Ifrit":"Fire elemental")+" concentrates embers from its fists before launching a flurry of punches.");
			var damage:Number = inte + wis;
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 0.3;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 1.5);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath it avoiding all punches!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The blazing fists connect with your body. Talk about Pyromania! ");
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
			}
		}
		
		public function subbossSpecial():void {
			outputText("The Ifrit solidiies the ambient elemental energy into countles small fireballs before launching them at you with a thrust of its hands.");
			if (player.getEvasionRoll()) outputText(" You slide underneath the barrage. Talk about Pyromania!");
			else {
				var damage:Number = inte + wis;
				if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
				if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 0.3;
				damage *= 3.75;
				damage = Math.round(damage);
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The flaming spheres explode upon impact with you. Talk about Pyromania! ");
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP1:Number = rand(5);
					if (choiceP1 == 0) fluffyOfPunches();
					if (choiceP1 == 1) baseElementalAttack();
					if (choiceP1 > 1) subbossSpecial();
				}
				else {
					var choice11:Number = rand(6);
					if (choice11 < 2) fluffyOfPunches();
					if (choice11 == 2 || choice11 == 3) baseElementalAttack();
					if (choice11 > 3) subbossSpecial();
				}
			}
			else {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP:Number = rand(5);
					if (choiceP < 4) fluffyOfPunches();
					if (choiceP == 4) baseElementalAttack();
				}
				else {
					var choice1:Number = rand(6);
					if (choice1 < 3) fluffyOfPunches();
					if (choice1 == 3 || choice1 == 4) baseElementalAttack();
					if (choice1 == 5) eAttack();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) SceneLib.dungeons.riverdungeon.defeatFireElementalSubBoss();
			else cleanupAfterCombat();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) SceneLib.dungeons.riverdungeon.defeatedByFireElementalSubBoss();
			else SceneLib.dungeons.riverdungeon.defeatedByFireElemental();
		}
		
		public function FireElemental() 
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 0) {
				this.short = "fire elemental";
				this.imageName = "fire elemental";
				this.long = "You're currently fighting fire elemental. It's a four foot tall body of flame, currently using its bare fists to fight.";
				this.tallness = 48;
				initStrTouSpeInte(10, 20, 40, 50);
				initWisLibSensCor(50, 10, 20, 50);
				this.weaponAttack = 5;
				this.armorDef = 5;
				this.armorMDef = 30;
				this.level = 12;
				this.bonusHP = 400;
				this.additionalXP = 50;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 1) {
				this.short = "fire elemental";
				this.imageName = "fire elemental";
				this.long = "You're currently fighting fire elemental. It's a four foot, three inch tall body of flame, currently using its bare fists to fight.";
				this.tallness = 51;
				initStrTouSpeInte(12, 22, 42, 60);
				initWisLibSensCor(60, 10, 25, 50);
				this.weaponAttack = 6;
				this.armorDef = 6;
				this.armorMDef = 35;
				this.level = 15;
				this.bonusHP = 450;
				this.additionalXP = 75;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 2) {
				this.short = "fire elemental";
				this.imageName = "fire elemental";
				this.long = "You're currently fighting fire elemental. It's a four and a half foot tall body of flame, currently using its bare fists to fight";
				this.tallness = 54;
				initStrTouSpeInte(14, 24, 44, 70);
				initWisLibSensCor(70, 10, 30, 50);
				this.weaponAttack = 7;
				this.armorDef = 7;
				this.armorMDef = 40;
				this.level = 18;
				this.bonusHP = 500;
				this.additionalXP = 100;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 3) {
				this.short = "fire elemental";
				this.imageName = "fire elemental";
				this.long = "You're currently fighting fire elemental. It's a four foot, nine inch tall body of flame, currently using its bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(16, 26, 46, 80);
				initWisLibSensCor(80, 10, 35, 50);
				this.weaponAttack = 8;
				this.armorDef = 8;
				this.armorMDef = 45;
				this.level = 21;
				this.bonusHP = 550;
				this.additionalXP = 125;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {
				this.short = "ifrit";
				this.imageName = "fire ifrit";
				this.long = "You're currently fighting 'female' ifrit. It's a nine foot tall body of flame, currently using its bare fists to fight";
				this.tallness = 108;
				initStrTouSpeInte(24, 39, 69, 120);
				initWisLibSensCor(120, 15, 55, 50);
				this.weaponAttack = 10;
				this.armorDef = 10;
				this.armorMDef = 60;
				this.level = 24;
				this.bonusHP = 875;
				this.additionalXP = 190;
			}
			this.a = "the ";
			this.plural = false;
			this.lustVuln = 0;
			this.drop = new ChainedDrop()
					.add(useables.ELSHARD, 1);
			this.createBreastRow(0, 1);
			initGenderless();
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.armorName = "fire skin";
			this.createPerk(PerkLib.EnemyElementalType, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireNature, 0, 0, 0, 0);
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {
				this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
				this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			}
			checkMonster();
		}
		
	}

}