/**
 * Coded by aimozg on 01.06.2017.
 */
package classes.Items.Consumables {
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Face;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Wings;
import classes.CockTypesEnum;
import classes.Items.Consumable;
import classes.PerkLib;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.CoC;

public class MaraFruit extends Consumable{
	public function MaraFruit() {
		super("MaraFru", "MaraFruit", "an apple-shaped fruit", 10, "This green apple-shaped fruit that spread delicious scent around. You have second thoughts about eating it as this may alter your form in some way like many other fruits.");
	}

	override public function useItem():Boolean {
		var changes:Number = 0;
		var changeLimit:Number = 1;
		if (rand(3) == 0) changeLimit++;
		changeLimit += player.additionalTransformationChances;
		player.slimeFeed();
		//Temporary storage
		var temp2:Number = 0;
		var temp3:Number = 0;
		clearOutput();
		outputText("Biting into it, sweet juices seem to explode from the flesh, dribbling down your chin.  It tastes like a dessert and you chow down, happily munching away.  In no time flat, you're down to just a core.");
		//-Increase strength up to 80.
		if (changes < changeLimit && rand(4) == 0 && player.MutagenBonus("str", 1)) {
			outputText("\n\nYou feel a bit stronger as you take in a deep breath. You reflexively think about taking in more sunlight.");
			changes++;
		}
		//-Increase toughness up to 100.
		if (changes < changeLimit && rand(4) == 0 && player.MutagenBonus("tou", 1)) {
			outputText("\n\nYour body suddenly feels tougher and more resilient just like a tree.");
			changes++;
		}
		//-Reduces speed down to 60.
		if (player.spe > 60 && changes < changeLimit && rand(4) == 0) {
			outputText("\n\nYou start to feel sluggish and cold.  Lying down to bask in the sun might make you feel better.");
			player.addCurse("spe", 2,1);
			changes++;
		}
		if (player.blockingBodyTransformations()) changeLimit = 0;
		//Female changes - pussy to flower (for now unused)
		if (player.gender == 2 || (player.gender == 3 && player.mf("m", "f") == "f")) {
			var boobsGrew:Boolean = false;
			if (player.biggestTitSize() <= 15 && changes < changeLimit && rand(3) == 0) {
				if (rand(2) == 0) outputText("\n\nYour [breasts] tingle for a moment before becoming larger.");
				else outputText("\n\nYou feel a little weight added to your chest as your [breasts] seem to inflate and settle in a larger size.");
				player.growTits(1 + rand(3), 1, false, 3);
				changes++;
				player.addCurse("sen", 1,1);
				boobsGrew = true;
			}
			if (rand(3) == 0 && changes < changeLimit && player.hips.type < 10) {
				outputText("\n\nYour gait shifts slightly to accommodate your widening [hips]. The change is subtle, but they're definitely broader.");
				player.hips.type++;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.butt.type < 8) {
				outputText("\n\nWhen you stand back, up your [ass] jiggles with a good bit of extra weight.");
				player.butt.type++;
				changes++;
			}
			if (player.vaginas.length > 0) {
				outputText("\n\n");
				//0 = dry, 1 = wet, 2 = extra wet, 3 = always slick, 4 = drools constantly, 5 = female ejaculator
				if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) {
					if (player.vaginas.length == 1) outputText("Your [vagina] gushes fluids down your leg as you spontaneously orgasm.");
					else outputText("Your [vagina]s gush fluids down your legs as you spontaneously orgasm, leaving a thick puddle of pussy-juice on the ground.  It is rapidly absorbed by the earth.");
					player.orgasm();
				}
				if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) {
					outputText("After the last few times, you thought that the sudden arousal weakened with each use of the fruit, with the last time having caused you almost no noticeable increase in it. Clearly, you were wrong, as the sudden spike of arousal obligingly points out to you.  ");
					if (player.vaginas.length == 1) outputText("You cannot resist as your hands dive into your [vagina].  ");
					if (player.vaginas.length > 1) outputText("You cannot resist plunging your hands inside your [vagina]s.  ");
					outputText("Your orgasm comes mercifully quickly, accompanied by an impressive spray of your fluids.  Still high from the aphrodisiac effects of the fruit, you cannot help but be delighted at this new development.  <b>You are now a squirter</b>.");
					player.orgasm();
				}
				if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) {
					outputText("You suddenly feel something trickling down your leg. The strong smell of fish slams into your poor unprepared nose, clueing you in as to the nature of the liquid. But just when you are getting used to the idea of smelling like a fishing port, the smell begins to change to a far lighter and sweeter one, which you recognize as that of the fruit. Your [vagina] now constantly drools lubricant down your leg, filling the air with a pleasant scent that most would mistake for perfume.");
				}
				if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) {
					outputText("Once more, the fruit’s effects make themselves known, leaving you hornier and wetter than you already were, the later of which is likely to be permanent. At least this time you were already expecting it, so you weren’t forced to relieve yourself on the spot like the last time.");
				}
				if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) {
					outputText("Suddenly your arousal spikes. You feel as if you had downed several lust drafts while already in heat or rut, forcing you to masturbate furiously on the spot.  ");
					if (player.vaginas.length == 1) outputText("You realize afterwards that your [vagina] felt much wetter than normal.");
					else outputText("You realize afterwards that your [vagina] were much wetter than normal.");
					outputText("  Will you eventually become as juicy as the fruit was?");
				}
				if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) {
					outputText("You feel a tingling in your crotch, but cannot identify it.");
				}
				var temp:int = player.vaginas.length;
				while (temp > 0) {
					temp--;
					if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLAVERING) player.vaginas[temp].vaginalWetness++;
				}
				changes++;
			}
			//Fertility boost
			if (player.vaginas.length > 0 && player.fertility < 40) {
				outputText("\n\nYou feel your womb start to give off a pleasant warmth, instinctively knowing it has become more fertile. Plants <b>are</b> known for their fertility, and you <b>are</b> trying to become somewhat closer to them, so this was to be expected. Perhaps being as fertile as this once verdant land won’t be so bad. Might as well try to give the goddess a run for her money.");
				player.fertility += 5;
				changes++;
			}
		}
		//Male changes
		if (player.gender <= 1 || (player.gender == 3 && player.mf("m", "f") == "m")) {
			if(rand(2) == 0 && player.cockTotal() > player.tentacleCocks()) {
				var choices:Array = [];
				temp = 0;
				while(temp < player.cockTotal()) {
					if(player.cocks[temp].cockType != CockTypesEnum.TENTACLE) choices[choices.length] = temp;
					temp++;
				}
				temp = choices[rand(choices.length)];
				outputText("\n\nYour " + num2Text2(temp+1) + " penis itches, and you idly scratch at it.  As you do, it begins to grow longer and longer, all the way to the ground before you realize something is wrong.  You pull open your [armor] and look down, discovering your " + player.cockDescript(temp) + " has become a tentacle!  As you watch, it shortens back up; it's colored green except for a purplish head, and evidence seems to suggest you can make it stretch out at will.  <b>You now have a");
				if(player.tentacleCocks() > 0) outputText("nother");
				outputText(" tentacle-cock!</b>");
				player.cocks[temp].cockType = CockTypesEnum.TENTACLE;
				player.cocks[temp].knotMultiplier = 1.3;
				dynStats("lus", 10);
				player.addCurse("sen", 3,1);
			}
			if (rand(3) == 0 && changes < changeLimit && player.breastRows.length > 0) {
				//Single row
				if (player.breastRows.length == 1) {
					//Shrink if bigger than B cups
					if (player.breastRows[0].breastRating >= 1) {
						temp = 1;
						player.breastRows[0].breastRating--;
						//Shrink again if huuuuge
						if (player.breastRows[0].breastRating > 8) {
							temp++;
							player.breastRows[0].breastRating--;
						}
						//Talk about shrinkage
						if (temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your " + player.breastDescript(0) + " have shrunk to " + player.breastCup(0) + "s.");
						if (temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are MUCH smaller, down to " + player.breastCup(0) + "s.");
						changes++;
					}
				}
				//multiple
				else {
					//temp2 = amount changed
					//temp3 = counter
					temp = 0;
					temp2 = 0;
					temp3 = 0;
					if (player.biggestTitSize() >= 1) outputText("\n");
					while (temp3 < player.breastRows.length) {
						if (player.breastRows[temp3].breastRating >= 1) {
							player.breastRows[temp3].breastRating--;
							temp2++;
							outputText("\n");
							//If this isn't the first change...
							if (temp2 > 1) outputText("...and y");
							else outputText("Y");
							outputText("our " + player.breastDescript(temp3) + " shrink, dropping to " + player.breastCup(temp3) + "s.");
						}
						temp3++;
					}
					if (temp2 == 2) outputText("\nYou feel so much lighter after the change.");
					if (temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.");
					if (temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
					if (temp2 > 0) changes++;
				}
			}
			if (changes < changeLimit && rand(3) == 0 && player.hips.type >= 4) {
				outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your waistline has narrowed, becoming [hips].");
				player.hips.type--;
				if (player.hips.type > 15) player.hips.type--;
				changes++;
			}
			if(player.butt.type >= 4 && rand(3) == 0 && changes < changeLimit)
			{
				outputText("\n\nYou cringe as your [butt] begins to feel uncomfortably tight.  Once the sensation passes, you look over your shoulder, inspecting yourself.  It would appear that your ass has become smaller!");
				player.butt.type--;
				if(player.butt.type > 10) player.butt.type--;
				if(player.butt.type > 15) player.butt.type--;
				if(player.butt.type > 20) player.butt.type--;
				if(player.butt.type > 23) player.butt.type--;
				changes++;
			}
		}

		//Skin
		if (!player.hasPlainSkinOnly() && !player.isGargoyle() && changes < changeLimit && rand(4) == 0 && player.faceType == Face.HUMAN) {
			outputText("\n\n");
			CoC.instance.transformations.SkinPlain.applyEffect();
			changes++;
		}
		if (player.hasPlainSkinOnly() && player.skinTone != "leaf green" && player.skinTone != "lime green" && player.skinTone != "turquoise" && player.skinTone != "light green" && changes < changeLimit && rand(2) == 0) {
			if (rand(10) == 0) player.skinTone = "turquoise";
			else {
				if (rand(7) == 0) player.skinTone = "lime green";
				else {
					if (rand(4) == 0) player.skinTone = "leaf green";
					else player.skinTone = "light green";
				}
			}
			changes++;
			outputText("\n\nWhoah, that was weird.  You just hallucinated that your skin turned " + player.skinTone + ".  No way!  It's staying, it really changed color!");
		}
		//insert here turning into bark skin so it req. at least 2x use of mara fruit a także dodać wymaganie posiadanie już plant arms i legs
		//Legs
		if (player.skin.hasPlainSkinOnly() && (player.skinTone == "leaf green" || player.skinTone == "lime green" || player.skinTone == "turquoise" || player.skinTone == "light green") && changes < changeLimit && rand(3) == 0) {
			//Males/genderless get clawed feet
			if (player.gender <= 1 || (player.gender == 3 && player.mf("m", "f") == "m")) {
				if (player.lowerBody != LowerBody.PLANT_ROOT_CLAWS) {
					outputText("\n\n");
					CoC.instance.transformations.LowerBodyPlantRootClaws.applyEffect();
				}
			}
			//Females/futa get high heels
			else {
				if (player.lowerBody != LowerBody.PLANT_HIGH_HEELS && player.lowerBody != LowerBody.PLANT_FLOWER) {
					outputText("\n\n");
					CoC.instance.transformations.LowerBodyPlantHighHeels.applyEffect();
				}
			}
			changes++;
		}
		//Arms
		if ((player.lowerBody == LowerBody.PLANT_HIGH_HEELS || player.lowerBody == LowerBody.PLANT_ROOT_CLAWS) && !InCollection(player.arms.type, Arms.GARGOYLE, Arms.PLANT) && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.ArmsPlant.applyEffect();
			changes++;
		}
		//Wings slot aka tentacle cockvine wings
		if (player.arms.type == Arms.PLANT && player.wings.type != Wings.PLANT && player.lowerBody != LowerBody.PLANT_FLOWER && changes < changeLimit && rand(3) == 0) {
			CoC.instance.transformations.WingsPlant.applyEffect();
			changes++;
		}
		//Ears
		if (player.ears.type != Ears.ELFIN && !player.isGargoyle() && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EarsElfin.applyEffect();
			changes++;
		}

		if (CoC.instance.transformations.EyesPlantColors.isPossible() && changes < changeLimit && rand(4) == 0) {
			CoC.instance.transformations.EyesPlantColors.applyEffect(false);
			outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady yourself and open your eyes, you realize something seems different, as if the nerves have been optimized.  Your vision has been changed somehow absorbing more light then normal. When you go look into a water puddle you notice your the changes in full. <b>Your eyes color has changed to [eyecolor].</b>");
			changes++;
		}
		//Face
		if (player.faceType != Face.HUMAN && changes < changeLimit && rand(4) == 0) {
			changes++;
      outputText("\n\n");
      CoC.instance.transformations.FaceHuman.applyEffect(false);
			outputText("\n\nAnother violent sneeze escapes you.  It hurt!  You feel your nose and discover your face has changed back into a more normal look. <b>You have a human looking face again!</b>");
		}
		//Leaf Hair
		if (player.hairColor == "green" && (player.hairType != Hair.LEAF && player.hairType != Hair.GRASS) && !player.isGargoyle() && rand(3) == 0 && changes < changeLimit)
		{
			if (rand(2) == 0) {
				outputText("\n\n");
				CoC.instance.transformations.HairGrass.applyEffect(false);
			}
			else {
				outputText("\n\n");
				CoC.instance.transformations.HairLeaf.applyEffect(false);
			}
			changes++;
		}
		//green hair
		if (player.hairColor != "green" && !player.isGargoyle() && rand(3) == 0 && changes < changeLimit)
		{
			outputText("\n\nAt first it looks like nothing changed but then you realize all the hair on your body has shifted to a verdant green color.  <b>You now have green hair.</b>");
			player.hairColorOnly = "green";
		}
		//Horns
		if ((player.hairType == Hair.LEAF || player.hairType == Hair.GRASS) && changes < changeLimit && rand(2) == 0) {
			//Males/genderless get oak horns
			if (player.gender <= 1 || (player.gender == 3 && player.mf("m", "f") == "m")) {
				outputText("\n\n");
				CoC.instance.transformations.HornsOak.applyEffect();
			}
			//Females/futa get orchid flowers
			else {
				outputText("\n\n");
				CoC.instance.transformations.HornsOrchid.applyEffect();
			}
			changes++;
		}
		//
		if (player.plantScore() >= 7 && player.wings.type == Wings.PLANT && player.hasStatusEffect(StatusEffects.AlrauneFlower) && changes < changeLimit && rand(2) == 0) {
			outputText("\n\nYour close your eyes to appreciate the feeling of the sun on your vegetal skin, losing yourself in the sensation. The feeling is short lived as your feet suddenly tingle with a weird feeling. Opening your eyes you look down in panic as your feet roots themselves in the ground and start to merge together up to your pussy into a trunk which turn a shade of green darker than the rest of your body. Your tentacle wings have also moved down to your feet tips but the weirdest thing happens when everything below your waist grows bloated, easily becoming twice as large as you are. ");
			outputText("Your legs almost look... like a flower about to bloom? Bloom it does indeed as everything below your waist explodes in a orchid of enormous size with petals large enough to engulf you entirely. Worried about being rooted in place you try and move and to your surprise you pretty much discover you can actually walk around on the vine like tentacle cocks at the base of your body. It feels weird at first but you think you will get used to walking on pseudo vines.");
			if (player.tailType != 0) {
				if (player.tailType == 5 || player.tailType == 6) outputText(" Your insectile abdomen recedes");
				else if (player.tailType > 0 && player.tailCount > 1) outputText(" Your tails recede");
				else outputText(" Your tail recedes");
				outputText(" back into your body, disappearing entirely into your backside.");
			}
			CoC.instance.transformations.TailNone.applyEffect(false);
			CoC.instance.transformations.WingsNone.applyEffect(false);
			CoC.instance.transformations.LowerBodyPlantFlower.applyEffect(false);
			player.coatColor = "pink";
			changes++;
		}
		player.refillHunger(10);
		return false;
	}
}
}
