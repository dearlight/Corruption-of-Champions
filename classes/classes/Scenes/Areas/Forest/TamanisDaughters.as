package classes.Scenes.Areas.Forest
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Monsters.Goblin;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

public class TamanisDaughters extends Goblin
	{
		private function midRoundMadness():void {
			var selector:Number = rand(4);
			if(selector == 0) {
				outputText("A slender hand reaches inside your [armor] and gives your ");
				if(player.balls > 0) {
					if(rand(2) == 0) outputText(player.multiCockDescriptLight());
					else outputText(player.ballsDescriptLight());
				}
				else outputText(player.multiCockDescriptLight());
				outputText(" a gentle squeeze.  You twist away but your breathing gets a little heavier.\n\n");
			}
			else if(selector == 1) {
				outputText("A girl latches onto your [legs] and begins caressing your body lovingly, humming happily.  You quickly shake her loose but the attention makes you blush a little more.\n\n");
			}
			else if(selector == 2) {
				outputText("One of your daughters launches onto your back and presses her hard, pierced nipples against your neck.  She whispers in your ear, \"<i>Twist my nipples dad!</i>\"\n\n");
				outputText("You reach back and throw her off, but her perverted taunts still leave you feeling a little hot under the collar.\n\n");
			}
			else outputText("A daughter lays down in front of you and starts jilling herself on the spot.  It's impossible to not glance down and see her or hear her pleasured moans.  You step away to remove the distraction but it definitely causes some discomfort in your [armor].\n\n");
			player.dynStats("lus", 1 + player.lib/15+rand(player.cor/30));
		}

		private function tamaniShowsUp():void {
			if (TamainsDaughtersScene.tamaniPresent) {
				if (rand(4) == 0) goblinDrugAttack(); //Tamani already there - chance of potion
			}
			else if (rand(6) == 0) {
				TamainsDaughtersScene.tamaniPresent = true;
				outputText("A high-pitched yet familiar voice calls out, \"<i><b>So this is where you skanks ran off to---wait a second.  Are you trying to poach Tamani's man!?</b></i>\"\n\n");
				outputText("You can see Tamani lurking around the rear of the goblin pack, visibly berating her daughters.  On one hand it sounds like she might help you, but knowing goblins, she'll probably forget about her anger and help them subdue you for more cum...\n\n");
				//(+5 mob strength)
				strStat.core.value += 5;
				//(+5 mob toughness)
				touStat.core.value += 5;
				HP += 10;
				//(-20 mob lust)
				lust -= 20;
				//append combat desc
				long += " <b>Tamani lurks in the back of the crowd, curvier than her brood and watching with a mixture of amusement and irritation.  She runs a hand through her pink and black hair, waiting for an opportunity to get involved...</b>";
			}
		}

		override protected function performCombatAction():void
		{
			var select:int = 1;
			//mid-round madness!
			midRoundMadness();
			tamaniShowsUp();

			if (special1 != null) select++;
			if (special2 != null) select++;
			if (special3 != null) select++;
			switch (rand(select)) {
				case 0:
					createStatusEffect(StatusEffects.Attacks, int(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 20), 0, 0, 0); //Tamani's Daughters get multiattacks!
					if (statusEffectv1(StatusEffects.Attacks) > 20) addStatusValue(StatusEffects.Attacks, 1, -(statusEffectv1(StatusEffects.Attacks) - 20));
					eAttack();
					break;
				case 1:
					special1();
					break;
				case 2:
					special2();
					break;
				default:
					special3();
					break;
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.forest.tamaniDaughtersScene.combatWinAgainstDaughters();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foes seem visibly disgusted and leave, telling you to, \"<i>quit being so fucking gross...</i>\"");
				SceneLib.combat.cleanupAfterCombatImpl();
			} else {
				SceneLib.forest.tamaniDaughtersScene.loseToDaughters();
			}
		}

		public function TamanisDaughters()
		{
			super(true);
			this.a = "the group of ";
			this.short = "Tamani's daughters";
			this.imageName = "tamanisdaughters";
			this.long = "A large grouping of goblin girls has gathered around you, surrounding you on all sides.  Most have varying shades of green skin, though a few have yellowish or light blue casts to their skin.  All are barely clothed, exposing as much of their flesh as possible in order to excite a potential mate.  Their hairstyles are as varied as their clothing and skin-tones, and the only things they seem to have in common are cute faces and curvy forms.  It looks like they want something from you.";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
			this.tallness = 40;
			this.hips.type = Hips.RATING_AMPLE + 1;
			this.butt.type = Butt.RATING_NOTICEABLE + 1;
			this.skinTone = "greenish gray";
			this.hairColor = "pink";
			this.hairLength = 16;
			initStrTouSpeInte(55, 30, 45, 50);
			initWisLibSensCor(50, 70, 70, 50);
			this.weaponName = "fists";
			this.weaponVerb="tiny punch";
			this.weaponAttack = 5;
			this.armorName = "leather straps";
			this.armorDef = 5;
			this.armorMDef = 1;
			this.bonusHP = 50 + (int(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 2) * 15);
			if (bonusHP > 3350) bonusHP = 3350;
			this.bonusLust = 148 + (int(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 2) * 10);
			if (bonusLust > 2048) bonusLust = 2048;
			this.lust = 30;
			this.lustVuln = .65;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 8 + (Math.floor(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 20));
			if (level > 30) level = 30;
			this.gems = rand(15) + 5;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE,5).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.PURPDYE);
			this.special1 = goblinDrugAttack;
			this.special2 = goblinTeaseAttack;
			if (flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] > 20) this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
			else this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
