package classes.Scenes.Dungeons.DeepCave
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

public class Vala extends Monster
	{
		//Vala AI

		//Blood magic?
		public function valaSpecial1():void {
			outputText("Vala dabs at one of her wounds and swoons.  Is she actually getting off from the wounds?  Damn she's damaged!  Vala licks the blood from her fingers, winks, and blows pink mist from her mouth.");
			//Lightly wounded.
			if(HPRatio() > .7) {
				outputText("  The sweet-smelling cloud rapidly fills the room, but the volume of mist is low enough that you don't end up breathing in that much of it.  It does make your pulse quicken in the most pleasant way though...");
				player.dynStats("lus", 5 + player.lib/20);
			}
			else if(HPRatio() > .4) {
				outputText("  The rose-colored vapor spreads throughout the room, forcing you to breathe it in or pass out from lack of air.  It smells sweet and makes your head swim with sensual promises and your crotch tingle with desire.  Panicked by the knowledge that you're being drugged, you gasp, but it only draws more of the rapidly disappating cloud into your lungs, fueling your lust.");
				player.dynStats("lus", 10 + player.lib/20);
			}
			else {
				outputText("  The cloying, thick cloud of pink spools out from her mouth and fills the room with a haze of bubblegum-pink sweetness.  Even the shallowest, most experimental breath makes your heart pound and your crotch thrum with excitement.  You gasp in another quick breath and sway back and forth on your feet, already on the edge of giving in to the faerie.");
				player.dynStats("lus", 30 + player.lib/10);
			}
		}
		//Milk magic
		public function valaSpecial2():void {
			outputText("With a look of ecstasy on her face, Vala throws back her head and squeezes her pillowy chest with her hands, firing gouts of thick faerie milk from her over-sized bosom!  You try to dodge, but she's squirting so much it's impossible to dodge it all, and in no time you're drenched with a thick coating of Vala's milk.");
			outputText("  She releases her breasts, shaking them back and forth for your benefit, and flutters her wings, blowing shiny, glitter-like flakes at you.  They stick to the milk on your skin, leaving you coated in milk and faerie-dust.");
			outputText("\nVala says, \"<i>Now you can be sexy like Vala!</i>\"\n");

			if(hasStatusEffect(StatusEffects.Milk)) {
				addStatusValue(StatusEffects.Milk,1,5);
				outputText("Your [skin.type] tingles pleasantly, making you feel sexy and exposed.  Oh no!  It seems each coating of milk and glitter is stronger than the last!");
			}
			else {
				createStatusEffect(StatusEffects.Milk,5,0,0,0);
				outputText("You aren't sure if there's something in her milk, the dust, or just watching her squirt and shake for you, but it's turning you on.");
			}
			player.dynStats("lus", statusEffectv1(StatusEffects.Milk) + player.lib / 20);
		}
		//Masturbation
		public function valaMasturbate():void {
			outputText("The mind-fucked faerie spreads her alabaster thighs and dips a finger into the glistening slit between her legs, sliding in and out, only pausing to circle her clit.  She brazenly masturbates, putting on quite the show.  Vala slides another two fingers inside herself and finger-fucks herself hard, moaning and panting lewdly.  Then she pulls them out and asks, \"<i>Did you like that?  Will you fuck Vala now?</i>\"");
			player.dynStats("lus", 4 + player.cor/10);
		}


		//[Fight dialog]
		public function valaCombatDialogue():void {
			if(!hasStatusEffect(StatusEffects.Vala)) {
				outputText("\"<i>Sluts needs to service the masters!</i>\" the fairy wails, flying high. \"<i>If they are not pleased, Bitch doesn't get any cum!</i>\"");
				createStatusEffect(StatusEffects.Vala,0,0,0,0);
			}
			else {
				addStatusValue(StatusEffects.Vala,1,1);
				if(statusEffectv1(StatusEffects.Vala) == 1) outputText("\"<i>If you won't fuck Bitch, you must not be a master,</i>\" she realizes, the fight invigorating her lust-deadened brain. \"<i>You get to be a pet for the masters, too!</i>\"");
				else if(statusEffectv1(StatusEffects.Vala) == 2) outputText("\"<i>If the masters like you, maybe they will let Bitch keep you for herself! Won't you like that?</i>\"");
				else if(statusEffectv1(StatusEffects.Vala) == 3) outputText("\"<i>We obey the masters. They fed Bitch until she became big enough to please them. The masters love their pets so much, you'll see.</i>\"");
				else if(statusEffectv1(StatusEffects.Vala) == 4) outputText("\"<i>Thoughts are so hard. Much easier to be a toy slut. Won't you like being a toy? All that nasty memory fucked out of your head.</i>\"");
				else if(statusEffectv1(StatusEffects.Vala) == 5) outputText("\"<i>Bitch has given birth to many of the masters' children. She will teach you to please the masters. Maybe you can birth more masters for us to fuck?</i>\"");
				else outputText("\"<i>Bitch loves when her children use her as their fathers did. Sluts belong to them. Slut love them. You will love them too!</i>\"");
			}
		}

		override protected function performCombatAction():void
		{
			//VALA SPEAKS!
			valaCombatDialogue();
			outputText("\n\n");
			//Select Attack
			//BLood magic special
			if (HPRatio() < .85 && rand(3) == 0) valaSpecial1();
			//25% chance of milksquirt.
			else if (rand(4) == 0) valaSpecial2();
			else valaMasturbate();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.deepcave.fightValaVictory();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foe doesn't seem put off enough to leave...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.dungeons.deepcave.loseToVala();
			}
		}

		public function Vala()
		{
			this.a = "";
			this.short = "Vala";
			this.imageName = "vala";
			this.long = "While the fey girl is whip-thin, her breasts are disproportionately huge. They'd be at least a DD-cup on a normal human, but for her height and body type, they're practically as large as her head. They jiggle at her slow, uneven breathing, tiny drops of milk bubbling at her nipples with every heartbeat.  She seems fixated on mating with you, and won't take no for an answer.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_GAPING_WIDE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 25, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 4*12;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE;
			this.skinTone = "fair";
			this.hairColor = "purple";
			this.hairLength = 22;
			initStrTouSpeInte(75, 90, 90, 90);
			initWisLibSensCor(90, 55, 35, 50);
			this.weaponName = "fists";
			this.weaponVerb="caresses";
			this.weaponAttack = 1;
			this.armorName = "skin";
			this.armorDef = 1;
			this.armorMDef = 1;
			var lustVuln:Number = .5;
			if(game.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0) lustVuln += .25;
			if(game.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 2) lustVuln += .5;
			var lust:Number = 30 + game.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] * 10;
			if(lust > 80) lust = 80;
			this.bonusHP = 500;
			this.bonusLust = 116;
			this.lust = lust;
			this.lustVuln = lustVuln;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 26;
			this.gems = 1;
			this.additionalXP = 100;
			if(game.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0) this.XP = 10;
			if(game.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 2) this.XP = 1;
			this.special1 = special1;
			this.special2 = special2;
			this.special3 = special3;
			var wingDesc:String = "shimmering wings";
			if(flags[kFLAGS.TIMES_PC_DEFEATED_VALA] == 0) this.drop = new WeightedDrop(consumables.NUMBROX);
			else this.drop = NO_DROP;
			this.wings.type = Wings.BEE_LARGE;
			this.wings.desc = wingDesc;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
