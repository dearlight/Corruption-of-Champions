package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class GoblinShaman extends Goblin
	{
		public var spellCostCharge:int = 6;
		public var spellCostBlind:int = 8;
		public var spellCostWhitefire:int = 12;
		public var spellCostArouse:int = 6;
		public var spellCostHeal:int = 8;
		public var spellCostMight:int = 10;
		
		public function castSpell():void {
			var spellChooser:int = rand(6);
			//Makes sure to not stack spell effects.
			if (lust < 50) spellChooser = rand(3);
			if (lust > 75) spellChooser = rand(3) + 3;
			if (spellChooser == 0 && hasStatusEffect(StatusEffects.ChargeWeapon)) {
				spellChooser = rand(5) + 1;
			}
			if (spellChooser == 4 && HPRatio() >= 0.7) {
				spellChooser++;
			}
			if (spellChooser == 5 && statStore.hasBuff("GoblinMight")) {
				spellChooser = rand(5);
				if (spellChooser == 0 && hasStatusEffect(StatusEffects.ChargeWeapon)) spellChooser++;
			}
			//Spell time!
			//Charge Weapon
			if (spellChooser == 0 && fatigue <= (100 - spellCostCharge)) {
				outputText("The goblin utters word of power, summoning an electrical charge around her staff. <b>It looks like she'll deal more physical damage now!</b>");
				createStatusEffect(StatusEffects.ChargeWeapon, 25 * spellMultiplier(), 0, 0, 0);
				this.weaponAttack += 25 * spellMultiplier();
				fatigue += spellCostCharge;
			}
			//Blind
			else if (spellChooser == 1 && fatigue <= (100 - spellCostBlind)) {
				outputText("The goblin glares at you and points at you! A bright flash erupts before you!  ");
				if ((!player.hasPerk(MutationsLib.GorgonsEyes) && rand(player.inte / 5) <= 4) && !player.hasPerk(PerkLib.BlindImmunity)) {
					outputText("<b>You are blinded!</b>");
					player.createStatusEffect(StatusEffects.Blind, 1 + rand(3), 0, 0, 0);
				}
				else if (player.hasPerk(MutationsLib.GorgonsEyes)) {
					outputText("Your mutated eyes are uneffected by the blinding light!");
				}
				else {
					outputText("You manage to blink in the nick of time!");
				}
				fatigue += spellCostBlind;
			}
			//Whitefire
			else if (spellChooser == 2 && fatigue <= (100 - spellCostWhitefire)) {
				outputText("The goblin narrows her eyes and focuses her mind with deadly intent. She snaps her fingers and you are enveloped in a flash of white flames!  ");
				var damage:int = inte + rand(50) * spellMultiplier();
				if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				player.addStatusValue(StatusEffects.Blizzard, 1, -1);
				outputText("Luckily, your ice maelstorm still surrounds you, reducing the damage you take.  ");
				damage *= 0.2;
				}
				if (player.isGoo()) {
					damage *= 1.5;
					outputText("It's super effective! ");
				}
				if (flags[kFLAGS.GAME_DIFFICULTY] == 1) damage *= 1.2;
				else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) damage *= 1.5;
				else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) damage *= 2;
				else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) damage *= 3.5;
				damage = Math.round(damage);
				player.takeFireDamage(damage, true);
				fatigue += spellCostWhitefire;
			}
			//Arouse
			else if (spellChooser == 3 && fatigue <= (100 - spellCostArouse)) {
				outputText("She makes a series of arcane gestures, drawing on her lust to inflict it upon you! ");
				var lustDamage:int = (inte / 10) + (player.lib / 10) + rand(10) * spellMultiplier();
				lustDamage = lustDamage * (EngineCore.lustPercent() / 100);
				player.dynStats("lus", lustDamage, "scale", false);
				outputText(" <b>(<font color=\"#ff00ff\">" + (Math.round(lustDamage * 10) / 10) + "</font>)</b>");
				fatigue += spellCostArouse;
			}
			//Heal
			else if (spellChooser == 4 && fatigue <= (100 - spellCostHeal)) {
				outputText("She focuses on her body and her desire to end pain, trying to draw on her arousal without enhancing it.");
				var temp:int = int(10 + (inte/2) + rand(inte/3)) * spellMultiplier();
				outputText("She flushes with success as her wounds begin to knit! <b>(<font color=\"#008000\">+" + temp + "</font>)</b>.");
				addHP(temp);
				fatigue += spellCostHeal;
			}
			//Might
			else if (spellChooser == 5 && fatigue <= (100 - spellCostMight)) {
				outputText("She flushes, drawing on her body's desires to empower her muscles and toughen her up.");
				outputText("The rush of power flows through her body.");
				statStore.addBuffObject({str:+20 * spellMultiplier(), tou:+20 * spellMultiplier()},"GoblinMight")
				fatigue += spellCostMight;
			}
		}
		
		private function spellMultiplier():Number {
			var mult:Number = 1;
			mult += player.newGamePlusMod() * 0.5;
			return mult;
		}
		
		override protected function performCombatAction():void {
			var choice:Number = rand(8);
			if (choice < 3) eAttack();
			else if (choice == 3) goblinDrugAttack();
			else if (choice == 4) goblinTeaseAttack();
			else castSpell();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.goblinShamanScene.goblinShamanRapeIntro();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.gender == 0) {
				outputText("You collapse in front of the goblin, too wounded to fight.  She growls and kicks you in the head, making your vision swim. As your sight fades, you hear her murmur, \"<i>Fucking dumbasses. You can't even bother to grow something?</i>\"");
				SceneLib.combat.cleanupAfterCombatImpl();
			} 
			else {
				SceneLib.goblinShamanScene.goblinShamanBeatYaUp();
			}
		}
		
		public function GoblinShaman()
		{
			this.a = "the ";
			this.short = "goblin shaman";
			this.imageName = "goblinshaman";
			this.long = "The goblin before you stands approximately three and a half feet tall. Her ears appear to be pierced more than most goblins. Her hair is deep indigo. She’s wielding a staff in her right hand. In addition to the straps covering her body, she’s wearing a necklace seemingly carved with what looks like shark teeth. She’s also wearing a tattered loincloth, unlike most goblins, who would show off their pussies. From the looks of one end of her staff glowing, she’s clearly a shaman!";
			if (player.hasCock()) this.long += "  She's clearly intent on casting you into submission, to forcibly make you impregnate her.";
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 44 + rand(7);
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.skinTone = "dark green";
			this.hairColor = "indigo";
			this.hairLength = 4;
			initStrTouSpeInte(79, 60, 80, 97);
			initWisLibSensCor(97, 45, 45, 60);
			this.weaponName = "wizard staff";
			this.weaponVerb = "bludgeon";
			this.weaponAttack = 16;
			this.armorName = "fur loincloth";
			this.armorDef = 12;
			this.armorMDef = 36;
			this.fatigue = 0;
			this.bonusHP = 375;
			this.bonusLust = 114;
			this.lust = 35;
			this.lustVuln = 0.4;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 24;
			this.gems = rand(15) + 25;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE,5).
					add(weapons.W_STAFF,1).
					add(undergarments.FURLOIN,1).
					add(jewelries.MYSTRNG, 1).
					add(jewelries.LIFERNG,1).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.GREEN_D,
							consumables.PURPDYE);
			this.abilities = [
				{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_WEAPON]},
				{ call: goblinDrugAttack, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[TAG_FLUID]},
				{ call: goblinTeaseAttack, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[]},
				{ call: castSpell, type: ABILITY_MAGIC, range: RANGE_RANGED, tags:[], weight:2},
			]
			checkMonster();
		}
		
	}

}
