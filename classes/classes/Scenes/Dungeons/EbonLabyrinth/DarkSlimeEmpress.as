/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.EbonLabyrinth
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class DarkSlimeEmpress extends Monster
	{
		private function gooHaremStrike():void
		{
			outputText("The slime girls begin to fondle your ");
			if (player.hasCock()) outputText("[cock]");
			if (player.gender == 3) outputText(" and ");
			if (player.hasVagina()) outputText("[pussy]");
			if (player.gender == 0) outputText("empty nether");
			outputText(" religiously in an all out effort to make you cum the fluids they all so crave");
			if (player.gender == 0) outputText(", though you doubt they’ll get any due to your absence of endowments");
			outputText(". ");
			if (player.isLactating()) outputText("One of them even made suction cup tentacles in order to milk your breasts. ");
			outputText("You’re being violated from all sides and in all possible ways by a full harem of jelly girls!\n\n");
			player.dynStats("lus", 17 + rand(7) + this.sens / 5, "scale", false);
			if (!hasStatusEffect(StatusEffects.LingeringSlime)) createStatusEffect(StatusEffects.LingeringSlime, 0, 0, 0, 0);
		}

		private function gooSlimeBarrage():void
		{
			outputText("The slimes suddenly create bows and arrows out of their body, shooting at you with a volley of slimy aphrodisiac bolts!\n");
            //4 attacks for all
            for (var i:int = 0; i < 4; ++i)
			    gooSlimeBarrageD();
            //up to 8 more, but smoother now
            for (var r:int = 50; r <= 85; r += 5)
			    if (player.spe < ((2*r * (player.newGamePlusMod() + 1)) + rand(r))) gooSlimeBarrageD();
			outputText("\n");
		}
		private function gooSlimeBarrageD():void {
			var td:Number = 7 + rand(5);
			td += player.lib / 8;
			td += player.effectiveSensitivity() / 8;
			td = Math.round(td);
			td = td * (EngineCore.lustPercent() / 100);
			if (!hasStatusEffect(StatusEffects.LingeringSlime)) createStatusEffect(StatusEffects.LingeringSlime, 0, 0, 0, 0);
			outputText("\nLust swells up in your body as the substance splash on you. <b>(<font color=\"#ff00ff\">" + (Math.round(td * 10) / 10) + "</font>)</b> lust damage.");
			player.dynStats("lus", td, "scale", false);
		}

		private function gooGroupGrapple():void
		{
			outputText("The slime girls suddenly attempt to grapple you one after another to restrict your movements!");
			if((player.hasPerk(PerkLib.Evade) && rand(6) == 0) || (player.spe > ((this.spe * 1.5) + rand(200)))) outputText("You barely manage to break out of their clingy bodies!");
			else {
				outputText("Before you know it you’re covered and pulled down by their combined bodies.");
				if (!player.hasStatusEffect(StatusEffects.GooBind)) player.createStatusEffect(StatusEffects.GooBind, 0, 0, 0, 0);
			}
		}

		override protected function performCombatAction():void {
			if (hasStatusEffect(StatusEffects.LingeringSlime)) {
				outputText("Small stains of lingering slimes cling to your body, insidiously pouring you with aphrodisiacs.\n\n");
				player.dynStats("lus", (10 + int(player.lib / 12 + player.cor / 14)));
				removeStatusEffect(StatusEffects.LingeringSlime);
			}
			super.performCombatAction();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.darkSlimeEmpressScene.defeat();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.darkSlimeEmpressScene.defeatedBy();
		}

		public function DarkSlimeEmpress()
		{
			var mod:int = inDungeon ? SceneLib.dungeons.ebonlabyrinth.enemyLevelMod : 3;
            initStrTouSpeInte(120 + 20*mod, 240 + 50*mod, 160 + 40*mod, 150 + 30*mod);
            initWisLibSensCor(150 + 30*mod, 240 + 50*mod, 200 + 10*mod, 10);
            this.armorDef = 60 + 20*mod;
            this.armorMDef = 180 + 60*mod;
            this.bonusHP = 10000 + 2500*mod;
            this.bonusLust = 505 + 65*mod;
            this.level = 60 + 5*mod; //starts from 65 due to EL levelMod calculations;
            this.gems = mod > 50 ? 0 : Math.floor((2500 + rand(500)) * Math.exp(0.3*mod));
            this.additionalXP = mod > 50 ? 0 : Math.floor(10000 * Math.exp(0.3*mod));
            
			this.a = "";
			this.short = "Dark Slime Empress";
			this.imageName = "googirl";
			this.long = "You face a dark slime empress and her purple legion of fanatical slime soldiers all bent on engulfing you! The empress sits on her throne in the back of the room ordering her soldiers around. These gooey soldiers fight with slime made weaponry which, while inefficient at dealing wounds, are quite efficient at arousing you.";
			this.plural = true;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 9001, 0, 0, 0);
			this.createBreastRow(3);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.createStatusEffect(StatusEffects.BonusACapacity,9001,0,0,0);
			this.tallness = 120;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.GOO;
			this.skin.setBaseOnly({color:"purple",type:Skin.GOO});
			this.hairColor = "purple";
			this.hairLength = 12 + rand(10);
			this.weaponName = "hands";
			this.weaponAttack = 35;
			this.weaponVerb="slap";
			this.armorName = "gelatinous skin";
			this.lust = 45;
			this.lustVuln = .75;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.drop = new WeightedDrop(consumables.DSLIMEJ, 1);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.LightningVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGooType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
			this.abilities = [
				{ call: gooHaremStrike, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_FLUID,]},
				{ call: gooGroupGrapple, type: ABILITY_TEASE, range: RANGE_MELEE, tags:[TAG_FLUID]},
				{ call: gooHaremStrike, type: ABILITY_TEASE, range: RANGE_MELEE, tags:[TAG_FLUID], condition: function():Boolean { return player.hasStatusEffect(StatusEffects.GooBind) }, weight:Infinity},
				{ call: gooSlimeBarrage, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_FLUID]}
			]
			checkMonster();
		}
	}
}
