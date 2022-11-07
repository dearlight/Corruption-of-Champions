/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Beach 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

public class DemonPackBeach extends Monster
	{
		
		override public function teased(lustDelta:Number, isNotSilent:Boolean = true):void
		{
			outputText("\n");
			if(lustDelta == 0) outputText("\n" + capitalA + short + " seems unimpressed.");
			else if(lustDelta > 0 && lustDelta < 5) outputText("The demons lessen somewhat in the intensity of their attack, and some even eye up your assets as they strike at you.");
			else if(lustDelta >= 5 && lustDelta < 10) outputText("The demons are obviously steering clear from damaging anything you might use to fuck and they're starting to leave their hands on you just a little longer after each blow. Some are starting to cop quick feels with their other hands and you can smell the demonic lust of a dozen bodies on the air.");
			else if(lustDelta >= 10) outputText("The demons are less and less willing to hit you and more and more willing to just stroke their hands sensuously over you. The smell of demonic lust is thick on the air and part of the group just stands there stroking themselves openly.");
			applyTease(lustDelta);
		}
		
		public function DemonPackBeach() 
		{
			this.a = "the ";
			this.short = "beach demons";
			this.imageName = "demonmob";
			this.long= "The group is composed of roughly fifty tan-skinned demons, mostly humanoid in shape with many and varied corruptions across the mob. You see demonic high heels, twisting horns and swinging cocks of all shapes and sizes. There even seems to be a shark head in there somewhere. You also make out plenty of breasts ranging from tiny ones to a pair that requires a second person to carry them, and with those breasts a wide range of pussies, dripping and dry, sometimes nestled below some form of demonic dick.  The small crew carries no weapons and what little clothing they wear is well-shredded, except for one hefty male wearing a cloak of what appears to be snakeskin across his broad shoulders and eye path over his left eye.  You spot an odd patch that reads, \"<i>42nd East Sea Company: Vaginal Clearance</i>\" on his shoulder.";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock(18,2);
			this.createCock(18,2,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(170, 190, 80, 40);
			initWisLibSensCor(40, 150, 80, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 69;
			this.armorName = "demonic skin";
			this.armorDef = 55;
			this.armorMDef = 10;
			this.bonusHP = 200;
			this.bonusLust = 275;
			this.lust = 30;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 45;
			this.gems = rand(60)+20;
			this.drop = new WeightedDrop().addMany(1,
							consumables.SUCMILK,
							consumables.INCUBID,
							consumables.OVIELIX,
							consumables.B__BOOK);
			this.abilities = [
				{call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[]},
				{call: SceneLib.combat.packAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{call: SceneLib.combat.lustAttack, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[]},
			];
			this.tailType = Tail.DEMONIC;
			this.horns.type = Horns.DEMON;
			this.horns.count = 2;
			this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 45, 0, 0, 0);
			checkMonster();
		}
		
	}

}