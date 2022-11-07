/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.Areas.Swamp.*;
import classes.Scenes.NPCs.BelisaFollower;
import classes.Scenes.NPCs.LilyFollower;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class Swamp extends BaseContent
	{
		public var corruptedDriderScene:CorruptedDriderScene = new CorruptedDriderScene();
		public var femaleSpiderMorphScene:FemaleSpiderMorphScene = new FemaleSpiderMorphScene();
		public var maleSpiderMorphScene:MaleSpiderMorphScene = new MaleSpiderMorphScene();
		public var rogar:Rogar = new Rogar();
		public function Swamp()
		{
		}
		public function exploreSwamp():void
		{
			//M1 Cerberus
			if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns2) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns2) == 0 && player.hasKeyItem("M1 Cerberus") < 0 && rand(2) == 0) {
				partsofM1Cerberus();
				return;
			}
			//Discover 'Bog' at after 25 explores of swamp
			if ((player.level + combat.playerLevelAdjustment()) >= 23 && flags[kFLAGS.BOG_EXPLORED] == 0) {
				clearOutput();
				outputText("While exploring the swamps, you find yourself into a particularly dark, humid area of this already fetid biome.  You judge that you could find your way back here pretty easily in the future, if you wanted to.  With your newfound discovery fresh in your mind, you return to camp.\n\n(<b>Bog exploration location unlocked!</b>)");
				flags[kFLAGS.BOG_EXPLORED]++;
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			flags[kFLAGS.TIMES_EXPLORED_SWAMP]++;
			/*  SPECIAL SCENE OVERWRITES */
			//Belisa
			if (!player.hasStatusEffect(StatusEffects.SpoodersOff) && BelisaFollower.BelisaEncounternum == 0 && rand(2) == 0) {
				SceneLib.belisa.firstEncounter();
				return;
			}
			//Lily
			if (!player.hasStatusEffect(StatusEffects.SpoodersOff) && LilyFollower.LilyFollowerState == false && rand(3) == 0) {
				SceneLib.lily.lilyEncounter();
				return;
			}
			//KIHA X HEL THREESOME!
			if (!SceneLib.kihaFollower.followerKiha() && player.cor < 60 && flags[kFLAGS.KIHA_AFFECTION_LEVEL] >= 1 && flags[kFLAGS.HEL_FUCKBUDDY] > 0 && player.hasCock() && flags[kFLAGS.KIHA_AND_HEL_WHOOPIE] == 0) {
				SceneLib.kihaFollower.kihaXSalamander();
				return;
			}
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !SceneLib.helFollower.followerHel()) {
				SceneLib.helScene.helSexualAmbush();
				return;
			}
			//Etna
			if (flags[kFLAGS.ETNA_FOLLOWER] < 1 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && !player.hasStatusEffect(StatusEffects.EtnaOff) && rand(5) == 0 && (player.level >= 20)) {
				SceneLib.etnaScene.repeatYandereEnc();
				return;
			}
			//Ember
			if (flags[kFLAGS.TOOK_EMBER_EGG] == 0 && flags[kFLAGS.EGG_BROKEN] == 0 && flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0 && (flags[kFLAGS.TIMES_EXPLORED_SWAMP] % 40 == 0)) {
				SceneLib.emberScene.findEmbersEgg();
				return;
			}
			/*  STANDARD SCENE SELECTION  */
			var choices:Array = [];
			//Build the choice array
			//M & F spidermorphs
			choices[choices.length] = 0;
			choices[choices.length] = 1;
			//Drider
			choices[choices.length] = 2;
			//ROGAR
			if (flags[kFLAGS.ROGAR_DISABLED] == 0 && flags[kFLAGS.ROGAR_PHASE] < 3)
				choices[choices.length] = 3;
			//Kiha
			choices[choices.length] = 4;

			//Pick from the choices and pull the encounter.
			var choice:Number = choices[rand(choices.length)];
			switch (choice) {
				case 0:
					femaleSpiderMorphScene.fSpiderMorphGreeting();
					break;
				case 1:
					maleSpiderMorphScene.greetMaleSpiderMorph();
					break;
				case 2:
					corruptedDriderScene.driderEncounter();
					break;
				case 3:
					rogar.encounterRogarSwamp();
					break;
				case 4:
					//Kiha follower gets to explore her territory!
					if (SceneLib.kihaFollower.followerKiha()) SceneLib.kihaScene.kihaExplore();
					else SceneLib.kihaScene.encounterKiha();
					break;
				default:
					outputText("New explore code fucked up.  YOU BONED (TELL ORMAEL/AIMOZG)");
					doNext(playerMenu);
					break;
			}
		}
		public function partsofM1Cerberus():void {
			clearOutput();
			outputText("As you explore the swamp you run into what appears to be the half sunken remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to pull up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the M1 Cerberus in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("M1 Cerberus", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
	}
}