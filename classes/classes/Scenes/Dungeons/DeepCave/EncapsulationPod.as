﻿package classes.Scenes.Dungeons.DeepCave
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Skin;
import classes.Scenes.SceneLib;
import classes.internals.*;

/**
	 * ...
	 * @author Fake-Name
	 */

	// This doesn't work, because there is some obnoxious issues with the fact that we only have one instance of monster at any time, and static evaluation
	// of the game leads the compiler to not know if setDescriptionForPlantPot() is available, therefore resulting in an error


	public class EncapsulationPod extends Monster
	{

		public function encapsulationPodAI():void {
			//[Round 1 Action]
			if(!hasStatusEffect(StatusEffects.Round)) {
				outputText("You shiver from the feeling of warm wetness crawling up your [legs].   Tentacles brush against your ");
				if(player.balls > 0) {
					outputText(ballsDescriptLight() + " ");
					if(player.hasVagina()) outputText("and ");
				}
				if(player.hasVagina()) outputText("[vagina]");
				else if(player.balls == 0) outputText("taint ");
				outputText("as they climb ever-further up your body.  In spite of yourself, you feel the touch of arousal licking at your thoughts.\n");
				if(player.lust < 35) {
					player.dynStats("lus", 1);
					player.lust = 35;
					statScreenRefresh();
				}
			}
			//[Round 2 Action]
			else if(statusEffectv1(StatusEffects.Round) == 2) {
				outputText("The tentacles under your [armor] squirm against you, seeking out openings to penetrate and genitalia to caress.  ");
				if(player.balls > 0) outputText("One of them wraps itself around the top of your [sack] while its tip slithers over your [balls].  Another ");
				else outputText("One ");
				if(player.cockTotal() > 0) {
					outputText("prods your [cock] for a second before it begins slithering around it, snake-like.  Once it has you encircled from [cockhead] to ");
					if(!player.hasSheath()) outputText("base");
					else outputText("sheath");
					outputText(", it begins to squeeze and relax to a pleasant tempo.  ");
				}
				else {
					if(player.hasVagina()) {
						outputText("prods at your groin, circling around your " + player.vaginaDescript(0) + " deliberately, as if seeking other toys to play with.  ");
						if(player.clitLength > 4) outputText("It brushes your [clit] then curls around it, squeezing and gently caressing it with a slow, pleasing rhythm.  ");
					}
					else {
						outputText("prods your groin before curling around to circle your " + Appearance.assholeDescript(player) + " playfully.  The entire tendril pulses in a pleasant, relaxing way.  ");
					}
				}
				if(player.cockTotal() > 1) {
					outputText("Your other ");
					if(player.cockTotal() == 2) outputText(cockDescript(1) + " gets the same treatment, and soon both of your [cocks] are quite happy to be here.  ");
					else outputText(player.multiCockDescriptLight() + " get the same treatment and soon feel quite happy to be here.  ");
				}
				if(player.hasVagina()) {
					outputText("The violation of your [vagina] is swift and painless.  The fungus' slippery lubricants make it quite easy for it to slip inside, and you find your [vagina] engorging with pleasure in spite of your need to escape.  The tentacle folds up so that it can rub its stalk over your [clit], ");
					if(player.clitLength > 3) outputText("and once it discovers how large it is, it wraps around it and squeezes.  It feels good!  ");
					else outputText("and it has quite an easy time making your bud grow hard and sensitive.  The constant rubbing feels good!  ");
				}
				outputText("One 'lucky' stalk manages to find your " + Appearance.assholeDescript(player) + ".  As soon as it touches your rear 'entrance', it lunges forward to penetrate you.  The fluids coating the tentacle make your muscles relax, allowing it to slide inside you with ease.\n\n");
				
				outputText("The rest of the mass continues to crawl up you.  They tickle at your ");
				if(player.pregnancyIncubation > 0 && player.pregnancyIncubation < 120) outputText("pregnant ");
				outputText("belly as they get closer and closer to ");
				if(player.biggestTitSize() < 1) outputText("your chest");
				else outputText("the underside of your " + allBreastsDescript());
				outputText(".  Gods above, this is turning you on!  Your lower body is being violated in every conceivable way and it's only arousing you more.  Between the mind-numbing smell and the sexual assault you're having a hard time focusing.\n");
				if(player.lust < 65) {
					player.dynStats("lus", 1);
					player.lust = 65;
					statScreenRefresh();
				}
			}
			//[Round 3 Action]
			else if(statusEffectv1(StatusEffects.Round) == 3) {
				outputText("The wet, warm pressure of the fungus' protrusion working their way up your body feels better than it has any right to be.  It's like a combination of a warm bath and a gentle massage, and when combined with the thought-numbing scent in the air, it's nigh-impossible to resist relaxing a little.  In seconds the mass of tentacles is underneath your [armor] and rubbing over your chest and " + nippleDescript(0) + "s.  You swoon from the sensation and lean back against the wall while they stroke and caress you, teasing your sensitive " + nippleDescript(0) + ".");
				if(player.hasFuckableNipples()) outputText("  Proof of your arousal leaks from each " + nippleDescript(0) + " as their entrances part for the probing tentacles.  They happily dive inside to begin fucking your breasts, doubling your pleasure.");
				outputText("  Moans escape your mouth as your hips begin to rock in time with the tentacles and the pulsing luminance of your fungus-pod.  It would be easy to lose yourself here.  You groan loudly enough to startle yourself back to attention.  You've got to get out!\n\n");
				
				outputText("The tentacles that aren't busy with your [allbreasts] are already climbing higher, and the slime has reached your waist.  If anything it actually makes the constant violation more intense and relaxing.  You start to sink down into it, but catch yourself and pull yourself back up.  No! You've got to fight!\n");
				if(player.lust < 85) {
					player.dynStats("lus", 1);
					player.lust = 85;
					statScreenRefresh();
				}
			}
			//[Round 4 Action]
			else {
				player.dynStats("lus", 1);
				player.lust = player.maxLust();
				statScreenRefresh();
				outputText("What's happening to you definitely isn't rape.  Not anymore.  You like it too much.  You lean back against a wall of the pod and thrust your " + Appearance.hipDescription(player) + " pitifully against a phantom lover, moaning lewdly as you're forcibly pleasured.  You grab hold of the fleshy walls with your hands and try to hold yourself up, but your [legs] have the consistency of jello.   They fold neatly underneath you as you slide into the ooze and begin to float inside it.  It's comforting in an odd way, and while you're gasping in between moans, your balance finally gives out.  You sink deeper into the fluid and lose all sense of direction.  Up and down become meaningless constructs that no longer matter to you.\n\n");
				
				outputText("The thick slime passes over your lips and nose as you sink into the rising tide of bliss, and you find yourself wondering how you'll breathe.  Instinctively, you hold your breath.  Even riddled with sexual bliss and thought-obliterating drugs, you won't let yourself open your mouth when 'underwater'.  The lack of oxygen makes your heart hammer in your chest");
				if(player.cockTotal() > 0) {
					outputText(", and [eachcock] bloats with blood, getting larger than ever");
				}
				outputText(".  Before you can pass out, the constant penetration forces a moan from your lips.\n\n");
				
				outputText("A tentacle takes the opportunity to slip into your mouth along with a wave of the slime.  You try to cough out the fluid, but there isn't any air left in your lungs to push it out.  The orally-fixated tendril widens and begins to pour more of it inside you, and with nowhere else to go, it packs your goo-filled lungs to the brim before you start to swallow.  You relax and exhale the last of your air from your nose as your body calms itself.  Somehow you can breathe the fungus-pod's fluids!\n\n");
				
				outputText("You're floating in pure liquid bliss.  Thoughts melt away before they can form, and every inch of your body is being caressed, squeezed, or penetrated by the warm, slime-slicked tentacles.  Nearly every muscle in your body goes completely slack as you're cradled with bliss.  Without your thoughts or stress bothering you, the pleasure swiftly builds to a crescendo.\n\n");
				
				outputText("The wave of need starts out inside your crotch, begging to be let out, but you can't even be bothered to move your " + Appearance.hipDescription(player) + " anymore.  Without your help, release stays just out of reach, but the tentacles working your body seem intent on spurring it on.  The one inside your " + Appearance.assholeDescript(player) + " begins to pump more quickly, and with the added pressure, you cum quickly.  ");
				if(!player.hasVagina()) {
					outputText("Your body twitches weakly, too relaxed to move while it gets off from anal penetration.");
				}
				else outputText("Your body twitches weakly, too relaxed to move while it gets off from being double-penetrated.");
				if(player.hasFuckableNipples()) {
					outputText("  Your " + nippleDescript(0) + "s squirt around their phallic partners, leaking sexual lubricant ");
					if(player.biggestLactation() > 1) outputText("and milk ");
					outputText("while the fucking continues.");
				}
				if(player.cockTotal() > 0) {
					outputText("  The tentacles around [eachcock] squeeze and rotate, screwing you silly through your orgasm while cum dribbles in a steady stream from your loins.  Normally it would be squirting out in thick ropes, but the muscle-relaxing drugs in your system make the spurts a steady, weak flow.");
					if(player.cumQ() > 800) outputText("  Of course with all the semen you produce, the flesh-pod's ooze clouds over quite quickly, blocking your vision with a purple-white haze.");
				}
				if(player.biggestLactation() > 1) {
					outputText("Milk leaks out too, ");
					if(player.biggestLactation() < 2) outputText("though the slight dribble is barely noticeable to you.");
					else if(player.biggestLactation() < 3) outputText("coloring things a little more white.");
					else outputText("thickening your fluid-filled prison with nutrients.");
				}
				//[NEXT – CHOOSE APPRORIATE]
				doNext(SceneLib.dungeons.deepcave.loseToThisShitPartII);
				return;
			}
			//Set flags for rounds
			if(!hasStatusEffect(StatusEffects.Round)) {
				createStatusEffect(StatusEffects.Round,2,0,0,0);
			}
			else addStatusValue(StatusEffects.Round,1,1);
		}
		
		override protected function performCombatAction():void
		{
			encapsulationPodAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.deepcave.encapsulationVictory();
		}

		override public function get long():String {
			//[Round 1 Description]
			var _long:String;
			if(!hasStatusEffect(StatusEffects.Round)) _long = "You're totally trapped inside a pod!  The walls are slimy and oozing moisture that makes the air sickeningly sweet.  It makes you feel a little dizzy.  Tentacles are climbing up your " + game.player.legs() + " towards your crotch, doing their best to get under you " + game.player.armorName + ".  There's too many to try to pull away.  Your only chance of escape is to create a way out!";
			//[Round 2 Description]
			else if(statusEffectv1(StatusEffects.Round) == 2) {
				_long = "You're still trapped inside the pod!  By now the walls are totally soaked with some kind of viscous slime.  The smell of it is unbearably sweet and you have to put a hand against the wall to steady yourself.  Warm tentacles are curling and twisting underneath your armor, caressing every ";
				if(player.hasFullCoatOfType(Skin.FUR)) _long += "furry ";
				if(player.hasFullCoatOfType(Skin.SCALES)) _long += "scaley ";
				_long += "inch of your [legs], crotch, and " + Appearance.buttDescription(player) + ".";
			}
			//[Round 3 Description]
			else if(statusEffectv1(StatusEffects.Round) == 3) {
				_long = "You're trapped inside the pod and being raped by its many tentacles!   The pooling slime is constantly rising, and in a few moments it will have reached your groin.  The viscous sludge makes it hard to move and the smell of it is making it even harder to think or stand up.  The tentacles assaulting your groin don't stop moving for an instant, and in spite of yourself, some part of you wants them to make you cum quite badly.";
			}
			//[Round 4 Description]
			else {
				_long = "You're trapped inside the pod and being violated by tentacles from the shoulders down!  The slime around your waist is rising even faster now.  It will probably reach ";
				if(player.biggestTitSize() >= 1) _long += "the underside of your " + Appearance.allBreastsDescript(player);
				else _long += "your chest";
				_long += " in moments.  You're being fucked by a bevy of tentacles while your nipples are ";
				if(!player.hasFuckableNipples()) _long += "fondled ";
				else _long += "fucked ";
				_long += "by more of the slippery fungal protrusions.  It would be so easy to just relax back in the fluid and let it cradle you while you're pleasured.  You barely even smell the sweet, thought-killing scent from before, but your hips are rocking on their own and you stumble every time you try to move.  Your resistance is about to give out!";
			}
			//[DAMAGE DESCRIPTS – Used All Rounds]
			//[Greater than 80% Life]
			if(HPRatio() > 0.8) {
				_long += "  The pulsing luminescence continues to oscillate in a regular rhythm.  You haven't done enough damage to the thing to affect it in the slightest.";
			}
			//[Greater than 60% Life]
			else if(HPRatio() > 0.6) {
				_long += "  Your attacks have turned a part of the wall a sickly black color, and it no longer glows along with the rest of your chamber.";
			}
			//[Greater than 40% Life] 
			else if(HPRatio() > 0.4) {
				_long += "  You've dented the wall with your attacks.  It's permanently deformed and bruised solid black from your struggles.  Underneath the spongy surface you can feel a rock-solid core that's beginning to give.";
			}
			//Greater than 20% Life] 
			else if(HPRatio() > 0.2) {
				_long += "  You have to blink your eyes constantly because the capsule's bio-luminescent lighting is going nuts.  The part of the wall you're going after is clearly dead, but the rest of your fungal prison is flashing in a crazy, panicked fashion.";
			}
			//[Greater than 0% Life]
			else {
				_long += "  You can see light through the fractured wall in front of you!  One more solid strike should let you escape!";
			}
			return _long;
		}

		public function EncapsulationPod()
		{
			this.a = "the ";
			this.short = "pod";
			this.imageName = "pod";
			this.long = "";
			// this.plural = false;
			initGenderless();
			createBreastRow(0,0);
			this.tallness = 120;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_BUTTLESS;
			this.skin.setBaseOnly({type:Skin.PLAIN,color:"purple",desc:"covering"});
			this.hairColor = "black";
			this.hairLength = 0;
			initStrTouSpeInte(180, 1, 1, 1);
			initWisLibSensCor(1, 1, 1, 100);
			this.weaponName = "pod";
			this.weaponVerb="pod";
			this.weaponAttack = 4;
			this.armorName = "pod";
			this.armorDef = 4;
			this.armorMDef = 0;
			this.bonusHP = 1200;
			this.lust = 10;
			this.lustVuln = 0;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 28;
			this.gems = 1;
			this.additionalXP = 200;
			this.drop = new WeightedDrop(weapons.JRAPIER, 1);
			this.special1 = special1;
			this.special2 = special2;
			this.special3 = special3;
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}