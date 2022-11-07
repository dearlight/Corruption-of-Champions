/**
 * ...
 * @author Ormael
 */
package classes.Scenes
{
import classes.*;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.DeepSea.Kraken;
import classes.Scenes.Areas.Forest.TamainsDaughtersScene;
import classes.Scenes.Areas.Forest.TamaniScene;
import classes.Scenes.Areas.Forest.WorldTree;
import classes.Scenes.Areas.HighMountains.IzumiScene;
import classes.Scenes.Areas.HighMountains.MinotaurMobScene;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.SuccubusGardener;
import classes.Scenes.Dungeons.DesertCave.SandMother;
import classes.Scenes.Explore.Pierce;
import classes.Scenes.Explore.TheDummy;
import classes.Scenes.Monsters.Malikore;
import classes.Scenes.NPCs.Alvina;
import classes.Scenes.NPCs.Aria;
import classes.Scenes.NPCs.Belisa;
import classes.Scenes.NPCs.BelisaFollower;
import classes.Scenes.NPCs.Carrera;
import classes.Scenes.NPCs.DivaScene;
import classes.Scenes.NPCs.DriderTown;
import classes.Scenes.NPCs.Lilith;
import classes.Scenes.NPCs.LilyFollower;
import classes.Scenes.NPCs.RyuBiDragon;
import classes.Scenes.NPCs.Sonya;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.NPCs.WaizAbi;
import classes.Scenes.Places.Boat.Marae;
import classes.Scenes.Places.HeXinDao.AdventurerGuild;
import classes.Items.*;
import classes.Stats.Buff;
import classes.Scenes.Dungeons.EbonLabyrinth.*;
import classes.GeneticMemories.*;

use namespace CoC;

public class Soulforce extends BaseContent
{
	public var tamaniDaughtersScene:TamainsDaughtersScene = new TamainsDaughtersScene();
	public var tamaniScene:TamaniScene = new TamaniScene();
	public var izumiScenes:IzumiScene = new IzumiScene();
	public var worldtreeScene:WorldTree = new WorldTree();
	public var minotaurSonsScene:MinotaurMobScene = new MinotaurMobScene();

	public function accessSoulforceMenu():void {
		clearOutput();
		SoulCultivationLvL();
		var dailySoulforceUsesLimit:Number = 0;
		if (player.hasPerk(PerkLib.JobSoulCultivator)) dailySoulforceUsesLimit++;
		if (player.hasPerk(PerkLib.SoulWarrior)) dailySoulforceUsesLimit++;
		if (player.hasPerk(PerkLib.SoulElder)) dailySoulforceUsesLimit++;
		if (player.hasPerk(PerkLib.SoulTyrant)) dailySoulforceUsesLimit++;
		if (player.hasPerk(PerkLib.SoulAncestor)) dailySoulforceUsesLimit++;//dodawać kolejne co 3 level-e
		outputText("<b>Cultivation level:</b> " + flags[kFLAGS.SOUL_CULTIVATION] + "\n");
		outputText("<b>Additional Soulforce from training:</b> " + flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] + " / 2330\n");
		if (player.hasPerk(PerkLib.Dantain)) {
			if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor) && player.perkv1(PerkLib.Dantain) == 0) player.addPerkValue(PerkLib.Dantain, 1, 1);
			if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor) && player.perkv1(PerkLib.Dantain) == 1) player.addPerkValue(PerkLib.Dantain, 1, 1);
			if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor) && player.perkv1(PerkLib.Dantain) == 2) player.addPerkValue(PerkLib.Dantain, 1, 1);
			outputText("<b>Dantain:</b> ");
			if (player.perkv1(PerkLib.Dantain) == 3) outputText("Nascent Soul");
			else if (player.perkv1(PerkLib.Dantain) == 2) outputText("Core Formation");
			else if (player.perkv1(PerkLib.Dantain) == 1) outputText("Foundation Establishment");
			else outputText("Qi Condensation");
			outputText("\n");
		}
		/*	outputText("<b>Progress toward clearing next meridian: </b>");
			if (flags[kFLAGS.UNLOCKED_MERIDIANS] == 2)
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
			else if (flags[kFLAGS.UNLOCKED_MERIDIANS] == 1)
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
			else
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
			outputText("<b>PC Speed %:</b> " + player.getMaxStats("spe") + "\n");
		*/	outputText("<b>Uses of soulforce per day (for 4 first option beside cultivate):</b> " + flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] + " / " + dailySoulforceUsesLimit + "\n");
		/*	if (player.hasStatusEffect(StatusEffects.TelAdreTripxi)) {
				outputText("<b>TelAdre Tripxi Guns general timer:</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxi) + "\n");
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns1)) {
					outputText("<b>TelAdre Tripxi Guns 1 (v1):</b> " + player.statusEffectv1(StatusEffects.TelAdreTripxiGuns1) + " (Desert Eagle)\n");
					outputText("<b>TelAdre Tripxi Guns 1 (v2):</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxiGuns1) + " (Dart pistol)\n");
					outputText("<b>TelAdre Tripxi Guns 1 (v3):</b> " + player.statusEffectv3(StatusEffects.TelAdreTripxiGuns1) + " (Double barreled dragon gun)\n");
					outputText("<b>TelAdre Tripxi Guns 1 (v4):</b> " + player.statusEffectv4(StatusEffects.TelAdreTripxiGuns1) + "\n");
				}
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns2)) {
					outputText("<b>TelAdre Tripxi Guns 2 (v1):</b> " + player.statusEffectv1(StatusEffects.TelAdreTripxiGuns2) + " (M1 Cerberus)\n");
					outputText("<b>TelAdre Tripxi Guns 2 (v2):</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxiGuns2) + " (Twin Dart pistol)\n");
					outputText("<b>TelAdre Tripxi Guns 2 (v3):</b> " + player.statusEffectv3(StatusEffects.TelAdreTripxiGuns2) + " (Lactoblasters)\n");
					outputText("<b>TelAdre Tripxi Guns 2 (v4):</b> " + player.statusEffectv4(StatusEffects.TelAdreTripxiGuns2) + "\n");
				}
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns3)) {
					outputText("<b>TelAdre Tripxi Guns 3 (v1):</b> " + player.statusEffectv1(StatusEffects.TelAdreTripxiGuns3) + " (Tripxi Fatbilly)\n");
					outputText("<b>TelAdre Tripxi Guns 3 (v2):</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxiGuns3) + " (Harpoon Gun)\n");
					outputText("<b>TelAdre Tripxi Guns 3 (v3):</b> " + player.statusEffectv3(StatusEffects.TelAdreTripxiGuns3) + "\n");
					outputText("<b>TelAdre Tripxi Guns 3 (v4):</b> " + player.statusEffectv4(StatusEffects.TelAdreTripxiGuns3) + "\n");
				}
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns4)) {
					outputText("<b>TelAdre Tripxi Guns 4 (v1):</b> " + player.statusEffectv1(StatusEffects.TelAdreTripxiGuns4) + " (Snippler)\n");
					outputText("<b>TelAdre Tripxi Guns 4 (v2):</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxiGuns4) + "\n");
					outputText("<b>TelAdre Tripxi Guns 4 (v3):</b> " + player.statusEffectv3(StatusEffects.TelAdreTripxiGuns4) + "\n");
					outputText("<b>TelAdre Tripxi Guns 4 (v4):</b> " + player.statusEffectv4(StatusEffects.TelAdreTripxiGuns4) + "\n");
				}
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns5)) {
					outputText("<b>TelAdre Tripxi Guns 5 (v1):</b> " + player.statusEffectv1(StatusEffects.TelAdreTripxiGuns5) + " (Touhouna M3)\n");
					outputText("<b>TelAdre Tripxi Guns 5 (v2):</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxiGuns5) + " (Derpnade Launcher)\n");
					outputText("<b>TelAdre Tripxi Guns 5 (v3):</b> " + player.statusEffectv3(StatusEffects.TelAdreTripxiGuns5) + "\n");
					outputText("<b>TelAdre Tripxi Guns 5 (v4):</b> " + player.statusEffectv4(StatusEffects.TelAdreTripxiGuns5) + "\n");
				}
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns6)) {
					outputText("<b>TelAdre Tripxi Guns 6 (v1):</b> " + player.statusEffectv1(StatusEffects.TelAdreTripxiGuns6) + " (Twin Grakaturd)\n");
					outputText("<b>TelAdre Tripxi Guns 6 (v2):</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxiGuns6) + "\n");
					outputText("<b>TelAdre Tripxi Guns 6 (v3):</b> " + player.statusEffectv3(StatusEffects.TelAdreTripxiGuns6) + "\n");
					outputText("<b>TelAdre Tripxi Guns 6 (v4):</b> " + player.statusEffectv4(StatusEffects.TelAdreTripxiGuns6) + "\n");
				}
			}
		*/	menu();
		if (player.hasPerk(PerkLib.EnergyDependent)) addButtonDisabled(0, "Cultivate", "You're unable to recover soulforce by cultivating.");
		else addButton(0, "Cultivate", SoulforceRegeneration).hint("Spend some time on restoring some of the used soulforce.");
		if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) addButton(1, "Contemplate", DaoContemplations).hint("Dao Contemplations");
		else addButtonDisabled(1, "???", "Req.  successfully surviving 1st Tribulation.");
		if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) {
			addButton(2, "Self-sustain", SelfSustain).hint("Spend some soulforce on suppresing hunger for a while."); //zamiana soulforce na satiety w stosunku 1:5
			addButton(3, "Repres. Lust", RepresLust).hint("Spend some soulforce on calming your sexual urges."); //używanie soulforce do zmniejszania lust w stosunku 1:2
			addButton(4, "Adj. Corr.", CorruptionAndSoulforce).hint("Spend some soulforce on affecting your current corruption."); //używanie soulforce do zmniejszania corruption w stosunku 1:100 a zdobywanie corruption w stosunku 1:50
		}
		else {
			addButtonDisabled(2, "Self-sustain", "Wait till new day arrive to use this option again.");
			addButtonDisabled(3, "Repres. Lust", "Wait till new day arrive to use this option again.");
			addButtonDisabled(4, "Adj. Corr.", "Wait till new day arrive to use this option again.");
		}
		//addButton(5, "Upgrade", UpgradeItems).hint("."); //ulepszanie itemów
		if (player.hasPerk(PerkLib.Metamorph)) {
			if (player.blockingBodyTransformations()) addButtonDisabled(6, "Metamorph", "Your current body state prevents you from using Metamorph. (Either cure it or ascend to gain access to metamorph menu again)");
			else addButton(6, "Metamorph", SceneLib.metamorph.openMetamorph).hint("Use your soulforce to mold your body.");//używanie metamorfowania z użyciem soulforce
		}
		else addButtonDisabled(6, "???", "Req. Metamorph.");
		if (player.hasPerk(PerkLib.SoulSense)) addButton(7, "Soul Sense", SoulSense).hint("Use your soul sense to trigger specific encounters."); //używanie divine sense aby znaleść określone event encounters: Tamani (lvl 6+), Tamani daugthers (lvl 6+), Kitsune mansion (lvl 12+), Izumi (lvl 18/24+), itp.
		else addButtonDisabled(7, "???", "Req. Soul Sense.");
		if (player.hasPerk(PerkLib.SoulApprentice)) {
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(9, "Mana", ManaAndSoulforce).hint("Convert some soulforce into mana or vice versa."); //używanie soulforce do zamiany na mane w stosunku 1:1 a many do soulforce 1:2, używalne nawet w walce też ale z wiekszym kosztem przeliczania czyli 1:2 i 1:4
			else addButtonDisabled(9, "Mana", "Wait till new day arrive to use this option again.");
		}
		else addButtonDisabled(9, "???", "Req. Soul Apprentice stage.");
		addButton(10, "Cheats", SoulforceCheats1, 0).hint("This should be obvious. ^^");//block this option at each public version
		if (canfaceTribulation()) addButton(13, "Tribulation", tribulationsPrompt).hint("To face it or not? That's the question.");
		else addButtonDisabled(13, "Tribulation", "It's not (yet) time for this.");
		addButton(14, "Back", playerMenu);
	}//w lini 28 w oOnLoadVariables zmian wprowadzić i w lini conditionalConverters w folderze parser zmian dot. wraith wprowadzić, zablokować perki soul king to soul ancestor w momencie robienia release version

	public function SoulCultivationLvL():void {	//Converted Soul Cultivation level check to a function, easier to update, and much nicer on the eyes than the old block of ifs!
		//Actually.... Since the tier and lvl have to sync for the soul cult lvl, and is checked for the output tier... I can hijack this and use it to output the tiers as well!
		/*var cultTier:Array = [PerkLib.SoulApprentice, PerkLib.SoulPersonage, PerkLib.SoulWarrior, PerkLib.SoulSprite, PerkLib.SoulScholar, PerkLib.SoulElder, PerkLib.SoulExalt, PerkLib.SoulOverlord, PerkLib.SoulTyrant, PerkLib.SoulKing, PerkLib.SoulEmperor, PerkLib.SoulAncestor];
			var pLvlMax:int = 122;	//Should only need to change this and above array for future expansion.
			var cultRankTier:Array = ["Late ", "Early ", "Middle "];
			var cultStanding:String = "Mortal";
			var lNeed:Boolean = true;
			var pLvl:int = 6;
			var cLvlTier:int = 0;
			var perkTier:PerkType;*/
		var cultTier:Array = [PerkLib.JobSoulCultivator, PerkLib.SoulApprentice, PerkLib.SoulPersonage, PerkLib.SoulWarrior, PerkLib.SoulSprite, PerkLib.SoulScholar, PerkLib.SoulElder, PerkLib.SoulExalt, PerkLib.SoulOverlord, PerkLib.SoulTyrant, PerkLib.SoulKing, PerkLib.SoulEmperor, PerkLib.SoulAncestor];
		var pLvlMax:int = 76;	//Should only need to change this and above array for future expansion.
		var cultRankTier:Array = ["Late ", "Early ", "Middle "];
		var lNeed:Boolean = true;
		var pLvl:int = 6;
		var cLvlTier:int = 0;
		var cultStanding:String = "Mortal";
		flags[kFLAGS.SOUL_CULTIVATION] = 0;
		/*for (var i:int = 0; i < cultTier.length(); i++){	//This *should* work?
				if (!player.hasPerk(cultTier[i])){
					if (i == 0) break;
					perkTier = cultTier[i - 1];
					if (player.level < 76) pLvlMax = player.level
					if (i - 1 < 6){
						cultStanding = cultRankTier[pLvlMax % 3] + perkTier.name();
					}
					else{
						cultStanding = cultRankTier[pLvlMax % 4] + perkTier.name();
					}
					break;
				}
			}*/
		if (player.level >= 4 && player.hasPerk(cultTier[0])){	//Deprecating.
			flags[kFLAGS.SOUL_CULTIVATION] +=3;
		}
		else if (player.level >= 2 && player.hasPerk(cultTier[0])){	//Actually.... I can also get rid of the checks for the cultTier here, since you have to have that perk beforehand to get to this menu in the first place...
			flags[kFLAGS.SOUL_CULTIVATION] +=2;
			lNeed = false;
		}
		else if (player.level >= 1 && player.hasPerk(cultTier[0])){
			flags[kFLAGS.SOUL_CULTIVATION] +=1;
			lNeed = false;
		}
		while (lNeed) {
			if (player.level >= pLvl && pLvl <= pLvlMax && player.hasPerk(cultTier[floor(pLvl /6)])){
				flags[kFLAGS.SOUL_CULTIVATION] +=1;
			}
			else {
				lNeed = false;
			}
			if (cLvlTier == 3) cLvlTier = 0;
			if (!lNeed){
				if (flags[kFLAGS.SOUL_CULTIVATION] >=4){
					cultStanding = cultRankTier[cLvlTier] + cultTier[floor(int((pLvl-2)/6))].name();
				}
			}
			pLvl += 2;
			cLvlTier += 1;
		}
		outputText("<b>Cultivation stage:</b> " + cultStanding + "\n");
	}

	public function SoulforceCheats1(page:int = 0):void{
		clearOutput();
		outputText("Collection of current used cheats that with time will be removed or replaced by new ones.");
		outputText("\n\nAscension points: " + player.ascensionPerkPoints + "");
		menu();
		var menuItems:Array = [];
		menuItems.push("StatsAdj/Ascen", StatsAscensionMenu, "For more precisely adjusting each of the 8 main stats and Ascension related stuff.");
		menuItems.push("P/G/XP/LvL", PerksGemsEXPLvL, "Adding/Removing perk points and adding gems/exp/lvl.");
		menuItems.push("Equip", EquipmentMenu, "For creating various equipment items for tests.");
		menuItems.push("NonEquip", NonEquipmentMenu, "For creating various non-equipment items for tests.");
		menuItems.push("Materials", MaterialMenu, "For creating various materials for tests.");
		menuItems.push("Enemies", EnemiesMenu, "For spawning various enemies to test fight them.");
		menuItems.push("Camp NPC's", FasterOrInstantCampNPCRecruitment, "Menu to speed up recruitment of camp npc's due to testing needs.");
		menuItems.push("Body State", BodyStateMenu, "For more precisely adjusting a few other body values or parts than Stats Adj option.");
		menuItems.push("Test dynamic stat", TestDynamicStats, "Test Dynamic stats.");
		menuItems.push("MetamorphFull", (player.hasPerk(PerkLib.Metamorph))? AllMetamorphOptionsUnlock: false, "Unlock all Metamorph options.");
		menuItems.push("BelisaTest", (BelisaFollower.BelisaInGame && BelisaFollower.BelisaFollowerStage < 3) ? belisatest3 : false, "Belisa Trigger");
		menuItems.push("BeliConfFix", (TyrantiaFollower.TyrantiaFollowerStage >= 4 && BelisaFollower.BelisaFollowerStage >= 5 && BelisaFollower.BelisaEncounternum >= 5 && BelisaFollower.BelisaAffectionMeter >= 80 && !BelisaFollower.BelisaConfessed) ? belisatest2 : false, "Belisa Confession Fix");
		menuItems.push("LilyTest", !LilyFollower.LilyFollowerState ? lilytest : false, "Lily Trigger");
		menuItems.push("FixJiangshi", jiangshiBuggedItemsCleanUpCrew0, "Shit! Here we go Again! Fixing Jiangshi! (better use it only once or may be some bugs i not plan to account for in case of using this more than once - i not blocked using it more than once so belive ppl will be reasonable to not click like mad this)");
		menuItems.push("BodyPartEditor", SceneLib.debugMenu.bodyPartEditorRoot, "");
		menuItems.push("ClickItTwice", AddMaxBackpack00, "Golem Army and Ascension: Additional Organ Mutation/Prestige perks correction pre global save upgrade on new public build.");
		menuItems.push("Instant-house", AddMaxBackpack01, "Instant-house + bed");
		menuItems.push("Hex-Mate", AddMaxBackpack02, "Hex-Mate");
		menuItems.push("WendigoTrigger", AddMaxBackpack4, "Trigger Wendigo transformation. (Without active Wendigo Psychosis will do nothing ;) )");
		menuItems.push("ClickItOnce", (!player.hasStatusEffect(StatusEffects.ZenjiZList))? AddMaxBackpack3 : false, "Fixing Lover Zenji missing one status effect needed for his sex scenes menu.");
		menuItems.push("QuestItBag", AddMaxBackpack2, "Giving missing Quest Items Bag as part of Adventure Guild welcome/promotion package.");
		menuItems.push("RevertCabin", RevertCabinProgress, "Revert cabin flag back to value 2 (for bug fix test)");
		menuItems.push("Gargoyle", GargoyleMenu, "To Be or Not To Be Gargoyle that is a question.");
		menuItems.push(":Re", (flags[kFLAGS.EVANGELINE_LVL_UP] > 0)? AddMaxBackpack5 : false, "Rewind Evangeline.");
		menuItems.push("ChimeraBodyUlt", ChimeraBodyUltimateStage, "Ultimate Stage of Chimera Body for tests and lulz. Now with on/off switch for more lulz.");
		menuItems.push("All4HiddenPrestige", AddMaxBackpack03, "A11 th4t H1dd3n Prestige is Y0urs to T4ke!!!");
		menuItems.push("PerkGalore1", PerkGalore1, "");
		menuItems.push("PerkGalore2", PerkGalore2, "");
		menuItems.push("ClickItOnce", (flags[kFLAGS.MARRIAGE_FLAG] == 1)? AddMaxBackpack033 : false, "Fix Marriage Unlock from Michiko for future clarity.");
		menuItems.push("RemoveRP", cheatRemoveRP, "Remove Racial Paragon perk");
		menuItems.push("Fix Shards", cheatFixShards, "Check player's quest and give the deserved shards");
		menuItems.push("Add Shard", cheatAddShard, "Add 1 radiant shard");
		menuItems.push("Remove Shard", cheatRemoveShard, "Remove 1 radiant shard");
		menuItems.push("LustBreath", (player.hasPerk(PerkLib.DragonPoisonBreath))? FairyTest: false, "Replacing 1 perk with another");
		menuItems.push("TyrantPF", (TyrantiaFollower.TyrantiaFollowerStage == 5 && TyrantiaFollower.TyraniaCorrupteedLegendaries == 0)? FairyTest5: false, "Patching Tyrantia corrupted legendaries unlock");
		menuItems.push("LilyPregF", (DriderTown.LilyKidsPCPregnancy != 0 && LilyFollower.LilyFollowerState)? FairyTest3: false, "Curing Lily Infertility ^^");
		//menuItems.push("Mutationstest2", mutations2, "MutationsTest2");
		//menuItems.push("Mutation test reset", resetMutations, "Reset Mutations");
		menuGen(menuItems, page, accessSoulforceMenu);
	}


	public function mutations2():void{
		clearOutput();
		menu();
		var page:int = 0;
		var menuItems:Array = [];
		outputText("MutationsApplicator");
		for each (var pArray:Array in IMutationsLib.mutationsArray("Thyroid")){
			var temp:Array = [];
			temp = cDynPerk(pArray[0], pArray[1]);
			if (temp[1] is Function){
				temp.insertAt(1,curry(temp[1], testdone));
				temp.removeAt(2);
			}

			for each (var i:* in temp){
				menuItems.push(i);
			}
			//menuItems.push(temp[0]);
		}
		menuGen(menuItems, page, curry(SoulforceCheats1, 2));

		function testdone():void{
			clearOutput();
			outputText("testDone!");
			doNext(accessSoulforceMenu);
		}
	}

	public function FairyTest3():void {
		DriderTown.LilyKidsPCPregnancy = 0;
		doNext(curry(SoulforceCheats1, 0));
	}
	public function FairyTest5():void {
		TyrantiaFollower.TyrantiaFollowerStage = 4;
		TyrantiaFollower.TyraniaCorrupteedLegendaries = 1;
		doNext(curry(SoulforceCheats1, 0));
	}
	public function FairyTest():void {
		player.removePerk(PerkLib.DragonPoisonBreath);
		player.createPerk(PerkLib.DragonLustPoisonBreath, 0, 0, 0, 0);
		doNext(curry(SoulforceCheats1, 0));
	}
	public function belisatest2():void{
		BelisaFollower.BelisaConfessed = true;
		doNext(curry(SoulforceCheats1,2));
	}
	public function belisatest3():void {
		if (BelisaFollower.BelisaEncounternum >= 1) SceneLib.belisa.subsequentEncounters();
		else SceneLib.belisa.firstEncounter();
	}
	public function resetMutations():void{
		clearOutput();
		player.removePerk(MutationsLib.KitsuneThyroidGland);
		player.removePerk(MutationsLib.KitsuneThyroidGlandPrimitive);
		player.removePerk(MutationsLib.KitsuneThyroidGlandEvolved);
		outputText("Reset done!");
		doNext(curry(SoulforceCheats1,2));
	}
    public function cheatFixShards():void { //wrapper for fixShards to use it in cheat menu
		clearOutput();
        fixShards();
		doNext(curry(SoulforceCheats1,2));
    }
	public function fixShards():void {
		var cnt:int = 0;
		player.removeKeyItem("Radiant shard");
		outputText("Received shards for: ")
		if (flags[kFLAGS.AYANE_FOLLOWER] == 2) {
			++cnt;
			outputText("\nP.Ayane");
		}
		if (flags[kFLAGS.AMILY_FOLLOWER] == 1) {
			++cnt;
			outputText("\nP.Amily");
		}
		if (flags[kFLAGS.AMILY_FOLLOWER] == 2) {
			++cnt;
			outputText("\nC.Amily");
		}
		if (DivaScene.instance.status == -1) {
			++cnt;
			outputText("\nDiva");
		}
		if (flags[kFLAGS.ELECTRA_FOLLOWER] == 2) {
			++cnt;
			outputText("\nElectra");
		}
		if (flags[kFLAGS.ETNA_FOLLOWER] == 2) {
			++cnt;
			outputText("\nEtna");
		}
		if (flags[kFLAGS.KIHA_FOLLOWER] == 1) {
			++cnt;
			outputText("\nKiha");
		}
		if (flags[kFLAGS.CERAPH_FOLLOWER_PIERCING] == 1 || flags[kFLAGS.CERAPH_FOLLOWER_CARRY] == 1) {
			++cnt;
			outputText("\nCeraph");
		}
		if (flags[kFLAGS.VAPULA_FOLLOWER] == 1) {
			++cnt;
			outputText("\nVapula");
		}
		if (cnt) {
			outputText("\nReceived " + cnt + " shards.");
			cheatAddShard(cnt);
		}
		else
			outputText("\nNo shards, go complete quests :(");
	}

	public function cheatRemoveRP():void {
		clearOutput();
		if (player.removePerk(PerkLib.RacialParagon)) {
			++player.perkPoints;
			outputText("Done!");
		}
		else
			outputText("No such perk.");
		doNext(camp.doCamp);
	}

	public function cheatRemoveShard():void {
		if(player.keyItemvX("Radiant shard", 1) == 1)
			player.removeKeyItem("Radiant shard");
		else
			player.addKeyValue("Radiant shard", 1, -1);
		outputText("\n\n<b>You currently have "+ player.keyItemvX("Radiant shard", 1) +" radiant shards.</b>");
		doNext(curry(SoulforceCheats1, 2));
	}

	public function cheatAddShard(cnt:int = 1):void {
		if (player.hasKeyItem("Radiant shard") >= 0)
			player.addKeyValue("Radiant shard", 1, cnt);
		else
			player.createKeyItem("Radiant shard", cnt, 0, 0, 0);
		outputText("\n\n<b>You currently have "+ player.keyItemvX("Radiant shard", 1) + " radiant shards.</b>");
		doNext(curry(SoulforceCheats1,2));
	}

	private function jiangshiBuggedItemsCleanUpCrew0():void {
		if (player.weapon != WeaponLib.FISTS) {
			if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2) {
				flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 1;
				player.setWeapon(WeaponLib.FISTS);
				jiangshiBuggedItemsCleanUpCrew1();
			}
			else inventory.takeItem(player.setWeapon(WeaponLib.FISTS), jiangshiBuggedItemsCleanUpCrew1);
		}
		else doNext(jiangshiBuggedItemsCleanUpCrew1);
	}
	private function jiangshiBuggedItemsCleanUpCrew1():void {
		if (player.weaponRange != WeaponRangeLib.NOTHING) inventory.takeItem(player.setWeaponRange(WeaponRangeLib.NOTHING), jiangshiBuggedItemsCleanUpCrew2);
		else doNext(jiangshiBuggedItemsCleanUpCrew2);
	}
	private function jiangshiBuggedItemsCleanUpCrew2():void {
		if (player.shield != ShieldLib.NOTHING) {
			if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2) {
				flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 1;
				player.setShield(ShieldLib.NOTHING);
				jiangshiBuggedItemsCleanUpCrew3();
			}
			else inventory.takeItem(player.setShield(ShieldLib.NOTHING), jiangshiBuggedItemsCleanUpCrew3);
		}
		else doNext(jiangshiBuggedItemsCleanUpCrew3);
	}
	private function jiangshiBuggedItemsCleanUpCrew3():void {
		if (player.armor != ArmorLib.NOTHING) {
			if (player.armor == armors.GOOARMR) player.armor.removeText();
			inventory.takeItem(player.setArmor(armors.TRADITC), jiangshiBuggedItemsCleanUpCrew4);
		}
		else doNext(jiangshiBuggedItemsCleanUpCrew4);
	}
	private function jiangshiBuggedItemsCleanUpCrew4():void {
		if (player.lowerGarment != UndergarmentLib.NOTHING) {
			inventory.takeItem(player.setUndergarment(UndergarmentLib.NOTHING, UndergarmentLib.TYPE_LOWERWEAR), jiangshiBuggedItemsCleanUpCrew5);
		}
		else doNext(jiangshiBuggedItemsCleanUpCrew5);
	}
	private function jiangshiBuggedItemsCleanUpCrew5():void {
		if (player.upperGarment != UndergarmentLib.NOTHING) {
			inventory.takeItem(player.setUndergarment(UndergarmentLib.NOTHING, UndergarmentLib.TYPE_UPPERWEAR), jiangshiBuggedItemsCleanUpCrew6);
		}
		else doNext(jiangshiBuggedItemsCleanUpCrew6);
	}
	private function jiangshiBuggedItemsCleanUpCrew6():void {
		if (player.headJewelry != HeadJewelryLib.NOTHING) flags[kFLAGS.PLAYER_DISARMED_HEAD_ACCESORY_ID] = player.headJewelry.id;
		player.setHeadJewelry(headjewelries.JIANGCT);
		player.statStore.replaceBuffObject({'str.mult':0.2,'tou.mult':0.2,'lib.mult':0.2,'sens':80}, 'Jiangshi Curse Tag', { text: 'Jiangshi Curse Tag' });
		doNext(curry(SoulforceCheats1, 0));
	}
	public function AddMaxBackpack00():void {
		outputText("\n\nFix completed");
		if (player.hasPerk(PerkLib.GolemArmyLieutenant) && !player.hasPerk(PerkLib.GolemArmyJuniorLieutenant)) {
			if (player.hasPerk(PerkLib.GolemArmyLieutenant)) {
				player.removePerk(PerkLib.GolemArmyLieutenant);
				player.createPerk(PerkLib.GolemArmyJuniorLieutenant,0,0,0,0);
			}
			if (player.hasPerk(PerkLib.GolemArmyCaptain)) {
				player.removePerk(PerkLib.GolemArmyCaptain);
				player.createPerk(PerkLib.GolemArmyLieutenant,0,0,0,0);
			}
			if (player.hasPerk(PerkLib.GolemArmyMajor)) {
				player.removePerk(PerkLib.GolemArmyMajor);
				player.createPerk(PerkLib.GolemArmyCaptain,0,0,0,0);
			}
			if (player.hasPerk(PerkLib.GolemArmyColonel)) {
				player.removePerk(PerkLib.GolemArmyColonel);
				player.createPerk(PerkLib.GolemArmyMajor,0,0,0,0);
			}
			if (player.hasPerk(PerkLib.GolemArmyGeneral)) {
				player.removePerk(PerkLib.GolemArmyGeneral);
				player.createPerk(PerkLib.GolemArmyLieutenantColonel,0,0,0,0);
			}
		}
		if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation01)) {
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)) player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1,1);
			else player.createPerk(PerkLib.AscensionAdditionalOrganMutationX, 1, 0, 0, 1);
			player.removePerk(PerkLib.AscensionAdditionalOrganMutation01);
		}
		if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation02)) {
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)) player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1,2);
			else player.createPerk(PerkLib.AscensionAdditionalOrganMutationX,2,0,0,1);
			player.removePerk(PerkLib.AscensionAdditionalOrganMutation02);
		}
		if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation03)){
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)) player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1,3);
			else player.createPerk(PerkLib.AscensionAdditionalOrganMutationX,3,0,0,1);
			player.removePerk(PerkLib.AscensionAdditionalOrganMutation03);
		}
		if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation04)){
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)) player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1,4);
			else player.createPerk(PerkLib.AscensionAdditionalOrganMutationX,4,0,0,1);
			player.removePerk(PerkLib.AscensionAdditionalOrganMutation04);
		}
		if (player.hasPerk(PerkLib.AscensionBuildingPrestige01)) {
			if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1,1);
			else player.createPerk(PerkLib.AscensionBuildingPrestigeX, 1, 0, 0, 1);
			player.removePerk(PerkLib.AscensionBuildingPrestige01);
		}
		if (player.hasPerk(PerkLib.AscensionBuildingPrestige02)) {
			if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1,2);
			else player.createPerk(PerkLib.AscensionBuildingPrestigeX,2,0,0,1);
			player.removePerk(PerkLib.AscensionBuildingPrestige02);
		}
		if (player.hasPerk(PerkLib.AscensionBuildingPrestige03)){
			if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1,3);
			else player.createPerk(PerkLib.AscensionBuildingPrestigeX,3,0,0,1);
			player.removePerk(PerkLib.AscensionBuildingPrestige03);
		}
		if (player.hasPerk(PerkLib.AscensionBuildingPrestige04)){
			if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1,4);
			else player.createPerk(PerkLib.AscensionBuildingPrestigeX,4,0,0,1);
			player.removePerk(PerkLib.AscensionBuildingPrestige04);
		}
		if (player.hasPerk(PerkLib.AscensionBuildingPrestige05)) {
			if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1,5);
			else player.createPerk(PerkLib.AscensionBuildingPrestigeX, 5, 0, 0, 1);
			player.removePerk(PerkLib.AscensionBuildingPrestige05);
		}
		if (player.hasPerk(PerkLib.AscensionBuildingPrestige06)) {
			if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1,6);
			else player.createPerk(PerkLib.AscensionBuildingPrestigeX,6,0,0,1);
			player.removePerk(PerkLib.AscensionBuildingPrestige06);
		}
		if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] > 0) flags[kFLAGS.CHRISTMAS_TREE_LEVEL]++;
		doNext(curry(SoulforceCheats1, 1));
	}
	public function AddMaxBackpack033():void {
		outputText("\n\nFix completed");
		flags[kFLAGS.MARRIAGE_FLAG] = 0;
		flags[kFLAGS.MICHIKO_TALK_MARRIAGE] = 1;
		doNext(curry(SoulforceCheats1, 1));
	}
	public function AddMaxBackpack03():void {
		outputText("\n\nA11 th4t H1dd3n Prestige is Y0urs to T4ke!!!");
		if (!player.hasPerk(PerkLib.PrestigeJobArcaneArcher)) player.createPerk(PerkLib.PrestigeJobArcaneArcher, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobArchpriest)) player.createPerk(PerkLib.PrestigeJobArchpriest, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobBerserker)) player.createPerk(PerkLib.PrestigeJobBerserker, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobDruid)) player.createPerk(PerkLib.PrestigeJobDruid, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobNecromancer)) player.createPerk(PerkLib.PrestigeJobNecromancer, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobSentinel)) player.createPerk(PerkLib.PrestigeJobSentinel, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobSoulArtMaster)) player.createPerk(PerkLib.PrestigeJobSoulArtMaster, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobSpellKnight)) player.createPerk(PerkLib.PrestigeJobSpellKnight, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobStalker)) player.createPerk(PerkLib.PrestigeJobStalker, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobTempest)) player.createPerk(PerkLib.PrestigeJobTempest, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobWarlock)) player.createPerk(PerkLib.PrestigeJobWarlock, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.HiddenJobAsura)) player.createPerk(PerkLib.HiddenJobAsura, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.HiddenJobBloodDemon)) player.createPerk(PerkLib.HiddenJobBloodDemon, 0, 0, 0, 0);
		doNext(curry(SoulforceCheats1, 1));
	}
	public function AddMaxBackpack02():void {
		if (!player.hasPerk(PerkLib.JobSorcerer)) player.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
		player.createPerk(PerkLib.PrestigeJobWarlock, 0, 0, 0, 0);
		player.createPerk(PerkLib.HexKnowledge, 0, 0, 0, 0);
		player.createPerk(PerkLib.DarkRitual, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.KnowsConsumingDarkness, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.KnowsCurseOfDesire, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.KnowsCurseOfWeeping, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.KnowsLifeSiphon, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.KnowsLifetap, 0, 0, 0, 0);
		doNext(curry(SoulforceCheats1, 1));
	}
	public function AddMaxBackpack01():void {
		flags[kFLAGS.CAMP_BUILT_CABIN] = 1;
		flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] = 1;
		doNext(curry(SoulforceCheats1, 1));
	}
	public function AddMaxBackpack2():void {
		if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0 && AdventurerGuild.Slot01Cap < 10) {
			AdventurerGuild.Slot01Cap = 10;
			AdventurerGuild.Slot02Cap = 10;
		}
		if (player.hasKeyItem("Adventurer Guild: Iron plate") >= 0 && AdventurerGuild.Slot03Cap < 10) {
			AdventurerGuild.Slot01Cap = 10;
			AdventurerGuild.Slot02Cap = 10;
			AdventurerGuild.Slot03Cap = 10;
			AdventurerGuild.Slot04Cap = 10;
		}
		doNext(curry(SoulforceCheats1, 1));
	}
	public function AddMaxBackpack3():void {
		player.createStatusEffect(StatusEffects.ZenjiZList, 0, 0, 0, 0);
		doNext(curry(SoulforceCheats1, 0));
	}
	public function AddMaxBackpack4():void {
		if (player.hasStatusEffect(StatusEffects.WendigoPsychosis)) SceneLib.glacialRift.wendigoScene.becomeWendigo();
		else {
			outputText("Get a Life... i mean Wendigo Psychosis...");
			doNext(curry(SoulforceCheats1, 1));
		}
	}
	public function AddMaxBackpack5():void {
		if (flags[kFLAGS.EVANGELINE_LVL_UP] > 0) flags[kFLAGS.EVANGELINE_LVL_UP] = 0;
		if (flags[kFLAGS.EVANGELINE_DEFEATS_COUNTER] > 0) flags[kFLAGS.EVANGELINE_DEFEATS_COUNTER] = 0;
		if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] > 0) flags[kFLAGS.EVANGELINE_SPELLS_CASTED] = 0;
		if (flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] > 0) flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 0;
		if (flags[kFLAGS.EVANGELINE_02330] > 0) flags[kFLAGS.EVANGELINE_02330] = 0;
		if (flags[kFLAGS.EVANGELINE_02331] > 0) flags[kFLAGS.EVANGELINE_02331] = 0;
		if (flags[kFLAGS.EVANGELINE_02332] > 0) flags[kFLAGS.EVANGELINE_02332] = 0;
		if (flags[kFLAGS.EVANGELINE_02333] > 0) flags[kFLAGS.EVANGELINE_02333] = 0;
		outputText("Rewind Evangeline ^^");
		doNext(curry(SoulforceCheats1, 1));
	}
	public function TestDynamicStats():void {
		player.statStore.addBuff('sens',+10,'tag',{text:'Debug buff!', rate: Buff.RATE_HOURS, tick: 1});
		statScreenRefresh();
		doNext(curry(SoulforceCheats1,0));
	}
	public function FightAria():void {
		clearOutput();
		outputText("Entering battle with Melkie! Enjoy ^^");
		startCombat(new Aria());
	}
	public function FightLethice():void {
		clearOutput();
		outputText("Entering battle with Lethice! Enjoy ^^");
		startCombat(new Lethice());
	}
	public function FightAlvina():void {
		clearOutput();
		outputText("Entering battle with Alvina! Enjoy ^^");
		startCombat(new Alvina());
	}
	public function FightChaosChimera():void {
		clearOutput();
		outputText("Entering battle with Chaos Chimera! Enjoy ^^");
		startCombat(new ChaosChimera());
	}
	public function FightDarkSlimeEmpress():void {
		clearOutput();
		outputText("Entering battle with Dark Slime Empress! Enjoy ^^");
		startCombat(new DarkSlimeEmpress());
	}
	public function FightHydra():void {
		clearOutput();
		outputText("Entering battle with Hydra! Enjoy ^^");
		startCombat(new Hydra());
	}
	public function FightHellfireSnail():void {
		clearOutput();
		outputText("Entering battle with Hellfire Snail! Enjoy ^^");
		startCombat(new HellfireSnail());
	}
	public function ChimeraBodyUltimateStage():void {
		if (player.hasPerk(PerkLib.ChimericalBodyUltimateStage)) {
			player.removePerk(PerkLib.ChimericalBodyUltimateStage);
			outputText("\n\n<b>(Lost Perk: Chimerical Body: Ultimate Stage!)</b>");
		}
		else {
			player.createPerk(PerkLib.ChimericalBodyUltimateStage, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Chimerical Body: Ultimate Stage!)</b>");
		}
		doNext(curry(SoulforceCheats1, 0));
	}
	public function AllMetamorphOptionsUnlock():void {
		for each (var hairMem: * in HairMem.Memories) {
			Metamorph.GeneticMemoryStorage[hairMem.id] = true;
		}
		for each (var faceMem: * in FaceMem.Memories) {
			Metamorph.GeneticMemoryStorage[faceMem.id] = true;
		}
		for each (var eyesMem: * in EyesMem.Memories) {
			Metamorph.GeneticMemoryStorage[eyesMem.id] = true;
		}
		for each (var earsMem: * in EarsMem.Memories) {
			Metamorph.GeneticMemoryStorage[earsMem.id] = true;
		}
		for each (var armsMem: * in ArmsMem.Memories) {
			Metamorph.GeneticMemoryStorage[armsMem.id] = true;
		}
		for each (var hornsMem: * in HornsMem.Memories) {
			Metamorph.GeneticMemoryStorage[hornsMem.id] = true;
		}
		for each (var skinMem: * in SkinMem.Memories) {
			Metamorph.GeneticMemoryStorage[skinMem.id] = true;
		}
		for each (var skinPatternMem: * in SkinPatternMem.Memories) {
			Metamorph.GeneticMemoryStorage[skinPatternMem.id] = true;
		}
		for each (var tongueMem: * in TongueMem.Memories) {
			Metamorph.GeneticMemoryStorage[tongueMem.id] = true;
		}
		for each (var wingsMem: * in WingsMem.Memories) {
			Metamorph.GeneticMemoryStorage[wingsMem.id] = true;
		}
		for each (var antennaeMem: * in AntennaeMem.Memories) {
			Metamorph.GeneticMemoryStorage[antennaeMem.id] = true;
		}
		for each (var gillsMem: * in GillsMem.Memories) {
			Metamorph.GeneticMemoryStorage[gillsMem.id] = true;
		}
		for each (var rearBodyMem: * in RearBodyMem.Memories) {
			Metamorph.GeneticMemoryStorage[rearBodyMem.id] = true;
		}
		for each (var lowerBodyMem: * in LowerBodyMem.Memories) {
			Metamorph.GeneticMemoryStorage[lowerBodyMem.id] = true;
		}
		for each (var tailMem: * in TailMem.Memories) {
			Metamorph.GeneticMemoryStorage[tailMem.id] = true;
		}
		Metamorph.GeneticMemoryStorage["Taur Lower Body"] = true;
		doNext(curry(SoulforceCheats1, 0));
	}
	public function PerkGalore1():void {
		if (!player.hasPerk(PerkLib.CorruptedKitsune)) {
			player.createPerk(PerkLib.CorruptedKitsune, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Corrupted Kitsune!)</b>");
		}
		if (!player.hasPerk(PerkLib.CorruptedNinetails)) {
			player.createPerk(PerkLib.CorruptedNinetails, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Corrupted Ninetails!)</b>");
		}
		if (!player.hasPerk(PerkLib.EnlightenedKitsune)) {
			player.createPerk(PerkLib.EnlightenedKitsune, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Enlightened Kitsune!)</b>");
		}
		if (!player.hasPerk(PerkLib.EnlightenedNinetails)) {
			player.createPerk(PerkLib.EnlightenedNinetails, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Enlightened Ninetails!)</b>");
		}
		if (!player.hasPerk(PerkLib.FerasBoonAlpha)) {
			player.createPerk(PerkLib.FerasBoonAlpha, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Feras Boon Alpha!)</b>");
		}
		if (!player.hasPerk(PerkLib.FerasBoonBreedingBitch)) {
			player.createPerk(PerkLib.FerasBoonBreedingBitch, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Feras Boon Breeding Bitch!)</b>");
		}
		if (!player.hasPerk(PerkLib.FerasBoonMilkingTwat)) {
			player.createPerk(PerkLib.FerasBoonMilkingTwat, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Feras Boon Milking Twat!)</b>");
		}
		if (!player.hasPerk(PerkLib.FerasBoonSeeder)) {
			player.createPerk(PerkLib.FerasBoonSeeder, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Feras Boon Seeder!)</b>");
		}
		if (!player.hasPerk(PerkLib.FireLord)) {
			player.createPerk(PerkLib.FireLord, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: FireLord!)</b>");
		}
		if (!player.hasPerk(PerkLib.Hellfire)) {
			player.createPerk(PerkLib.Hellfire, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Hellfire!)</b>");
		}
		if (!player.hasPerk(PerkLib.MagicalFertility)) {
			player.createPerk(PerkLib.MagicalFertility, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Magical Fertility!)</b>");
		}
		if (!player.hasPerk(PerkLib.MagicalVirility)) {
			player.createPerk(PerkLib.MagicalVirility, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Magical Virility!)</b>");
		}
		if (!player.hasPerk(PerkLib.MaraesGiftButtslut)) {
			player.createPerk(PerkLib.MaraesGiftButtslut, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Maraes Gift Buttslut!)</b>");
		}
		if (!player.hasPerk(PerkLib.MaraesGiftFertility)) {
			player.createPerk(PerkLib.MaraesGiftFertility, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Maraes Gift Fertility!)</b>");
		}
		if (!player.hasPerk(PerkLib.MaraesGiftProfractory)) {
			player.createPerk(PerkLib.MaraesGiftProfractory, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Maraes Gift Profractory!)</b>");
		}
		if (!player.hasPerk(PerkLib.MaraesGiftStud)) {
			player.createPerk(PerkLib.MaraesGiftStud, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Maraes Gift Stud!)</b>");
		}
		if (!player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) {
			player.createPerk(PerkLib.NinetailsKitsuneOfBalance, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: 9T Kitsune Of Balance!)</b>");
		}
		if (!player.hasPerk(PerkLib.MilkMaid)) {
			player.createPerk(PerkLib.MilkMaid, 1, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: MilkMaid!)</b>");
		}
		if (!player.hasPerk(PerkLib.OneTrackMind)) {
			player.createPerk(PerkLib.OneTrackMind, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: One Track Mind!)</b>");
		}
		if (!player.hasPerk(PerkLib.PureAndLoving)) {
			player.createPerk(PerkLib.PureAndLoving, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pure And Loving!)</b>");
		}
		if (!player.hasPerk(PerkLib.PurityBlessing)) {
			player.createPerk(PerkLib.PurityBlessing, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Purity Blessing!)</b>");
		}
		if (!player.hasPerk(PerkLib.SensualLover)) {
			player.createPerk(PerkLib.SensualLover, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Sensual Lover!)</b>");
		}
		if (!player.hasPerk(PerkLib.ThickSkin)) {
			player.createPerk(PerkLib.ThickSkin, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Thick Skin!)</b>");
		}
		if (player.hasPerk(PerkLib.Perfection) && !player.hasPerk(PerkLib.Creationism)) {
			player.createPerk(PerkLib.Creationism, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Creationism!)</b>");
		}
		if (player.hasPerk(PerkLib.SoulPowered) && !player.hasPerk(PerkLib.AllSeeing)) {
			player.createPerk(PerkLib.AllSeeing, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: All-Seeing!)</b>");
		}
		if (player.hasPerk(PerkLib.SoulOfSteel) && !player.hasPerk(PerkLib.GodOfSteel)) {
			player.createPerk(PerkLib.GodOfSteel, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: God of Steel!)</b>");
		}
		if (player.hasPerk(PerkLib.BlessedByLadyGodiva) && !player.hasPerk(PerkLib.LadyGodivasFavoriteChild)) {
			player.createPerk(PerkLib.LadyGodivasFavoriteChild, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Lady Godiva's favorite Child!)</b>");
		}
		if (player.hasPerk(PerkLib.Surgeon) && !player.hasPerk(PerkLib.Medic)) {
			player.createPerk(PerkLib.Medic, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: MEDIC!!!!)</b>");
		}
		if (player.hasPerk(PerkLib.Cardinal) && !player.hasPerk(PerkLib.Pope)) {
			player.createPerk(PerkLib.Pope, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pope!)</b>");
		}
		if (player.hasPerk(PerkLib.President) && !player.hasPerk(PerkLib.Nerd)) {
			player.createPerk(PerkLib.Nerd, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: NERD!!!!)</b>");
		}
		if (player.hasPerk(PerkLib.SpysEnemy) && !player.hasPerk(PerkLib.ShitYouTouchedSasha)) {
			player.createPerk(PerkLib.ShitYouTouchedSasha, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: SHIT YOU TOUCHED SASHA!!!)</b>");
		}
		if (player.hasPerk(PerkLib.ZZZ) && !player.hasPerk(PerkLib.Lazy)) {
			player.createPerk(PerkLib.Lazy, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: LAZY!!!!)</b>");
		}/*		Slut
			if (player.hasPerk(PerkLib.) && !player.hasPerk(PerkLib.)) {
				player.createPerk(PerkLib., 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: !)</b>");
				player.createPerk(PerkLib., 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: !)</b>");
				player.createPerk(PerkLib., 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: !)</b>");
			}*/
		if (player.hasPerk(PerkLib.Weap0n) && !player.hasPerk(PerkLib.Arm0r)) {
			player.createPerk(PerkLib.Arm0r, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Armor!)</b>");
		}
		if (player.hasPerk(PerkLib.SexChampion) && !player.hasPerk(PerkLib.SexDeity)) {
			player.createPerk(PerkLib.SexDeity, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Sex Deity!)</b>");
		}
		doNext(curry(SoulforceCheats1, 1));
	}
	public function PerkGalore2():void {
		if (!player.hasPerk(PerkLib.PrestigeJobSeer)) {
			player.createPerk(PerkLib.PrestigeJobSeer, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Prestige Job: Seer!)</b>");
		}
		if (!player.hasPerk(PerkLib.PrestigeJobSoulArcher)) {
			player.createPerk(PerkLib.PrestigeJobSoulArcher, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Prestige Job: Soul Archer!)</b>");
		}
		if (!player.hasPerk(PerkLib.PiercedCrimstone)) {
			player.createPerk(PerkLib.PiercedCrimstone, 5, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pierced: Crimstone!)</b>");
		}
		if (!player.hasPerk(PerkLib.PiercedFertite)) {
			player.createPerk(PerkLib.PiercedFertite, 5, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pierced: Fertite!)</b>");
		}
		if (!player.hasPerk(PerkLib.PiercedFurrite)) {
			player.createPerk(PerkLib.PiercedFurrite, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pierced: Furrite!)</b>");
		}
		if (!player.hasPerk(PerkLib.PiercedLethite)) {
			player.createPerk(PerkLib.PiercedLethite, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pierced: Lethite!)</b>");
		}
		if (!player.hasPerk(PerkLib.BroodMother)) {
			player.createPerk(PerkLib.BroodMother, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Brood Mother!)</b>");
		}
		if (!player.hasPerk(PerkLib.Androgyny)) {
			player.createPerk(PerkLib.Androgyny, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Androgyny!)</b>");
		}
		if (!player.hasPerk(PerkLib.BasiliskWomb)) {
			player.createPerk(PerkLib.BasiliskWomb, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Basilisk Womb!)</b>");
		}
		if (!player.hasPerk(PerkLib.BunnyEggs)) {
			player.createPerk(PerkLib.BunnyEggs, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Bunny Eggs!)</b>");
		}
		if (!player.hasPerk(PerkLib.DeityJobMunchkin)) {
			player.createPerk(PerkLib.DeityJobMunchkin, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Deity Job: Munchkin!)</b>");
		}
		if (!player.hasPerk(PerkLib.Diapause)) {
			player.createPerk(PerkLib.Diapause, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Diapause!)</b>");
		}
		if (!player.hasPerk(PerkLib.Feeder)) {
			player.createPerk(PerkLib.Feeder, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Feeder!)</b>");
		}
		if (!player.hasPerk(PerkLib.HarpyWomb)) {
			player.createPerk(PerkLib.HarpyWomb, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Harpy Womb!)</b>");
		}
		if (!player.hasPerk(PerkLib.ImprovedVenomGland)) {
			player.createPerk(PerkLib.ImprovedVenomGland, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Improved Venom Gland!)</b>");
		}
		if (!player.hasPerk(PerkLib.MinotaurCumResistance)) {
			player.createPerk(PerkLib.MinotaurCumResistance, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Minotaur Cum Resistance!)</b>");
		}
		if (!player.hasPerk(PerkLib.BasiliskResistance)) {
			player.createPerk(PerkLib.BasiliskResistance, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Basilisk Resistance!)</b>");
		}
		if (!player.hasPerk(PerkLib.Cornucopia)) {
			player.createPerk(PerkLib.Cornucopia, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Cornucopia!)</b>");
		}
		if (!player.hasPerk(PerkLib.DemonicLethicite)) {
			player.createPerk(PerkLib.DemonicLethicite, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Demonic Lethicite!)</b>");
		}
		if (!player.hasPerk(PerkLib.DemonSlayer)) {
			player.createPerk(PerkLib.DemonSlayer, 0.1, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Demon Slayer!)</b>");
		}
		if (!player.hasPerk(PerkLib.ElvenBounty)) {
			player.createPerk(PerkLib.ElvenBounty, 0, 15, 0, 0);
			outputText("\n\n<b>(Gained Perk: Elven Bounty!)</b>");
		}
		if (!player.hasPerk(PerkLib.FeralHunter)) {
			player.createPerk(PerkLib.FeralHunter, 0.1, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Feral Hunter!)</b>");
		}
		if (!player.hasPerk(PerkLib.MarbleResistant)) {
			player.createPerk(PerkLib.MarbleResistant, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Marble Resistant!)</b>");
		}
		if (!player.hasPerk(PerkLib.Misdirection)) {
			player.createPerk(PerkLib.Misdirection, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Misdirection!)</b>");
		}
		if (!player.hasPerk(PerkLib.OmnibusGift)) {
			player.createPerk(PerkLib.OmnibusGift, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Omnibus Gift!)</b>");
		}
		if (!player.hasPerk(PerkLib.PilgrimsBounty)) {
			player.createPerk(PerkLib.PilgrimsBounty, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pilgrims Bounty!)</b>");
		}
		if (!player.hasPerk(PerkLib.ProductivityDrugs)) {
			player.createPerk(PerkLib.ProductivityDrugs,player.cor,10,player.lib,0);
			outputText("\n\n<b>(Gained Perk: Productivity Drugs!)</b>");
		}
		if (!player.hasPerk(PerkLib.SenseCorruption)) {
			player.createPerk(PerkLib.SenseCorruption, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Sense Corruption!)</b>");
		}
		if (!player.hasPerk(PerkLib.SenseWrath)) {
			player.createPerk(PerkLib.SenseWrath, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Sense Wrath!)</b>");
		}
		if (!player.hasPerk(PerkLib.Whispered)) {
			player.createPerk(PerkLib.Whispered, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Whispered!)</b>");
		}
		if (!player.hasPerk(PerkLib.ControlledBreath)) {
			player.createPerk(PerkLib.ControlledBreath, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Controlled Breath!)</b>");
		}
		if (!player.hasPerk(PerkLib.CleansingPalm)) {
			player.createPerk(PerkLib.CleansingPalm, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Cleansing Palm!)</b>");
		}
		if (!player.hasPerk(PerkLib.Enlightened)) {
			player.createPerk(PerkLib.Enlightened, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Enlightened!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryAlchemist) && !player.hasPerk(PerkLib.PastLifeAlchemist)) {
			player.createPerk(PerkLib.HistoryAlchemist, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Alchemist!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryCultivator) && !player.hasPerk(PerkLib.PastLifeCultivator)) {
			player.createPerk(PerkLib.HistoryCultivator, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Cultivator!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryFighter) && !player.hasPerk(PerkLib.PastLifeFighter)) {
			player.createPerk(PerkLib.HistoryFighter, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Fighter!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryFortune) && !player.hasPerk(PerkLib.PastLifeFortune)) {
			player.createPerk(PerkLib.HistoryFortune, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Fortune!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryHealer) && !player.hasPerk(PerkLib.PastLifeHealer)) {
			player.createPerk(PerkLib.HistoryHealer, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Healer!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryReligious) && !player.hasPerk(PerkLib.PastLifeReligious)) {
			player.createPerk(PerkLib.HistoryReligious, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Religious!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryScholar) && !player.hasPerk(PerkLib.PastLifeScholar)) {
			player.createPerk(PerkLib.HistoryScholar, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Scholar!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryScout) && !player.hasPerk(PerkLib.PastLifeScout)) {
			player.createPerk(PerkLib.HistoryScout, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Scout!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistorySlacker) && !player.hasPerk(PerkLib.PastLifeSlacker)) {
			player.createPerk(PerkLib.HistorySlacker, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Slacker!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistorySlut) && !player.hasPerk(PerkLib.PastLifeSlut)) {
			player.createPerk(PerkLib.HistorySlut, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Slut!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistorySmith) && !player.hasPerk(PerkLib.PastLifeSmith)) {
			player.createPerk(PerkLib.HistorySmith, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Smith!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryTactician) && !player.hasPerk(PerkLib.PastLifeTactician)) {
			player.createPerk(PerkLib.HistoryTactician, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Tactician!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryWhore) && !player.hasPerk(PerkLib.PastLifeWhore)) {
			player.createPerk(PerkLib.HistoryWhore, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Whore!)</b>");
		}
		doNext(curry(SoulforceCheats1, 1));
	}
	public function StatsAscensionMenu():void {
		menu();
		addButton(0, "Ascension", StatsAscensionMenu2);
		addButton(5, "Str", StatsMenuStr).hint("Adj Str.");
		addButton(6, "Tou", StatsMenuTou).hint("Adj Tou.");
		addButton(7, "Spe", StatsMenuSpe).hint("Adj Spe.");
		addButton(8, "Inte", StatsMenuInte).hint("Adj Inte.");
		addButton(9, "Wis", StatsMenuWis).hint("Adj Wis.");
		addButton(10, "Tone/Thicc/Fem", StatsMenuToneThicknessFeminity).hint("Adj Tone/Thickness/Feminity.");
		addButton(11, "Lib", StatsMenuLib).hint("Adj Lib.");
		addButton(12, "Sen", StatsMenuSen).hint("Adj Sen.");
		addButton(13, "Cor", StatsMenuCor).hint("Adj Cor.");
		addButton(14, "Back", curry(SoulforceCheats1, 0));
	}
	public function StatsAscensionMenu2():void {
		menu();
		addButton(0, "EarlyAscension", EarlyAscension).hint("Allowing to premature ascension.");
		addButton(1, "NG tier ++", IncreaseAscensionCounter).hint("Allowing to increase ascension counter.");
		if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0) addButton(2, "NG tier --", DecreaseAscensionCounter).hint("Allowing to decrease ascension counter.");
		addButton(5, "AscenPerks01", AddAscensionPerkPoints1).hint("Add 1 ascension perk point for use during ascending to the next NG+ tier.");
		addButton(6, "AscenPerks05", AddAscensionPerkPoints2).hint("Add 5 ascension perk points for use during ascending to the next NG+ tier.");
		addButton(7, "AscenPerks10", AddAscensionPerkPoints3).hint("Add 10 ascension perk points for use during ascending to the next NG+ tier.");
		addButton(8, "AscenPerks50", AddAscensionPerkPoints4).hint("Add 50 ascension perk points for use during ascending to the next NG+ tier.");
		addButton(9, "AscenPerks100", AddAscensionPerkPoints5).hint("Add 100 ascension perk points for use during ascending to the next NG+ tier.");
		addButton(14, "Back", StatsAscensionMenu);
	}
	public function StatsMenuStr():void {
		menu();
		addButton(0, "Str Up 1", AddStr1).hint("Add 1 to Str.");
		addButton(5, "Str Down 1", SubStr1).hint("Substract 1 from Str.");
		addButton(1, "Str Up 2", AddStr2).hint("Add 10 to Str.");
		addButton(6, "Str Down 2", SubStr2).hint("Substract 10 from Str.");
		addButton(2, "Str Up 3", AddStr3).hint("Add 50 to Str.");
		addButton(7, "Str Down 3", SubStr3).hint("Substract 50 from Str.");
		addButton(3, "Str Up 4", AddStr4).hint("Add 200 to Str.");
		addButton(8, "Str Down 4", SubStr4).hint("Substract 200 from Str.");
		addButton(4, "Str Up 5", AddStr5).hint("Add 1000 to Str.");
		addButton(9, "Str Down 5", SubStr5).hint("Substract 1000 from Str.");
		addButton(14, "Back", StatsAscensionMenu);
	}
	public function StatsMenuTou():void {
		menu();
		addButton(0, "Tou Up 1", AddTou1).hint("Add 1 to Tou.");
		addButton(5, "Tou Down 1", SubTou1).hint("Substract 1 from Tou.");
		addButton(1, "Tou Up 2", AddTou2).hint("Add 10 to Tou.");
		addButton(6, "Tou Down 2", SubTou2).hint("Substract 10 from Tou.");
		addButton(2, "Tou Up 3", AddTou3).hint("Add 50 to Tou.");
		addButton(7, "Tou Down 3", SubTou3).hint("Substract 50 from Tou.");
		addButton(3, "Tou Up 4", AddTou4).hint("Add 200 to Tou.");
		addButton(8, "Tou Down 4", SubTou4).hint("Substract 200 from Tou.");
		addButton(4, "Tou Up 5", AddTou5).hint("Add 1000 to Tou.");
		addButton(9, "Tou Down 5", SubTou5).hint("Substract 1000 from Tou.");
		addButton(14, "Back", StatsAscensionMenu);
	}
	public function StatsMenuSpe():void {
		menu();
		addButton(0, "Spe Up 1", AddSpe1).hint("Add 1 to Spe.");
		addButton(5, "Spe Down 1", SubSpe1).hint("Substract 1 from Spe.");
		addButton(1, "Spe Up 2", AddSpe2).hint("Add 10 to Spe.");
		addButton(6, "Spe Down 2", SubSpe2).hint("Substract 10 from Spe.");
		addButton(2, "Spe Up 3", AddSpe3).hint("Add 50 to Spe.");
		addButton(7, "Spe Down 3", SubSpe3).hint("Substract 50 from Spe.");
		addButton(3, "Spe Up 4", AddSpe4).hint("Add 200 to Spe.");
		addButton(8, "Spe Down 4", SubSpe4).hint("Substract 200 from Spe.");
		addButton(4, "Spe Up 5", AddSpe5).hint("Add 1000 to Spe.");
		addButton(9, "Spe Down 5", SubSpe5).hint("Substract 1000 from Spe.");
		addButton(14, "Back", StatsAscensionMenu);
	}
	public function StatsMenuInte():void {
		menu();
		addButton(0, "Inte Up 1", AddInte1).hint("Add 1 to Inte.");
		addButton(5, "Inte Down 1", SubInte1).hint("Substract 1 from Inte.");
		addButton(1, "Inte Up 2", AddInte2).hint("Add 10 to Inte.");
		addButton(6, "Inte Down 2", SubInte2).hint("Substract 10 from Inte.");
		addButton(2, "Inte Up 3", AddInte3).hint("Add 50 to Inte.");
		addButton(7, "Inte Down 3", SubInte3).hint("Substract 50 from Inte.");
		addButton(3, "Inte Up 4", AddInte4).hint("Add 200 to Inte.");
		addButton(8, "Inte Down 4", SubInte4).hint("Substract 200 from Inte.");
		addButton(4, "Inte Up 5", AddInte5).hint("Add 1000 to Inte.");
		addButton(9, "Inte Down 5", SubInte5).hint("Substract 1000 from Inte.");
		addButton(14, "Back", StatsAscensionMenu);
	}
	public function StatsMenuWis():void {
		menu();
		addButton(0, "Wis Up 1", AddWis1).hint("Add 1 to Wis.");
		addButton(5, "Wis Down 1", SubWis1).hint("Substract 1 from Wis.");
		addButton(1, "Wis Up 2", AddWis2).hint("Add 10 to Wis.");
		addButton(6, "Wis Down 2", SubWis2).hint("Substract 10 from Wis.");
		addButton(2, "Wis Up 3", AddWis3).hint("Add 50 to Wis.");
		addButton(7, "Wis Down 3", SubWis3).hint("Substract 50 from Wis.");
		addButton(3, "Wis Up 4", AddWis4).hint("Add 200 to Wis.");
		addButton(8, "Wis Down 4", SubWis4).hint("Substract 200 from Wis.");
		addButton(4, "Wis Up 5", AddWis5).hint("Add 1000 to Wis.");
		addButton(9, "Wis Down 5", SubWis5).hint("Substract 1000 from Wis.");
		addButton(14, "Back", StatsAscensionMenu);
	}
	public function StatsMenuLib():void {
		menu();
		addButton(0, "Lib Up 1", AddLib1).hint("Add 1 to Lib.");
		addButton(5, "Lib Down 1", SubLib1).hint("Substract 1 from Lib.");
		addButton(1, "Lib Up 2", AddLib2).hint("Add 10 to Lib.");
		addButton(6, "Lib Down 2", SubLib2).hint("Substract 10 from Lib.");
		addButton(2, "Lib Up 3", AddLib3).hint("Add 50 to Lib.");
		addButton(7, "Lib Down 3", SubLib3).hint("Substract 50 from Lib.");
		addButton(3, "Lib Up 4", AddLib4).hint("Add 200 to Lib.");
		addButton(8, "Lib Down 4", SubLib4).hint("Substract 200 from Lib.");
		addButton(4, "Lib Up 5", AddLib5).hint("Add 1000 to Lib.");
		addButton(9, "Lib Down 5", SubLib5).hint("Substract 1000 from Lib.");
		addButton(14, "Back", StatsAscensionMenu);
	}
	public function StatsMenuSen():void {
		menu();
		addButton(0, "Sen Up 1", AddSen1).hint("Add 1 to Sen.");
		addButton(5, "Sen Down 1", SubSen1).hint("Substract 1 from Sen.");
		addButton(1, "Sen Up 2", AddSen2).hint("Add 10 to Sen.");
		addButton(6, "Sen Down 2", SubSen2).hint("Substract 10 from Sen.");
		addButton(2, "Sen Up 3", AddSen3).hint("Add 50 to Sen.");
		addButton(7, "Sen Down 3", SubSen3).hint("Substract 50 from Sen.");
		addButton(3, "Sen Up 4", AddSen4).hint("Add 200 to Sen.");
		addButton(8, "Sen Down 4", SubSen4).hint("Substract 200 from Sen.");
		addButton(4, "Sen Up 5", AddSen5).hint("Add 1000 to Sen.");
		addButton(9, "Sen Down 5", SubSen5).hint("Substract 1000 from Sen.");
		addButton(14, "Back", StatsAscensionMenu);
	}
	public function StatsMenuCor():void {
		menu();
		addButton(0, "Cor Up 1", AddCor1).hint("Add 1 to Cor.");
		addButton(5, "Cor Down 1", SubCor1).hint("Substract 1 from Cor.");
		addButton(1, "Cor Up 2", AddCor2).hint("Add 5 to Cor.");
		addButton(6, "Cor Down 2", SubCor2).hint("Substract 5 from Cor.");
		addButton(2, "Cor Up 3", AddCor3).hint("Add 10 to Cor.");
		addButton(7, "Cor Down 3", SubCor3).hint("Substract 10 from Cor.");
		addButton(3, "Cor Up 4", AddCor4).hint("Add 50 to Cor.");
		addButton(8, "Cor Down 4", SubCor4).hint("Substract 50 from Cor.");
		addButton(14, "Back", StatsAscensionMenu);
	}
	public function StatsMenuToneThicknessFeminity():void {
		menu();
		addButton(0, "Tone Up 1", AddTone1).hint("Add 1 to Tone.");
		addButton(2, "Tone Down 1", SubTone1).hint("Substract 1 from Tone.");
		addButton(1, "Tone Up 2", AddTone2).hint("Add 10 to Tone.");
		addButton(3, "Tone Down 2", SubTone2).hint("Substract 10 from Tone.");
		addButton(5, "Thickness Up 1", AddThickness1).hint("Add 1 to Thickness.");
		addButton(7, "Thickness Down 1", SubThickness1).hint("Substract 1 from Thickness.");
		addButton(6, "Thickness Up 2", AddThickness2).hint("Add 10 to Thickness.");
		addButton(8, "Thickness Down 2", SubThickness2).hint("Substract 10 from Thickness.");
		addButton(10, "Feminity Up 1", AddFeminity1).hint("Add 1 to Feminity.");
		addButton(12, "Feminity Down 1", SubFeminity1).hint("Substract 1 from Feminity.");
		addButton(11, "Feminity Up 2", AddFeminity2).hint("Add 10 to Feminity.");
		addButton(13, "Feminity Down 2", SubFeminity2).hint("Substract 10 from Feminity.");
		addButton(14, "Back", StatsAscensionMenu);
	}
	public function PerksGemsEXPLvL():void {
		menu();
		addButton(0, "Add 1 PerkP", AddPerkPoint).hint("Add 1 perk point.");
		addButton(1, "Add 5 PerkP", AddPerkPoints).hint("Add 5 perk points.");
		addButton(2, "Sub 10 PerkP", SubPerkPoints).hint("Substract 10 perk points.");
		addButton(3, "Add Gems 1", AddGems1).hint("Add 100 gems.");
		addButton(4, "Add Gems 2", AddGems2).hint("Add 1,000 gems.");
		addButton(5, "Add EXP 1", AddEXP1).hint("Add 100 EXP.");
		addButton(6, "Add EXP 2", AddEXP2).hint("Add 1,000 EXP.");
		addButton(7, "Add EXP 3", AddEXP3).hint("Add 10,000 EXP.");
		addButton(8, "Add EXP 4", AddEXP4).hint("Add 100,000 EXP.");
		addButton(4, "Add Gems 3", AddGems3).hint("Add 10,000 gems.");
		if (player.hasPerk(PerkLib.SoulAncestor)) addButton(10, "10-12 St.", Stage10to12SoulPerks).hint("Remove all soul cultivator related perks for stages 10-12 of cultivation to keep save compatibility with public build saves.");
		if (!player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) addButton(11, "Trib Perk", TribulationPerks).hint("Add E class Tribulation survivor perk.");
		if (player.level < CoC.instance.levelCap) addButton(12, "Add 1 LvL", AddLvL1).hint("Add 1 Level (with stat and perk points).");
		if (player.level < CoC.instance.levelCap - 9) addButton(13, "Add 10 LvL's", AddLvL2).hint("Add 10 Levels (with stat and perk points).");
		addButton(14, "Back", curry(SoulforceCheats1, 0));
	}
	public function BodyStateMenu():void {
		menu();
		addButton(0, "Height U1", AddTallness1).hint("Add 2 to Height.");
		addButton(2, "Height D1", SubTallness1).hint("Substract 2 from Height.");
		addButton(1, "Height U2", AddTallness2).hint("Add 12 to Height.");
		addButton(3, "Height D2", SubTallness2).hint("Substract 12 from Height.");
		addButton(4, "Hair L. Up", AddHairLength).hint("Add 2 to Hair Length.");
		addButton(9, "Hair L. Down", SubHairLength).hint("Substract 2 from Hair Length.");
		addButton(5, "Cup Up", AddCupSize).hint("Add 1 to Cup Size.");
		addButton(6, "Cup Down", SubCupSize).hint("Substract 1 from Cup Size.");
		addButton(7, "Cock Up", AddCockLength).hint("Add 1 to Cock Length.");
		addButton(8, "Cock Down", SubCockLength).hint("Substract 1 from Cock Length.");
		addButton(10, "Add Pussy", AddPussy).hint("Add Vagina.");
		addButton(11, "Rem Pussy", RemovePussy).hint("Remove Vagina.");
		addButton(12, "Add C+B", AddCockBalls).hint("Add Cock+Balls.");
		addButton(13, "Rem C+B", RemoveCockBalls).hint("Remove Cock+Balls.");
		addButton(14, "Back", curry(SoulforceCheats1, 0));
	}
	public function AddTallness1():void {
		player.tallness += 2;
		if (player.tallness >= 132) player.tallness = 132;
		BodyStateMenu();
	}
	public function AddTallness2():void {
		player.tallness += 12;
		if (player.tallness >= 132) player.tallness = 132;
		BodyStateMenu();
	}
	public function AddHairLength():void {
		player.hairLength += 2;
		BodyStateMenu();
	}
	public function AddCupSize():void {
		var growth:int = 1;
		if (player.breastRows[0].breastRating < 2) growth++;
		player.growTits(growth, player.breastRows.length, true, 3);
		BodyStateMenu();
	}
	public function AddCockLength():void {
		player.lengthChange(1, 1);
		BodyStateMenu();
	}
	public function AddPussy():void {
		player.createVagina();
		player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_TIGHT;
		player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_NORMAL;
		player.vaginas[0].virgin = true;
		player.clitLength = .25;
		if (player.fertility <= 5) player.fertility = 6;
		BodyStateMenu();
	}
	public function AddCockBalls():void {
		player.createCock();
		player.cocks[0].cockLength = 4;
		player.cocks[0].cockThickness = 1;
		player.cocks[0].cockType = CockTypesEnum.HUMAN;
		player.clitLength = .25;
		if (player.balls <= 1) {
			player.balls = 2;
			player.ballSize = 1;
		}
		BodyStateMenu();
	}
	public function SubTallness1():void {
		player.tallness -= 2;
		if (player.tallness < 42) player.tallness = 42;
		BodyStateMenu();
	}
	public function SubTallness2():void {
		player.tallness -= 12;
		if (player.tallness < 42) player.tallness = 42;
		BodyStateMenu();
	}
	public function SubHairLength():void {
		player.hairLength -= 2;
		if (player.hairLength < 0) player.hairLength = 0;
		BodyStateMenu();
	}
	public function SubCupSize():void {
		if (player.breastRows[0].breastRating >= 1) player.breastRows[0].breastRating--;
		BodyStateMenu();
	}
	public function SubCockLength():void {
		var index:int = 0;
		player.lengthChange(-1, 1);
		if (player.cocks[index].cockLength < 2) {
			outputText("  ");
			player.killCocks(1);
		}
		BodyStateMenu();
	}
	public function RemovePussy():void {
		player.removeVagina(0, 1);
		player.clitLength = .25;
		BodyStateMenu();
	}
	public function RemoveCockBalls():void {
		player.killCocks(1);
		if (player.balls > 1) {
			player.balls = 0;
			player.ballSize = 0;
		}
		BodyStateMenu();
	}

	/*if (player.breastRows.length == 0) {
					outputText("A perfect pair of B cup breasts, complete with tiny nipples, form on your chest.");
					player.createBreastRow();
					player.breastRows[0].breasts = 2;
					//player.breastRows[0].breastsPerRow = 2;
					player.breastRows[0].nipplesPerBreast = 1;
					player.breastRows[0].breastRating = 2;
					outputText("\n");
				}
			}*/
	public function FasterOrInstantCampNPCRecruitment():void {
		menu();
		addButton(0, "E.I.K.", EmberIsabellaKiha).hint("Ember / Isabella / Kiha (If PC have all 3 nothing will happen after choosing this option.)");
		if (flags[kFLAGS.ETNA_FOLLOWER] < 2) addButton(1, "Etna", SuccubusishMantioreOnLeash);
		if (flags[kFLAGS.KINDRA_FOLLOWER] < 1) addButton(2, "Kindra", KindraMemory5);
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KINDRA_LVL_UP] == 6) addButton(3, "Kindra 1UP", Kindra1stLvLUp);
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KINDRA_LVL_UP] == 7) addButton(3, "Kindra 2UP", Kindra2ndLvLUp);
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KINDRA_LVL_UP] == 8) addButton(3, "Kindra 3UP", Kindra3rdLvLUp);
		if (flags[kFLAGS.KINDRA_LVL_UP] >= 7) addButton(4, "Kindra DeLvL", KindraTestDeLvL);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] < 1) addButton(5, "Ember 1UP", Ember1stLvLUp);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 1) addButton(5, "Ember 2UP", Ember2ndLvLUp);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 2) addButton(5, "Ember 3UP", Ember3rdLvLUp);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 3) addButton(5, "Ember 4UP", Ember4thLvLUp);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 4) addButton(5, "Ember 5UP", Ember5thLvLUp);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 5) addButton(5, "Ember 6UP", Ember6thLvLUp);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 6) addButton(5, "Ember 7UP", Ember7thLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] < 1) addButton(6, "Isabella 1UP", Isabella1stLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 1) addButton(6, "Isabella 2UP", Isabella2ndLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 2) addButton(6, "Isabella 3UP", Isabella3rdLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 3) addButton(6, "Isabella 4UP", Isabella4thLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 4) addButton(6, "Isabella 5UP", Isabella5thLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 5) addButton(6, "Isabella 6UP", Isabella6thLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 6) addButton(6, "Isabella 7UP", Isabella7thLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] < 1) addButton(7, "Kiha 1UP", Kiha1stLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 1) addButton(7, "Kiha 2UP", Kiha2ndLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 2) addButton(7, "Kiha 3UP", Kiha3rdLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 3) addButton(7, "Kiha 4UP", Kiha4thLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 4) addButton(7, "Kiha 5UP", Kiha5thLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 5) addButton(7, "Kiha 6UP", Kiha6thLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 6) addButton(7, "Kiha 7UP", Kiha7thLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] < 1) addButton(8, "Etna 1UP", Etna1stLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 1) addButton(8, "Etna 2UP", Etna2ndLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 2) addButton(8, "Etna 3UP", Etna3rdLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 3) addButton(8, "Etna 4UP", Etna4thLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 4) addButton(8, "Etna 5UP", Etna5thLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 5) addButton(8, "Etna 6UP", Etna6thLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 6) addButton(8, "Etna 7UP", Etna7thLvLUp);
		if (flags[kFLAGS.EMBER_LVL_UP] >= 1) addButton(10, "Ember DeLvL", EmberTestDeLvL);
		if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) addButton(11, "Isabella DeLvL", IsabellaTestDeLvL);
		if (flags[kFLAGS.KIHA_LVL_UP] >= 1) addButton(12, "Kiha DeLvL", KihaTestDeLvL);
		if (flags[kFLAGS.ETNA_LVL_UP] >= 1) addButton(13, "Etna DeLvL", EtnaTestDeLvL);
		addButton(14, "Back", curry(SoulforceCheats1, 0));
	}
	public function EmberIsabellaKiha():void {
		if (flags[kFLAGS.EMBER_HATCHED] < 1 && flags[kFLAGS.TOOK_EMBER_EGG] < 1) InstaEmberEggInCamp();
		if (flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] < 1) LilCocksLoverSummoning();
		if (flags[kFLAGS.KIHA_FOLLOWER] < 1) ResidentCampDragonishTsundere();
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function InstaEmberEggInCamp():void {
		player.createKeyItem("Dragon Egg", 0, 0, 0, 0);
		flags[kFLAGS.TOOK_EMBER_EGG] = 1;
		flags[kFLAGS.EMBER_COR] = 50;
		outputText("\n\n<b>Ember Egg put in camp.</b>");
	}
	public function LilCocksLoverSummoning():void {
		flags[kFLAGS.ISABELLA_COUNTDOWN_TO_CONTRACEPTIONS] = 240;
		flags[kFLAGS.ISABELLA_AFFECTION] = 100;
		flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] = 1;
		flags[kFLAGS.ISABELLA_PLAINS_DISABLED] = 1;
		outputText("\n\n<b>I heard you love cows loving small cocks...so here you will get Isabella *wink wink*</b>");
	}
	public function ResidentCampDragonishTsundere():void {
		flags[kFLAGS.KIHA_AFFECTION_LEVEL] = 2;
		flags[kFLAGS.KIHA_AFFECTION] = 100;
		flags[kFLAGS.KIHA_MOVE_IN_OFFER] = 1;
		flags[kFLAGS.KIHA_FOLLOWER] = 1;
		outputText("\n\n<b>We need more...yandered dragon-like waifu. Or was it only more of Kiha?</b>");
	}
	public function KindraMemory5():void {
		flags[kFLAGS.KINDRA_LVL_UP] = 6;
		flags[kFLAGS.KINDRA_FOLLOWER] = 1;
		flags[kFLAGS.KINDRA_AFFECTION] = 5;
		outputText("\n\n<b>Kindra... and everything is clear.</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function SuccubusishMantioreOnLeash():void {
		flags[kFLAGS.ETNA_AFFECTION] = 80;
		flags[kFLAGS.ETNA_FOLLOWER] = 2;
		flags[kFLAGS.ETNA_DAILY_VENOM_VIAL] = 0;
		outputText("\n\n<b>Watch for Etna is in da hous... err camp.</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember1stLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 1;
		outputText("\n\n<b>Ember 1st LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember2ndLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 2;
		outputText("\n\n<b>Ember 2nd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember3rdLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 3;
		outputText("\n\n<b>Ember 3rd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember4thLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 4;
		outputText("\n\n<b>Ember 4th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember5thLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 5;
		outputText("\n\n<b>Ember 5th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember6thLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 6;
		outputText("\n\n<b>Ember 6th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember7thLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 7;
		outputText("\n\n<b>Ember 7th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function EmberTestDeLvL():void {
		flags[kFLAGS.EMBER_LVL_UP]--;
		outputText("\n\n<b>Ember been De-LvL'd!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella1stLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 1;
		outputText("\n\n<b>Isabella 1st LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella2ndLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 2;
		outputText("\n\n<b>Isabella 2nd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella3rdLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 3;
		outputText("\n\n<b>Isabella 3rd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella4thLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 4;
		outputText("\n\n<b>Isabella 4th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella5thLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 5;
		outputText("\n\n<b>Isabella 5th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella6thLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 6;
		outputText("\n\n<b>Isabella 6th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella7thLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 7;
		outputText("\n\n<b>Isabella 7th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function IsabellaTestDeLvL():void {
		flags[kFLAGS.ISABELLA_LVL_UP]--;
		outputText("\n\n<b>Isabella been De-LvL'd!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha1stLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 1;
		outputText("\n\n<b>Kiha 1st LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha2ndLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 2;
		outputText("\n\n<b>Kiha 2nd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha3rdLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 3;
		outputText("\n\n<b>Kiha 3rd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha4thLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 4;
		outputText("\n\n<b>Kiha 4th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha5thLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 5;
		outputText("\n\n<b>Kiha 5th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha6thLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 6;
		outputText("\n\n<b>Kiha 6th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha7thLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 7;
		outputText("\n\n<b>Kiha 7th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function KihaTestDeLvL():void {
		flags[kFLAGS.KIHA_LVL_UP]--;
		outputText("\n\n<b>Kiha been De-LvL'd!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kindra1stLvLUp():void {
		flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KINDRA_LVL_UP] = 7;
		outputText("\n\n<b>Kindra 1st LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kindra2ndLvLUp():void {
		flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KINDRA_LVL_UP] = 8;
		outputText("\n\n<b>Kindra 2nd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kindra3rdLvLUp():void {
		flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KINDRA_LVL_UP] = 9;
		outputText("\n\n<b>Kindra 3rd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function KindraTestDeLvL():void {
		flags[kFLAGS.KINDRA_LVL_UP]--;
		outputText("\n\n<b>Kindra been De-LvL'd!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna1stLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 1;
		outputText("\n\n<b>Etna 1st LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna2ndLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 2;
		outputText("\n\n<b>Etna 2nd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna3rdLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 3;
		outputText("\n\n<b>Etna 3rd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna4thLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 4;
		outputText("\n\n<b>Etna 4th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna5thLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 5;
		outputText("\n\n<b>Etna 5th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna6thLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 6;
		outputText("\n\n<b>Etna 6th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna7thLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 7;
		outputText("\n\n<b>Etna 7th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function EtnaTestDeLvL():void {
		flags[kFLAGS.ETNA_LVL_UP]--;
		outputText("\n\n<b>Etna been De-LvL'd!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function EquipmentMenu(page:int = 1):void {
		menu();
		if (page == 1) {
			addButton(0, "Rap. Perk", AddRapPerk).hint("Add Raphael Rapier Perk and 1 Dragon Rapier.  USE only ONCE to not break the game!");
			addButton(1, "Sky Pearl", AddSkyPoisonPearl).hint("Add 1 Sky Poison Pearl.");
			addButton(2, "CatONIneTWhip", AddCatONineTailWhip).hint("Add 1 Bastet Whip.");
			addButton(3, "NineTailWhip", AddNineTailWhip).hint("Add 1 Nine Tail Whip.");
			addButton(4, "DualLAxes", AddDualMinoAxes).hint("Add 1 pair of Large Axes.");
			addButton(5, "UH Ayo Arm", AddUltraHeavyAyoArmor).hint("Add 1 Ultra heavy Ayo Armor for testing purposes.");
			//6
			addButton(7, "HB Mech", AddHBMech).hint("Add 1 Howling Banshee Mech for testing purposes.");
			addButton(8, "GobMechPrime", AddGoblinMechPrime).hint("Add 1 Goblin Mech Prime for testing purposes.");
			addButton(9, "GiantSlayerMech", AddGiantSlayerMech).hint("Add 1 Giant Slayer Mech for testing purposes.");
			addButton(10, "E. Tome", AddTheElementalistsTome).hint("Add 1 Elementalist’s Tome.");
			addButton(11, "Evelyn", AddTheEvelyn).hint("Add 1 Evelyn Crossbow.");
			addButton(12, "InqTome", AddTheInquisitorsTome).hint("Add 1 Inquisitor's Tome.");
			addButton(13, "-2-", EquipmentMenu, page + 1);
			addButton(14, "Back", curry(SoulforceCheats1, 0));
		}
		if (page == 2)  {
			//0
			//1
			//2
			//3
			//4
			//5
			//6
			//7
			addButton(8, "CheckWeapon", TestWeaponType).hint("Detect Weapon Type Equiped for sprite and battle testing.");
			addButton(9, "Ascensus", AddTheStaffs).hint("Add set of items for Ascensus.");
			addButton(10, "YODrops", AddYukiOnnaStuff).hint("Add both Yuki Onna equipment drops for testing purposes.");
			addButton(11, "SpikeShields", AddSpikedShields).hint("Add set of two spiked shields of various sizes and weight for testing purposes.");
			addButton(12, "MatrixArmory1", AddTheSeerHairpinAndCo).hint("Adds: 1 Eldritch Staff, 1 master Gloves, 1 Gnoll Throwing Axes, 1 Hodr's Bow, 1 Truestrike Sword, 1 Sceptre of Command, 1 Demonic Scythe, 1 Seer's Hairpin, Sakura Petal Kimono, Oni bead necklace");
			addButton(13, "-1-", EquipmentMenu, page - 1);
			addButton(14, "Back", curry(SoulforceCheats1, 0));
		}
	}
	public function NonEquipmentMenu(page:int = 1):void {
		menu();
		if (page == 1) {
			addButton(0, "Fox Jewel", AddFoxJewel).hint("Add 1 Fox Jewel.");
			addButton(1, "CDI", AddCurrentDebugItem).hint("Add 1 Gun.");
			//addButton(2, "TrollFig", AddTrollFig).hint("Add 1 Troll Fig.");
			addButton(2, "CyclopTF", AddTrollFig).hint("Add 1 cyclop TF.");
			//addButton(3, "", ).hint("Add 1 .");
			//addButton(4, "AbyssalInk", "Not yet ready for test and just for future use put here already ^^ (Add 1 Abyssal Ink.)");
			//addButton(5, "D.Fruit", AddDisplacerFruit).hint("Add 1 Displacer Fruit.");
			addButton(3, "CrimsonJade", AddCrimsonJade).hint("Add 1 Crimson Jade.");
			addButton(4, "R.Manuscript", AddRedManuscript).hint("Add 1 Red Manuscript.");
			addButton(5, "ALICORN", AddAlicornium).hint("Add 1 Alicornium.");
			addButton(6, "SBMan", AddSoulBlastManual).hint("Add 1 Soul Blast manual.");
			addButton(7, "V.D.ARC", AddVeryDilutedArcaneRegenConcotion).hint("Add 1 very diluted Arcane Regen Concotion.");
			addButton(8, "D.ARC", AddDilutedArcaneRegenConcotion).hint("Add 1 diluted Arcane Regen Concotion.");
			addButton(9, "A.R.CON", AddArcaneRegenConcotion).hint("Add 1 Arcane Regen Concotion.");
			addButton(10, "White B.", AddWhiteBook).hint("Add 1 White Book.");
			addButton(11, "Black B.", AddBlackBook).hint("Add 1 Black Book.");
			addButton(12, "Grey B.", AddGreyBook).hint("Add 1 Grey Book.");
			addButton(13, "-2-", NonEquipmentMenu, page + 1);
			addButton(14, "Back", curry(SoulforceCheats1, 0));
		}
		if (page == 2) {
			addButton(0, "SkybornSeed", AddSkybornSeed).hint("Add 1 Skyborn Seed.");
			addButton(1, "F.Fish", AddFreshFish).hint("Add 1 Fresh Fish.");
			addButton(2, "BehemothCum", AddBehemothCum).hint("Add 1 bottle of Behemoth Cum.");
			addButton(3, "TGOGossamer", AddThickGreenOnnaGossamer).hint("Add 1 Thick Green Onna Gossamer.");
			//addButton(4, "LeviSun.", AddLeviathanSunscreen).hint("Add 1 Leviathan Sunscreen");
			addButton(5, "Enigmanium", AddEnigmanium).hint("Add 1 vial of Enigmanium.");
			//addButton(6, "Skelp", AddSkelp).hint("Add 1 Skelp (WIP Melkie TF).");
			addButton(6, "dragonshit", AddDragonShit).hint("Add dragon stuff for jabberwocky test.");
			addButton(7, "Naga Oils", AddGorgonOil).hint("Add 1 vial of Gorgon, Vouivre and Couatl Oil.");
			addButton(8, "VT RV WF", AddVoltageTopaz).hint("Add 1 Voltage Topaz, 1 vial of Red Blood (Bat TF) and 1 Wonder Fruit.");
			addButton(9, "DSJ HS FSS", AddDarkSlimeJelly).hint("Add 1 Dark Slime Jelly, 1 Hydra Scale and 1 Fire Snail Saliva.");
			addButton(10, "Fafnir tear", AddFTear).hint("Add 1 Fafnir tear (Frost wyrm TF).");
			addButton(11, "Midnight gossamer", AddGossa).hint("Add 1 Midnight Gossamer.");
			addButton(12, consumables.VAMPBLD.shortName, addConsumable, consumables.VAMPBLD).hint("Add 1 " + consumables.VAMPBLD.longName + ".");
			//addButton(11, "", ).hint("Add 1 .");
			addButton(12, "E.Pearls", AddThePearls).hint("Add all three Elemental Pearls.");
			addButton(13, "-1-", NonEquipmentMenu, page - 1);
			addButton(14, "Back", curry(SoulforceCheats1, 0));
		}
	}

	private function addConsumable(consumable: Consumable): void {
		outputText("\n\n<b>(Gained 1 " + consumable.longName + "!)</b>\n\n");
		inventory.takeItem(consumable, curry(NonEquipmentMenu, 2));
	}

	public function MaterialMenu(page:int = 1):void {
		menu();
		if (page == 1) {
			addButton(0, "Wood", AddWood).hint("Add 100 Wood (game not check for limits so not go overboard with using this cheat).");
			addButton(1, "Nails", AddNail).hint("Add 50 Nails (game not check for limits so not go overboard with using this cheat).");
			addButton(2, "Stone", AddStone).hint("Add 100 Stone (game not check for limits so not go overboard with using this cheat).");
			addButton(3, "MetalPieces", AddMetalPieces).hint("Add 50 Metal Pieces (game not check for limits so not go overboard with using this cheat).");
			addButton(4, "SpiderSilk", AddSpiderSilk).hint("Add 1 Spider Silk.");
			addButton(5, "Ebonbloom", AddEbonbloom).hint("Add 1 Ebonbloom.");
			addButton(6, "WorldTreeB.", AddWorldTreeBranch).hint("Add 1 World Tree Branch.");
			addButton(7, "ChitinShard", AddBeeChitin).hint("Add 1 Chitin shard.");
			addButton(8, "GreenGel", AddGreenGel).hint("Add 1 Green Gel.");
			addButton(9, "DragonScale", AddDragonscale).hint("Add 1 Dragonscale.");
			addButton(10, "S.Shard", AddShard).hint("Add 1 S.Shard.");//addButton(10, "", ).hint("Add 1 .");
			addButton(11, "HEALHERB", AddHerb).hint("Add 1 HEALHERB.");
			addButton(12, "Copp+Tin", AddCooperTinOre).hint("Add 1 Cooper and Tin ore.");
			addButton(13, "-2-", MaterialMenu, page + 1);
			addButton(14, "Back", curry(SoulforceCheats1, 0));
		}
		if (page == 2) {
			addButton(0, "Skymetal", AddSkymetalOre).hint("Add 1 Skymetal Ore.");
			addButton(1, "Moonstone", AddMoonstone).hint("Add 1 Moonstone.");
			//addButton(2, "", ).hint("Add 1 .");
			//addButton(3, "", ).hint("Add 1 .");
			//addButton(4, "", ).hint("Add 1 .");
			//addButton(5, "", ).hint("Add 1 .");
			addButton(6, "UnicornHair", AddUnicornHair).hint("Add 1 Unicorn Hair.");
			addButton(7, "GolemCore", AddGolemCore).hint("Add 1 Golem Core.");
			addButton(8, "Mechanism", AddMechanism).hint("Add 1 Mechanism.");
			addButton(9, "EnergyCore", AddEnergyCore).hint("Add 1 Energy Core.");
			addButton(10, "F.Imp S.", AddFeralImpSkull).hint("Add 1 Feral Imp Skull.");
			addButton(11, "MetShoTom", AddMeteorShowerTome).hint("Add 1 Meteor Shower tome.");
			addButton(12, "PolMidScr", AddPolarMidnightScroll).hint("Add 1 Polar Midnight scroll.");
			addButton(13, "-1-", MaterialMenu, page - 1);
			addButton(14, "Back", curry(SoulforceCheats1, 0));
		}
	}
	public function EnemiesMenu(page:int = 1):void {
		menu();
		if (page == 1) {
			addButton(0, "FightForPearl", FightForPearl).hint("Test fight to get Sky Poison Pearl legally (aside we cheat to start fight)");
			addButton(1, "M.WSeaver", FightBelisa).hint("Test fight with Mana Weaver.");
			if (player.level >= 45 && TyrantiaFollower.TyrantiaFollowerStage < 4 && !TyrantiaFollower.TyraniaIsRemovedFromThewGame) addButton(2, "D.Giantess", FightTyrantia).hint("Test fight with Drider Giantess.");
			addButton(3, "B.Monke", FightWaizAbi).hint("You not even want to let the innocent bimbo monke free? <i>*sigh*</i>");
			addButton(4, "The Dummy", FightTheDummy).hint("Fight with The Dummy.");
			addButton(5, "Sand Mother", FightSandMother).hint("Test fight with Sand Mother.");
			addButton(6, "GothGirl", FightLilith).hint("Fight with devilish cute goth girl.");
			if (player.level >= 45) addButton(7, "Oculicorn", FightIridesian).hint("Test fight with Oculicorn.");
			addButton(8, "Sonya", FightSonya).hint("Test fight with Sonya.");
			addButton(9, "RyuBi", FightRyuBi).hint("Test fight with RyuBi.");
			addButton(10, "Marae", FightMarae).hint("Test fight with Marae (depending on game stage she can be buffed or unbuffed).");
			addButton(11, "SuccGard", FightSuccubusGardener).hint("Test fight with Succubus Gardener. (Also it will glitch right after fight so not start this fight if you got unsaved progress that you not wanna loose as only way to handle post fight glitch is restarting game)");
			addButton(12, "Lethice", FightLethice).hint("Test fight with Lethice.");
			addButton(13, "-2-", EnemiesMenu, page + 1);
			addButton(14, "Back", curry(SoulforceCheats1, 0));
		}
		if (page == 2)  {
			addButton(0, "DarkSlimeEmpress", FightDarkSlimeEmpress).hint("Test fight with Dark Slime Empress.");
			addButton(1, "Hydra", FightHydra).hint("Test fight with Hydra.");
			addButton(2, "HellfireSnail", FightHellfireSnail).hint("Test fight with Hellfire Snail.");
			addButton(3, "ChaosChimera", FightChaosChimera).hint("Test fight with Chaos Chimera.");
			addButton(4, "AnotSucc", FightCarrera).hint("Fight with probably another succubus out there...");
			addButton(5, "LvLUP Eva", LvLUPEva).hint("LvL UP forcefully Evangeline for testing purpose up to the limit.");
			addButton(6, "DELvL Eva", DELvLEva).hint("DE LvL forcefully Evangeline for testing purpose down toward the lvl 12.");
			addButton(7, "LvLUP Aurora", LvLUPAurora).hint("LvL UP forcefully Aurora for testing purpose up to the limit.");
			addButton(8, "DELvL Aurora", DELvLAurora).hint("DE LvL forcefully Aurora for testing purpose down toward the lvl 1.");
			addButton(9, "Aria", FightAria).hint("Test fight with melkie huntress Aria.");
			addButton(10, "SomeMalikore", FightRandomnMalikore).hint("Test fight with some malikore.");
			addButton(11, "Pierce", FightPierce).hint("Test fight with Pierce.");
			addButton(12, "Alvina", FightAlvina).hint("Test fight with Alvina.");
			addButton(13, "-1-", EnemiesMenu, page - 1);
			addButton(14, "Back", curry(SoulforceCheats1, 0));
		}
	}

	public function AddRapPerk():void {
		flags[kFLAGS.RAPHAEL_RAPIER_TRANING] = 4;
		player.createPerk(PerkLib.RapierTraining, 0, 0, 0, 0);
		outputText("\n\n<b>(Gained Perk: Rapier Training and 1 Dragon Rapier!)</b>\n\n");
		inventory.takeItem(weapons.DRAPIER, curry(EquipmentMenu, 1));
	}
	public function AddSkyPoisonPearl():void {
		outputText("\n\n<b>(Gained 1 Sky Poison Pearl!)</b>\n\n");
		inventory.takeItem(consumables.SPPEARL, curry(EquipmentMenu, 1));
	}
	public function AddCatONineTailWhip():void {
		outputText("\n\n<b>(Gained 1 Bastet Whip!)</b>\n\n");
		inventory.takeItem(weapons.CNTWHIP, curry(EquipmentMenu, 1));
	}
	public function AddNineTailWhip():void {
		outputText("\n\n<b>(Gained 1 Nine Tail Whip!)</b>\n\n");
		inventory.takeItem(weapons.NTWHIP, curry(EquipmentMenu, 1));
	}
	public function AddDualMinoAxes():void {
		outputText("\n\n<b>(Gained 1 pair of Large Axes!)</b>\n\n");
		inventory.takeItem(weapons.DL_AXE_, curry(EquipmentMenu, 1));
	}
	public function AddUltraHeavyAyoArmor():void {
		outputText("\n\n<b>(Gained 1 Ultra Heavy Ayo Armor!)</b>\n\n");
		inventory.takeItem(armors.UHAYOARM, curry(EquipmentMenu, 1));
	}
	public function AddHBMech():void {
		outputText("\n\n<b>(Gained 1 Howling Banshee Mech!)</b>\n\n");
		inventory.takeItem(vehicles.HB_MECH, curry(EquipmentMenu, 1));
	}
	public function AddGoblinMechPrime():void {
		outputText("\n\n<b>(Gained 1 Goblin Mech Prime!)</b>\n\n");
		inventory.takeItem(vehicles.GOBMPRI, curry(EquipmentMenu, 1));
	}
	public function AddGiantSlayerMech():void {
		outputText("\n\n<b>(Gained 1 Giant Slayer Mech!)</b>\n\n");
		inventory.takeItem(vehicles.GS_MECH, curry(EquipmentMenu, 1));
	}
	public function AddTheElementalistsTome():void {
		outputText("\n\n<b>(Gained 1 Elementalist’s Tome!)</b>\n\n");
		inventory.takeItem(weaponsrange.E_TOME_, curry(EquipmentMenu, 1));
	}
	public function AddTheEvelyn():void {
		outputText("\n\n<b>(Gained 1 Evelyn Crossbow!)</b>\n\n");
		inventory.takeItem(weaponsrange.EVELYN_, curry(EquipmentMenu, 1));
	}
	public function AddTheInquisitorsTome():void {
		outputText("\n\n<b>(Gained 1 Inquisitor's Tome!)</b>\n\n");
		inventory.takeItem(weaponsrange.I_TOME_, curry(EquipmentMenu, 1));
	}
	public function AddTheStaffs():void {
		outputText("\n\n<b>(Gained set of items to make Ascensus!)</b>\n\n");
		inventory.takeItem(useables.TBAPLAT, AddTheStaffs1);
	}
	public function AddTheStaffs1():void {
		outputText("\n\n");
		inventory.takeItem(useables.DBAPLAT, AddTheStaffs2);
	}
	public function AddTheStaffs2():void {
		outputText("\n\n");
		inventory.takeItem(weapons.W_STAFF, curry(EquipmentMenu, 2));
	}
	public function AddYukiOnnaStuff():void {
		outputText("\n\n<b>(Gained 1st Yuki Onna item!)</b>\n\n");
		inventory.takeItem(armors.BLIZZ_K, AddYukiOnnaStuff2);
	}
	public function AddYukiOnnaStuff2():void {
		outputText("\n\n<b>(Gained 2nd Yuki Onna item!)</b>\n\n");
		inventory.takeItem(headjewelries.SNOWFH, curry(EquipmentMenu, 2));
	}
	public function AddSpikedShields():void {
		outputText("\n\n<b>(Gained Heavy Spiked Shield!)</b>\n\n");
		inventory.takeItem(shields.SPIH_SH, AddSpikedShields2);
	}
	public function AddSpikedShields2():void {
		outputText("\n\n<b>(Gained Massive Spiked Shield!)</b>\n\n");
		inventory.takeItem(shields.SPIM_SH, curry(EquipmentMenu, 2));
	}
	public function AddTheSeerHairpinAndCo():void {
		outputText("\n\n<b>(Gained 1 Eldritch Staff!)</b>\n\n");
		inventory.takeItem(weapons.E_STAFF, AddTheSeerHairpinAndCo1);
	}
	public function AddTheSeerHairpinAndCo1():void {
		outputText("\n\n<b>(Gained 1 Master Gloves!)</b>\n\n");
		inventory.takeItem(weapons.MASTGLO, AddTheSeerHairpinAndCo2);
	}
	public function AddTheSeerHairpinAndCo2():void {
		outputText("\n\n<b>(Gained 1 Gnoll Throwing Axes!)</b>\n\n");
		inventory.takeItem(weaponsrange.GTHRAXE, AddTheSeerHairpinAndCo3);
	}
	public function AddTheSeerHairpinAndCo3():void {
		outputText("\n\n<b>(Gained 1 Hodr's Bow!)</b>\n\n");
		inventory.takeItem(weaponsrange.BOWHODR, AddTheSeerHairpinAndCo4);
	}
	public function AddTheSeerHairpinAndCo4():void {
		outputText("\n\n<b>(Gained 1 Sceptre of Command!)</b>\n\n");
		inventory.takeItem(weapons.SCECOMM, AddTheSeerHairpinAndCo5);
	}
	public function AddTheSeerHairpinAndCo5():void {
		outputText("\n\n<b>(Gained 1 Truestrike Sword!)</b>\n\n");
		inventory.takeItem(weapons.TRSTSWO, AddTheSeerHairpinAndCo6);
	}
	public function AddTheSeerHairpinAndCo6():void {
		outputText("\n\n<b>(Gained 1 Demonic Scythe!)</b>\n\n");
		inventory.takeItem(weapons.DEMSCYT, AddTheSeerHairpinAndCo7);
	}
	public function AddTheSeerHairpinAndCo7():void {
		outputText("\n\n<b>(Gained 1 Seer's Hairpin!)</b>\n\n");
		inventory.takeItem(headjewelries.SEERPIN, AddTheSeerHairpinAndCo8);
	}
	public function AddTheSeerHairpinAndCo8():void {
		outputText("\n\n<b>(Gained 1 Sakura Petal Kimono!)</b>\n\n");
		inventory.takeItem(armors.SPKIMO, AddTheSeerHairpinAndCo9);
	}
	public function AddTheSeerHairpinAndCo9():void {
		outputText("\n\n<b>(Gained 1 Oni bead necklace!)</b>\n\n");
		inventory.takeItem(necklaces.OBNECK, curry(EquipmentMenu, 2));
	}

	public function AddFoxJewel():void {
		outputText("\n\n<b>(Gained 1 Fox Jewel!)</b>\n\n");
		inventory.takeItem(consumables.FOXJEWL, curry(NonEquipmentMenu, 1));
	}
	public function AddFreshFish():void {
		outputText("\n\n<b>(Gained 1 Fresh Fish!)</b>\n\n");
		inventory.takeItem(consumables.FREFISH, curry(NonEquipmentMenu, 2));
	}
	public function AddTrollFig():void {
		//outputText("\n\n<b>(Gained 1 Troll Fig!)</b>\n\n");
		//inventory.takeItem(consumables.TROLFIG, curry(NonEquipmentMenu, 1));
		outputText("\n\n<b>(Gained 1 Cyclop TF)</b>\n\n");
		inventory.takeItem(consumables.EYEDROP, curry(NonEquipmentMenu, 1));
	}
	public function AddVoltageTopaz():void {
		outputText("\n\n<b>(Gained 1 Voltage Topaz!)</b>\n\n");
		inventory.takeItem(consumables.VOLTTOP, AddRedBlood);
	}
	public function AddDragonShit():void {
		outputText("\n\n<b>(Gained 1 dragon!)</b>\n\n");
		inventory.takeItem(consumables.DRAKHRT, AddJabbyShit);
	}
	public function AddJabbyShit():void {
		outputText("\n\n<b>(Gained 1 Jabby!)</b>\n\n");
		inventory.takeItem(consumables.JABBERS, curry(NonEquipmentMenu, 2));
	}
	public function AddRedBlood():void {
		outputText("\n\n<b>(Gained 1 vial of red blood!)</b>\n\n");
		inventory.takeItem(consumables.REDVIAL, AddWonderFruit);
	}
	public function AddWonderFruit():void {
		outputText("\n\n<b>(Gained 1 Wonder Fruit!)</b>\n\n");
		inventory.takeItem(consumables.WOFRUIT, curry(NonEquipmentMenu, 2));
	}
	public function AddDarkSlimeJelly():void {
		outputText("\n\n<b>(Gained 1 Dark Slime Jelly!)</b>\n\n");
		inventory.takeItem(consumables.DSLIMEJ, AddHydraScale);
	}
	public function AddHydraScale():void {
		outputText("\n\n<b>(Gained 1 Hydra Scale!)</b>\n\n");
		inventory.takeItem(consumables.HYDRASC, AddFireSnailSaliva);
	}
	public function AddFireSnailSaliva():void {
		outputText("\n\n<b>(Gained 1 Fire Snail Saliva!)</b>\n\n");
		inventory.takeItem(consumables.FSNAILS, curry(NonEquipmentMenu, 2));
	}
	public function AddGorgonOil():void {
		outputText("\n\n<b>(Gained 1 vial of Gorgon Oil!)</b>\n\n");
		inventory.takeItem(consumables.GORGOIL, AddVouivreOil);
	}
	public function AddVouivreOil():void {
		outputText("\n\n<b>(Gained 1 vial of Vouivre Oil!)</b>\n\n");
		inventory.takeItem(consumables.VOUIOIL, AddCouatlOil);
	}
	public function AddCouatlOil():void {
		outputText("\n\n<b>(Gained 1 vial of Couatl Oil!)</b>\n\n");
		inventory.takeItem(consumables.COUAOIL, curry(NonEquipmentMenu, 2));
	}
	public function AddEnigmanium():void {
		outputText("\n\n<b>(Gained 1 vial of Enigmanium!)</b>\n\n");
		inventory.takeItem(consumables.ENIGMANIUM, curry(NonEquipmentMenu, 2));
	}
	public function AddSkelp():void {
		outputText("\n\n<b>(Gained 1 Skelp!)</b>\n\n");
		inventory.takeItem(consumables.SKELP__, curry(NonEquipmentMenu, 2));
	}
	public function AddFTear():void {
		outputText("\n\n<b>(Gained 1 Fafnir Tear!)</b>\n\n");
		inventory.takeItem(consumables.F_TEAR, curry(NonEquipmentMenu, 2));
	}
	public function AddBubble():void {
		outputText("\n\n<b>(Gained 1 Bubblegum!)</b>\n\n");
		inventory.takeItem(consumables.BUBBLEG, curry(NonEquipmentMenu, 2));
	}

	public function AddGossa():void {
		outputText("\n\n<b>(Gained 1 Midnight gossamer!)</b>\n\n");
		inventory.takeItem(consumables.M_GOSSR, curry(NonEquipmentMenu, 2));
	}

	public function AddMetalPieces():void {
		outputText("\n\n<b>(Gained 50 Metal Pieces!)</b>\n\n");
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] += 50;
		statScreenRefresh();
		curry(MaterialMenu, 1);
	}
	public function AddSpiderSilk():void {
		outputText("\n\n<b>(Gained 1 Spider Silk!)</b>\n\n");
		inventory.takeItem(useables.T_SSILK, curry(MaterialMenu, 1));
	}
	public function AddBeeChitin():void {
		outputText("\n\n<b>(Gained 1 Chitin Shard!)</b>\n\n");
		inventory.takeItem(useables.B_CHITN, curry(MaterialMenu, 1));
	}
	public function AddGreenGel():void {
		outputText("\n\n<b>(Gained 1 Green Gel!)</b>\n\n");
		inventory.takeItem(useables.GREENGL, curry(MaterialMenu, 1));
	}
	public function AddDragonscale():void {
		outputText("\n\n<b>(Gained 1 Dragonscale!)</b>\n\n");
		inventory.takeItem(useables.D_SCALE, curry(MaterialMenu, 1));
	}
	public function AddShard():void {
		outputText("\n\n<b>(Gained 1 Shard!)</b>\n\n");
		inventory.takeItem(useables.S_SHARD, curry(MaterialMenu, 1));
	}
	public function AddHerb():void {
		outputText("\n\n<b>(Gained 1 Healing Herb!)</b>\n\n");
		inventory.takeItem(consumables.HEALHERB, curry(MaterialMenu, 1));
	}
	public function AddCooperTinOre():void {
		outputText("\n\n<b>(Gained 1 Copper Ore!)</b>\n\n");
		inventory.takeItem(useables.COP_ORE, AddCooperTinOre1);
	}
	public function AddCooperTinOre1():void {
		outputText("\n\n<b>(Gained 1 Tin Ore!)</b>\n\n");
		inventory.takeItem(useables.TIN_ORE, curry(MaterialMenu, 1));
	}
	public function AddEnergyCore():void {
		outputText("\n\n<b>(Gained 1 Energy Core!)</b>\n\n");
		flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] += 1;
		statScreenRefresh();
		curry(MaterialMenu, 2);
	}
	public function AddMechanism():void {
		outputText("\n\n<b>(Gained 1 Mechanism!)</b>\n\n");
		flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES] += 1;
		statScreenRefresh();
		curry(MaterialMenu, 2);
	}
	public function AddGolemCore():void {
		outputText("\n\n<b>(Gained 1 Golem Core!)</b>\n\n");
		inventory.takeItem(useables.GOLCORE, curry(MaterialMenu, 2));
	}
	public function AddSkymetalOre():void {
		outputText("\n\n<b>(Gained 1 Skymetal Ore!)</b>\n\n");
		inventory.takeItem(useables.SKYMETA, curry(MaterialMenu, 2));
	}
	public function AddMoonstone():void {
		outputText("\n\n<b>(Gained 1 Moonstone!)</b>\n\n");
		inventory.takeItem(useables.MOONSTO, curry(MaterialMenu, 2));
	}
	public function AddUnicornHair():void {
		outputText("\n\n<b>(Gained 1 Unicorn Hair!)</b>\n\n");
		inventory.takeItem(useables.UNICORNH, curry(MaterialMenu, 2));
	}
	public function AddPolarMidnightScroll():void {
		outputText("\n\n<b>(Gained 1 Polar Midnight scroll!)</b>\n\n");
		inventory.takeItem(consumables.POL_MID, curry(MaterialMenu, 2));
	}
	public function AddMeteorShowerTome():void {
		outputText("\n\n<b>(Gained 1 Meteor Shower tome!)</b>\n\n");
		inventory.takeItem(consumables.MET_SHO, curry(MaterialMenu, 2));
	}
	public function AddFeralImpSkull():void {
		outputText("\n\n<b>(Gained 1 Feral Imp Skull!)</b>\n\n");
		inventory.takeItem(useables.FIMPSKL, curry(MaterialMenu, 2));
	}

	public function TestWeaponType():void {
		outputText("Weapon types: "+[player.isStaffTypeWeapon(),player.isSwordTypeWeapon(),player.isAxeTypeWeapon(),player.isMaceHammerTypeWeapon(),player.isSpearTypeWeapon(),player.isScytheTypeWeapon(),player.isDuelingTypeWeapon()].join());
	}

	public function FightTheDummy():void {
		clearOutput();
		outputText("Entering battle with The Dummy! Enjoy ^^");
		startCombat(new TheDummy());
	}
	public function FightSuccubusGardener():void {
		clearOutput();
		outputText("Entering battle with Succubus Gardener! Enjoy ^^");
		startCombat(new SuccubusGardener());
	}

	public function AddThickGreenOnnaGossamer():void {
		outputText("\n\n<b>(Gained 1 Thick Green Onna Gossamer!)</b>\n\n");
		inventory.takeItem(consumables.WHITEIS, curry(SoulforceCheats1, 0));
	}
	public function AddWhiteIceShard():void {
		outputText("\n\n<b>(Gained 1 White Ice Shard!)</b>\n\n");
		inventory.takeItem(consumables.WHITEIS, curry(SoulforceCheats1, 0));
	}
	public function AddLeviathanSunscreen():void {
		outputText("\n\n<b>(Gained 1 Leviathan Sunscreen!)</b>\n\n");
		inventory.takeItem(consumables.LEVISUN, curry(SoulforceCheats1, 0));
	}
	public function AddVeryDilutedArcaneRegenConcotion():void {
		outputText("\n\n<b>(Gained 1 very diluted Arcane Regen Concotion!)</b>\n\n");
		inventory.takeItem(consumables.VDARCON, curry(NonEquipmentMenu, 1));
	}
	public function AddDilutedArcaneRegenConcotion():void {
		outputText("\n\n<b>(Gained 1 diluted Arcane Regen Concotion!)</b>\n\n");
		inventory.takeItem(consumables.D_ARCON, curry(NonEquipmentMenu, 1));
	}
	public function AddArcaneRegenConcotion():void {
		outputText("\n\n<b>(Gained 1 Arcane Regen Concotion!)</b>\n\n");
		inventory.takeItem(consumables.AREGCON, curry(NonEquipmentMenu, 1));
	}
	public function AddSoulBlastManual():void {
		outputText("\n\n<b>(Gained 1 Soul Blast Manual!)</b>\n\n");
		inventory.takeItem(consumables.SOBLMAN, curry(NonEquipmentMenu, 1));
	}
	public function AddDisplacerFruit():void {
		outputText("\n\n<b>(Gained 1 Displacer Fruit!)</b>\n\n");
		inventory.takeItem(consumables.ALICORN, curry(NonEquipmentMenu, 1));
	}
	public function AddAlicornium():void {
		outputText("\n\n<b>(Gained 1 Alicornium!)</b>\n\n");
		inventory.takeItem(consumables.ALICORN, curry(NonEquipmentMenu, 1));
	}
	public function AddMethir():void {
		outputText("\n\n<b>(Gained 1 Methir crystal!)</b>\n\n");
		inventory.takeItem(consumables.METHIRC, curry(NonEquipmentMenu, 1));
	}
	public function AddCurrentDebugItem():void {
		outputText("\n\n<b>(Gained 1 Testing gun!)</b>\n\n");
		inventory.takeItem(weaponsrange.M1CERBE, curry(NonEquipmentMenu, 1));
	}
	public function AddSkybornSeed():void {
		outputText("\n\n<b>(Gained 1 Skyborn Seed!)</b>\n\n");
		inventory.takeItem(consumables.SKYSEED, curry(NonEquipmentMenu, 2));
	}
	public function AddBehemothCum():void {
		outputText("\n\n<b>(Gained 1 vial of Behemoth Cum!)</b>\n\n");
		inventory.takeItem(consumables.BHMTCUM, curry(NonEquipmentMenu, 2));
	}
	public function AddEbonbloom():void {
		outputText("\n\n<b>(Gained 1 Ebonbloom!)</b>\n\n");
		inventory.takeItem(useables.EBONBLO, curry(MaterialMenu, 1));
	}
	public function AddWorldTreeBranch():void {
		outputText("\n\n<b>(Gained 1 Wold Tree branch!)</b>\n\n");
		inventory.takeItem(useables.WT_BRAN, curry(MaterialMenu, 1));
	}
	public function EarlyAscension():void {
		if (flags[kFLAGS.LETHICE_DEFEATED] == 1) {
			outputText("\n\n<b>You already used this cheat code!</b>");
		}
		else {
			flags[kFLAGS.LETHICE_DEFEATED] = 1;
			outputText("\n\n<b>You can Ascend now even if you not beaten Lethice yet!</b>");
		}
		doNext(StatsAscensionMenu2);
	}
	public function IncreaseAscensionCounter():void {
		outputText("\n\n<b>Your NG tier increased by 1!</b>");
		flags[kFLAGS.NEW_GAME_PLUS_LEVEL] += 1;
		doNext(StatsAscensionMenu2);
	}
	public function DecreaseAscensionCounter():void {
		outputText("\n\n<b>Your NG tier decreased by 1!</b>");
		flags[kFLAGS.NEW_GAME_PLUS_LEVEL] -= 1;
		doNext(StatsAscensionMenu2);
	}
	public function AddAscensionPerkPoints1():void {
		outputText("\n\n<b>You gained 1 Ascension Perk Point!</b>");
		player.ascensionPerkPoints += 1;
		doNext(StatsAscensionMenu2);
	}
	public function AddAscensionPerkPoints2():void {
		outputText("\n\n<b>You gained 5 Ascension Perk Points!</b>");
		player.ascensionPerkPoints += 5;
		doNext(StatsAscensionMenu2);
	}
	public function AddAscensionPerkPoints3():void {
		outputText("\n\n<b>You gained 10 Ascension Perk Points!</b>");
		player.ascensionPerkPoints += 10;
		doNext(StatsAscensionMenu2);
	}
	public function AddAscensionPerkPoints4():void {
		outputText("\n\n<b>You gained 50 Ascension Perk Points!</b>");
		player.ascensionPerkPoints += 50;
		doNext(StatsAscensionMenu2);
	}
	public function AddAscensionPerkPoints5():void {
		outputText("\n\n<b>You gained 100 Ascension Perk Points!</b>");
		player.ascensionPerkPoints += 100;
		doNext(StatsAscensionMenu2);
	}
	public function AddStr1():void {
		player.strStat.core.value += 1;
		statScreenRefresh();
		StatsMenuStr();
	}
	public function AddStr2():void {
		player.strStat.core.value += 10;
		statScreenRefresh();
		StatsMenuStr();
	}
	public function AddStr3():void {
		player.strStat.core.value += 50;
		statScreenRefresh();
		StatsMenuStr();
	}
	public function AddStr4():void {
		player.strStat.core.value += 200;
		statScreenRefresh();
		StatsMenuStr();
	}
	public function AddStr5():void {
		player.strStat.core.value += 1000;
		statScreenRefresh();
		StatsMenuStr();
	}
	public function AddTou1():void {
		player.touStat.core.value += 1;
		statScreenRefresh();
		StatsMenuTou();
	}
	public function AddTou2():void {
		player.touStat.core.value += 10;
		statScreenRefresh();
		StatsMenuTou();
	}
	public function AddTou3():void {
		player.touStat.core.value += 50;
		statScreenRefresh();
		StatsMenuTou();
	}
	public function AddTou4():void {
		player.touStat.core.value += 200;
		statScreenRefresh();
		StatsMenuTou();
	}
	public function AddTou5():void {
		player.touStat.core.value += 1000;
		statScreenRefresh();
		StatsMenuTou();
	}
	public function AddSpe1():void {
		player.speStat.core.value += 1;
		statScreenRefresh();
		StatsMenuSpe();
	}
	public function AddSpe2():void {
		player.speStat.core.value += 10;
		statScreenRefresh();
		StatsMenuSpe();
	}
	public function AddSpe3():void {
		player.speStat.core.value += 50;
		statScreenRefresh();
		StatsMenuSpe();
	}
	public function AddSpe4():void {
		player.speStat.core.value += 200;
		statScreenRefresh();
		StatsMenuSpe();
	}
	public function AddSpe5():void {
		player.speStat.core.value += 1000;
		statScreenRefresh();
		StatsMenuSpe();
	}
	public function AddInte1():void {
		player.intStat.core.value += 1;
		statScreenRefresh();
		StatsMenuInte();
	}
	public function AddInte2():void {
		player.intStat.core.value += 10;
		statScreenRefresh();
		StatsMenuInte();
	}
	public function AddInte3():void {
		player.intStat.core.value += 50;
		statScreenRefresh();
		StatsMenuInte();
	}
	public function AddInte4():void {
		player.intStat.core.value += 200;
		statScreenRefresh();
		StatsMenuInte();
	}
	public function AddInte5():void {
		player.intStat.core.value += 1000;
		statScreenRefresh();
		StatsMenuInte();
	}
	public function AddWis1():void {
		player.wisStat.core.value += 1;
		statScreenRefresh();
		StatsMenuWis();
	}
	public function AddWis2():void {
		player.wisStat.core.value += 10;
		statScreenRefresh();
		StatsMenuWis();
	}
	public function AddWis3():void {
		player.wisStat.core.value += 50;
		statScreenRefresh();
		StatsMenuWis();
	}
	public function AddWis4():void {
		player.wisStat.core.value += 200;
		statScreenRefresh();
		StatsMenuWis();
	}
	public function AddWis5():void {
		player.wisStat.core.value += 1000;
		statScreenRefresh();
		StatsMenuWis();
	}
	public function AddLib1():void {
		player.libStat.core.value += 1;
		statScreenRefresh();
		StatsMenuLib();
	}
	public function AddLib2():void {
		player.libStat.core.value += 10;
		statScreenRefresh();
		StatsMenuLib();
	}
	public function AddLib3():void {
		player.libStat.core.value += 50;
		statScreenRefresh();
		StatsMenuLib();
	}
	public function AddLib4():void {
		player.libStat.core.value += 200;
		statScreenRefresh();
		StatsMenuLib();
	}
	public function AddLib5():void {
		player.libStat.core.value += 1000;
		statScreenRefresh();
		StatsMenuLib();
	}
	public function AddSen1():void {
		dynStats("sen", 1);
		statScreenRefresh();
		StatsMenuSen();
	}
	public function AddSen2():void {
		dynStats("sen", 10);
		statScreenRefresh();
		StatsMenuSen();
	}
	public function AddSen3():void {
		dynStats("sen", 50);
		statScreenRefresh();
		StatsMenuSen();
	}
	public function AddSen4():void {
		dynStats("sen", 200);
		statScreenRefresh();
		StatsMenuSen();
	}
	public function AddSen5():void {
		dynStats("sen", 1000);
		statScreenRefresh();
		StatsMenuSen();
	}
	public function AddCor1():void {
		dynStats("cor", 1);
		statScreenRefresh();
		StatsMenuCor();
	}
	public function AddCor2():void {
		dynStats("cor", 5);
		statScreenRefresh();
		StatsMenuCor();
	}
	public function AddCor3():void {
		dynStats("cor", 10);
		statScreenRefresh();
		StatsMenuCor();
	}
	public function AddCor4():void {
		dynStats("cor", 50);
		statScreenRefresh();
		StatsMenuCor();
	}
	public function AddTone1():void {
		player.tone = player.tone + 1;
		statScreenRefresh();
		StatsMenuToneThicknessFeminity();
	}
	public function AddTone2():void {
		player.tone = player.tone + 10;
		statScreenRefresh();
		StatsMenuToneThicknessFeminity();
	}
	public function AddThickness1():void {
		player.thickness = player.thickness + 1;
		statScreenRefresh();
		StatsMenuToneThicknessFeminity();
	}
	public function AddThickness2():void {
		player.thickness = player.thickness + 10;
		statScreenRefresh();
		StatsMenuToneThicknessFeminity();
	}
	public function AddFeminity1():void {
		player.femininity = player.femininity + 1;
		statScreenRefresh();
		StatsMenuToneThicknessFeminity();
	}
	public function AddFeminity2():void {
		player.femininity = player.femininity + 10;
		statScreenRefresh();
		StatsMenuToneThicknessFeminity();
	}
	public function SubStr1():void {
		player.strStat.core.value -= 1;
		statScreenRefresh();
		StatsMenuStr();
	}
	public function SubStr2():void {
		player.strStat.core.value -= 10;
		statScreenRefresh();
		StatsMenuStr();
	}
	public function SubStr3():void {
		player.strStat.core.value -= 50;
		statScreenRefresh();
		StatsMenuStr();
	}
	public function SubStr4():void {
		player.strStat.core.value -= 200;
		statScreenRefresh();
		StatsMenuStr();
	}
	public function SubStr5():void {
		player.strStat.core.value -= 1000;
		statScreenRefresh();
		StatsMenuStr();
	}
	public function SubTou1():void {
		player.touStat.core.value -= 1;
		statScreenRefresh();
		StatsMenuTou();
	}
	public function SubTou2():void {
		player.touStat.core.value -= 10;
		statScreenRefresh();
		StatsMenuTou();
	}
	public function SubTou3():void {
		player.touStat.core.value -= 50;
		statScreenRefresh();
		StatsMenuTou();
	}
	public function SubTou4():void {
		player.touStat.core.value -= 200;
		statScreenRefresh();
		StatsMenuTou();
	}
	public function SubTou5():void {
		player.touStat.core.value -= 1000;
		statScreenRefresh();
		StatsMenuTou();
	}
	public function SubSpe1():void {
		player.speStat.core.value -= 1;
		statScreenRefresh();
		StatsMenuSpe();
	}
	public function SubSpe2():void {
		player.speStat.core.value -= 10;
		statScreenRefresh();
		StatsMenuSpe();
	}
	public function SubSpe3():void {
		player.speStat.core.value -= 50;
		statScreenRefresh();
		StatsMenuSpe();
	}
	public function SubSpe4():void {
		player.speStat.core.value -= 200;
		statScreenRefresh();
		StatsMenuSpe();
	}
	public function SubSpe5():void {
		player.speStat.core.value -= 1000;
		statScreenRefresh();
		StatsMenuSpe();
	}
	public function SubInte1():void {
		player.intStat.core.value -= 1;
		statScreenRefresh();
		StatsMenuInte();
	}
	public function SubInte2():void {
		player.intStat.core.value -= 10;
		statScreenRefresh();
		StatsMenuInte();
	}
	public function SubInte3():void {
		player.intStat.core.value -= 50;
		statScreenRefresh();
		StatsMenuInte();
	}
	public function SubInte4():void {
		player.intStat.core.value -= 200;
		statScreenRefresh();
		StatsMenuInte();
	}
	public function SubInte5():void {
		player.intStat.core.value -= 1000;
		statScreenRefresh();
		StatsMenuInte();
	}
	public function SubWis1():void {
		player.wisStat.core.value -= 1;
		statScreenRefresh();
		StatsMenuWis();
	}
	public function SubWis2():void {
		player.wisStat.core.value -= 10;
		statScreenRefresh();
		StatsMenuWis();
	}
	public function SubWis3():void {
		player.wisStat.core.value -= 50;
		statScreenRefresh();
		StatsMenuWis();
	}
	public function SubWis4():void {
		player.wisStat.core.value -= 200;
		statScreenRefresh();
		StatsMenuWis();
	}
	public function SubWis5():void {
		player.wisStat.core.value -= 1000;
		statScreenRefresh();
		StatsMenuWis();
	}
	public function SubLib1():void {
		player.libStat.core.value -= 1;
		statScreenRefresh();
		StatsMenuLib();
	}
	public function SubLib2():void {
		player.libStat.core.value -= 10;
		statScreenRefresh();
		StatsMenuLib();
	}
	public function SubLib3():void {
		player.libStat.core.value -= 50;
		statScreenRefresh();
		StatsMenuLib();
	}
	public function SubLib4():void {
		player.libStat.core.value -= 200;
		statScreenRefresh();
		StatsMenuLib();
	}
	public function SubLib5():void {
		player.libStat.core.value -= 1000;
		statScreenRefresh();
		StatsMenuLib();
	}
	public function SubSen1():void {
		dynStats("sen", -1);
		statScreenRefresh();
		StatsMenuSen();
	}
	public function SubSen2():void {
		dynStats("sen", -10);
		statScreenRefresh();
		StatsMenuSen();
	}
	public function SubSen3():void {
		dynStats("sen", -50);
		statScreenRefresh();
		StatsMenuSen();
	}
	public function SubSen4():void {
		dynStats("sen", -200);
		statScreenRefresh();
		StatsMenuSen();
	}
	public function SubSen5():void {
		dynStats("sen", -1000);
		statScreenRefresh();
		StatsMenuSen();
	}
	public function SubCor1():void {
		dynStats("cor", -1);
		statScreenRefresh();
		StatsMenuCor();
	}
	public function SubCor2():void {
		dynStats("cor", -5);
		statScreenRefresh();
		StatsMenuCor();
	}
	public function SubCor3():void {
		dynStats("cor", -10);
		statScreenRefresh();
		StatsMenuCor();
	}
	public function SubCor4():void {
		dynStats("cor", -50);
		statScreenRefresh();
		StatsMenuCor();
	}
	public function SubTone1():void {
		player.tone = player.tone - 1;
		statScreenRefresh();
		StatsMenuToneThicknessFeminity();
	}
	public function SubTone2():void {
		player.tone = player.tone - 10;
		statScreenRefresh();
		StatsMenuToneThicknessFeminity();
	}
	public function SubThickness1():void {
		player.thickness = player.thickness - 1;
		statScreenRefresh();
		StatsMenuToneThicknessFeminity();
	}
	public function SubThickness2():void {
		player.thickness = player.thickness - 10;
		statScreenRefresh();
		StatsMenuToneThicknessFeminity();
	}
	public function SubFeminity1():void {
		player.femininity = player.femininity - 1;
		statScreenRefresh();
		StatsMenuToneThicknessFeminity();
	}
	public function SubFeminity2():void {
		player.femininity = player.femininity - 10;
		statScreenRefresh();
		StatsMenuToneThicknessFeminity();
	}
	public function AddPerkPoint():void {
		player.perkPoints = player.perkPoints + 1;
		PerksGemsEXPLvL();
	}
	public function AddPerkPoints():void {
		player.perkPoints = player.perkPoints + 5;
		PerksGemsEXPLvL();
	}
	public function SubPerkPoints():void {
		player.perkPoints = player.perkPoints - 10;
		PerksGemsEXPLvL();
	}
	public function AddGems1():void {
		player.gems = player.gems + 100;
		statScreenRefresh();
		PerksGemsEXPLvL();
	}
	public function AddGems2():void {
		player.gems = player.gems + 1000;
		statScreenRefresh();
		PerksGemsEXPLvL();
	}
	public function AddEXP1():void {
		player.XP = player.XP + 100;
		statScreenRefresh();
		PerksGemsEXPLvL();
	}
	public function AddEXP2():void {
		player.XP = player.XP + 1000;
		statScreenRefresh();
		PerksGemsEXPLvL();
	}
	public function AddEXP3():void {
		player.XP = player.XP + 10000;
		statScreenRefresh();
		PerksGemsEXPLvL();
	}
	public function AddEXP4():void {
		player.XP = player.XP + 100000;
		statScreenRefresh();
		PerksGemsEXPLvL();
	}
	public function AddGems3():void {
		player.gems = player.gems + 10000;
		statScreenRefresh();
		PerksGemsEXPLvL();
	}
	public function Stage10to12SoulPerks():void {
		if (player.hasPerk(PerkLib.FleshBodyOverlordStage)) {
			player.removePerk(PerkLib.FleshBodyOverlordStage);
			outputText("\n\n<b>(Lost Perk: Flesh Body Overlord Stage!)</b>");
		}
		if (player.hasPerk(PerkLib.DaoistOverlordStage)) {
			player.removePerk(PerkLib.DaoistOverlordStage);
			outputText("\n\n<b>(Lost Perk: Daoist Overlord Stage!)</b>");
		}
		if (player.hasPerk(PerkLib.SoulKing)) {
			player.removePerk(PerkLib.SoulKing);
			outputText("\n\n<b>(Lost Perk: Soul King!)</b>");
		}
		if (player.hasPerk(PerkLib.SoulEmperor)) {
			player.removePerk(PerkLib.SoulEmperor);
			outputText("\n\n<b>(Lost Perk: Soul Emperor!)</b>");
		}
		if (player.hasPerk(PerkLib.SoulAncestor)) {
			player.removePerk(PerkLib.SoulAncestor);
			outputText("\n\n<b>(Lost Perk: Soul Ancestor!)</b>");
		}
		doNext(curry(SoulforceCheats1, 0));
	}
	public function TribulationPerks():void {
		if (!player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) {
			player.createPerk(PerkLib.EclassHeavenTribulationSurvivor, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: E class Heaven Tribulation Survivor!)</b>");
		}
		doNext(curry(SoulforceCheats1, 0));
	}
	public function AddLvL1():void {
		player.level = player.level + 1;
		player.statPoints += 5;
		player.perkPoints = player.perkPoints + 1;
		statScreenRefresh();
		PerksGemsEXPLvL();
	}
	public function AddLvL2():void {
		player.level = player.level + 10;
		player.statPoints += 50;
		player.perkPoints = player.perkPoints + 10;
		statScreenRefresh();
		PerksGemsEXPLvL();
	}
	public function AddWhiteBook():void {
		outputText("\n\n<b>(Gained 1 White Book!)</b>\n\n");
		inventory.takeItem(consumables.W__BOOK, curry(NonEquipmentMenu, 1));
	}
	public function AddBlackBook():void {
		outputText("\n\n<b>(Gained 1 Black Book!)</b>\n\n");
		inventory.takeItem(consumables.B__BOOK, curry(NonEquipmentMenu, 1));
	}
	public function AddGreyBook():void {
		outputText("\n\n<b>(Gained 1 Grey Book!)</b>\n\n");
		inventory.takeItem(consumables.G__BOOK, curry(NonEquipmentMenu, 1));
	}
	public function AddRedManuscript():void {
		outputText("\n\n<b>(Gained 1 Red Manuscript!)</b>\n\n");
		inventory.takeItem(consumables.RMANUSC, curry(NonEquipmentMenu, 1));
	}
	public function AddCrimsonJade():void {
		outputText("\n\n<b>(Gained 1 Crimson Jade!)</b>\n\n");
		inventory.takeItem(consumables.CRIMS_J, curry(NonEquipmentMenu, 1));
	}
	public function AddThePearls():void {
		outputText("\n\n<b>(Gained set of items to get all perks countering Elemental Conjuer perks negative effects on stat caps!)</b>\n\n");
		inventory.takeItem(consumables.E3PEARL, AddThePearls1);
	}
	public function AddThePearls1():void {
		outputText("\n\n");
		inventory.takeItem(consumables.E5PEARL, AddThePearls2);
	}
	public function AddThePearls2():void {
		outputText("\n\n");
		inventory.takeItem(consumables.E7PEARL, curry(NonEquipmentMenu, 2));
	}
	public function AddWood():void {
		outputText("\n\n<b>(Gained 100 Wood!)</b>");
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += 100;
		statScreenRefresh();
		curry(MaterialMenu, 1);
	}
	public function AddNail():void {
		outputText("\n\n<b>(Gained 50 Nails!)</b>");
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] += 50;
		statScreenRefresh();
		curry(MaterialMenu, 1);
	}
	public function AddStone():void {
		outputText("\n\n<b>(Gained 100 Stones!)</b>");
		flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += 100;
		statScreenRefresh();
		curry(MaterialMenu, 1);
	}
	public function FightForPearl():void {
		clearOutput();
		outputText("Entering battle with Deep Sea Kraken Boss! Enjoy ^^");
		startCombat(new Kraken());
	}
	public function FightMarae():void {
		clearOutput();
		outputText("Entering battle with Marae Boss! Enjoy ^^");
		startCombat(new Marae());
	}
	public function FightPierce():void {
		clearOutput();
		outputText("Entering battle with Pierce! Enjoy ^^");
		startCombat(new Pierce());
	}
	public function FightBelisa():void {
		clearOutput();
		outputText("Entering battle with Mana Weaver! Enjoy ^^");
		startCombat(new Belisa());
	}
	public function FightIridesian():void {
		SceneLib.iridesianFollower.firstMeetingIridesian();
	}
	public function FightLilith():void {
		clearOutput();
		outputText("Entering battle with devilish cute goth girl! Enjoy ^^");
		startCombat(new Lilith());
	}
	public function FightCarrera():void {
		clearOutput();
		outputText("Entering battle with another succubus or maybe not your every succubus? Enjoy ^^");
		startCombat(new Carrera());
	}
	public function FightWaizAbi():void {
		clearOutput();
		outputText("So you cheating and skipping guardian angel gaze to beat poor Bimbo Monke? You're a Sexual Predator... <i>Start to dial local police number</i>");
		menu();
		addButton(1, "LvL18", FightWaizAbi18);
		addButton(2, "LvL24", FightWaizAbi24);
		addButton(3, "LvL30", FightWaizAbi30);
	}
	public function FightWaizAbi18():void {
		flags[kFLAGS.WAIZABI_LVL_UP] = 0;
		startCombat(new WaizAbi());
	}
	public function FightWaizAbi24():void {
		flags[kFLAGS.WAIZABI_LVL_UP] = 1;
		startCombat(new WaizAbi());
	}
	public function FightWaizAbi30():void {
		flags[kFLAGS.WAIZABI_LVL_UP] = 2;
		startCombat(new WaizAbi());
	}
	public function FightSandMother():void {
		clearOutput();
		outputText("Entering battle with Sand Mother! Enjoy ^^");
		startCombat(new SandMother(), true)
	};
	public function FightSonya():void {
		clearOutput();
		outputText("Entering battle with Sonya! Enjoy ^^");
		startCombat(new Sonya());
	}
	public function FightRyuBi():void {
		clearOutput();
		outputText("Entering battle with RyuBi! Enjoy ^^");
		startCombat(new RyuBiDragon());
	}
	public function FightRandomnMalikore():void {
		clearOutput();
		outputText("Entering battle with some malikore! Enjoy ^^");
		startCombat(new Malikore());
	}
	public function LvLUPAurora():void {
		outputText("\n\n<b>Aurora get stronger! (cheat stop working when she reach max possible lvl for now (atm it's lvl 73))</b>");
		if (flags[kFLAGS.AURORA_LVL] < 13) flags[kFLAGS.AURORA_LVL]++;
		EnemiesMenu(2);
	}
	public function DELvLAurora():void {
		outputText("\n\n<b>Aurora get weaker! (cheat stop working when she reach lvl 1)</b>");
		if (flags[kFLAGS.AURORA_LVL] > 1) flags[kFLAGS.AURORA_LVL]--;
		EnemiesMenu(2);
	}
	public function LvLUPEva():void {
		outputText("\n\n<b>Evangeline get stronger! (cheat stop working when she reach max possible lvl for now (atm it's lvl 42))</b>");
		if (flags[kFLAGS.EVANGELINE_LVL_UP] < 17) flags[kFLAGS.EVANGELINE_LVL_UP]++;
		EnemiesMenu(1);
	}
	public function DELvLEva():void {
		outputText("\n\n<b>Evangeline get weaker! (cheat stop working when she reach lvl 12)</b>");
		if (flags[kFLAGS.EVANGELINE_LVL_UP] > 6) flags[kFLAGS.EVANGELINE_LVL_UP]--;
		EnemiesMenu(1);
	}
	public function RevertCabinProgress():void {
		flags[kFLAGS.CAMP_CABIN_PROGRESS] = 2;
		doNext(curry(SoulforceCheats1, 0));
	}
	public function GargoyleMenu():void {
		menu();
		addButton(0, "Human", BackToHumanForm).hint("Return to been fully human from gargoyle form test.");
		addButton(1, "Marble", MarbleGargoyleForm).hint("Turn into marble gargoyle form for tests.");
		addButton(2, "Alabaster", AlabasterGargoyleForm).hint("Turn into alabaster gargoyle form for tests.");
		addButton(14, "Back", curry(SoulforceCheats1, 1));
	}
	public function BackToHumanForm():void {
		flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 0;
		player.skin.setBaseOnly({type:Skin.PLAIN});
		player.hairType = Hair.NORMAL;
		player.faceType = Face.HUMAN;
		player.tongue.type = Tongue.HUMAN;
		player.horns.type = Horns.NONE;
		player.beardLength = 0;
		player.beardStyle = 0;
		player.arms.type = Arms.HUMAN;
		player.tailType = Tail.NONE;
		player.tailRecharge = 0;
		player.wings.type = Wings.NONE;
		player.lowerBody = LowerBody.HUMAN;
		player.legCount = 2;
		player.eyes.type = Eyes.HUMAN;
		player.antennae.type = Antennae.NONE;
		player.ears.type = Ears.HUMAN;
		player.gills.type = Gills.NONE;
		player.rearBody.type = RearBody.NONE;
		player.skin.restore();
		if (player.hasPerk(PerkLib.GargoylePure)) player.removePerk(PerkLib.GargoylePure);
		if (player.hasPerk(PerkLib.GargoyleCorrupted)) player.removePerk(PerkLib.GargoyleCorrupted);
		player.removePerk(PerkLib.TransformationImmunity);
		clearOutput();
		outputText("You have become fully human again.");
		doNext(curry(SoulforceCheats1, 0));
	}
	public function MarbleGargoyleForm():void {
		flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 1;
		player.skinTone = "light grey";
		player.hairColor = "light grey";
		clearOutput();
		outputText("You have become marble gargoyle. Now choose your wings shape.");
		doNext(WingShapeChoices);
	}
	public function AlabasterGargoyleForm():void {
		flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 2;
		player.skinTone = "quartz white";
		player.hairColor = "quartz white";
		clearOutput();
		outputText("You have become alabaster gargoyle. Now choose your wings shape.");
		doNext(WingShapeChoices);
	}
	public function WingShapeChoices():void {
		menu();
		addButton(0, "Bird", BirdWings);
		addButton(1, "Bat's", BatsWings);
	}
	public function BirdWings():void {
		flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 1;
		clearOutput();
		outputText("Now choose your arms shape.");
		doNext(ArmTypeChoices);
	}
	public function BatsWings():void {
		flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 2;
		clearOutput();
		outputText("Now choose your arms shape.");
		doNext(ArmTypeChoices);
	}
	public function ArmTypeChoices():void {
		menu();
		addButton(0, "Gargy", BirdArms);
		addButton(1, "Human", BatsWings);
	}
	public function BirdArms():void {
		player.arms.type = Arms.GARGOYLE;
		clearOutput();
		outputText("Now choose your tail shape.");
		doNext(TailTypeChoices);
	}
	public function BatsArms():void {
		player.arms.type = Arms.GARGOYLE_2;
		clearOutput();
		outputText("Now choose your tail shape.");
		doNext(TailTypeChoices);
	}
	public function TailTypeChoices():void {
		menu();
		addButton(0, "Whip-like", BirdTail);
		addButton(1, "Mace-like", BatsTail);
	}
	public function BirdTail():void {
		player.tailType = Tail.GARGOYLE;
		clearOutput();
		outputText("Now choose your legs shape.");
		doNext(LegsTypeChoices);
	}
	public function BatsTail():void {
		player.tailType = Tail.GARGOYLE_2;
		clearOutput();
		outputText("Now choose your legs shape.");
		doNext(LegsTypeChoices);
	}
	public function LegsTypeChoices():void {
		menu();
		addButton(0, "Gargy", BirdLegs);
		addButton(1, "Human", BatsLegs);
	}
	public function BirdLegs():void {
		player.lowerBody = LowerBody.GARGOYLE;
		clearOutput();
		outputText("Now choose your feeding style.");
		doNext(SustainTypeChoices);
	}
	public function BatsLegs():void {
		player.lowerBody = LowerBody.GARGOYLE_2;
		clearOutput();
		outputText("Now choose your feeding style.");
		doNext(SustainTypeChoices);
	}
	public function SustainTypeChoices():void {
		menu();
		addButton(0, "Soulforce", BirdSustain);
		addButton(1, "Milk & Cum", BatsSustain);
	}
	public function BirdSustain():void {
		player.createPerk(PerkLib.GargoylePure,0,0,0,0);
		player.createPerk(PerkLib.TransformationImmunity, 0, 0, 0, 0);
		clearOutput();
		outputText("Now your PC will became Prototype Gargoyle ^^");
		doNext(GargoyleBodyChanges);
	}
	public function BatsSustain():void {
		player.createPerk(PerkLib.GargoyleCorrupted,0,0,0,0);
		player.createPerk(PerkLib.TransformationImmunity,0,0,0,0);
		clearOutput();
		outputText("Now your PC will became Prototype Gargoyle ^^");
		doNext(GargoyleBodyChanges);
	}
	public function GargoyleBodyChanges():void {
		if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) {
			player.skinTone = "light grey";
			player.hairColor = "light grey";
		}
		if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) {
			player.skinTone = "quartz white";
			player.hairColor = "quartz white";
		}
		player.skin.setBaseOnly({type:Skin.STONE});
		player.hairType = Hair.NORMAL;
		player.faceType = Face.DEVIL_FANGS;
		player.tongue.type = Tongue.DEMONIC;
		player.horns.type = Horns.GARGOYLE;
		player.horns.count = 12 + rand(4);
		player.beardLength = 0;
		player.beardStyle = 0;
		player.tailRecharge = 0;
		player.wings.type = Wings.GARGOYLE_LIKE_LARGE;
		player.legCount = 2;
		player.eyes.type = Eyes.GEMSTONES;
		player.antennae.type = Antennae.NONE;
		player.tongue.type = Tongue.DEMONIC;
		player.ears.type = Ears.ELFIN;
		player.gills.type = Gills.NONE;
		player.rearBody.type = RearBody.NONE;
		if (player.hasStatusEffect(StatusEffects.BlackNipples)) player.removeStatusEffect(StatusEffects.BlackNipples);
		//	if (player.averageNipplesPerBreast() > 1) player.breastRows[x].nipplesPerBreast = 1;
		if (player.hasStatusEffect(StatusEffects.Feeder)) {
			player.removeStatusEffect(StatusEffects.Feeder);
			player.removePerk(PerkLib.Feeder);
		}
		doNext(curry(SoulforceCheats1, 0));
	}
	public function SoulforceRegeneration():void {
		menu();
		addButton(0, "1 hour", SoulforceRegeneration1).hint("Cultivate for 1 hour (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(20) + " soulforce).");//x1
		addButton(1, "2 hours", SoulforceRegeneration2).hint("Cultivate for 2 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(60) + " soulforce).");//x3
		addButton(2, "4 hours", SoulforceRegeneration3).hint("Cultivate for 4 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(140) + " soulforce).");//x7
		addButton(3, "6 hours", SoulforceRegeneration4).hint("Cultivate for 6 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(220) + " soulforce).");//x11
		addButton(4, "8 hours", SoulforceRegeneration5).hint("Cultivate for 8 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(300) + " soulforce).");//x15
		addButton(5, "10 hours", SoulforceRegeneration6).hint("Cultivate for 10 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(380) + " soulforce).");//x19
		addButton(6, "12 hours", SoulforceRegeneration7).hint("Cultivate for 12 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(460) + " soulforce).");//x23
		addButton(7, "14 hours", SoulforceRegeneration8).hint("Cultivate for 14 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(540) + " soulforce).");//x27
		addButton(8, "16 hours", SoulforceRegeneration9).hint("Cultivate for 16 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(620) + " soulforce).");//x31
		addButton(14, "Back", accessSoulforceMenu);
	}
	private function SoulforceRegeneration00():Number {
		var SFR00:Number = 0;
		if (player.kitsuneScore() >= 5) {
			if (player.kitsuneScore() >= 9 && player.tailType == 13 && player.tailCount >= 2) {
				if (player.kitsuneScore() >= 16) {
					if (player.kitsuneScore() >= 21 && player.tailCount == 9 && player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) {
						if (player.kitsuneScore() >= 26) SFR00 += 200;
						else SFR00 += 150;
					}
					else SFR00 += 80;
				}
				else SFR00 += 40;
			}
			else SFR00 += 20;
		}
		if (player.nekomataScore() >= 10) {
			if (player.tailType == 8 && player.tailCount >= 2 && player.nekomataScore() >= 12) SFR00 += 40;
			else SFR00 += 20;
		}
		if (player.hasPerk(PerkLib.DaoistApprenticeStage)) SFR00 += 20;
		if (player.hasPerk(PerkLib.DaoistWarriorStage)) SFR00 += 20;
		if (player.hasPerk(PerkLib.DaoistElderStage)) SFR00 += 20;
		if (player.hasPerk(PerkLib.DaoistOverlordStage)) SFR00 += 20;
		if (player.hasPerk(PerkLib.DaoistTyrantStage)) SFR00 += 20;
		return SFR00;
	}
	private function SoulforceRegenerationCompatibileTrainingItems():Boolean {
		return player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring"
				|| player.weaponFlyingSwordsName == "training soul flying sword";
	}
	public function DaoContemplations():void {
		clearOutput();
		outputText("Which Dao would you try to comprehend?\n\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfFire)) outputText("Fire: "+player.statusEffectv1(StatusEffects.DaoOfFire)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfIce)) outputText("Ice: "+player.statusEffectv1(StatusEffects.DaoOfIce)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfLightning)) outputText("Lightning: "+player.statusEffectv1(StatusEffects.DaoOfLightning)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfDarkness)) outputText("Darkness: "+player.statusEffectv1(StatusEffects.DaoOfDarkness)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfPoison)) outputText("Poison: "+player.statusEffectv1(StatusEffects.DaoOfPoison)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfWind)) outputText("Wind: "+player.statusEffectv1(StatusEffects.DaoOfWind)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfBlood)) outputText("Blood: "+player.statusEffectv1(StatusEffects.DaoOfBlood)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfWater)) outputText("Water: "+player.statusEffectv1(StatusEffects.DaoOfWater)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfEarth)) outputText("Earth: "+player.statusEffectv1(StatusEffects.DaoOfEarth)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfAcid)) outputText("Acid: "+player.statusEffectv1(StatusEffects.DaoOfAcid)+"\n");
		menu();
		if (player.statusEffectv2(StatusEffects.DaoOfFire) == 5) addButtonDisabled(0, "Fire", "You reached limit of comprehending this Dao.");
		else addButton(0, "Fire", DaoContemplationsEffect, StatusEffects.DaoOfFire, "Fire");
		if (player.statusEffectv2(StatusEffects.DaoOfIce) == 5) addButtonDisabled(1, "Ice", "You reached limit of comprehending this Dao.");
		else addButton(1, "Ice", DaoContemplationsEffect, StatusEffects.DaoOfIce, "Ice");
		if (player.statusEffectv2(StatusEffects.DaoOfLightning) == 5) addButtonDisabled(2, "Lightning", "You reached limit of comprehending this Dao.");
		else addButton(2, "Lightning", DaoContemplationsEffect, StatusEffects.DaoOfLightning, "Lightning");
		if (player.statusEffectv2(StatusEffects.DaoOfDarkness) == 5) addButtonDisabled(3, "Darkness", "You reached limit of comprehending this Dao.");
		else addButton(3, "Darkness", DaoContemplationsEffect, StatusEffects.DaoOfDarkness, "Darkness");
		if (player.statusEffectv2(StatusEffects.DaoOfPoison) == 5) addButtonDisabled(4, "Poison", "You reached limit of comprehending this Dao.");
		else addButton(4, "Poison", DaoContemplationsEffect, StatusEffects.DaoOfPoison, "Poison");
		if (player.statusEffectv2(StatusEffects.DaoOfWind) == 5) addButtonDisabled(5, "Wind", "You reached limit of comprehending this Dao.");
		else addButton(5, "Wind", DaoContemplationsEffect, StatusEffects.DaoOfWind, "Wind");
		if (player.statusEffectv2(StatusEffects.DaoOfBlood) == 5) addButtonDisabled(6, "Blood", "You reached limit of comprehending this Dao.");
		else addButton(6, "Blood", DaoContemplationsEffect, StatusEffects.DaoOfBlood, "Blood");
		if (player.statusEffectv2(StatusEffects.DaoOfWater) == 5) addButtonDisabled(7, "Water", "You reached limit of comprehending this Dao.");
		else addButton(7, "Water", DaoContemplationsEffect, StatusEffects.DaoOfWater, "Water");
		if (player.statusEffectv2(StatusEffects.DaoOfEarth) == 5) addButtonDisabled(8, "Earth", "You reached limit of comprehending this Dao.");
		else addButton(8, "Earth", DaoContemplationsEffect, StatusEffects.DaoOfEarth, "Earth");
		if (player.statusEffectv2(StatusEffects.DaoOfAcid) == 5) addButtonDisabled(9, "Acid", "You reached limit of comprehending this Dao.");
		else addButton(9, "Acid", DaoContemplationsEffect, StatusEffects.DaoOfAcid, "Acid");
		addButton(14, "Back", accessSoulforceMenu);
	}
	private function DaoContemplationsEffect(statusEffect:StatusEffectType, daoname:String):void {
		clearOutput();
		outputText("You find a flat, comfortable rock to sit down on and contemplate.  Minute after minute you feel immersed into elements that surrounds you.  How they flow around you, how they change on their own and how they interact with each other.  All this while trying to understand, despite being insignificant while the great dao manifests around you.\n\n");
		var dao:Number = rand(6);
		if (dao > 0) {
			outputText("After the session ends you managed to progress in Dao of "+daoname+".");
			if (player.hasStatusEffect(statusEffect)) {
				player.addStatusValue(statusEffect, 1, dao);
				if (player.statusEffectv1(statusEffect) > 140 && player.statusEffectv2(statusEffect) == 4) {
					player.addStatusValue(statusEffect, 1, -140);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 5th layer.</b>");
				}
				if (player.statusEffectv1(statusEffect) > 100 && player.statusEffectv2(statusEffect) == 3) {
					player.addStatusValue(statusEffect, 1, -100);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 4th layer.</b>");
				}
				if (player.statusEffectv1(statusEffect) > 60 && player.statusEffectv2(statusEffect) == 2) {
					player.addStatusValue(statusEffect, 1, -60);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 3rd layer.</b>");
				}
				if (player.statusEffectv1(statusEffect) > 40 && player.statusEffectv2(statusEffect) == 1) {
					player.addStatusValue(statusEffect, 1, -40);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 2nd layer.</b>");
				}
				if (player.statusEffectv1(statusEffect) > 20 && player.statusEffectv2(statusEffect) == 0) {
					player.addStatusValue(statusEffect, 1, -20);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 1st layer.</b>");
				}
			}
			else player.createStatusEffect(statusEffect, dao, 0, 0, 0);
		}
		else outputText("After the session ends, you did not manage to progress in your comprehension.");
		outputText("\n\n");
		doNext(camp.returnToCampUseEightHours);
	}
	public function DaoContemplationsEffectClone(statusEffect:StatusEffectType, daoname:String):void {
		player.addStatusValue(statusEffect, 1, 1);
		if (player.statusEffectv1(statusEffect) > 140 && player.statusEffectv2(statusEffect) == 4) {
			player.addStatusValue(statusEffect, 1, -140);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 5th layer.</b>");
		}
		if (player.statusEffectv1(statusEffect) > 100 && player.statusEffectv2(statusEffect) == 3) {
			player.addStatusValue(statusEffect, 1, -100);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 4th layer.</b>");
		}
		if (player.statusEffectv1(statusEffect) > 60 && player.statusEffectv2(statusEffect) == 2) {
			player.addStatusValue(statusEffect, 1, -60);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 3rd layer.</b>");
		}
		if (player.statusEffectv1(statusEffect) > 40 && player.statusEffectv2(statusEffect) == 1) {
			player.addStatusValue(statusEffect, 1, -40);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 2nd layer.</b>");
		}
		if (player.statusEffectv1(statusEffect) > 20 && player.statusEffectv2(statusEffect) == 0) {
			player.addStatusValue(statusEffect, 1, -20);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 1st layer.</b>");
		}
	}
	public function SoulforceRegeneration2():void {
		clearOutput();
		var soulforceamountrestored:int = 52;
		soulforceamountrestored += (SoulforceRegeneration00() * 3);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 52;//48(4)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 52;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 2;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(40);
		doNext(camp.returnToCampUseTwoHours);
	}
	public function SoulforceRegeneration3():void {
		clearOutput();
		var soulforceamountrestored:int = 124;
		soulforceamountrestored += (SoulforceRegeneration00() * 7);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 124;//112(12)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 124;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 4;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(80);
		doNext(camp.returnToCampUseFourHours);
	}
	public function SoulforceRegeneration4():void {
		clearOutput();
		var soulforceamountrestored:int = 196;
		soulforceamountrestored += (SoulforceRegeneration00() * 11);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 196;//176(20)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 196;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 6;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(120);
		doNext(camp.returnToCampUseSixHours);
	}
	public function SoulforceRegeneration5():void {
		clearOutput();
		var soulforceamountrestored:int = 268;
		soulforceamountrestored += (SoulforceRegeneration00() * 15);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 268;//240(28)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 268;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 8;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(160);
		doNext(camp.returnToCampUseEightHours);
	}
	public function SoulforceRegeneration6():void {
		clearOutput();
		var soulforceamountrestored:int = 340;
		soulforceamountrestored += (SoulforceRegeneration00() * 19);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 340;//304(36)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 340;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 10;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(200);
		doNext(camp.returnToCampUseTenHours);
	}
	public function SoulforceRegeneration7():void {
		clearOutput();
		var soulforceamountrestored:int = 412;
		soulforceamountrestored += (SoulforceRegeneration00() * 23);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 412;//368(44)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 412;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 12;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(240);
		doNext(camp.returnToCampUseTwelveHours);
	}
	public function SoulforceRegeneration8():void {
		clearOutput();
		var soulforceamountrestored:int = 484;
		soulforceamountrestored += (SoulforceRegeneration00() * 27);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 484;//432(52)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 484;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 14;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(280);
		doNext(camp.returnToCampUseFourteenHours);
	}
	public function SoulforceRegeneration9():void {
		clearOutput();
		var soulforceamountrestored:int = 556;
		soulforceamountrestored += (SoulforceRegeneration00() * 31);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 556;//496(60)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 556;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 16;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(320);
		doNext(camp.returnToCampUseSixteenHours);
	}
	public function SoulforceGainedFromCultivation1():Number {
		var cumulativegains:Number = 0;
		if (player.weaponName == "training soul axe" && player.weaponRangeName == "training soul crossbow" && player.shieldName == "training soul buckler" && player.armorName == "training soul armor" && player.upperGarmentName == "soul training shirt" && player.lowerGarmentName == "soul training panties"
				&& player.headjewelryName == "training soul hairpin" && player.necklaceName == "training soul necklace" && player.jewelryName == "training soul ring" && player.jewelryName2 == "training soul ring" && player.jewelryName3 == "training soul ring" && player.jewelryName4 == "training soul ring"
				&& player.weaponFlyingSwordsName == "training soul flying sword") {
			cumulativegains += 28;//+130% jak wszystkie 13 slotów - każdy kolejny dodany slot dodaje kolejne 10%
		}
		else if (player.weaponName == "training soul axe" && player.weaponRangeName == "training soul crossbow" && player.shieldName == "training soul buckler" && player.armorName == "training soul armor" && player.upperGarmentName == "soul training shirt" && player.lowerGarmentName == "soul training panties"
				&& player.headjewelryName == "training soul hairpin" && player.necklaceName == "training soul necklace" && player.jewelryName == "training soul ring") {
			cumulativegains += 13;//+45% jak wszystkie 9 slotów - każdy kolejny dodany slot dodaje kolejne 5%
		}
		else {
			if (player.weaponName == "training soul axe") cumulativegains += 1;
			if (player.weaponRangeName == "training soul crossbow") cumulativegains += 1;
			if (player.shieldName == "training soul buckler") cumulativegains += 1;
			if (player.armorName == "training soul armor") cumulativegains += 1;
			if (player.upperGarmentName == "soul training shirt") cumulativegains += 1;
			if (player.lowerGarmentName == "soul training panties") cumulativegains += 1;
			if (player.headjewelryName == "training soul hairpin") cumulativegains += 1;
			if (player.necklaceName == "training soul necklace") cumulativegains += 1;
			if (player.jewelryName == "training soul ring") cumulativegains += 1;
			if (player.jewelryName2 == "training soul ring") cumulativegains += 1;
			if (player.jewelryName3 == "training soul ring") cumulativegains += 1;
			if (player.jewelryName4 == "training soul ring") cumulativegains += 1;
			if (player.weaponFlyingSwordsName == "training soul flying sword") cumulativegains += 1;
		}
		return cumulativegains;
	}
	public function SoulforceGainedFromCultivation2():void {
		var bonussoulforce2:Number = 0;//razem może mieć max 2330
		if (player.weaponName == "training soul axe") bonussoulforce2 += 80;
		if (player.weaponRangeName == "training soul crossbow") bonussoulforce2 += 50;
		if (player.shieldName == "training soul buckler") bonussoulforce2 += 60;
		if (player.armorName == "training soul armor") bonussoulforce2 += 240;
		if (player.upperGarmentName == "soul training shirt") bonussoulforce2 += 200;
		if (player.lowerGarmentName == "soul training panties") bonussoulforce2 += 200;
		if (player.headjewelryName == "training soul hairpin") bonussoulforce2 += 200;
		if (player.necklaceName == "training soul necklace") bonussoulforce2 += 300;
		if (player.jewelryName == "training soul ring") bonussoulforce2 += 100;
		if (player.jewelryName2 == "training soul ring") bonussoulforce2 += 100;
		if (player.jewelryName3 == "training soul ring") bonussoulforce2 += 100;
		if (player.jewelryName4 == "training soul ring") bonussoulforce2 += 100;
		if (player.weaponFlyingSwordsName == "training soul flying sword") bonussoulforce2 += 500;
		if ((bonussoulforce2 - flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]) > 0) {
			if ((bonussoulforce2 - flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]) > flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2]) flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] += flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2];
			else flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] += (bonussoulforce2 - flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]);
		}
	}
	public function AmountOfSoulforceRecoveredDuringCultivation(mod:Number):Number {
		var costPercent:Number = 100;
		if (player.kitsuneScore() >= 5) {
			if (player.kitsuneScore() >= 9 && player.tailType == 13 && player.tailCount >= 2) {
				if (player.kitsuneScore() >= 16) {
					if (player.kitsuneScore() >= 21 && player.tailCount == 9 && player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) {
						if (player.kitsuneScore() >= 26) costPercent += 1000;
						else costPercent += 650;
					}
					else costPercent += 400;
				}
				else costPercent += 200;
			}
			else costPercent += 100;
		}
		if (player.nekomataScore() >= 10) {
			if (player.tailType == 8 && player.tailCount >= 2 && player.nekomataScore() >= 12) costPercent += 200;
			else costPercent += 100;
		}
		if (player.hasPerk(PerkLib.DaoistCultivator)) costPercent += 100;
		if (player.hasPerk(PerkLib.DaoistApprenticeStage)) costPercent += 100;
		if (player.hasPerk(PerkLib.DaoistWarriorStage)) costPercent += 100;
		if (player.hasPerk(PerkLib.DaoistElderStage)) costPercent += 100;
		if (player.hasPerk(PerkLib.DaoistOverlordStage)) costPercent += 100;
		if (player.hasPerk(PerkLib.DaoistTyrantStage)) costPercent += 100;
		if (player.hasPerk(PerkLib.SoulApprentice)) costPercent += 100;
		if (player.hasPerk(PerkLib.SoulPersonage)) costPercent += 100;
		if (player.hasPerk(PerkLib.SoulWarrior)) costPercent += 100;
		if (player.hasPerk(PerkLib.SoulSprite)) costPercent += 150;
		if (player.hasPerk(PerkLib.SoulScholar)) costPercent += 150;
		if (player.hasPerk(PerkLib.SoulElder)) costPercent += 150;
		if (player.hasPerk(PerkLib.SoulExalt)) costPercent += 200;
		if (player.hasPerk(PerkLib.SoulOverlord)) costPercent += 200;
		if (player.hasPerk(PerkLib.SoulTyrant)) costPercent += 200;
		if (player.hasPerk(PerkLib.SoulKing)) costPercent += 250;
		if (player.hasPerk(PerkLib.SoulEmperor)) costPercent += 250;
		if (player.hasPerk(PerkLib.SoulAncestor)) costPercent += 250;
		mod *= costPercent/100;
		return mod;
	}
	public function SoulforceRegeneration1():void {
		clearOutput();
		var soulforceamountrestored:int = 16;
		soulforceamountrestored += SoulforceRegeneration00();
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 16;
		player.soulforce += soulforceamountrestored;
		if (SoulforceRegenerationCompatibileTrainingItems()) {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1();
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(20);
		doNext(camp.returnToCampUseOneHour);
	}
	public function SelfSustain():void {
		clearOutput();
		outputText("Use some of your soulforce to partialy sate your hunger. The higher your cultivation is the more of the soulforce you could drawn without hurting yourself.\n\n");
		outputText("So what amount of your soulforce do you want to use?");
		menu();
		addButton(0, "V. Low", SelfSustain1).hint("Spend 50 soulforce for 10 hunger.");
		if (player.hasPerk(PerkLib.SoulApprentice)) addButton(1, "Low", SelfSustain2).hint("Spend 100 soulforce for 20 hunger.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(2, "Low-Med", SelfSustain3).hint("Spend 200 soulforce for 40 hunger.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(3, "Medium", SelfSustain4).hint("Spend 400 soulforce for 80 hunger.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(4, "High-Med", SelfSustain5).hint("Spend 800 soulforce for 160 hunger.");
		if (player.hasPerk(PerkLib.SoulScholar)) addButton(5, "High", SelfSustain6).hint("Spend 1600 soulforce for 320 hunger.");
		if (player.hasPerk(PerkLib.SoulElder)) addButton(6, "V. High", SelfSustain7).hint("Spend 3200 soulforce for 640 hunger.");
		addButton(14, "Back", accessSoulforceMenu);
	}
	public function SelfSustain1():void {
		clearOutput();
		if (player.soulforce >= 50) {
			outputText("Consuming a little of soulforce you feel slightly less hungry.");
			player.soulforce -= 50;
			player.refillHunger(10);
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(10);
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(SelfSustain);
		}
	}
	public function SelfSustain2():void {
		clearOutput();
		if (player.soulforce >= 100) {
			outputText("Consuming a little of soulforce you feel a little less hungry.");
			player.soulforce -= 100;
			player.refillHunger(20);
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(20);
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(SelfSustain);
		}
	}
	public function SelfSustain3():void {
		clearOutput();
		if (player.soulforce >= 200) {
			outputText("Consuming some of your soulforce you feel a little less hungry than before.");
			player.soulforce -= 200;
			player.refillHunger(40);
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(40);
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(SelfSustain);
		}
	}
	public function SelfSustain4():void {
		clearOutput();
		if (player.soulforce >= 400) {
			outputText("Consuming some of your soulforce you feel your hungry decreasing slightly.");
			player.soulforce -= 400;
			player.refillHunger(80);
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(80);
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(SelfSustain);
		}
	}
	public function SelfSustain5():void {
		clearOutput();
		if (player.soulforce >= 800) {
			outputText("Consuming not a small amount of your soulforce you feel your hungry decreasing noticable.");
			player.soulforce -= 800;
			player.refillHunger(160);
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(160);
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(SelfSustain);
		}
	}
	public function SelfSustain6():void {
		clearOutput();
		if (player.soulforce >= 1600) {
			outputText("Consuming below averange amount of your soulforce you feel your hungry decreasing very noticable.");
			player.soulforce -= 1600;
			player.refillHunger(320);
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(320);
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(SelfSustain);
		}
	}
	public function SelfSustain7():void {
		clearOutput();
		if (player.soulforce >= 3200) {
			outputText("Consuming a bit below averange amount of your soulforce you feel your hungry decreasing by large margin.");
			player.soulforce -= 3200;
			player.refillHunger(640);
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(640);
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(SelfSustain);
		}
	}
	public function RepresLust():void {
		clearOutput();
		outputText("Use some of your soulforce to partialy suppress your lust. The higher your cultivation is the more of the soulforce you could drawn without hurting yourself.\n\n");
		outputText("So what amount of your soulforce do you want to use?");
		menu();
		addButton(0, "V. Low", RepresLust1).hint("Spend 40 soulforce for 20 lust.");
		if (player.hasPerk(PerkLib.SoulApprentice)) addButton(1, "Low", RepresLust2).hint("Spend 80 soulforce for 40 lust.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(2, "Low-med", RepresLust3).hint("Spend 200 soulforce for 100 lust.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(3, "Medium", RepresLust4).hint("Spend 400 soulforce for 200 lust.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(4, "High-Med", RepresLust5).hint("Spend 800 soulforce for 400 lust.");
		if (player.hasPerk(PerkLib.SoulScholar)) addButton(5, "High", RepresLust6).hint("Spend 1600 soulforce for 800 lust.");
		if (player.hasPerk(PerkLib.SoulElder)) addButton(6, "V. High", RepresLust7).hint("Spend 3200 soulforce for 1600 lust.");
		addButton(14, "Back", accessSoulforceMenu);
	}
	public function RepresLust1():void {
		clearOutput();
		if (player.soulforce >= 40) {
			outputText("Consuming a little of soulforce you lust lowered very slightly.");
			player.soulforce -= 40;
			player.lust -= 20;
			if (player.lust < 0) player.lust = 0;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(RepresLust);
		}
	}
	public function RepresLust2():void {
		clearOutput();
		if (player.soulforce >= 80) {
			outputText("Consuming a little of soulforce you lust lowered a little bit.");
			player.soulforce -= 80;
			player.lust -= 40;
			if (player.lust < 0) player.lust = 0;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(RepresLust);
		}
	}
	public function RepresLust3():void {
		clearOutput();
		if (player.soulforce >= 200) {
			outputText("Consuming some of your soulforce you lust noticable lowered.");
			player.soulforce -= 200;
			player.lust -= 100;
			if (player.lust < 0) player.lust = 0;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(RepresLust);
		}
	}
	public function RepresLust4():void {
		clearOutput();
		if (player.soulforce >= 400) {
			outputText("Consuming some of your soulforce medicore amount of lust are gone.");
			player.soulforce -= 400;
			player.lust -= 200;
			if (player.lust < 0) player.lust = 0;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(RepresLust);
		}
	}
	public function RepresLust5():void {
		clearOutput();
		if (player.soulforce >= 800) {
			outputText("Consuming not a small amount of your soulforce bit above averange amount of your lust is gone.");
			player.soulforce -= 800;
			player.lust -= 400;
			if (player.lust < 0) player.lust = 0;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(RepresLust);
		}
	}
	public function RepresLust6():void {
		clearOutput();
		if (player.soulforce >= 1600) {
			outputText("Consuming below averange amount of your soulforce high amount of your lust is gone.");
			player.soulforce -= 1600;
			player.lust -= 800;
			if (player.lust < 0) player.lust = 0;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(RepresLust);
		}
	}
	public function RepresLust7():void {
		clearOutput();
		if (player.soulforce >= 3200) {
			outputText("Consuming a bit below averange amount of your soulforce most of your lust is gone.");
			player.soulforce -= 3200;
			player.lust -= 1600;
			if (player.lust < 0) player.lust = 0;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(RepresLust);
		}
	}
	public function ManaAndSoulforce():void {
		clearOutput();
		outputText("Use some of your soulforce to slowly conver it into mana or some mana in soulforce. The higher your cultivation is the more you could convert without hurting yourself.\n\n");
		outputText("So what amount of your soulforce/mana do you want to convert?");
		menu();
		//	if (CoC.instance.inCombat) {
		//		addButton(14, "Back", CoC.instance.combatMenu);
		//	}You sit down and focus your spiritual power to recover some of your physical stamina, within moments, you feel rested and refreshed. - może do wykorzystania potem gdzieś?
		//	else {
		addButton(0, "100", Covert100Soulforce).hint("Convert 100 soulforce to 100 mana.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(1, "200", Covert200Soulforce).hint("Convert 200 soulforce to 200 mana.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(2, "500", Covert500Soulforce).hint("Convert 500 soulforce to 500 mana.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(3, "1000", Covert1000Soulforce).hint("Convert 1000 soulforce to 1000 mana.");
		if (player.hasPerk(PerkLib.SoulScholar)) addButton(4, "2000", Covert2000Soulforce).hint("Convert 2000 soulforce to 2000 mana.");
		addButton(5, "100", Covert100Mana).hint("Convert 100 mana to 50 soulforce.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(6, "200", Covert200Mana).hint("Convert 200 mana to 100 soulforce.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(7, "500", Covert500Mana).hint("Convert 500 mana to 250 soulforce.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(8, "1000", Covert1000Mana).hint("Convert 1000 mana to 500 soulforce.");
		if (player.hasPerk(PerkLib.SoulScholar)) addButton(9, "2000", Covert2000Mana).hint("Convert 2000 mana to 1000 soulforce.");
		if (player.hasPerk(PerkLib.SoulElder)) addButton(10, "5000", Covert5000Soulforce).hint("Convert 5000 soulforce to 5000 mana.");
		if (player.hasPerk(PerkLib.SoulExalt)) addButton(11, "10000", Covert10000Soulforce).hint("Convert 10000 soulforce to 10000 mana.");
		if (player.hasPerk(PerkLib.SoulElder)) addButton(12, "5000", Covert5000Mana).hint("Convert 5000 mana to 2500 soulforce.");
		if (player.hasPerk(PerkLib.SoulExalt)) addButton(13, "10000", Covert10000Mana).hint("Convert 10000 mana to 5000 soulforce.");
		addButton(14, "Back", accessSoulforceMenu);
		//	}
	}
	public function Covert100Soulforce():void {
		clearOutput();
		if (player.soulforce >= 100) {
			outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
			player.soulforce -= 100;
			player.mana += 100;
			if (player.mana > player.maxMana()) player.mana = player.maxMana();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(ManaAndSoulforce);
		}
	}
	public function Covert200Soulforce():void {
		clearOutput();
		if (player.soulforce >= 200) {
			outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
			player.soulforce -= 200;
			player.mana += 200;
			if (player.mana > player.maxMana()) player.mana = player.maxMana();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(ManaAndSoulforce);
		}
	}
	public function Covert500Soulforce():void {
		clearOutput();
		if (player.soulforce >= 500) {
			outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
			player.soulforce -= 500;
			player.mana += 500;
			if (player.mana > player.maxMana()) player.mana = player.maxMana();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(ManaAndSoulforce);
		}
	}
	public function Covert1000Soulforce():void {
		clearOutput();
		if (player.soulforce >= 1000) {
			outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
			player.soulforce -= 1000;
			player.mana += 1000;
			if (player.mana > player.maxMana()) player.mana = player.maxMana();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(ManaAndSoulforce);
		}
	}
	public function Covert2000Soulforce():void {
		clearOutput();
		if (player.soulforce >= 2000) {
			outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
			player.soulforce -= 2000;
			player.mana += 2000;
			if (player.mana > player.maxMana()) player.mana = player.maxMana();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(ManaAndSoulforce);
		}
	}
	public function Covert5000Soulforce():void {
		clearOutput();
		if (player.soulforce >= 5000) {
			outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
			player.soulforce -= 5000;
			player.mana += 5000;
			if (player.mana > player.maxMana()) player.mana = player.maxMana();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(ManaAndSoulforce);
		}
	}
	public function Covert10000Soulforce():void {
		clearOutput();
		if (player.soulforce >= 10000) {
			outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
			player.soulforce -= 10000;
			player.mana += 10000;
			if (player.mana > player.maxMana()) player.mana = player.maxMana();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(ManaAndSoulforce);
		}
	}
	public function Covert100Mana():void {
		clearOutput();
		if (player.mana < 100) {
			outputText("Your current mana is too low.");
			doNext(ManaAndSoulforce);
		}
		else {
			outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
			player.mana -= 100;
			player.soulforce += 50;
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
	}
	public function Covert200Mana():void {
		clearOutput();
		if (player.mana < 200) {
			outputText("Your current mana is too low.");
			doNext(ManaAndSoulforce);
		}
		else {
			outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
			player.mana -= 200;
			player.soulforce += 100;
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
	}
	public function Covert500Mana():void {
		clearOutput();
		if (player.mana < 500) {
			outputText("Your current mana is too low.");
			doNext(ManaAndSoulforce);
		}
		else {
			outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
			player.mana -= 500;
			player.soulforce += 250;
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
	}
	public function Covert1000Mana():void {
		clearOutput();
		if (player.mana < 1000) {
			outputText("Your current mana is too low.");
			doNext(ManaAndSoulforce);
		}
		else {
			outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
			player.mana -= 1000;
			player.soulforce += 500;
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
	}
	public function Covert2000Mana():void {
		clearOutput();
		if (player.mana < 2000) {
			outputText("Your current mana is too low.");
			doNext(ManaAndSoulforce);
		}
		else {
			outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
			player.mana -= 2000;
			player.soulforce += 1000;
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
	}
	public function Covert5000Mana():void {
		clearOutput();
		if (player.mana < 5000) {
			outputText("Your current mana is too low.");
			doNext(ManaAndSoulforce);
		}
		else {
			outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
			player.mana -= 5000;
			player.soulforce += 2500;
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
	}
	public function Covert10000Mana():void {
		clearOutput();
		if (player.mana < 10000) {
			outputText("Your current mana is too low.");
			doNext(ManaAndSoulforce);
		}
		else {
			outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
			player.mana -= 10000;
			player.soulforce += 5000;
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
	}
	public function CorruptionAndSoulforce():void {
		clearOutput();
		outputText("Use some of your soulforce to slowly purify or...corrupt yourself. The higher your cultivation is the more of the soulforce you could drawn without hurting yourself.\n\n");
		outputText("So what amount of your soulforce do you want to use?");
		menu();
		addButton(0, "V. Low", CorrDrop1).hint("Spend 100 soulforce for lowering corruption by 1.");
		if (player.hasPerk(PerkLib.SoulApprentice)) addButton(1, "Low", CorrDrop2).hint("Spend 200 soulforce for lowering corruption by 2.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(2, "Medium", CorrDrop3).hint("Spend 500 soulforce for lowering corruption by 5.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(3, "High", CorrDrop4).hint("Spend 1000 soulforce for lowering corruption by 10.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(4, "V. High", CorrDrop5).hint("Spend 2000 soulforce for lowering corruption by 20.");
		addButton(5, "V. Low", CorrRise1).hint("Spend 50 soulforce for rising corruption by 1.");
		if (player.hasPerk(PerkLib.SoulApprentice)) addButton(6, "Low", CorrRise2).hint("Spend 100 soulforce for rising corruption by 2.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(7, "Medium", CorrRise3).hint("Spend 250 soulforce for rising corruption by 5.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(8, "High", CorrRise4).hint("Spend 500 soulforce for rising corruption by 10.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(9, "V. High", CorrRise5).hint("Spend 1000 soulforce for rising corruption by 20.");
		addButton(14, "Back", accessSoulforceMenu);
	}
	public function CorrDrop1():void {
		clearOutput();
		if (player.soulforce >= 100) {
			outputText("Consuming a little of soulforce you corruption lowered very slightly.");
			player.soulforce -= 100;
			player.cor -= 1;
			if (player.cor < 0) player.cor = 0;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(CorruptionAndSoulforce);
		}
	}
	public function CorrDrop2():void {
		clearOutput();
		if (player.soulforce >= 200) {
			outputText("Consuming a little of soulforce you corruption lowered a little bit.");
			player.soulforce -= 200;
			player.cor -= 2;
			if (player.cor < 0) player.cor = 0;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(CorruptionAndSoulforce);
		}
	}
	public function CorrDrop3():void {
		clearOutput();
		if (player.soulforce >= 500) {
			outputText("Consuming some of your soulforce you corruption lowered noticable lowered.");
			player.soulforce -= 500;
			player.cor -= 5;
			if (player.cor < 0) player.cor = 0;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(CorruptionAndSoulforce);
		}
	}
	public function CorrDrop4():void {
		clearOutput();
		if (player.soulforce >= 1000) {
			outputText("Consuming some of your soulforce medicore amount of corruption are gone.");
			player.soulforce -= 1000;
			player.cor -= 10;
			if (player.cor < 0) player.cor = 0;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(CorruptionAndSoulforce);
		}
	}
	public function CorrDrop5():void {
		clearOutput();
		if (player.soulforce >= 2000) {
			outputText("Consuming not a small amount of your soulforce you corruption most of your corruption is gone.");
			player.soulforce -= 2000;
			player.cor -= 20;
			if (player.cor < 0) player.cor = 0;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(CorruptionAndSoulforce);
		}
	}
	public function CorrRise1():void {
		clearOutput();
		if (player.soulforce >= 50) {
			outputText("Consuming a little of soulforce you corruption rised very slightly.");
			player.soulforce -= 50;
			player.cor += 1;
			if (player.cor > 100) player.cor = 100;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(CorruptionAndSoulforce);
		}
	}
	public function CorrRise2():void {
		clearOutput();
		if (player.soulforce >= 100) {
			outputText("Consuming a little of soulforce you corruption rised a little bit.");
			player.soulforce -= 100;
			player.cor += 2;
			if (player.cor > 100) player.cor = 100;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(CorruptionAndSoulforce);
		}
	}
	public function CorrRise3():void {
		clearOutput();
		if (player.soulforce >= 250) {
			outputText("Consuming some of your soulforce you corruption noticable rised.");
			player.soulforce -= 250;
			player.cor += 5;
			if (player.cor > 100) player.cor = 100;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(CorruptionAndSoulforce);
		}
	}
	public function CorrRise4():void {
		clearOutput();
		if (player.soulforce >= 500) {
			outputText("Consuming some of your soulforce your corruption rised by a medicore amount.");
			player.soulforce -= 500;
			player.cor += 10;
			if (player.cor > 100) player.cor = 100;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(CorruptionAndSoulforce);
		}
	}
	public function CorrRise5():void {
		clearOutput();
		if (player.soulforce >= 1000) {
			outputText("Consuming not a small amount of your soulforce you gained much corruption.");
			player.soulforce -= 1000;
			player.cor += 20;
			if (player.cor > 100) player.cor = 100;
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(CorruptionAndSoulforce);
		}
	}
	public function SoulSense():void {
		clearOutput();
		outputText("Using a tiny amount of soulforce you could try to use soul sense to locate some of people you meet of location you found before without wasting hours for that. Especialy if those people are usualy roaming around or places that constantly changing their location.");
		outputText("\n\nAmount of soulforce used to locate them using soul sense depening of relative power of searched person or location.");
		menu();
		if (flags[kFLAGS.SOUL_SENSE_TAMANI] >= 3) addButton(0, "Tamani", TamaniEnc).hint("Req. 80+ soulforce");
		else addButtonDisabled(0, "Tamani", "");
		if (flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] >= 3) {
			if (flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16) {
				if (player.hasCock()) addButton(1, "Tamani D.", TamaniDaughtersEnc).hint("Req. at least 80+ soulforce (more daughters will increase needed SF)");
				else addButtonDisabled(1, "Tamani D.", "Req. to have cock of any type.");
			}
			else addButtonDisabled(1, "Tamani D.", "Req. to have 16+ (still alive) daughters with Tamani.");
		}
		else addButtonDisabled(1, "Tamani D.", "");
		if (flags[kFLAGS.SOUL_SENSE_KITSUNE_MANSION] >= 3) addButton(2, "KitsuMansion", KitsuneMansion).hint("Req. 90+ soulforce");
		else addButtonDisabled(2, "KitsuMansion", "");
		if (flags[kFLAGS.SOUL_SENSE_IZUMI] >= 3) addButton(3, "Izumi", IzumiEnc).hint("Req. 300+ soulforce");
		else addButtonDisabled(3, "Izumi", "");
		//next page button?
		if (flags[kFLAGS.SOUL_SENSE_PRISCILLA] >= 3) addButton(5, "Priscilla", PriscillaEnc).hint("Req. 320+ soulforce");
		else addButtonDisabled(5, "Priscilla", "");
		if (flags[kFLAGS.SOUL_SENSE_MINOTAUR_SONS] >= 3) {
			if (flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] >= 3) {
				if (player.hasVagina()) addButton(6, "Mino Sons", MinotaurSonsEnc).hint("Req. at least 260+ soulforce (more sons will increase needed SF)");
				else addButtonDisabled(6, "Mino Sons", "Req. to have vagina.");
			}
			else addButtonDisabled(6, "Mino Sons", "Req. to have 3+ (still alive) minotaur sons.");
		}
		else addButtonDisabled(6, "Mino Sons", "");
		//button 7 - Sheila (non demon ver) find
		//button 8 - ?Behemoth find?
		//previous page button?
		if (flags[kFLAGS.SOUL_SENSE_WORLD_TREE] >= 1) addButton(10, "WorldTree", findWorldTree).hint("Req. 100+ soulforce");
		else addButtonDisabled(10, "WorldTree", "");
		//button 11
		if (flags[kFLAGS.SOUL_SENSE_GIACOMO] >= 3) addButton(12, "Giacomo", findGiacomo).hint("Req. 100+ soulforce");
		else addButtonDisabled(12, "Giacomo", "");
		addButton(13, "???", theUnknown).hint("Draw into your soulforce for soulsensing.");
		addButton(14, "Back", accessSoulforceMenu);
	}
	public function TamaniEnc():void {
		if (player.soulforce >= 80) {
			player.soulforce -= 80;
			statScreenRefresh();
			tamaniScene.encounterTamani();
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	public function TamaniDaughtersEnc():void {
		if (player.soulforce >= 10 * (8 + (Math.floor(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 20)))) {
			player.soulforce -= 10 * (8 + (Math.floor(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 20)));
			statScreenRefresh();
			tamaniDaughtersScene.encounterTamanisDaughters();
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	public function KitsuneMansion():void {
		if (player.soulforce >= 90) {
			player.soulforce -= 90;
			statScreenRefresh();
			SceneLib.kitsuneScene.enterTheTrickster();
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	public function IzumiEnc():void {
		if (player.soulforce >= 300) {
			player.soulforce -= 300;
			statScreenRefresh();
			izumiScenes.encounter();
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	public function PriscillaEnc():void {
		if (player.soulforce >= 320) {
			player.soulforce -= 320;
			statScreenRefresh();
			SceneLib.goblinElderScene.goblinElderEncounter();
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	public function MinotaurSonsEnc():void {
		if (player.soulforce >= 10 * (26 + Math.round((flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] - 3)/2))) {
			player.soulforce -= 10 * (26 + Math.round((flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] - 3)/2));
			statScreenRefresh();
			minotaurSonsScene.meetMinotaurSons();
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	//button 7
	//button 8
	public function findWorldTree():void {
		if (player.soulforce >= 100) {
			player.soulforce -= 100;
			statScreenRefresh();
			worldtreeScene.YggdrasilDiscovery();
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	//button 11
	public function findGiacomo():void {
		if (player.soulforce >= 100) {
			player.soulforce -= 100;
			statScreenRefresh();
			SceneLib.giacomoShop.giacomoEncounter();
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	public function theUnknown():void {
		if (player.soulforce >= 100) {
			player.soulforce -= 100;
			menu();
			/*statScreenRefresh();
			if (rand(2) == 0) {
				clearOutput();
				outputText("A gigantic monkey and you. (placeholder text for now so not mind it and just kick the monkey ass)");
				flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] = 1;
				startCombat(new Oozaru());
			}
			else SceneLib.ryubi.RyuBiEnterTheDragon();*/
			if (BelisaFollower.BelisaInGame && BelisaFollower.BelisaFollowerStage < 3 && BelisaFollower.BelisaEncounternum >= 1 && !player.hasStatusEffect(StatusEffects.SpoodersOff)) addButton(0, "???", belisatest).hint("Shy Spooder");
			if (!LilyFollower.LilyFollowerState && !player.hasStatusEffect(StatusEffects.SpoodersOff)) addButton(1, "???", lilytest).hint("Lewd Spooder");
			if (player.level >= 45 && TyrantiaFollower.TyrantiaFollowerStage < 4 && !TyrantiaFollower.TyraniaIsRemovedFromThewGame && !player.hasStatusEffect(StatusEffects.SpoodersOff)) addButton(2, "???", FightTyrantia).hint("Scary Spooder");
			if (player.level >= 3 && flags[kFLAGS.IZMA_ENCOUNTER_COUNTER] > 0 && (flags[kFLAGS.IZMA_WORMS_SCARED] == 0 || !player.hasStatusEffect(StatusEffects.Infested)) && flags[kFLAGS.IZMA_FOLLOWER_STATUS] <= 0) addButton(3, "???", tigerSharkGal).hint("Tigershark Gal?");
			if (player.level >= 3 && flags[kFLAGS.DIANA_FOLLOWER] < 6 && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1 && !player.hasStatusEffect(StatusEffects.DianaOff)) addButton(4, "???", shyHealer).hint("Shy Healer");
			if (flags[kFLAGS.ISABELLA_PLAINS_DISABLED] == 0) addButton(5, "???", germanCow).hint("German Cow");
			addButton(14, "Back", SoulSense);
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	public function lilytest():void {
		SceneLib.lily.lilyEncounter();
	}
	public function belisatest():void {
		SceneLib.belisa.subsequentEncounters();
	}
	public function FightTyrantia():void {
		clearOutput();
		if (TyrantiaFollower.TyrantiaFollowerStage > 2) SceneLib.tyrania.repeatEncounterBattlefield();
		else if (TyrantiaFollower.TyrantiaAffectionMeter > 40 && TyrantiaFollower.TyrantiaFollowerStage > 1) SceneLib.tyrania.encounterBattlefieldAfter40Affection();
		else if (TyrantiaFollower.TyrantiaFollowerStage > 0) SceneLib.tyrania.repeatEncounterBattlefield();
		else SceneLib.tyrania.firstEncounter();
	}
	public function tigerSharkGal():void {
		player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
		SceneLib.izmaScene.meetIzmaAtLake();
	}
	public function shyHealer():void {
		if ((flags[kFLAGS.DIANA_FOLLOWER] < 3 || flags[kFLAGS.DIANA_FOLLOWER] == 5) && flags[kFLAGS.DIANA_LVL_UP] >= 8) SceneLib.dianaScene.postNameEnc();
		else SceneLib.dianaScene.repeatEnc();
	}
	public function germanCow():void {
		SceneLib.isabellaScene.isabellaGreeting();
	}
	
	private function canfaceTribulation():Boolean {
		return (player.level >= 27 && player.hasPerk(PerkLib.SoulWarrior) && !player.hasStatusEffect(StatusEffects.TribulationCountdown) && !player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) ||
				(player.level >= 54 && player.hasPerk(PerkLib.SoulElder) && !player.hasStatusEffect(StatusEffects.TribulationCountdown) && !player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) ||
				(player.level >= 78 && player.hasPerk(PerkLib.SoulOverlord) && !player.hasStatusEffect(StatusEffects.TribulationCountdown) && !player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor));
	}
	public function tribulationsPrompt():void {
		clearOutput();
		outputText("Something within you speaks. You can sense that you’ve nearly reached the pinnacle of cultivation as a Soul ");
		if (player.level >= 60 && !player.hasPerk(PerkLib.SoulKing)) outputText("Tyrant");
		else if (player.level >= 42 && !player.hasPerk(PerkLib.SoulExalt)) outputText("Elder");
		else outputText("Warrior");
		outputText(". Now, only a tiny step is needed to advance further.");
		outputText("\n\nThough, you pause. It’s a feeling so close, yet so far. Do you progress your skills naturally, or push for the goal that you’ve worked so hard to achieve.");
		menu();
		addButton(1, "No", tribulationsPromptNo);
		addButton(3, "Yes", tribulationsPromptYes);
	}
	public function tribulationsPromptYes():void {
		clearOutput();
		outputText("There’s no use in delaying the inevitable. You do not fear the tribulation, you know you’re ready.");
		outputText("\n\nYou know it’s time to give it your all. With determination and force of will, you cannot fail.");
		player.createStatusEffect(StatusEffects.TribulationCountdown, (2 + rand(4)), 0, 0, 0);
		doNext(playerMenu);
	}
	public function tribulationsPromptNo():void {
		clearOutput();
		outputText("As you pause, you know it’s not time yet. You can suppress your soulforce until it’s time for the tribulation to descend. Hopefully, then you’ll be ready.");
		doNext(accessSoulforceMenu);
	}
}
}