/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Items.WeaponLib;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;
	
	public class Ceani extends Monster
	{
		public function moveBleedingBite():void {
			outputText("Ceani lunges in for a bite tearing a fair chunk out of you and you begin bleeding. ");
			var bleeddura:Number = 3;
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			damage += rand(this.str);
			if (flags[kFLAGS.CEANI_LVL_UP] >= 4) {
				bleeddura += 1;
				damage += eBaseStrengthDamage() * 0.5;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] >= 8) {
				bleeddura += 1;
				damage += eBaseStrengthDamage() * 0.5;
			}
			player.takePhysDamage(damage, true);
			if (player.hasStatusEffect(StatusEffects.IzmaBleed)) player.addStatusValue(StatusEffects.IzmaBleed,1,bleeddura);
			else player.createStatusEffect(StatusEffects.IzmaBleed,bleeddura,0,0,0);
		}
		
		public function moveHarpoonDancing():void {
			outputText("Ceani whirls her harpoon around, striking with both ends of the weapon with calculated and devastating strikes.\n\n");
			outputText("Ceani slashes you for ");
			moveHarpoonDancingDamage();
			outputText(" damage.\n\nCeani impales you for");
			moveHarpoonDancingDamage();
			outputText(" damage.\n\nCeani slams her weapon down onto you for");
			moveHarpoonDancingDamage();
			outputText(" damage.");
		}
		public function moveHarpoonDancingDamage():void {
			var damage:Number = 0;
			damage += eBaseStrengthDamage() * 0.5;
			if (flags[kFLAGS.CEANI_LVL_UP] >= 4) damage += eBaseStrengthDamage() * 0.25;
			if (flags[kFLAGS.CEANI_LVL_UP] >= 8) damage += eBaseStrengthDamage() * 0.25;
			damage += rand(this.str);
			player.takePhysDamage(damage, true);
		}
		
		public function moveTailSlam():void {
			outputText("Ceani’s tail sends you flying to the other edge of the ring. ");
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			if (flags[kFLAGS.CEANI_LVL_UP] >= 4) damage += eBaseStrengthDamage() * 0.5;
			if (flags[kFLAGS.CEANI_LVL_UP] >= 8) damage += eBaseStrengthDamage() * 0.5;
			damage += rand(this.str);
			player.takePhysDamage(damage, true);
			if (!player.hasPerk(PerkLib.Resolute)) {
				outputText(" <b>You are stunned and disarmed by the impact!</b>");
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
				player.setWeapon(WeaponLib.FISTS);
				player.createStatusEffect(StatusEffects.Disarmed, 2, 0, 0, 0);
				player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			}
			createStatusEffect(StatusEffects.AbilityCooldown1, 6, 0, 0, 0);
		}
		
		public function moveTremor():void {
			outputText("Ceani slam her foot in the ground causing it to shake under your feet. You lose your footing and land on your back.");
			player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		
		public function moveAwesomeBlow():void {
			outputText("Ceani grabs her harpoon with both hands and slams it on you in an attempt to hammer you into the ground like a nail. You manage to block the weapon but the titanic impact sends you reeling in pain. ");
			var damage:Number = 0;
			damage += eBaseStrengthDamage() * 0.6;
			if (flags[kFLAGS.CEANI_LVL_UP] >= 4) damage += eBaseStrengthDamage() * 0.3;
			if (flags[kFLAGS.CEANI_LVL_UP] >= 8) damage += eBaseStrengthDamage() * 0.3;
			damage += rand(this.str);
			player.takePhysDamage(damage, true);
			outputText(" damage.");
			player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		
		override protected function performCombatAction():void
		{
			var size:Number = 0;
			if (player.tallness >= 120) size += 3;
			else if (player.tallness >= 108) size += 4;
			else if (player.tallness < 108) size += 5;
			var choice:Number = rand(size);
			if (choice == 0) moveHarpoonDancingDamage();
			if (choice == 1) moveBleedingBite();
			if (choice == 2) {
				if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) moveTailSlam();
				else moveHarpoonDancingDamage();
			}
			if (choice == 3) moveTremor();
			if (choice == 4) moveAwesomeBlow();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.ceaniScene.sparringWithCeaniWon();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.ceaniScene.sparringWithCeaniLost();
		}
		
		public function Ceani() 
		{
			if (flags[kFLAGS.CEANI_LVL_UP] < 5) {
				this.armorDef = 25;
				this.armorMDef = 5;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 0) {
				initStrTouSpeInte(150, 300, 170, 200);
				initWisLibSensCor(200, 200, 80, 50);
				this.weaponAttack = 16;
				this.bonusLust = 318;
				this.level = 38;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 1) {
				initStrTouSpeInte(180, 300, 190, 200);
				initWisLibSensCor(200, 200, 85, 50);
				this.weaponAttack = 24;
				this.bonusLust = 331;
				this.level = 46;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 2) {
				initStrTouSpeInte(210, 300, 210, 200);
				initWisLibSensCor(200, 200, 90, 50);
				this.weaponAttack = 32;
				this.bonusLust = 344;
				this.level = 54;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 3) {
				initStrTouSpeInte(240, 300, 230, 200);
				initWisLibSensCor(200, 200, 95, 50);
				this.weaponAttack = 40;
				this.bonusLust = 357;
				this.level = 62;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 4) {
				initStrTouSpeInte(270, 300, 250, 200);
				initWisLibSensCor(200, 200, 100, 50);
				this.weaponAttack = 48;
				this.bonusLust = 368;
				this.level = 68;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 5) {
				initStrTouSpeInte(300, 320, 270, 210);
				initWisLibSensCor(210, 210, 105, 50);
				this.weaponAttack = 56;
				this.armorDef = 27;
				this.armorMDef = 6;
				this.bonusLust = 389;
				this.level = 74;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 6) {
				initStrTouSpeInte(330, 340, 290, 220);
				initWisLibSensCor(220, 220, 110, 50);
				this.weaponAttack = 64;
				this.armorDef = 29;
				this.armorMDef = 7;
				this.bonusLust = 410;
				this.level = 80;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 7) {
				initStrTouSpeInte(360, 360, 310, 230);
				initWisLibSensCor(230, 230, 115, 50);
				this.weaponAttack = 72;
				this.armorDef = 31;
				this.armorMDef = 8;
				this.bonusLust = 431;
				this.level = 86;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 8) {
				initStrTouSpeInte(390, 380, 330, 240);
				initWisLibSensCor(240, 240, 120, 50);
				this.weaponAttack = 80;
				this.armorDef = 33;
				this.armorMDef = 9;
				this.bonusLust = 352;
				this.level = 92;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 9) {
				initStrTouSpeInte(420, 400, 350, 250);
				initWisLibSensCor(250, 250, 125, 50);
				this.weaponAttack = 88;
				this.armorDef = 35;
				this.armorMDef = 10;
				this.bonusLust = 473;
				this.level = 98;
			}//level up giving 2x all growns and so follow next level ups's as long each npc break lvl 100 (also makes npc use new better gear)
			this.a = "";
			this.short = "Ceani";
			this.long = "You are sparing with Ceani the orca morph. While she is normally smiling all the time this time around she looks like an angry beast about to tear you to shreds. You realise only now how scary her sharp teeth are let alone that massive harpoon she wields. Both strong and swift, she easily proves that underneath her friendly, and at time goofy, demeanor she still is a deadly fighter most people on mareth would rather avoid the wrath of.";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("JJ"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 132;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.skinTone = "black with a white underside";
			this.hairColor = "blue";
			this.hairLength = 13;
			this.weaponName = "harpoon";
			this.weaponVerb="piercing stab";
			this.armorName = "pink bikini";
			this.bonusHP = 2000;
			this.lust = 30;
			this.lustVuln = .8;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 50;
			this.drop = new ChainedDrop().
				//	add(armors.INDESSR,1/10).
				//	add(consumables.L_DRAFT,1/4).
					add(consumables.ORCASUN,0.7);
			this.rearBody.type = RearBody.ORCA_BLOWHOLE;
			this.arms.type = Arms.ORCA;
			this.lowerBody = LowerBody.ORCA;
			this.tailType = Tail.ORCA;
			this.tailRecharge = 0;
			if (flags[kFLAGS.CEANI_LVL_UP] >= 4) {
				this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
				this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.CEANI_LVL_UP] >= 5) {
				this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.CEANI_LVL_UP] >= 6) {
				this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.CEANI_LVL_UP] >= 7) {
				this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
				this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.CEANI_LVL_UP] >= 8) {
				this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
				this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.CEANI_LVL_UP] >= 9) {
				this.createPerk(PerkLib.LegendaryStrength, 0, 0, 0, 0);
				this.createPerk(PerkLib.LegendaryToughness, 0, 0, 0, 0);
			}
			checkMonster();
		}
	}
}