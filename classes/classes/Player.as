﻿package classes
{
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.ISexyPart;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armor;
import classes.Items.ArmorLib;
import classes.Items.FlyingSwords;
import classes.Items.FlyingSwordsLib;
import classes.Items.HeadJewelry;
import classes.Items.HeadJewelryLib;
import classes.Items.ItemTags;
import classes.Items.Jewelry;
import classes.Items.JewelryLib;
import classes.Items.MiscJewelry;
import classes.Items.MiscJewelryLib;
import classes.Items.Mutations;
import classes.Items.Necklace;
import classes.Items.NecklaceLib;
import classes.Items.Shield;
import classes.Items.ShieldLib;
import classes.Items.Vehicles;
import classes.Items.VehiclesLib;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Items.WeaponRange;
import classes.Items.WeaponRangeLib;
import classes.Items.Undergarment;
import classes.Items.UndergarmentLib;
import classes.Scenes.Areas.Forest.BeeGirlScene;
import classes.Scenes.Areas.Forest.KitsuneScene;
import classes.Scenes.Combat.CombatAbilities;
import classes.Scenes.Combat.CombatAbility;
import classes.Scenes.NPCs.AetherTwinsFollowers;
import classes.Scenes.NPCs.EvangelineFollower;
import classes.Scenes.NPCs.Forgefather;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.Places.Mindbreaker;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.Pregnancy;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.StatusEffects.HeatEffect;
import classes.StatusEffects.RutEffect;
import classes.StatusEffects.VampireThirstEffect;
import classes.internals.Utils;
import classes.lists.BreastCup;

use namespace CoC;

	/**
	 * ...
	 * @author Yoffy
	 */
	public class Player extends Character {

		public function Player() {
			for (var i:int = 0; i < CombatAbility.Registry.length; i++) {
				cooldowns[i] = 0;
			}
			//Item things
			itemSlot1 = new ItemSlotClass();
			itemSlot2 = new ItemSlotClass();
			itemSlot3 = new ItemSlotClass();
			itemSlot4 = new ItemSlotClass();
			itemSlot5 = new ItemSlotClass();
			itemSlot6 = new ItemSlotClass();
			itemSlot7 = new ItemSlotClass();
			itemSlot8 = new ItemSlotClass();
			itemSlot9 = new ItemSlotClass();
			itemSlot10 = new ItemSlotClass();
			itemSlot11 = new ItemSlotClass();
			itemSlot12 = new ItemSlotClass();
			itemSlot13 = new ItemSlotClass();
			itemSlot14 = new ItemSlotClass();
			itemSlot15 = new ItemSlotClass();
			itemSlot16 = new ItemSlotClass();
			itemSlot17 = new ItemSlotClass();
			itemSlot18 = new ItemSlotClass();
			itemSlot19 = new ItemSlotClass();
			itemSlot20 = new ItemSlotClass();
			itemSlots = [itemSlot1, itemSlot2, itemSlot3, itemSlot4, itemSlot5, itemSlot6, itemSlot7, itemSlot8, itemSlot9, itemSlot10, itemSlot11, itemSlot12, itemSlot13, itemSlot14, itemSlot15, itemSlot16, itemSlot17, itemSlot18, itemSlot19, itemSlot20];
		}

		protected final function outputText(text:String, clear:Boolean = false):void
		{
			if (clear) EngineCore.clearOutputTextOnly();
			EngineCore.outputText(text);
		}

		public var startingRace:String = "human";

		//Autosave
		public var slotName:String = "VOID";
		public var autoSave:Boolean = false;

		//Lust vulnerability
		public var lustVuln:Number = 1;

		//Mastery attributes
		public var masteryFeralCombatLevel:Number = 0;
		public var masteryFeralCombatXP:Number = 0;
		public var masteryGauntletLevel:Number = 0;
		public var masteryGauntletXP:Number = 0;
		public var masterySwordLevel:Number = 0;
		public var masterySwordXP:Number = 0;
		public var masteryAxeLevel:Number = 0;
		public var masteryAxeXP:Number = 0;
		public var masteryMaceHammerLevel:Number = 0;
		public var masteryMaceHammerXP:Number = 0;
		public var masteryDuelingSwordLevel:Number = 0;
		public var masteryDuelingSwordXP:Number = 0;
		public var masteryPolearmLevel:Number = 0;
		public var masteryPolearmXP:Number = 0;
		public var masterySpearLevel:Number = 0;
		public var masterySpearXP:Number = 0;
		public var masteryDaggerLevel:Number = 0;
		public var masteryDaggerXP:Number = 0;
		public var masteryWhipLevel:Number = 0;
		public var masteryWhipXP:Number = 0;
		public var masteryExoticLevel:Number = 0;
		public var masteryExoticXP:Number = 0;
		public var masteryArcheryLevel:Number = 0;
		public var masteryArcheryXP:Number = 0;
		public var masteryThrowingLevel:Number = 0;
		public var masteryThrowingXP:Number = 0;
		public var masteryFirearmsLevel:Number = 0;
		public var masteryFirearmsXP:Number = 0;
		public var dualWSLevel:Number = 0;
		public var dualWSXP:Number = 0;
		public var dualWNLevel:Number = 0;
		public var dualWNXP:Number = 0;
		public var dualWLLevel:Number = 0;
		public var dualWLXP:Number = 0;
		public var dualWFLevel:Number = 0;
		public var dualWFXP:Number = 0;

		//Combat ability cooldowns. Index is ability id.
		public var cooldowns:/*int*/Array = [];
		
		//Mining attributes
		public var miningLevel:Number = 0;
		public var miningXP:Number = 0;
		
		//Herbalism attributes
		public var herbalismLevel:Number = 0;
		public var herbalismXP:Number = 0;

		//Teasing attributes
		public var teaseLevel:Number = 0;
		public var teaseXP:Number = 0;

		//Prison stats
		public var hunger:Number = 0; //Also used in survival and realistic mode
		public var obey:Number = 0;
		public var esteem:Number = 0;
		public var will:Number = 0;

		public var obeySoftCap:Boolean = true;

		//Perks used to store 'queued' perk buys
		public var perkPoints:Number = 0;
		public var statPoints:Number = 0;
		public var superPerkPoints:Number = 0;
		public var ascensionPerkPoints:Number = 0;

		public var tempStr:Number = 0;
		public var tempTou:Number = 0;
		public var tempSpe:Number = 0;
		public var tempInt:Number = 0;
		public var tempWis:Number = 0;
		public var tempLib:Number = 0;
		//Number of times explored for new areas
		public var explored:Number = 0;
		public var exploredForest:Number = 0;
		public var exploredDesert:Number = 0;
		public var exploredMountain:Number = 0;
		public var exploredLake:Number = 0;

		//Player pregnancy variables and functions
		private var pregnancy:Pregnancy = new Pregnancy();
		override public function pregnancyUpdate():Boolean {
			return pregnancy.updatePregnancy(); //Returns true if we need to make sure pregnancy texts aren't hidden
		}

		// Inventory
		public var itemSlot1:ItemSlotClass;
		public var itemSlot2:ItemSlotClass;
		public var itemSlot3:ItemSlotClass;
		public var itemSlot4:ItemSlotClass;
		public var itemSlot5:ItemSlotClass;
		public var itemSlot6:ItemSlotClass;
		public var itemSlot7:ItemSlotClass;
		public var itemSlot8:ItemSlotClass;
		public var itemSlot9:ItemSlotClass;
		public var itemSlot10:ItemSlotClass;
		public var itemSlot11:ItemSlotClass;
		public var itemSlot12:ItemSlotClass;
		public var itemSlot13:ItemSlotClass;
		public var itemSlot14:ItemSlotClass;
		public var itemSlot15:ItemSlotClass;
		public var itemSlot16:ItemSlotClass;
		public var itemSlot17:ItemSlotClass;
		public var itemSlot18:ItemSlotClass;
		public var itemSlot19:ItemSlotClass;
		public var itemSlot20:ItemSlotClass;
		public var itemSlots:Array;

		public var prisonItemSlots:Array = [];
		public var previouslyWornClothes:Array = []; //For tracking achievement.

		private var _weapon:Weapon = WeaponLib.FISTS;
		private var _weaponRange:WeaponRange = WeaponRangeLib.NOTHING;
		private var _weaponFlyingSwords:FlyingSwords = FlyingSwordsLib.NOTHING;
		private var _armor:Armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
		private var _miscjewelry:MiscJewelry = MiscJewelryLib.NOTHING;
		private var _miscjewelry2:MiscJewelry = MiscJewelryLib.NOTHING;
		private var _headjewelry:HeadJewelry = HeadJewelryLib.NOTHING;
		private var _necklace:Necklace = NecklaceLib.NOTHING;
		private var _jewelry:Jewelry = JewelryLib.NOTHING;
		private var _jewelry2:Jewelry = JewelryLib.NOTHING;
		private var _jewelry3:Jewelry = JewelryLib.NOTHING;
		private var _jewelry4:Jewelry = JewelryLib.NOTHING;
		private var _shield:Shield = ShieldLib.NOTHING;
		private var _upperGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _lowerGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _vehicle:Vehicles = VehiclesLib.NOTHING;
		private var _modArmorName:String = "";

		//override public function set armors
		override public function set armorValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorValue.");
		}

		override public function set armorName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorName.");
		}

		override public function set armorDef(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorDef.");
		}

		override public function set armorMDef(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorMDef.");
		}

		override public function set armorPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorPerk.");
		}

		//override public function set weapons
		override public function set weaponName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponName.");
		}

		override public function set weaponVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponVerb.");
		}

		override public function set weaponAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponAttack.");
		}

		override public function set weaponPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponPerk.");
		}

		override public function set weaponValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponValue.");
		}

		//override public function set weapons range
		override public function set weaponRangeName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeName.");
		}

		override public function set weaponRangeVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeVerb.");
		}

		override public function set weaponRangeAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeAttack.");
		}

		override public function set weaponRangePerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangePerk.");
		}

		override public function set weaponRangeValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeValue.");
		}

		//override public function set misc jewelries
		override public function set miscjewelryName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryName.");
		}

		override public function set miscjewelryEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryEffectId.");
		}

		override public function set miscjewelryEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryEffectMagnitude.");
		}

		override public function set miscjewelryPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryPerk.");
		}

		override public function set miscjewelryValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryValue.");
		}
		override public function set miscjewelryName2(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryName2.");
		}

		override public function set miscjewelryEffectId2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryEffectId2.");
		}

		override public function set miscjewelryEffectMagnitude2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryEffectMagnitude2.");
		}

		override public function set miscjewelryPerk2(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryPerk2.");
		}

		override public function set miscjewelryValue2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryValue2.");
		}

		//override public function set head jewelries
		override public function set headjewelryName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryName.");
		}

		override public function set headjewelryEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryEffectId.");
		}

		override public function set headjewelryEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryEffectMagnitude.");
		}

		override public function set headjewelryPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryPerk.");
		}

		override public function set headjewelryValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryValue.");
		}

		//override public function set necklaces
		override public function set necklaceName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklaceName.");
		}

		override public function set necklaceEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklaceEffectId.");
		}

		override public function set necklaceEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklaceEffectMagnitude.");
		}

		override public function set necklacePerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklacePerk.");
		}

		override public function set necklaceValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklaceValue.");
		}

		//override public function set jewelries
		override public function set jewelryName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryName.");
		}

		override public function set jewelryEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectId.");
		}

		override public function set jewelryEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectMagnitude.");
		}

		override public function set jewelryPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryPerk.");
		}

		override public function set jewelryValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryValue.");
		}
		override public function set jewelryName2(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryName2.");
		}

		override public function set jewelryEffectId2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectId2.");
		}

		override public function set jewelryEffectMagnitude2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectMagnitude2.");
		}

		override public function set jewelryPerk2(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryPerk2.");
		}

		override public function set jewelryValue2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryValue2.");
		}

		//override public function set shields
		override public function set shieldName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldName.");
		}

		override public function set shieldBlock(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldBlock.");
		}

		override public function set shieldPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldPerk.");
		}

		override public function set shieldValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldValue.");
		}

		//override public function set undergarments
		override public function set upperGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentName.");
		}

		override public function set upperGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentPerk.");
		}

		override public function set upperGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentValue.");
		}

		override public function set lowerGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentName.");
		}

		override public function set lowerGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentPerk.");
		}

		override public function set lowerGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentValue.");
		}

		//override public function set vehicles
		override public function set vehiclesName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesName.");
		}

		override public function set vehiclesEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesEffectId.");
		}

		override public function set vehiclesEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesEffectMagnitude.");
		}

		override public function set vehiclesPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesPerk.");
		}

		override public function set vehiclesValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesValue.");
		}


		public function get modArmorName():String
		{
			if (_modArmorName == null) _modArmorName = "";
			return _modArmorName;
		}

		public function set modArmorName(value:String):void {
			if (value == null) value = "";
			_modArmorName = value;
		}
		public function isWearingArmor():Boolean {
			return armor != ArmorLib.COMFORTABLE_UNDERCLOTHES && armor != ArmorLib.NOTHING;
		}
		public function isStancing():Boolean {
			return (lowerBody == LowerBody.DRAGON && arms.type == Arms.DRACONIC) || (lowerBody == LowerBody.HINEZUMI && arms.type == Arms.HINEZUMI) || isFeralStancing() || isSitStancing();
		}
		public function isSitStancing():Boolean {
			return (lowerBody == LowerBody.LION && arms.type == Arms.LION);
		}
		public function isFeralStancing():Boolean {
			return (lowerBody == LowerBody.WOLF && arms.type == Arms.WOLF) || (lowerBody == LowerBody.LION && arms.type == Arms.DISPLACER);
		}
		public function isGargoyleStancing():Boolean {
			return (lowerBody == LowerBody.GARGOYLE || lowerBody == LowerBody.GARGOYLE_2) && (arms.type == Arms.GARGOYLE || arms.type == Arms.GARGOYLE_2);
		}
		//Natural Armor (need at least to partialy covering whole body)
		public function haveNaturalArmor():Boolean
		{
			return hasPerk(PerkLib.ThickSkin) || skin.hasFur() || skin.hasChitin() || skin.hasScales() || skin.hasBark() || skin.hasDragonScales() || skin.hasBaseOnly(Skin.STONE);
		}
		//Unhindered related acceptable armor types
		public function meetUnhinderedReq():Boolean
		{
			return armor.hasTag(ItemTags.AGILE);
		}
		//override public function get armors
		override public function get armorName():String {
			if (_modArmorName.length > 0) return modArmorName;
			else if (_armor.name == "nothing" && lowerGarmentName != "nothing") return lowerGarmentName;
			else if (_armor.name == "nothing" && lowerGarmentName == "nothing") return "gear";
			return _armor.name;
		}
		override public function get armorDef():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var armorDef:Number = _armor.def;
			armorDef += upperGarment.armorDef;
			armorDef += lowerGarment.armorDef;
			//Blacksmith history!
			if (armorDef > 0 && (hasPerk(PerkLib.HistorySmith) || hasPerk(PerkLib.PastLifeSmith))) {
				var smithPBonus:Number = 1.05;
				if (hasPerk(PerkLib.Tongs)) smithPBonus += 0.05;
				if (hasPerk(PerkLib.Bellows)) smithPBonus += 0.05;
				if (hasPerk(PerkLib.Furnace)) smithPBonus += 0.05;
				if (hasPerk(PerkLib.Hammer)) smithPBonus += 0.05;
				if (hasPerk(PerkLib.Anvil)) smithPBonus += 0.05;
				if (hasPerk(PerkLib.Weap0n)) smithPBonus += 0.05;
				if (hasPerk(PerkLib.Arm0r)) smithPBonus += 0.05;
				armorDef = Math.round(armorDef * smithPBonus);
				armorDef += 1;
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinArmorPolishing)) {
				armorDef = Math.round(armorDef * (1 + (statusEffectv2(StatusEffects.KonstantinArmorPolishing) / 100)));
				armorDef += 1;
			}
			//Skin armor perk
			if (hasPerk(PerkLib.ThickSkin)) {
				armorDef += (2 * newGamePlusMod);
			}
			//Stacks on top of Thick Skin perk.
			var p:Boolean = skin.isCoverLowMid();
			if (skin.hasFur()) armorDef += (p?1:2) * newGamePlusMod;
			if (hasGooSkin() && skinAdj == "slimy") armorDef += (2 * newGamePlusMod);
			if (skin.hasChitin()) armorDef += (p?2:4)*newGamePlusMod;
			if (skin.hasScales()) armorDef += (p?3:6)*newGamePlusMod; //bee-morph (), mantis-morph (), scorpion-morph (wpisane), spider-morph (wpisane)
			if (skin.hasBark() || skin.hasDragonScales()) armorDef += (p?4:8)*newGamePlusMod;
			if (skin.hasBaseOnly(Skin.STONE)) armorDef += (10 * newGamePlusMod);
			//'Thick' dermis descriptor adds 1!
			if (skinAdj == "smooth") armorDef += (1 * newGamePlusMod);
			//Plant races score bonuses
			if (plantScore() >= 4) {
				if (plantScore() >= 7) armorDef += (10 * newGamePlusMod);
				else if (plantScore() == 6) armorDef += (8 * newGamePlusMod);
				else if (plantScore() == 5) armorDef += (4 * newGamePlusMod);
				else armorDef += (2 * newGamePlusMod);
			}
			if (yggdrasilScore() >= 10 || alrauneScore() >= 13) armorDef += (10 * newGamePlusMod);
			//Dragon score bonuses
			if (dragonScore() >= 16) {
				if (dragonScore() >= 32) armorDef += (10 * newGamePlusMod);
				else if (dragonScore() >= 24) armorDef += (4 * newGamePlusMod);
				else armorDef += (1 * newGamePlusMod);
			}
			if (frostWyrmScore() >= 18) {
				/*if (frostWyrmScore() >= 30) armorDef += (10 * newGamePlusMod);
				else */if (frostWyrmScore() >= 26) armorDef += (4 * newGamePlusMod);
				else armorDef += (1 * newGamePlusMod);
			}
			if (leviathanScore() >= 20) {
				if (leviathanScore() >= 30) armorDef += (5 * newGamePlusMod);
				else armorDef += (1 * newGamePlusMod);
			}
			//Bonus defense
			if (arms.type == Arms.YETI) armorDef += (1 * newGamePlusMod);
			if (arms.type == Arms.SPIDER || arms.type == Arms.MANTIS || arms.type == Arms.BEE || arms.type == Arms.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (arms.type == Arms.DRACONIC || arms.type == Arms.JABBERWOCKY || arms.type == Arms.FROSTWYRM || arms.type == Arms.SEA_DRAGON) armorDef += (3 * newGamePlusMod);
			if (arms.type == Arms.HYDRA) armorDef += (4 * newGamePlusMod);
			if (tailType == Tail.SPIDER_ADBOMEN || tailType == Tail.MANTIS_ABDOMEN || tailType == Tail.BEE_ABDOMEN) armorDef += (2 * newGamePlusMod);
			if (tailType == Tail.DRACONIC) armorDef += (3 * newGamePlusMod);
			if (lowerBody == LowerBody.FROSTWYRM) armorDef += (6 * newGamePlusMod);
			if (lowerBody == LowerBody.YETI) armorDef += (1 * newGamePlusMod);
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS || lowerBody == LowerBody.BEE || lowerBody == LowerBody.MANTIS || lowerBody == LowerBody.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (lowerBody == LowerBody.DRAGON || lowerBody == LowerBody.JABBERWOCKY || lowerBody == LowerBody.SEA_DRAGON) armorDef += (3 * newGamePlusMod);
			if (lowerBody == LowerBody.DRIDER || lowerBody == LowerBody.HYDRA) armorDef += (4 * newGamePlusMod);
			if (rearBody.type == RearBody.YETI_FUR) armorDef += (4 * newGamePlusMod);
			if (hasPerk(PerkLib.Lycanthropy)) armorDef += 10 * newGamePlusMod;
			if (isGargoyle() && Forgefather.material == "granite")
			{
				if (Forgefather.refinement == 1) armorDef *= (1.15);
				if (Forgefather.refinement == 2) armorDef *= (1.25);
				if (Forgefather.refinement == 3 || Forgefather.refinement == 4) armorDef *= (1.5);
				if (Forgefather.refinement == 5) armorDef *= (2);
			}
			//if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) {
				//if (arms.type == Arms.GARGOYLE || arms.type == Arms.GARGOYLE_2) armorDef += (30 * newGamePlusMod);
				//if (tailType == Tail.GARGOYLE || tailType == Tail.GARGOYLE_2) armorDef += (30 * newGamePlusMod);
				//if (lowerBody == LowerBody.GARGOYLE || lowerBody == LowerBody.GARGOYLE_2) armorDef += (30 * newGamePlusMod);
				//if (wings.type == Wings.GARGOYLE_LIKE_LARGE) armorDef += (30 * newGamePlusMod);
				//if (faceType == Face.DEVIL_FANGS) armorDef += (30 * newGamePlusMod);
			//}
			//if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) armorDef += (25 * newGamePlusMod);
			if (hasPerk(PerkLib.ElementalBody)) {
				if (perkv1(PerkLib.ElementalBody) == 2) {
					if (perkv2(PerkLib.ElementalBody) == 1) armorDef += (10 * newGamePlusMod);
					if (perkv2(PerkLib.ElementalBody) == 2) armorDef += (20 * newGamePlusMod);
					if (perkv2(PerkLib.ElementalBody) == 3) armorDef += (30 * newGamePlusMod);
					if (perkv2(PerkLib.ElementalBody) == 4) armorDef += (40 * newGamePlusMod);
				}
				if (perkv1(PerkLib.ElementalBody) == 4) {
					if (perkv2(PerkLib.ElementalBody) == 1) armorDef += (5 * newGamePlusMod);
					if (perkv2(PerkLib.ElementalBody) == 2) armorDef += (10 * newGamePlusMod);
					if (perkv2(PerkLib.ElementalBody) == 3) armorDef += (15 * newGamePlusMod);
					if (perkv2(PerkLib.ElementalBody) == 4) armorDef += (20 * newGamePlusMod);
				}
			}
			//Soul Cultivators bonuses
			if (hasPerk(PerkLib.BodyCultivator)) {
				armorDef += (1 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.FleshBodyApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) armorDef += 2 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulPersonage)) armorDef += 2 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulWarrior)) armorDef += 2 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) armorDef += 4 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulScholar)) armorDef += 4 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulElder)) armorDef += 4 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyElderStage)) {
				if (hasPerk(PerkLib.SoulExalt)) armorDef += 6 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulOverlord)) armorDef += 6 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulTyrant)) armorDef += 6 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyOverlordStage)) {
				if (hasPerk(PerkLib.SoulKing)) armorDef += 8 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulEmperor)) armorDef += 8 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulAncestor)) armorDef += 8 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) armorDef += 6 * newGamePlusMod;
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) armorDef += 9 * newGamePlusMod;
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) armorDef += 12 * newGamePlusMod;
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) armorDef += 15 * newGamePlusMod;
			//Agility boosts armor ratings!
			var speedBonus:int = 0;
			if (hasPerk(PerkLib.Agility)) {
				if (armorPerk == "Light" || _armor.name == "nothing" || _armor.name == "some taur paladin armor" || _armor.name == "some taur blackguard armor") {
					speedBonus += Math.round(spe / 10);
				}
				else if (armorPerk == "Medium") {
					speedBonus += Math.round(spe / 25);
				}
			}
			if (hasPerk(PerkLib.ArmorMaster)) {
				if (armorPerk == "Heavy" || _armor.name == "Drider-weave Armor") speedBonus += Math.round(spe / 50);
			}
			armorDef += speedBonus;
			//Feral armor boosts armor ratings!
			var toughnessBonus:int = 0;
			if (hasPerk(PerkLib.FeralArmor) && haveNaturalArmor() && armor.hasTag(ItemTags.AGILE)) {
				toughnessBonus += Math.round(tou / 20);
			}
			if (hasPerk(MutationsLib.NukiNuts)) {
				toughnessBonus += Math.round(ballSize);
			}
			if (hasPerk(MutationsLib.NukiNutsPrimitive)) {
				toughnessBonus += Math.round(ballSize);
			}
			if (hasPerk(MutationsLib.NukiNutsEvolved)) {
				toughnessBonus += Math.round(ballSize);
			}
			armorDef += toughnessBonus;
			if (hasPerk(PerkLib.PrestigeJobSentinel) && (armorPerk == "Heavy" || _armor.name == "Drider-weave Armor")) armorDef += _armor.def;
			if (hasPerk(PerkLib.ShieldExpertise) && shieldName != "nothing" && isShieldsForShieldBash()) {
				if (shieldBlock >= 4) armorDef += Math.round(shieldBlock * 0.25);
				else armorDef += 1;
			}
			//Acupuncture effect
			if (hasPerk(PerkLib.ChiReflowDefense)) armorDef *= UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI;
			if (hasPerk(PerkLib.ChiReflowAttack)) armorDef *= UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI;
			//Other bonuses
			if (hasPerk(PerkLib.ToughHide) && haveNaturalArmor()) armorDef += (2 * newGamePlusMod);
			if (hasPerk(MutationsLib.PigBoarFat)) armorDef += (1 * newGamePlusMod);
			if (hasPerk(MutationsLib.PigBoarFatPrimitive)) armorDef += (2 * newGamePlusMod);
			if (hasPerk(MutationsLib.PigBoarFatEvolved)) armorDef += (12 * newGamePlusMod);
			if (hasPerk(PerkLib.GoblinoidBlood)) {
				var goblinbracerBonus:int = 0;
				if (hasKeyItem("Powboy") >= 0) {
					goblinbracerBonus += Math.round(inte / 10);
					if (goblinbracerBonus > (10 * newGamePlusMod)) goblinbracerBonus = (10 * newGamePlusMod);
				}
				if (hasKeyItem("M.G.S. bracer") >= 0) {
					goblinbracerBonus += Math.round(inte / 10);
					if (goblinbracerBonus > (20 * newGamePlusMod)) goblinbracerBonus = (20 * newGamePlusMod);
				}
				armorDef += goblinbracerBonus;
			}
			if (headjewelryName == "Kabuto & Mempo set") {
				armorDef += 3;
				if (armorName == "samurai armor") armorDef += 4;
			}
			if (headjewelryName == "HB helmet") armorDef += 5;
			if (vehiclesName == "Goblin Mech Alpha") {
				armorDef += 10;
				if (hasKeyItem("Upgraded Armor plating 1.0") >= 0) armorDef += 5;
				if (hasKeyItem("Upgraded Armor plating 2.0") >= 0) armorDef += 10;
				if (hasKeyItem("Upgraded Armor plating 3.0") >= 0) armorDef += 15;
			}
			if (vehiclesName == "Goblin Mech Prime") {
				armorDef += 20;
				if (hasKeyItem("Upgraded Armor plating 1.0") >= 0) armorDef += 10;
				if (hasKeyItem("Upgraded Armor plating 2.0") >= 0) armorDef += 20;
				if (hasKeyItem("Upgraded Armor plating 3.0") >= 0) armorDef += 30;
			}
			if (vehiclesName == "Giant Slayer Mech") {
				armorDef += 20;
				if (hasKeyItem("Upgraded Armor plating 1.0") >= 0) armorDef += 40;
				if (hasKeyItem("Upgraded Armor plating 2.0") >= 0) armorDef += 60;
				if (hasKeyItem("Upgraded Armor plating 3.0") >= 0) armorDef += 80;
			}
			if (vehiclesName == "Howling Banshee Mech") {
				armorDef += 15;
				if (hasKeyItem("HB Armor Plating") >= 0) {
					if (keyItemvX("HB Armor Plating", 1) == 1) armorDef += 15;
					if (keyItemvX("HB Armor Plating", 1) == 2) armorDef += 25;
					if (keyItemvX("HB Armor Plating", 1) == 3) armorDef += 35;
					if (keyItemvX("HB Armor Plating", 1) == 4) armorDef += 45;
				}
			}
			armorDef = Math.round(armorDef);
			//Berzerking removes armor
			if (hasStatusEffect(StatusEffects.Berzerking) && !hasPerk(PerkLib.ColdFury)) armorDef = 0;
			if (hasStatusEffect(StatusEffects.ChargeArmor) && (!isNaked() || (isNaked() && haveNaturalArmor() && hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor)))) armorDef += Math.round(statusEffectv1(StatusEffects.ChargeArmor));
			if (hasStatusEffect(StatusEffects.CompBoostingPCArmorValue)) armorDef += (level * newGamePlusMod);
			if (hasStatusEffect(StatusEffects.StoneSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.StoneSkin));
			if (hasStatusEffect(StatusEffects.BarkSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.BarkSkin));
			if (hasStatusEffect(StatusEffects.MetalSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.MetalSkin));
			if (CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				armorDef -= CoC.instance.monster.statusEffectv1(StatusEffects.TailWhip);
				if(armorDef < 0) armorDef = 0;
			}
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				if (jewelryName == "Flame Lizard ring" || jewelryName2 == "Flame Lizard ring" || jewelryName3 == "Flame Lizard ring" || jewelryName4 == "Flame Lizard ring") armorDef = Math.round(armorDef * 1.15);
				else armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			if (statStore.hasBuff("CrinosShape") && hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor)) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			armorDef = Math.round(armorDef);
			return armorDef;
		}
		override public function get armorMDef():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var armorMDef:Number = _armor.mdef;
			armorMDef += upperGarment.armorMDef;
			armorMDef += lowerGarment.armorMDef;
			//Blacksmith history!
			if (armorDef > 0 && (hasPerk(PerkLib.HistorySmith) || hasPerk(PerkLib.PastLifeSmith))) {
				var smithMBonus:Number = 1.05;
				if (hasPerk(PerkLib.Tongs)) smithMBonus += 0.05;
				if (hasPerk(PerkLib.Bellows)) smithMBonus += 0.05;
				if (hasPerk(PerkLib.Furnace)) smithMBonus += 0.05;
				if (hasPerk(PerkLib.Hammer)) smithMBonus += 0.05;
				if (hasPerk(PerkLib.Anvil)) smithMBonus += 0.05;
				if (hasPerk(PerkLib.Weap0n)) smithMBonus += 0.05;
				if (hasPerk(PerkLib.Arm0r)) smithMBonus += 0.05;
				armorMDef = Math.round(armorMDef * smithMBonus);
				armorMDef += 1;
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinArmorPolishing)) {
				armorMDef = Math.round(armorMDef * (1 + (statusEffectv2(StatusEffects.KonstantinArmorPolishing) / 100)));
				armorMDef += 1;
			}
			//Skin armor perk
			if (hasPerk(PerkLib.ThickSkin)) {
				armorMDef += (1 * newGamePlusMod);
			}
			//Stacks on top of Thick Skin perk.
			var p:Boolean = skin.isCoverLowMid();
			if (skin.hasFur()) armorMDef += (p?1:2)*newGamePlusMod;
			if (hasGooSkin() && skinAdj == "slimy") armorMDef += (2 * newGamePlusMod);
			if (skin.hasChitin()) armorMDef += (p?2:4)*newGamePlusMod;
			if (skin.hasScales()) armorMDef += (p?3:6)*newGamePlusMod; //bee-morph (), mantis-morph (), scorpion-morph (wpisane), spider-morph (wpisane)
			if (skin.hasBark() || skin.hasDragonScales()) armorMDef += (p?4:8)*newGamePlusMod;
			if (skin.hasBaseOnly(Skin.STONE)) armorMDef += (10 * newGamePlusMod);/*
			//'Thick' dermis descriptor adds 1!
			if (skinAdj == "smooth") armorMDef += (1 * newGamePlusMod);/*
			//Plant score bonuses
			if (plantScore() >= 4) {
				if (plantScore() >= 7) armorDef += (10 * newGamePlusMod);
				else if (plantScore() == 6) armorDef += (8 * newGamePlusMod);
				else if (plantScore() == 5) armorDef += (4 * newGamePlusMod);
				else armorDef += (2 * newGamePlusMod);
			}*/
			if (yggdrasilScore() >= 10) armorMDef += (10 * newGamePlusMod);
			//Dragon score bonuses
			if (dragonScore() >= 16) {
				if (dragonScore() >= 32) armorMDef += (10 * newGamePlusMod);
				else if (dragonScore() >= 24) armorMDef += (4 * newGamePlusMod);
				else armorMDef += (1 * newGamePlusMod);
			}
			if (frostWyrmScore() >= 18) {
				/*if (frostWyrmScore() >= 30) armorMDef += (10 * newGamePlusMod);
				else */if (frostWyrmScore() >= 26) armorMDef += (4 * newGamePlusMod);
				else armorMDef += (1 * newGamePlusMod);
			}
			if (leviathanScore() >= 20) {
				if (leviathanScore() >= 30) armorMDef += (5 * newGamePlusMod);
				else armorMDef += (1 * newGamePlusMod);
			}
			//Bonus defense
			if (arms.type == Arms.YETI) armorMDef += (1 * newGamePlusMod);
			if (arms.type == Arms.SPIDER || arms.type == Arms.MANTIS || arms.type == Arms.BEE || arms.type == Arms.SALAMANDER) armorMDef += (2 * newGamePlusMod);
			if (arms.type == Arms.DRACONIC || arms.type == Arms.FROSTWYRM) armorMDef += (3 * newGamePlusMod);
			if (arms.type == Arms.HYDRA) armorMDef += (4 * newGamePlusMod);
			if (tailType == Tail.SPIDER_ADBOMEN || tailType == Tail.MANTIS_ABDOMEN || tailType == Tail.BEE_ABDOMEN) armorMDef += (2 * newGamePlusMod);
			if (tailType == Tail.DRACONIC) armorMDef += (3 * newGamePlusMod);
			if (tailType == LowerBody.FROSTWYRM) armorMDef += (6 * newGamePlusMod);
			if (lowerBody == LowerBody.YETI) armorMDef += (1 * newGamePlusMod);
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS || lowerBody == LowerBody.BEE || lowerBody == LowerBody.MANTIS || lowerBody == LowerBody.SALAMANDER) armorMDef += (2 * newGamePlusMod);
			if (lowerBody == LowerBody.DRAGON) armorMDef += (3 * newGamePlusMod);
			if (lowerBody == LowerBody.DRIDER) armorMDef += (4 * newGamePlusMod);
			//if (hasPerk(PerkLib.Vulpesthropy)) armorMDef += 10 * newGamePlusMod;
			if (isGargoyle() && Forgefather.material == "alabaster")
			{
				if (Forgefather.refinement == 1) armorMDef *= (1.15);
				if (Forgefather.refinement == 2) armorMDef *= (1.25);
				if (Forgefather.refinement == 3 || Forgefather.refinement == 4) armorMDef *= (1.5);
				if (Forgefather.refinement == 5) armorMDef *= (2);
			}
			//if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) armorMDef += (25 * newGamePlusMod);
			//if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) {
				//if (arms.type == Arms.GARGOYLE || arms.type == Arms.GARGOYLE_2) armorMDef += (30 * newGamePlusMod);
				//if (tailType == Tail.GARGOYLE || tailType == Tail.GARGOYLE_2) armorMDef += (30 * newGamePlusMod);
				//if (lowerBody == LowerBody.GARGOYLE || lowerBody == LowerBody.GARGOYLE_2) armorMDef += (30 * newGamePlusMod);
				//if (wings.type == Wings.GARGOYLE_LIKE_LARGE) armorMDef += (30 * newGamePlusMod);
				//if (faceType == Face.DEVIL_FANGS) armorMDef += (30 * newGamePlusMod);
			//}
			if (hasPerk(PerkLib.ElementalBody)) {
				if (perkv1(PerkLib.ElementalBody) == 2) {
					if (perkv2(PerkLib.ElementalBody) == 1) armorMDef += (10 * newGamePlusMod);
					if (perkv2(PerkLib.ElementalBody) == 2) armorMDef += (20 * newGamePlusMod);
					if (perkv2(PerkLib.ElementalBody) == 3) armorMDef += (30 * newGamePlusMod);
					if (perkv2(PerkLib.ElementalBody) == 4) armorMDef += (40 * newGamePlusMod);
				}
				if (perkv1(PerkLib.ElementalBody) == 4) {
					if (perkv2(PerkLib.ElementalBody) == 1) armorMDef += (5 * newGamePlusMod);
					if (perkv2(PerkLib.ElementalBody) == 2) armorMDef += (10 * newGamePlusMod);
					if (perkv2(PerkLib.ElementalBody) == 3) armorMDef += (15 * newGamePlusMod);
					if (perkv2(PerkLib.ElementalBody) == 4) armorMDef += (20 * newGamePlusMod);
				}
			}
			//Soul Cultivators bonuses
			if (hasPerk(PerkLib.FleshBodyApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) armorMDef += 1 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulPersonage)) armorMDef += 1 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulWarrior)) armorMDef += 1 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) armorMDef += 3 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulScholar)) armorMDef += 3 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulElder)) armorMDef += 3 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyElderStage)) {
				if (hasPerk(PerkLib.SoulExalt)) armorMDef += 5 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulOverlord)) armorMDef += 5 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulTyrant)) armorMDef += 5 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyOverlordStage)) {
				if (hasPerk(PerkLib.SoulKing)) armorMDef += 7 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulEmperor)) armorMDef += 7 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulAncestor)) armorMDef += 7 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) armorMDef += 4 * newGamePlusMod;
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) armorMDef += 6 * newGamePlusMod;
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) armorMDef += 8 * newGamePlusMod;
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) armorMDef += 10 * newGamePlusMod;/*
			//Agility boosts armor ratings!
			var speedBonus:int = 0;
			if (hasPerk(PerkLib.Agility)) {
				if (armorPerk == "Light" || _armor.name == "nothing") {
					speedBonus += Math.round(spe / 10);
				}
				else if (armorPerk == "Medium") {
					speedBonus += Math.round(spe / 25);
				}
			}
			if (hasPerk(PerkLib.ArmorMaster)) {
				if (armorPerk == "Heavy" || _armor.name == "Drider-weave Armor") speedBonus += Math.round(spe / 50);
			}
			armorDef += speedBonus;
			//Feral armor boosts armor ratings!
			var toughnessBonus:int = 0;
			if (hasPerk(PerkLib.FeralArmor) && haveNaturalArmor() && meetUnhinderedReq()) {
				toughnessBonus += Math.round(tou / 20);
			}
			armorDef += toughnessBonus;
			if (hasPerk(PerkLib.PrestigeJobSentinel) && (armorPerk == "Heavy" || _armor.name == "Drider-weave Armor")) armorDef += _armor.def;
			if (hasPerk(PerkLib.ShieldExpertise) && shieldName != "nothing") {
				if (shieldBlock >= 4) armorDef += Math.round(shieldBlock);
				else armorDef += 1;
			}
			//Acupuncture effect
			if (hasPerk(PerkLib.ChiReflowDefense)) armorDef *= UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI;
			if (hasPerk(PerkLib.ChiReflowAttack)) armorDef *= UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI;*/
			//Other bonuses
			if (hasPerk(PerkLib.ToughHide) && haveNaturalArmor()) armorMDef += (1 * newGamePlusMod);
			if (hasPerk(MutationsLib.PigBoarFat)) armorMDef += (1 * newGamePlusMod);
			if (hasPerk(MutationsLib.PigBoarFatPrimitive)) armorMDef += (2 * newGamePlusMod);
			if (hasPerk(MutationsLib.PigBoarFatEvolved)) armorMDef += (12 * newGamePlusMod);
			if (hasPerk(PerkLib.GoblinoidBlood)) {
				var goblinbracerBonus:int = 0;
				if (hasKeyItem("Powboy") >= 0) {
					goblinbracerBonus += Math.round(inte / 10);
					if (goblinbracerBonus > (10 * newGamePlusMod)) goblinbracerBonus = (10 * newGamePlusMod);
				}
				if (hasKeyItem("M.G.S. bracer") >= 0) {
					goblinbracerBonus += Math.round(inte / 10);
					if (goblinbracerBonus > (20 * newGamePlusMod)) goblinbracerBonus = (20 * newGamePlusMod);
				}
				armorMDef += goblinbracerBonus;
			}
			if (headjewelryName == "HB helmet") armorMDef += 4;
			if (vehiclesName == "Goblin Mech Alpha") {
				armorMDef += 10;
				if (hasKeyItem("Upgraded Armor plating 1.0") >= 0) armorMDef += 5;
				if (hasKeyItem("Upgraded Armor plating 2.0") >= 0) armorMDef += 10;
				if (hasKeyItem("Upgraded Armor plating 3.0") >= 0) armorMDef += 15;
			}
			if (vehiclesName == "Goblin Mech Prime") {
				armorMDef += 20;
				if (hasKeyItem("Upgraded Armor plating 1.0") >= 0) armorMDef += 10;
				if (hasKeyItem("Upgraded Armor plating 2.0") >= 0) armorMDef += 20;
				if (hasKeyItem("Upgraded Armor plating 3.0") >= 0) armorMDef += 30;
			}
			if (vehiclesName == "Giant Slayer Mech") {
				armorMDef += 20;
				if (hasKeyItem("Upgraded Leather Insulation 1.0") >= 0) armorMDef += 40;
				if (hasKeyItem("Upgraded Leather Insulation 2.0") >= 0) armorMDef += 60;
				if (hasKeyItem("Upgraded Leather Insulation 3.0") >= 0) armorMDef += 80;
			}
			if (vehiclesName == "Howling Banshee Mech") {
				armorMDef += 15;
				if (hasKeyItem("HB Leather Insulation") >= 0) {
					if (keyItemvX("HB Leather Insulation", 2) == 1) armorMDef += 15;
					if (keyItemvX("HB Leather Insulation", 2) == 2) armorMDef += 25;
					if (keyItemvX("HB Leather Insulation", 2) == 3) armorMDef += 35;
					if (keyItemvX("HB Leather Insulation", 2) == 4) armorMDef += 45;
				}
			}
			armorMDef = Math.round(armorMDef);
			//Berzerking/Lustzerking removes magic resistance
			if (hasStatusEffect(StatusEffects.Berzerking) && !hasPerk(PerkLib.ColderFury)) armorMDef = 0;
			if (hasStatusEffect(StatusEffects.Lustzerking) && !hasPerk(PerkLib.ColderLust)) armorMDef = 0;
			//if (hasStatusEffect(StatusEffects.ChargeArmor) && (!isNaked() || (isNaked() && haveNaturalArmor() && hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor)))) armorDef += Math.round(statusEffectv1(StatusEffects.ChargeArmor));
			if (hasStatusEffect(StatusEffects.StoneSkin)) armorMDef += Math.round(statusEffectv1(StatusEffects.StoneSkin));
			if (hasStatusEffect(StatusEffects.BarkSkin)) armorMDef += Math.round(statusEffectv1(StatusEffects.BarkSkin));
			if (hasStatusEffect(StatusEffects.MetalSkin)) armorMDef += Math.round(statusEffectv1(StatusEffects.MetalSkin));/*
			if (CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				armorDef -= CoC.instance.monster.statusEffectv1(StatusEffects.TailWhip);
				if(armorDef < 0) armorDef = 0;
			}
			if (hasStatusEffect(StatusEffects.CrinosShape) && hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor)) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}*/
			armorMDef = Math.round(armorMDef);
			return armorMDef;
		}
		public function get armorBaseDef():Number {
			return _armor.def;
		}
		override public function get armorPerk():String {
			return _armor.perk;
		}
		override public function get armorValue():Number {
			return _armor.value;
		}
		//Wing Slap compatibile wings + tiers of wings for dmg multi
		public function haveWingsForWingSlap():Boolean
		{
			return Arms.Types[arms.type].wingSlap || Wings.Types[wings.type].wingSlap;
		}
		public function thirdtierWingsForWingSlap():Boolean
		{
			return wings.type == Wings.BAT_LIKE_LARGE_2 || wings.type == Wings.DRACONIC_HUGE;
		}
		//Natural Claws (arm types and weapons that can substitude them)
		public function haveNaturalClaws():Boolean { return Arms.Types[arms.type].claw || Arms.Types[arms.type].armSlam || Arms.Types[arms.type].scythe || LowerBody.hasClaws(this);}
		public function haveNaturalClawsTypeWeapon():Boolean {return weaponName == "gauntlet with claws" || weaponName == "gauntlet with an aphrodisiac-coated claws" || weaponName == "Venoclaw" || weaponName == "hooked gauntlets" || (shield == game.shields.AETHERS && weapon == game.weapons.AETHERD && (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Gaunlets" || AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets"));}
		//Other natural weapon checks
		public function hasABiteAttack():Boolean { return (lowerBody == LowerBody.HYDRA || Face.Types[faceType].bite);}
		public function hasAWingAttack():Boolean { return (Wings.Types[wings.type].wingSlap || wings.type == Wings.THUNDEROUS_AURA || wings.type == Wings.WINDY_AURA);}
		public function hasAGoreAttack():Boolean { return (Horns.Types[horns.type].gore);}
		public function hasATailSlapAttack():Boolean { return (Tail.Types[tail.type].tailSlam || Tail.Types[tail.type].stinger || Tail.Types[tail.type].Energy || LowerBody.canTailSlam(this));}
		public function hasTalonsAttack():Boolean{return LowerBody.hasTalons(this);}
		public function hasTentacleAttacks():Boolean{return LowerBody.hasTentacles(this) || hasPerk(PerkLib.MorphicWeaponry);}
		public function hasNaturalWeapons():Boolean { return (haveNaturalClaws() || hasABiteAttack() || hasAWingAttack() || hasAGoreAttack() || hasATailSlapAttack() || hasTalonsAttack || hasTentacleAttacks || isAlraune() || isTaur());}
		//Some other checks
		public function isGoblinoid():Boolean { return (goblinScore() > 9 || gremlinScore() > 14); }
		public function isSlime():Boolean { return (hasPerk(PerkLib.DarkSlimeCore) || hasPerk(PerkLib.SlimeCore)); }
		public function isHarpy():Boolean { return (harpyScore() > 10 || thunderbirdScore() > 15 || phoenixScore() > 15); }
		public function isWerewolf():Boolean { return (werewolfScore() >= 12); }
		public function isNightCreature():Boolean { return (vampireScore() >= 10 || batScore() >= 6 || jiangshiScore() >= 20); }
		public function hasDarkVision():Boolean { return (Eyes.Types[eyes.type].Darkvision); }
		public function isHavingEnhancedHearing():Boolean { return (ears.type == Ears.ELVEN); }
		//Weapons for Whirlwind
		public function isWeaponForWhirlwind():Boolean
		{
			return isSwordTypeWeapon() || isAxeTypeWeapon() || weaponSpecials("Whirlwind");// || weapon == game.weapons.
		}
		//Weapons for Whipping
		public function isWeaponsForWhipping():Boolean
		{
			return weaponSpecials("Whipping");
		}
		//1H Weapons
		public function isOneHandedWeapons():Boolean
		{
			return (!weaponSpecials("Dual Large") && !weaponSpecials("Dual") && !weaponSpecials("Dual Small") &&!weaponSpecials("Staff") && !weaponSpecials("Large") && !weaponSpecials("Massive") && weapon != game.weapons.DAISHO);
		}
		//Non Large/Massive weapons
		public function isNoLargeNoStaffWeapon():Boolean
		{
			return (!weaponSpecials("Dual Large") && !weaponSpecials("Large") && !weaponSpecials("Massive") && !isStaffTypeWeapon());
		}
		//Wrath Weapons
		public function isLowGradeWrathWeapon():Boolean
		{
			return weaponSpecials("LGWrath") || weaponRange == game.weaponsrange.B_F_BOW || AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets";
		}
		public function isDualLowGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.DBFSWO || weapon == game.weapons.ANGSTD || weapon == game.weapons.DBFWHIP;
		}/*
		public function isMidGradeWrathWeapon():Boolean
		{
			return weaponSpecials("MGWrath") || weapon == game.weapons.NTWHIP;
		}*/
		public function isDualMidGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.ASTERIUS;
		}/*
		public function isHighGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.CNTWHIP;
		}
		public function isDualHighGradeWrathWeapon():Boolean
		{
			return ;
		}*/
		//Free off-hand for spellcasting and etc.
		public function isHavingFreeOffHand():Boolean
		{
			return !isShieldsForShieldBash() && shield != game.shields.BATTNET && shield != game.shields.Y_U_PAN;
		}
		public function isNotHavingShieldCuzPerksNotWorkingOtherwise():Boolean
		{
			return shield == ShieldLib.NOTHING || shield == game.shields.AETHERS;
		}

		//weaponType check. Make sure weapon has the type filled in. Currently, Type is the last parameter in Weapon().
		//Fists and fist weapons
		public function isFistOrFistWeapon():Boolean {
			return weaponName == "fists" || isGauntletWeapon();
		}
		public function isGauntletWeapon():Boolean {
			return (weaponClass("Gauntlet")) || (shield == game.shields.AETHERS && weapon == game.weapons.AETHERD && (AetherTwinsFollowers.AetherTwinsShape == "" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Gaunlets" || AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets"));
		}
		//Sword-type weapons
		public function isSwordTypeWeapon():Boolean {
			return (weaponClass("Sword"));
		}
		//Axe-type weapons
		public function isAxeTypeWeapon():Boolean {
			return (weaponClass("Axe"));
		}
		//Mace/Hammer-type weapons
		public function isMaceHammerTypeWeapon():Boolean {
			return (weaponClass("Mace/Hammer"));
		}
		public function isTetsubo():Boolean {
			return (weaponClass("Tetsubo"));
		}
		//Dueling sword-type weapons (rapier & katana)
		public function isDuelingTypeWeapon():Boolean {
			return (weaponClass("Dueling"));
		}
		//Polearm-type
		public function isPolearmTypeWeapon():Boolean {
			return (weaponClass("Polearm"));
		}
		//Spear-type
		public function isSpearTypeWeapon():Boolean {
			return (weaponClass("Spear")) || weapon == game.weapons.SKYPIER;
		}
		//Scythe-type
		public function isScytheTypeWeapon():Boolean {
			return (weaponClass("Scythe"));
		}
		//Dagger-type weapons
		public function isDaggerTypeWeapon():Boolean {
			return (weaponClass("Dagger"));
		}
		//Staff <<SCECOMM(scepter not staff)>>
		public function isStaffTypeWeapon():Boolean {
			return (weaponClass("Staff")) || weapon == game.weapons.ASCENSU || weapon == game.weapons.B_STAFF || weapon == game.weapons.DEPRAVA || weapon == game.weapons.PURITAS || weapon == game.weapons.WDSTAFF;
		}
		//Whip-type weapons
		public function isWhipTypeWeapon():Boolean {
			return (weaponClass("Whip"));
		}
		//Ribbon-type weapons
		public function isRibbonTypeWeapon():Boolean {
			return (weaponClass("Ribbon"));
		}
		//Exotic-type weapons
		public function isExoticTypeWeapon():Boolean {
			return isRibbonTypeWeapon() || (weaponClass("Exotic"));
		}
		//Partial staff type weapons
		public function isPartiallyStaffTypeWeapon():Boolean {
			return (weaponClass("StaffPart")) || weapon == game.weapons.DEMSCYT || weapon == game.weapons.LHSCYTH;// || weapon == game.weapons.E_STAFF || weapon == game.weapons.L_STAFF || weapon == game.weapons.N_STAFF || weapon == game.weapons.U_STAFF || weapon == game.weapons.W_STAFF || weapon == game.weapons.WDSTAFF
		}
		//Weapons for Sneak Attack (Meele and Range)
		public function haveWeaponForSneakAttack():Boolean
		{
			return weaponSpecials("Small") || weaponSpecials("Dual Small");
		}
		public function haveWeaponForSneakAttackRange():Boolean
		{
			return weaponRangePerk == "Bow" || weaponRange == game.weaponsrange.M1CERBE || weaponRange == game.weaponsrange.SNIPPLE;
		}
		//(dla Sword Immortal gra musi sprawdzić czy używa Sword type lub Dueling sword type weapons bo tak)
		//Throwable melee weapons
		public function haveThrowableMeleeWeapon():Boolean
		{
			return (weaponClass("Thrown"));//wrath large weapon that can be throwed or used in melee xD
		}
		//Cleave compatibile weapons
		public function haveWeaponForCleave():Boolean
		{
			return isAxeTypeWeapon() || isSwordTypeWeapon() || isDuelingTypeWeapon();
		}
		//No multishoot firearms
		public function noMultishootFirearms():Boolean
		{
			return weaponRange == game.weaponsrange.TRFATBI;//weaponRange == game.weaponsrange.TRFATBI ||
		}
		//Is in Ayo armor
		public function isInAyoArmor():Boolean
		{
			return armorPerk == "Light Ayo" || armorPerk == "Heavy Ayo" || armorPerk == "Ultra Heavy Ayo";
		}
		//Is in goblin mech
		public function isInGoblinMech():Boolean
		{
			return vehicles == game.vehicles.GOBMALP || vehicles == game.vehicles.GOBMPRI || vehicles == game.vehicles.GS_MECH;
		}
		//Is using goblin mech friendly firearms
		public function isUsingGoblinMechFriendlyFirearms():Boolean
		{
			return weaponRange == game.weaponsrange.ADBSCAT || weaponRange == game.weaponsrange.ADBSHOT || weaponRange == game.weaponsrange.BLUNDER || weaponRange == game.weaponsrange.DESEAGL || weaponRange == game.weaponsrange.DUEL_P_ || weaponRange == game.weaponsrange.FLINTLK || weaponRange == game.weaponsrange.HARPGUN || weaponRange == game.weaponsrange.IVIARG_
			 || weaponRange == game.weaponsrange.M1CERBE || weaponRange == game.weaponsrange.TOUHOM3 || weaponRange == game.weaponsrange.TWINGRA || weaponRange == game.weaponsrange.TDPISTO || weaponRange == game.weaponsrange.DPISTOL;
		}
		//Is in medium sized mech (med sized races mech)(have upgrade option to allow smaller than medium races pilot it)
		public function isInNonGoblinMech():Boolean
		{
			return vehicles == game.vehicles.HB_MECH;// || vehicles == game.vehicles.GOBMPRI
		}
		//Is using howling banshee mech friendly range weapons
		public function isUsingHowlingBansheeMechFriendlyRangeWeapons():Boolean
		{
			return weaponRangePerk == "Bow" || weaponRangePerk == "Crossbow";
		}
		//Is in ... mech (large sized races mech)(have upgrade option to allow smaller than large races pilot it)
		//Player have any party member with them
		public function companionsInPCParty():Boolean
		{
			return flags[kFLAGS.PLAYER_COMPANION_0] != "" || flags[kFLAGS.PLAYER_COMPANION_1] != "" || flags[kFLAGS.PLAYER_COMPANION_2] != "" || flags[kFLAGS.PLAYER_COMPANION_3] != "";
		}
		//PC can fly without natural wings
		public function canFlyNoWings():Boolean
		{
			return weaponFlyingSwordsName != "nothing" || hasPerk(PerkLib.GclassHeavenTribulationSurvivor);
		}
		//Flying swords related checks
		public function canFlyOnFlyingSwords():Boolean
		{
			return weaponFlyingSwordsPerk == "Large" || weaponFlyingSwordsPerk == "Large Two" || weaponFlyingSwordsPerk == "Massive";
		}
		public function usingSingleFlyingSword():Boolean
		{
			return weaponFlyingSwordsPerk == "Small" || weaponFlyingSwordsPerk == "Large" || weaponFlyingSwordsPerk == "Massive";
		}
		//Natural Jouster perks req check
		public function isMeetingNaturalJousterReq():Boolean
		{
			return (((isTaur() || isDrider() || canFly()) && spe >= 60) && hasPerk(PerkLib.Naturaljouster) && (!(PerkLib.DoubleAttack) || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)))
             || (spe >= 150 && hasPerk(PerkLib.Naturaljouster) && hasPerk(PerkLib.DoubleAttack) && (!hasPerk(PerkLib.DoubleAttack) || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)));
		}
		public function isMeetingNaturalJousterMasterGradeReq():Boolean
		{
			return (((isTaur() || isDrider() || canFly()) && spe >= 180) && hasPerk(PerkLib.NaturaljousterMastergrade) && (!hasPerk(PerkLib.DoubleAttack) || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)))
             || (spe >= 450 && hasPerk(PerkLib.NaturaljousterMastergrade) && hasPerk(PerkLib.DoubleAttack) && (!hasPerk(PerkLib.DoubleAttack) || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)));
		}
		public function haveWeaponForJouster():Boolean
		{
			return isSpearTypeWeapon();
		}
		public function playerIsBlinded():Boolean
		{
			return hasStatusEffect(StatusEffects.Blind) || hasStatusEffect(StatusEffects.Snowstorms);
		}
		public function playerHasFourArms():Boolean
		{
			return arms.type == Arms.DISPLACER;
		}
		//override public function get weapons
		override public function get weaponName():String {
			return _weapon.name;
		}
		override public function get weaponVerb():String {
			return _weapon.verb;
		}
		override public function get weaponAttack():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var attack:Number = _weapon.attack;
			if (hasPerk(PerkLib.JobSwordsman) && weaponSpecials("Large")) {
				if (hasPerk(PerkLib.WeaponMastery) && str >= 100) {
					if (hasPerk(PerkLib.WeaponGrandMastery) && str >= 140) attack *= 2;
					else attack *= 1.5;
				}
				else attack *= 1.25;
			}
			if (hasPerk(PerkLib.WeaponGrandMastery) && weaponSpecials("Dual Large") && str >= 140) {
				attack *= 2;
			}
			if (hasPerk(PerkLib.GigantGripEx) && weaponSpecials("Massive")) {
				if (hasPerk(PerkLib.WeaponMastery) && str >= 100) {
					if (hasPerk(PerkLib.WeaponGrandMastery) && str >= 140) attack *= 2;
					else attack *= 1.5;
				}
				else attack *= 1.25;
			}
			if (hasPerk(PerkLib.HiddenMomentum) && (weaponSpecials("Large") || (hasPerk(PerkLib.GigantGripEx) && weaponSpecials("Massive"))) && str >= 75 && spe >= 50) {
				attack += (((str + spe) - 100) * 0.2);
			}//30-70-110
			if (hasPerk(PerkLib.HiddenDualMomentum) && weaponSpecials("Dual Large") && str >= 150 && spe >= 100) {
				attack += (((str + spe) - 200) * 0.2);
			}//20-60-100
			if (hasPerk(PerkLib.LightningStrikes) && spe >= 60 && (!weaponSpecials("Massive") || !weaponSpecials("Large") || !weaponSpecials("Dual Large") || !weaponSpecials("Small") || !weaponSpecials("Dual Small") || !isFistOrFistWeapon())) {
				attack += ((spe - 50) * 0.3);
			}//45-105-165
			if (weaponSpecials("Hybrid") && shieldName == "nothing"){
				attack *= 1.5;
			}
			if (hasPerk(PerkLib.StarlightStrikes) && spe >= 60 && (weaponSpecials("Small") || weaponSpecials("Dual Small"))) {
				attack += ((spe - 50) * 0.2);
			}
			if (hasPerk(PerkLib.SteelImpact)) {
				attack += ((tou - 50) * 0.3);
			}
			if (isFistOrFistWeapon()) {
				if (hasPerk(PerkLib.IronFistsI) && str >= 50) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsII) && str >= 65) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsIII) && str >= 80) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsIV) && str >= 95) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsV) && str >= 110) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsVI) && str >= 125) {
					attack += 10;
				}
				if (hasPerk(PerkLib.JobBrawler) && str >= 60) {
					attack += (5 * newGamePlusMod);
				}
				if (hasPerk(PerkLib.MightyFist) && isFistOrFistWeapon()) {
					attack += (5 * newGamePlusMod);
				}
				if (SceneLib.combat.unarmedAttack()) {
					attack += SceneLib.combat.unarmedAttack();
				}
			}
			if (hasPerk(PerkLib.PrestigeJobTempest) && (weaponSpecials("Dual Small") || weaponSpecials("Dual") || weaponSpecials("Dual Large") || weapon == game.weapons.DAISHO)) {
				attack += (5 * newGamePlusMod);
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinWeaponSharpening) && weaponName != "fists") {
				attack *= 1 + (statusEffectv2(StatusEffects.KonstantinWeaponSharpening) / 100);
			}
			if (hasStatusEffect(StatusEffects.Berzerking) || hasStatusEffect(StatusEffects.Lustzerking)) {
				var zerkersboost:Number = 0;
				zerkersboost += (15 + (15 * newGamePlusMod));
				if (hasPerk(PerkLib.ColdFury) || hasPerk(PerkLib.ColdLust)) zerkersboost += (5 + (5 * newGamePlusMod));
				if (hasPerk(PerkLib.ColderFury) || hasPerk(PerkLib.ColderLust)) zerkersboost += (10 + (10 * newGamePlusMod));
				if (hasPerk(MutationsLib.SalamanderAdrenalGlandsEvolved)) zerkersboost += (30 + (30 * newGamePlusMod));
				if (hasPerk(PerkLib.Lustzerker) && (jewelryName == "Flame Lizard ring" || jewelryName2 == "Flame Lizard ring" || jewelryName3 == "Flame Lizard ring" || jewelryName4 == "Flame Lizard ring")) zerkersboost += (5 + (5 * newGamePlusMod));
				if (hasPerk(PerkLib.BerserkerArmor)) zerkersboost += (5 + (5 * newGamePlusMod));
				if (hasStatusEffect(StatusEffects.Berzerking) && hasStatusEffect(StatusEffects.Lustzerking)) {
					if (hasPerk(PerkLib.ColderFury) || hasPerk(PerkLib.ColderLust)) zerkersboost *= 4;
					else if (hasPerk(PerkLib.ColderFury) || hasPerk(PerkLib.ColderLust)) zerkersboost *= 3;
					else zerkersboost *= 2.5;
				}
				attack += zerkersboost;
			}
			if (isGargoyle() && Forgefather.material == "ebony")
			{
				if (Forgefather.refinement == 1) attack *= (1.15);
				if (Forgefather.refinement == 2) attack *= (1.25);
				if (Forgefather.refinement == 3 || Forgefather.refinement == 4) attack *= (1.5);
				if (Forgefather.refinement == 5) attack *= (2);
			}
			if (hasStatusEffect(StatusEffects.ChargeWeapon)) {
				if (weaponName == "fists" && !hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalWeapons)) attack += 0;
				else attack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
			}
			attack = Math.round(attack);
			return attack;
		}
		public function get weaponBaseAttack():Number {
			return _weapon.attack;
		}
		override public function get weaponPerk():String {
			return _weapon.perk || "";
		}
		override public function get weaponType():String {
			return _weapon.type || "";
		}
		override public function get weaponValue():Number {
			return _weapon.value;
		}
		//First arg is weapon type. Second is override, in case you want to check specific weapon.
		public function weaponClass(pWeaponClass:String = "", orWeaponCheck:* = null):Boolean {
			var temp:Array = [];
			if (orWeaponCheck != null){
				temp = orWeaponCheck.type.split(", ");
			}
			else{
				temp = weapon.type.split(", ");
			}
			return (temp.indexOf(pWeaponClass) >= 0);
		}
		public function weaponSpecials(pWeaponSpecials:String = "", orWeaponCheck:* = null):Boolean {
			var temp:Array = [];
			if (orWeaponCheck != null){
				temp = orWeaponCheck.perk.split(", ");
			}
			else{
				temp = weapon.perk.split(", ");
			}
			return (temp.indexOf(pWeaponSpecials) >= 0);
		}
		//Is DualWield
		public function isDualWield():Boolean
		{
			return weaponRangePerk == "Dual Firearms" || weaponSpecials("Dual Large") || weaponSpecials("Dual Small") || weaponSpecials("Dual");
		}
		//Artifacts Bows
		public function isArtifactBow():Boolean
		{
			return weaponRange == game.weaponsrange.BOWGUID || weaponRange == game.weaponsrange.BOWHODR;
		}
		//Is Bows
		public function isBowTypeWeapon():Boolean
		{
			return weaponRangePerk == "Bow";
		}
		//Is Thrown
		public function isThrownTypeWeapon():Boolean
		{
			return weaponRangePerk == "Throwing";
		}
		//Using Tome
		public function isUsingTome():Boolean
		{
			return weaponRangeName == "nothing" || weaponRangeName == "Inquisitor’s Tome" || weaponRangeName == "Sage’s Sketchbook";
		}
		//Using a spear DEPRECATED
		public function isUsingSpear():Boolean
		{
			return (weaponClass("Spear"));
		}
		//Using Staff
		public function isUsingStaff():Boolean
		{
			return isStaffTypeWeapon();
		}
		//Using Wand
		public function isUsingWand():Boolean
		{
			return weaponSpecials("Wand");
		}
		//override public function get weapons
		override public function get weaponRangeName():String {
			return _weaponRange.name;
		}
		override public function get weaponRangeVerb():String {
			return _weaponRange.verb;
		}
		override public function get weaponRangeAttack():Number {
			//var newGamePlusMod:int = this.newGamePlusMod()+1;
			var rangeattack:Number = _weaponRange.attack;
			if (hasPerk(PerkLib.PracticedShot) && str >= 60 && (weaponRangePerk == "Bow" || weaponRangePerk == "Crossbow" || weaponRangePerk == "Throwing")) {
				if (hasPerk(PerkLib.EagleEye)) rangeattack *= 2;
				else rangeattack *= 1.5;
			}
			if (hasPerk(PerkLib.Sharpshooter) && weaponRangePerk != "Bow") {
				if (inte < 201) rangeattack *= (1 + (inte / 200));
				else rangeattack *= 2;
			}
			if (isGargoyle() && Forgefather.material == "sandstone")
			{
				if (Forgefather.refinement == 1) rangeattack *= (1.15);
				if (Forgefather.refinement == 2) rangeattack *= (1.25);
				if (Forgefather.refinement == 3 || Forgefather.refinement == 4) rangeattack *= (1.5);
				if (Forgefather.refinement == 5) rangeattack *= (2);
			}
		/*	if(hasPerk(PerkLib.LightningStrikes) && spe >= 60 && weaponRangePerk != "Large") {
				rangeattack += Math.round((spe - 50) / 3);
			}
			if(hasPerk(PerkLib.IronFistsI) && str >= 50 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(hasPerk(PerkLib.IronFistsII) && str >= 65 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(hasPerk(PerkLib.IronFistsIII) && str >= 80 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(hasPerk(PerkLib.IronFistsIV) && str >= 95 && weaponRangeName == "fists") {
			}
			if(arms.type == MANTIS && weaponRangeName == "fists") {
				rangeattack += (15 * newGamePlusMod);
			}
			if(hasStatusEffect(StatusEffects.Berzerking)) rangeattack += (30 + (15 * newGamePlusMod));
			if(hasStatusEffect(StatusEffects.Lustzerking)) rangeattack += (30 + (15 * newGamePlusMod));
			if(hasPerk(PerkLib.)) rangeattack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
		*/	if (hasStatusEffect(StatusEffects.ChargeWeapon) && !isUsingTome()) {
				rangeattack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
			}
			rangeattack = Math.round(rangeattack);
			return rangeattack;
		}
		public function get weaponRangeBaseAttack():Number {
			return _weaponRange.attack;
		}
		override public function get weaponRangePerk():String {
			return _weaponRange.perk || "";
		}
		override public function get weaponRangeValue():Number {
			return _weaponRange.value;
		}
		public function get ammo():int {
			return flags[kFLAGS.FLINTLOCK_PISTOL_AMMO];
		}
		public function set ammo(value:int):void {
			flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = value;
		}

		//override public function get weapons
		override public function get weaponFlyingSwordsName():String {
			return _weaponFlyingSwords.name;
		}
		override public function get weaponFlyingSwordsVerb():String {
			return _weaponFlyingSwords.verb;
		}
		override public function get weaponFlyingSwordsAttack():Number {
			//var newGamePlusMod:int = this.newGamePlusMod()+1;
			var flyingswordsattack:Number = _weaponFlyingSwords.attack;
			//flyingswordsattack = Math.round(flyingswordsattack);
			return flyingswordsattack;
		}
		public function get weaponFlyingSwordsBaseAttack():Number {
			return _weaponFlyingSwords.attack;
		}
		override public function get weaponFlyingSwordsPerk():String {
			return _weaponFlyingSwords.perk || "";
		}
		override public function get weaponFlyingSwordsValue():Number {
			return _weaponFlyingSwords.value;
		}

		//override public function get miscjewelries.
		override public function get miscjewelryName():String {
			return _miscjewelry.name;
		}
		override public function get miscjewelryEffectId():Number {
			return _miscjewelry.effectId;
		}
		override public function get miscjewelryEffectMagnitude():Number {
			return _miscjewelry.effectMagnitude;
		}
		override public function get miscjewelryPerk():String {
			return _miscjewelry.perk;
		}
		override public function get miscjewelryValue():Number {
			return _miscjewelry.value;
		}
		override public function get miscjewelryName2():String {
			return _miscjewelry2.name;
		}
		override public function get miscjewelryEffectId2():Number {
			return _miscjewelry2.effectId;
		}
		override public function get miscjewelryEffectMagnitude2():Number {
			return _miscjewelry2.effectMagnitude;
		}
		override public function get miscjewelryPerk2():String {
			return _miscjewelry2.perk;
		}
		override public function get miscjewelryValue2():Number {
			return _miscjewelry2.value;
		}

		//override public function get headjewelries.
		override public function get headjewelryName():String {
			return _headjewelry.name;
		}
		override public function get headjewelryEffectId():Number {
			return _headjewelry.effectId;
		}
		override public function get headjewelryEffectMagnitude():Number {
			return _headjewelry.effectMagnitude;
		}
		override public function get headjewelryPerk():String {
			return _headjewelry.perk;
		}
		override public function get headjewelryValue():Number {
			return _headjewelry.value;
		}

		//override public function get necklaces.
		override public function get necklaceName():String {
			return _necklace.name;
		}
		override public function get necklaceEffectId():Number {
			return _necklace.effectId;
		}
		override public function get necklaceEffectMagnitude():Number {
			return _necklace.effectMagnitude;
		}
		override public function get necklacePerk():String {
			return _necklace.perk;
		}
		override public function get necklaceValue():Number {
			return _necklace.value;
		}

		//override public function get jewelries.
		override public function get jewelryName():String {
			return _jewelry.name;
		}
		override public function get jewelryEffectId():Number {
			return _jewelry.effectId;
		}
		override public function get jewelryEffectMagnitude():Number {
			return _jewelry.effectMagnitude;
		}
		override public function get jewelryPerk():String {
			return _jewelry.perk;
		}
		override public function get jewelryValue():Number {
			return _jewelry.value;
		}
		override public function get jewelryName2():String {
			return _jewelry2.name;
		}
		override public function get jewelryEffectId2():Number {
			return _jewelry2.effectId;
		}
		override public function get jewelryEffectMagnitude2():Number {
			return _jewelry2.effectMagnitude;
		}
		override public function get jewelryPerk2():String {
			return _jewelry2.perk;
		}
		override public function get jewelryValue2():Number {
			return _jewelry2.value;
		}
		override public function get jewelryName3():String {
			return _jewelry3.name;
		}
		override public function get jewelryEffectId3():Number {
			return _jewelry3.effectId;
		}
		override public function get jewelryEffectMagnitude3():Number {
			return _jewelry3.effectMagnitude;
		}
		override public function get jewelryPerk3():String {
			return _jewelry3.perk;
		}
		override public function get jewelryValue3():Number {
			return _jewelry3.value;
		}
		override public function get jewelryName4():String {
			return _jewelry4.name;
		}
		override public function get jewelryEffectId4():Number {
			return _jewelry4.effectId;
		}
		override public function get jewelryEffectMagnitude4():Number {
			return _jewelry4.effectMagnitude;
		}
		override public function get jewelryPerk4():String {
			return _jewelry4.perk;
		}
		override public function get jewelryValue4():Number {
			return _jewelry4.value;
		}

		//override public function get vehicle.
		override public function get vehiclesName():String {
			return _vehicle.name;
		}
		override public function get vehiclesEffectId():Number {
			return _vehicle.effectId;
		}
		override public function get vehiclesEffectMagnitude():Number {
			return _vehicle.effectMagnitude;
		}
		override public function get vehiclesPerk():String {
			return _vehicle.perk;
		}
		override public function get vehiclesValue():Number {
			return _vehicle.value;
		}

		//Shields for Bash
		public function isShieldsForShieldBash():Boolean
		{
			return shield == game.shields.BSHIELD || shield == game.shields.BUCKLER || shield == game.shields.DRGNSHL || shield == game.shields.KITE_SH || shield == game.shields.TRASBUC || shield == game.shields.SPIL_SH || shield == game.shields.SANCTYN || shield == game.shields.SANCTYL || shield == game.shields.SANCTYD
			 || shieldPerk == "Large" || shieldPerk == "Massive" || (shield == game.shields.AETHERS && weapon == game.weapons.AETHERD && (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Gaunlets" || AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets"));
		}
		//override public function get shields
		override public function get shieldName():String {
			return _shield.name;
		}
		override public function get shieldBlock():Number {
			var block:Number = _shield.block;
			if (hasPerk(PerkLib.JobKnight)) {
				if (shieldPerk == "Massive") block += 3;
				else if (shieldPerk == "Large") block += 2;
				else block += 1;
			}
			if (shield == game.shields.AETHERS && weapon == game.weapons.AETHERD) {
				if (AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets") block += 4;
				else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Gaunlets") block += 2;
				block += 1;
			}
			if (hasPerk(PerkLib.PrestigeJobSentinel)) {
				if (shieldPerk == "Massive") block += 3;
				else if (shieldPerk == "Large") block += 2;
				else block += 1;
			}
			if (hasPerk(PerkLib.ShieldCombat)) {
				if (shieldPerk == "Massive") block += 6;
				else if (shieldPerk == "Large") block += 4;
				else block += 2;
			}
			block = Math.round(block);
			return block;
		}
		override public function get shieldPerk():String {
			return _shield.perk;
		}
		override public function get shieldValue():Number {
			return _shield.value;
		}
		public function get shield():Shield
		{
			return _shield;
		}

		//override public function get undergarment
		override public function get upperGarmentName():String {
			return _upperGarment.name;
		}
		override public function get upperGarmentPerk():String {
			return _upperGarment.perk;
		}
		override public function get upperGarmentValue():Number {
			return _upperGarment.value;
		}
		public function get upperGarment():Undergarment
		{
			return _upperGarment;
		}

		override public function get lowerGarmentName():String {
			return _lowerGarment.name;
		}
		override public function get lowerGarmentPerk():String {
			return _lowerGarment.perk;
		}
		override public function get lowerGarmentValue():Number {
			return _lowerGarment.value;
		}
		public function get lowerGarment():Undergarment
		{
			return _lowerGarment;
		}

		public function get armor():Armor
		{
			return _armor;
		}

		public function setArmor(newArmor:Armor):Armor {
			//Returns the old armor, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldArmor:Armor = _armor.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newArmor == null) {
				CoC_Settings.error(short + ".armor is set to null");
				newArmor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			_armor = newArmor.playerEquip(); //The armor can also choose to equip something else - useful for Ceraph's trap armor
			return oldArmor;
		}

		/*
		public function set armor(value:Armor):void
		{
			if (value == null){
				CoC_Settings.error(short+".armor is set to null");
				value = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setArmorHiddenField(value:Armor):void
		{
			this._armor = value;
		}

		public function get weapon():Weapon
		{
			return _weapon;
		}

		public function setWeapon(newWeapon:Weapon):Weapon {
			//Returns the old weapon, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeapon:Weapon = _weapon.playerRemove(); //The weapon is responsible for removing any bonuses, perks, etc.
			if (newWeapon == null) {
				CoC_Settings.error(short + ".weapon (melee) is set to null");
				newWeapon = WeaponLib.FISTS;
			}
			_weapon = newWeapon.playerEquip(); //The weapon can also choose to equip something else
			return oldWeapon;
		}

		/*
		public function set weapon(value:Weapon):void
		{
			if (value == null){
				CoC_Settings.error(short+".weapon is set to null");
				value = WeaponLib.FISTS;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setWeaponHiddenField(value:Weapon):void
		{
			this._weapon = value;
		}

		//Range Weapon, added by Ormael
		public function get weaponRange():WeaponRange
		{
			return _weaponRange;
		}

		public function setWeaponRange(newWeaponRange:WeaponRange):WeaponRange {
			//Returns the old shield, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeaponRange:WeaponRange = _weaponRange.playerRemove();
			if (newWeaponRange == null) {
				CoC_Settings.error(short + ".weapon (range) is set to null");
				newWeaponRange = WeaponRangeLib.NOTHING;
			}
			_weaponRange = newWeaponRange.playerEquip();
			return oldWeaponRange;
		}

		// in case you don't want to call the value.equip
		public function setWeaponRangeHiddenField(value:WeaponRange):void
		{
			this._weaponRange = value;
		}

		//Flying Swords, added by Ormael
		public function get weaponFlyingSwords():FlyingSwords
		{
			return _weaponFlyingSwords;
		}

		public function setWeaponFlyingSwords(newWeaponFlyingSwords:FlyingSwords):FlyingSwords {
			//Returns the old flying Swords, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeaponFlyingSwords:FlyingSwords = _weaponFlyingSwords.playerRemove();
			if (newWeaponFlyingSwords == null) {
				CoC_Settings.error(short + ".weapon (flying swords) is set to null");
				newWeaponFlyingSwords = FlyingSwordsLib.NOTHING;
			}
			_weaponFlyingSwords = newWeaponFlyingSwords.playerEquip();
			return oldWeaponFlyingSwords;
		}

		// in case you don't want to call the value.equip
		public function setWeaponFlyingSwordsHiddenField(value:FlyingSwords):void
		{
			this._weaponFlyingSwords = value;
		}

		//Misc Jewelry, added by Ormael
		public function get miscJewelry():MiscJewelry
		{
			return _miscjewelry;
		}

		public function setMiscJewelry(newMiscJewelry:MiscJewelry):MiscJewelry {
			//Returns the old misc jewelery, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldMiscJewelry:MiscJewelry = _miscjewelry.playerRemove();
			if (newMiscJewelry == null) {
				CoC_Settings.error(short + ".miscjewelry is set to null");
				newMiscJewelry = MiscJewelryLib.NOTHING;
			}
			_miscjewelry = newMiscJewelry.playerEquip(); //The head jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldMiscJewelry;
		}
		// in case you don't want to call the value.equip
		public function setMiscJewelryHiddenField(value:MiscJewelry):void
		{
			this._miscjewelry = value;
		}

		public function get miscJewelry2():MiscJewelry
		{
			return _miscjewelry2;
		}

		public function setMiscJewelry2(newMiscJewelry:MiscJewelry):MiscJewelry {
			//Returns the old misc jewelery, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldMiscJewelry:MiscJewelry = _miscjewelry2.playerRemove();
			if (newMiscJewelry == null) {
				CoC_Settings.error(short + ".miscjewelry2 is set to null");
				newMiscJewelry = MiscJewelryLib.NOTHING;
			}
			_miscjewelry2 = newMiscJewelry.playerEquip(); //The head jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldMiscJewelry;
		}
		// in case you don't want to call the value.equip
		public function setMiscJewelryHiddenField2(value:MiscJewelry):void
		{
			this._miscjewelry2 = value;
		}

		//Head Jewelry, added by Ormael
		public function get headJewelry():HeadJewelry
		{
			return _headjewelry;
		}

		public function setHeadJewelry(newHeadJewelry:HeadJewelry):HeadJewelry {
			//Returns the old head jewelery, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldHeadJewelry:HeadJewelry = _headjewelry.playerRemove();
			if (newHeadJewelry == null) {
				CoC_Settings.error(short + ".headjewelry is set to null");
				newHeadJewelry = HeadJewelryLib.NOTHING;
			}
			_headjewelry = newHeadJewelry.playerEquip(); //The head jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldHeadJewelry;
		}
		// in case you don't want to call the value.equip
		public function setHeadJewelryHiddenField(value:HeadJewelry):void
		{
			this._headjewelry = value;
		}

		//Necklace, added by Ormael
		public function get necklace():Necklace
		{
			return _necklace;
		}

		public function setNecklace(newNecklace:Necklace):Necklace {
			//Returns the old necklace, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldNecklace:Necklace = _necklace.playerRemove();
			if (newNecklace == null) {
				CoC_Settings.error(short + ".necklace is set to null");
				newNecklace = NecklaceLib.NOTHING;
			}
			_necklace = newNecklace.playerEquip(); //The necklace can also choose to equip something else - useful for Ceraph's trap armor
			return oldNecklace;
		}
		// in case you don't want to call the value.equip
		public function setNecklaceHiddenField(value:Necklace):void
		{
			this._necklace = value;
		}

		//Jewelry, added by Kitteh6660
		public function get jewelry():Jewelry
		{
			return _jewelry;
		}

		public function setJewelry(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField(value:Jewelry):void
		{
			this._jewelry = value;
		}

		public function get jewelry2():Jewelry
		{
			return _jewelry2;
		}

		public function setJewelry2(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry2.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry2 is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry2 = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField2(value:Jewelry):void
		{
			this._jewelry2 = value;
		}

		public function get jewelry3():Jewelry
		{
			return _jewelry3;
		}

		public function setJewelry3(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry3.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry2 is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry3 = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField3(value:Jewelry):void
		{
			this._jewelry3 = value;
		}

		public function get jewelry4():Jewelry
		{
			return _jewelry4;
		}

		public function setJewelry4(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry4.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry2 is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry4 = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField4(value:Jewelry):void
		{
			this._jewelry4 = value;
		}

		public function setShield(newShield:Shield):Shield {
			//Returns the old shield, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldShield:Shield = _shield.playerRemove(); //The shield is responsible for removing any bonuses, perks, etc.
			if (newShield == null) {
				CoC_Settings.error(short + ".shield is set to null");
				newShield = ShieldLib.NOTHING;
			}
			_shield = newShield.playerEquip(); //The shield can also choose to equip something else.
			return oldShield;
		}

		// in case you don't want to call the value.equip
		public function setShieldHiddenField(value:Shield):void
		{
			this._shield = value;
		}

		public function setUndergarment(newUndergarment:Undergarment, typeOverride:int = -1):Undergarment {
			//Returns the old undergarment, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldUndergarment:Undergarment = UndergarmentLib.NOTHING;
			if (newUndergarment.type == UndergarmentLib.TYPE_UPPERWEAR || typeOverride == 0) {
				oldUndergarment = _upperGarment.playerRemove(); //The undergarment is responsible for removing any bonuses, perks, etc.
				if (newUndergarment == null) {
					CoC_Settings.error(short + ".upperGarment is set to null");
					newUndergarment = UndergarmentLib.NOTHING;
				}
				_upperGarment = newUndergarment.playerEquip(); //The undergarment can also choose to equip something else.
			}
			else if (newUndergarment.type == UndergarmentLib.TYPE_LOWERWEAR || typeOverride == 1) {
				oldUndergarment = _lowerGarment.playerRemove(); //The undergarment is responsible for removing any bonuses, perks, etc.
				if (newUndergarment == null) {
					CoC_Settings.error(short + ".lowerGarment is set to null");
					newUndergarment = UndergarmentLib.NOTHING;
				}
				_lowerGarment = newUndergarment.playerEquip(); //The undergarment can also choose to equip something else.
			}
			return oldUndergarment;
		}

		// in case you don't want to call the value.equip
		public function setUndergarmentHiddenField(value:Undergarment, type:int):void
		{
			if (type == UndergarmentLib.TYPE_UPPERWEAR) this._upperGarment = value;
			else this._lowerGarment = value;
		}

		//Vehicles, added by Ormael
		public function get vehicles():Vehicles
		{
			return _vehicle;
		}

		public function setVehicle(newVehicle:Vehicles):Vehicles {
			//Returns the old vehicle, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldVehicle:Vehicles = _vehicle.playerRemove();
			if (newVehicle == null) {
				CoC_Settings.error(short + ".vehicle is set to null");
				newVehicle = VehiclesLib.NOTHING;
			}
			_vehicle = newVehicle.playerEquip(); //The vehicle can also choose to equip something else
			return oldVehicle;
		}
		// in case you don't want to call the value.equip
		public function setVehicleHiddenField(value:Vehicles):void
		{
			this._vehicle = value;
		}

		// Potions
		/**
		 * Array of objects { type: PotionType, count: Number }
		 */
		public var potions:Array = [];
		public function numberOfPotions(pt: PotionType): Number {
			for (var i:int = 0; i < potions.length; i++){
				if (potions[i].type == pt) {
					return potions[i].count;
				}
			}
			return 0;
		}
		public function setNumberOfPotions(pt: PotionType, count: Number): void {
			for (var i:int = 0; i < potions.length; i++) {
				if (potions[i].type == pt) {
					if (count <= 0) { // remove the potion
						potions.splice(i, 1);
					} else {
						potions[i].count = count;
					}
					return;
				}
			}
			// did not find a potion entry, create new
			if (count > 0) {
				potions.push( { type: pt, count: count });
			}
		}
		public function changeNumberOfPotions(pt: PotionType, change: Number): void {
			setNumberOfPotions(pt, numberOfPotions(pt) + change);
		}

		public override function lustPercent():Number {
			var lust:Number = 100;
			var minLustCap:Number = 25;

			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//ADDITIVE REDUCTIONS
			//THESE ARE FLAT BONUSES WITH LITTLE TO NO DOWNSIDE
			//TOTAL IS LIMITED TO 75%!
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Corrupted Libido reduces lust gain by 10%!
			if(hasPerk(PerkLib.CorruptedLibido)) lust -= 10;
			//Acclimation reduces by 15%
			if(hasPerk(PerkLib.Acclimation)) lust -= 15;
			//Purity blessing reduces lust gain
			if(hasPerk(PerkLib.PurityBlessing)) lust -= 5;
			//Resistance = 10%
			if(hasPerk(PerkLib.ResistanceI)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceII)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceIII)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceIV)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceV)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceVI)) lust -= 5;
			if(hasPerk(PerkLib.PewWarmer)) lust -= 5;
			if(hasPerk(PerkLib.Acolyte)) lust -= 5;
			if(hasPerk(PerkLib.Priest)) lust -= 5;
			if(hasPerk(PerkLib.Pastor)) lust -= 5;
			if(hasPerk(PerkLib.Saint)) lust -= 5;
			if(hasPerk(PerkLib.Cardinal)) lust -= 5;
			if(hasPerk(PerkLib.Pope)) lust -= 5;
			if(hasPerk(MutationsLib.LactaBovinaOvariesPrimitive)) lust -= 5;
			if(hasPerk(MutationsLib.MinotaurTesticlesPrimitive)) lust -= 5;
			if((hasPerk(PerkLib.UnicornBlessing) && cor <= 20) || (hasPerk(PerkLib.BicornBlessing) && cor >= 80)) lust -= 10;
			if(hasPerk(PerkLib.ChiReflowLust)) lust -= UmasShop.NEEDLEWORK_LUST_LUST_RESIST;
			if(jewelryEffectId == JewelryLib.MODIFIER_LUST_R) lust -= jewelryEffectMagnitude;
			if(jewelryEffectId2 == JewelryLib.MODIFIER_LUST_R) lust -= jewelryEffectMagnitude2;
			if(jewelryEffectId3 == JewelryLib.MODIFIER_LUST_R) lust -= jewelryEffectMagnitude3;
			if(jewelryEffectId4 == JewelryLib.MODIFIER_LUST_R) lust -= jewelryEffectMagnitude4;
			if(headjewelryEffectId == HeadJewelryLib.MODIFIER_LUST_R) lust -= headjewelryEffectMagnitude;
			if(necklaceEffectId == NecklaceLib.MODIFIER_LUST_R) lust -= necklaceEffectMagnitude;
			if(jewelryEffectId == JewelryLib.MODIFIER_LUST_R && jewelryEffectId2 == JewelryLib.MODIFIER_LUST_R && jewelryEffectId3 == JewelryLib.MODIFIER_LUST_R && jewelryEffectId4 == JewelryLib.MODIFIER_LUST_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_LUST_R && necklaceEffectId == NecklaceLib.MODIFIER_LUST_R) lust -= 15;
			if(lust < minLustCap) lust = minLustCap;
			if(statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
				if(lust >= 80) lust = 100;
				else lust += 20;
			}
			lust += Math.round(perkv1(PerkLib.PentUp)/2);
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//MULTIPLICATIVE REDUCTIONS
			//THESE PERKS ALSO RAISE MINIMUM LUST OR HAVE OTHER
			//DRAWBACKS TO JUSTIFY IT.
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Bimbo body slows lust gains!
			if((hasStatusEffect(StatusEffects.BimboChampagne) || hasPerk(PerkLib.BimboBody)) && lust > 0) lust *= .75;
			if(hasPerk(PerkLib.BroBody) && lust > 0) lust *= .75;
			if(hasPerk(PerkLib.FutaForm) && lust > 0) lust *= .75;
			//Omnibus' Gift reduces lust gain by 15%
			if(hasPerk(PerkLib.OmnibusGift)) lust *= .85;
			//Fera Blessing reduces lust gain by 15%
			if(hasStatusEffect(StatusEffects.BlessingOfDivineFera)) lust *= .85;
			//Luststick reduces lust gain by 10% to match increased min lust
			if(hasPerk(PerkLib.LuststickAdapted)) lust *= 0.9;
			if (hasPerk(PerkLib.PureAndLoving)) lust *= 0.95;
			//Berseking reduces lust gains by 10%
			if (hasStatusEffect(StatusEffects.Berzerking)) lust *= 0.9;
			if (hasStatusEffect(StatusEffects.Overlimit)) lust *= 0.9;
			if (TyrantiaFollower.TyrantiaTrainingSessions >= 25 && lust100 >= 50) {
				if (lust100 >= 100) lust *= 0.3; 
				else if (lust100 >= 51) lust *= (1 - ((lust100 - 30) * 0.01));
				else lust *= 0.8;
			}
			//Items
			if (jewelryEffectId == JewelryLib.PURITY) lust *= 1 - (jewelryEffectMagnitude / 100);
			if (armor == game.armors.DBARMOR) lust *= 0.9;
			if (weapon == game.weapons.HNTCANE) lust *= 0.75;
			if ((weapon == game.weapons.PURITAS) || (weapon == game.weapons.ASCENSU)) lust *= 0.9;
			if (vehiclesName == "Giant Slayer Mech") lust *= 0.25;
			// Lust mods from Uma's content -- Given the short duration and the gem cost, I think them being multiplicative is justified.
			// Changing them to an additive bonus should be pretty simple (check the static values in UmasShop.as)
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac)
			{
				if (sac.value1 == UmasShop.MASSAGE_RELIEF || sac.value1 == UmasShop.MASSAGE_LUST)
				{
					lust *= sac.value2;
				}
			}
			if(statusEffectv1(StatusEffects.Maleficium) > 0) {
				if (hasPerk(MutationsLib.ObsidianHeartEvolved)) {
					if (lust >= 70) lust = 100;
					else lust += 30;
				}
				else {
					if (lust >= 50) lust = 100;
					else lust += 50;
				}
			}
			if (hasStatusEffect(StatusEffects.Aegis)) lust *= 0.5;
			lust = Math.round(lust);
			if (hasStatusEffect(StatusEffects.Lustzerking) && !hasPerk(PerkLib.ColdLust)) lust = 100;
			if (hasStatusEffect(StatusEffects.BlazingBattleSpirit)) lust = 0;
			return lust;
		}

		public function effectiveLibido():Number {
			var mins:Object = getAllMinStats();
			var baseLib:Number = lib;
			var finalLib:Number = 1;
			if (finalLib < 0.05) finalLib = 0.05;
			baseLib = Math.round(baseLib * finalLib);
			if (baseLib < mins.lib) baseLib = mins.lib;
			return baseLib;
		}

		public function effectiveSensitivity():Number {
			var mins:Object = getAllMinStats();
			var baseSens:Number = sens;
			var finalSens:Number = 1;
			if (hasPerk(PerkLib.Desensitization)) finalSens -= 0.05;
			if (hasPerk(PerkLib.GreaterDesensitization)) finalSens -= 0.1;
			if (hasPerk(PerkLib.EpicDesensitization)) finalSens -= 0.15;
			if (hasPerk(PerkLib.LegendaryDesensitization)) finalSens -= 0.2;
			if (hasPerk(PerkLib.MythicalDesensitization)) finalSens -= 0.25;
			if (finalSens < 0.05) finalSens = 0.05;
			baseSens = Math.round(baseSens * finalSens);
			if (baseSens < mins.sens) baseSens = mins.sens;
			return baseSens;
		}

		public function bouncybodyDR():Number {
			var bbDR:Number = 0.25;
			if (hasPerk(MutationsLib.NaturalPunchingBag)) bbDR += 0.05;
			if (hasPerk(MutationsLib.NaturalPunchingBagPrimitive)) bbDR += 0.1;
			if (hasPerk(MutationsLib.NaturalPunchingBagEvolved)) bbDR += 0.2;
			return bbDR;
		}
		public function wrathFromHPmulti():Number {
			var WHmulti:Number = 1;
			WHmulti *= (effectiveSensitivity() * (1 / 100));
			if (hasPerk(PerkLib.FuelForTheFire)) WHmulti *= 2;
			return WHmulti;
		}
		public function wrathFromBeenPunchingBag(damage:Number):void {
			if (damage > 0) {
				var gainedWrath:Number = 0;
				gainedWrath += Math.sqrt(damage / 10);
				gainedWrath = Math.round(gainedWrath * wrathFromHPmulti());
				if (gainedWrath > 0) EngineCore.WrathChange(gainedWrath, false);
			}
		}

		public function manaShieldAbsorbMagic(damage:Number, display:Boolean = false):Number {
			return manaShieldAbsorb(damage, display, true);
		}
		public function manaShieldAbsorb(damage:Number, display:Boolean = false, magic:Boolean = false):Number{
			var magicmult:Number = 1;
			if (hasPerk(PerkLib.ImprovedManaShield)) magicmult *= 0.25;
			// if magical damage, double efficiency
			if (magic == true) magicmult *= 0.2;
			// defensive staff channeling
			if (hasPerk(PerkLib.DefensiveStaffChanneling) && (isStaffTypeWeapon() || isPartiallyStaffTypeWeapon())) magicmult *= 0.5;
			if (damage * magicmult <= mana) {
				mana -= (damage * magicmult);
				if (display) {
					if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
					else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
				}
				game.mainView.statsView.showStatDown('mana');
				dynStats("lus", 0); //Force display arrow.
				return 0;
			}
			else {
				var partial:Number = Math.round(mana / magicmult);
				damage -= partial;
				if (display) {
					if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + partial + "</font>)</b>");
					else outputText("<b>(<font color=\"#000080\">Absorbed " + partial + "</font>)</b>");
				}
				mana = 0;
				game.mainView.statsView.showStatDown('mana');
				dynStats("lus", 0); //Force display arrow.
				return damage;
			}
		}
		public function bloodShieldAbsorb(damage:Number, display:Boolean = false):Number{
			if (damage <= statusEffectv1(StatusEffects.BloodShield)) {
				addStatusValue(StatusEffects.BloodShield,1,-damage);
				if (display) {
					if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
					else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
				}
				return 0;
			}
			else {
				var partial:Number = statusEffectv1(StatusEffects.BloodShield);
				damage -= partial;
				if (display) {
					if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + partial + "</font>)</b>");
					else outputText("<b>(<font color=\"#000080\">Absorbed " + partial + "</font>)</b>");
				}
				removeStatusEffect(StatusEffects.BloodShield);
				return damage;
			}
		}
		public function difficultyDamageMultiplier(damage:Number):Number{
			var damageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) damageMultiplier *= 0.1;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) damageMultiplier *= 1.2;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) damageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) damageMultiplier *= 2;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) damageMultiplier *= 3.5;
			return damage * damageMultiplier;
		}
		public function takeDamage(damage:Number, damagetype:Number = 0, display:Boolean = false):Number{
			// Damage types:
			// 0: phys, 1: null, 2: null, 3: null
			// 4: magical, 5: fire, 6: ice
			// 7: lightning, 8: darkness, 9: poison
			// 10: wind, 11: water, 12: earth
			damage = difficultyDamageMultiplier(damage);
			//all dmg reduction effect(s)
			if (CoC.instance.monster.hasStatusEffect(StatusEffects.EnergyDrain)) damage *= 0.8;
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (henchmanBasedInvulnerabilityFrame()) henchmanBasedInvulnerabilityFrameTexts();
				else if (hasStatusEffect(StatusEffects.ManaShield)) {
					if (hasPerk(PerkLib.ArcaneShielding)) {
						if (damagetype < 4) damage = manaShieldAbsorb(damage, display);
						else damage = manaShieldAbsorbMagic(damage, display);
					}
					else damage = manaShieldAbsorb(damage, display);
				}
				else if (damage > 0 && hasStatusEffect(StatusEffects.BloodShield)) {
					damage = bloodShieldAbsorb(damage, display);
				}
				if (damage > 0) {
					switch (damagetype) {
						case 0: // physical
							damage = reducePhysDamage(damage);
							break;
						case 1: // physical
							damage = reducePhysDamage(damage);
							break;
						case 2: // physical
							damage = reducePhysDamage(damage);
							break;
						case 3: // physical
							damage = reducePhysDamage(damage);
							break;
						case 4: // magical
							damage = reduceMagicDamage(damage);
							break;
						case 5: // fire
							if (hasPerk(PerkLib.WalpurgisIzaliaRobe)) damage = damage/4*3;
							damage = reduceFireDamage(damage);
							break;
						case 6: // ice
							damage = reduceIceDamage(damage);
							break;
						case 7: // lightning
							damage = reduceLightningDamage(damage);
							break;
						case 8: // darkness
							damage = reduceDarknessDamage(damage);
							break;
						case 9: // poison
							damage = reducePoisonDamage(damage);
							break;
						case 10: // wind
							damage = reduceWindDamage(damage);
							break;
						case 11: // water
							damage = reduceWaterDamage(damage);
							break;
						case 12: // earth
							damage = reduceEarthDamage(damage);
							break;
						case 13: // acid
							damage = reducePoisonDamage(damage);
							break;
						default:
							damage = reducePhysDamage(damage);
					}
					//Wrath
					wrathFromBeenPunchingBag(damage);
					if (hasStatusEffect(StatusEffects.BoneArmor)) damage = Math.round(damage * 0.5);
					//game.HPChange(-damage, display);
					damage = Math.round(damage);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				if (damagetype == 0 && flags[kFLAGS.YAMATA_MASOCHIST] > 1 && flags[kFLAGS.AIKO_BOSS_COMPLETE] < 1) {
					dynStats("lus", int(damage / 8));
				}
				//Prevent negatives
				if (HP < minHP()){
					HP = minHP();
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}
		public override function damagePercent():Number {
			var mult:Number = 100;
			var armorMod:Number = armorDef;
			//--BASE--
			mult -= armorMod;
			if (mult < 20) mult = 20;
			//--PERKS--
			//Take damage you masochist!
			if (hasPerk(PerkLib.Masochist) && lib >= 60) {
				mult -= 20;
				if(armorName == "Scandalous Succubus Clothing"){
					mult -= 20;
					dynStats("lus", (2 * (1 + game.player.newGamePlusMod())));
				}
				dynStats("lus", (2 * (1 + game.player.newGamePlusMod())));
			}
			if (hasPerk(MutationsLib.DraconicBonesPrimitive)) {
				mult -= 5;
			}
			if (hasPerk(MutationsLib.DraconicBonesEvolved)) {
				mult -= 5;
			}
			if (hasPerk(MutationsLib.WhaleFat)) {
				mult -= 5;
			}
			if (hasPerk(MutationsLib.WhaleFatPrimitive)) {
				mult -= 10;
			}
			if (hasPerk(MutationsLib.WhaleFatEvolved)) {
				mult -= 20;
			}
			if (hasPerk(MutationsLib.YetiFat)) {
				mult -= 5;
			}
			if (hasPerk(MutationsLib.YetiFatPrimitive)) {
				mult -= 10;
			}
			if (hasPerk(MutationsLib.YetiFatEvolved)) {
				mult -= 20;
			}
			if (hasPerk(PerkLib.FenrirSpikedCollar)) {
				mult -= 15;
			}
			if (hasPerk(PerkLib.Juggernaut) && tou >= 100 && (armorPerk == "Heavy" || _armor.name == "Drider-weave Armor")) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.ImmovableObject) && tou >= 75) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.AyoArmorProficiency) && tou >= 100 && (armorPerk == "Light Ayo" || armorPerk == "Heavy Ayo" || armorPerk == "Ultra Heavy Ayo")) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.HeavyArmorProficiency) && tou >= 75 && (armorPerk == "Heavy" || _armor.name == "Drider-weave Armor")) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.ShieldHarmony) && tou >= 100 && isShieldsForShieldBash() && shieldName != "nothing" && !hasStatusEffect(StatusEffects.Stunned)) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.KnightlySword) && isSwordTypeWeapon() && isShieldsForShieldBash()) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.NakedTruth) && spe >= 75 && lib >= 60 && armor.hasTag(ItemTags.REVEALING)) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.FluidBody) && meetUnhinderedReq()) {
				mult -= 50;
				dynStats("lus", (5 * (1 + game.player.newGamePlusMod())));
			}
			if (hasPerk(PerkLib.HaltedVitals)) {
				if (hasStatusEffect(StatusEffects.AlterBindScroll1)) mult -= 40;
				else mult -= 20;
			}
			//--STATUS AFFECTS--
			//Black cat beer = 25% reduction!
			if (statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
				mult -= 25;
			}
			if (statusEffectv1(StatusEffects.OniRampage) > 0) {
				mult -= 20;
			}
			if (statusEffectv1(StatusEffects.EarthStance) > 0) {
				mult -= 30;
			}
			if (statusEffectv1(StatusEffects.AcidDoT) > 0) {
				mult += statusEffectv2(StatusEffects.AcidDoT);
			}
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			if (hasStatusEffect(StatusEffects.TyrantState)) mult += 20;
			if (TyrantiaFollower.TyrantiaTrainingSessions >= 25 && lust100 >= 50) {
				mult -= 20;
				if (lust100 >= 51) {
					if (lust100 >= 100) mult -= 50;
					else mult -= (lust100 - 50);
				}
			}
			if (jewelryEffectId == JewelryLib.MODIFIER_PHYS_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_PHYS_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_PHYS_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_PHYS_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_PHYS_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_PHYS_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_PHYS_R && jewelryEffectId2 == JewelryLib.MODIFIER_PHYS_R && jewelryEffectId3 == JewelryLib.MODIFIER_PHYS_R && jewelryEffectId4 == JewelryLib.MODIFIER_PHYS_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_PHYS_R && necklaceEffectId == NecklaceLib.MODIFIER_PHYS_R) mult -= 9;
			//Defend = 35-95% reduction
			if (hasStatusEffect(StatusEffects.Defend)) {
				if (hasPerk(PerkLib.DefenceStance) && tou >= 80) {
					if (hasPerk(PerkLib.MasteredDefenceStance) && tou >= 120) {
						if (hasPerk(PerkLib.PerfectDefenceStance) && tou >= 160) mult -= 95;
						else mult -= 70;
					}
					else mult -= 50;
				}
				else mult -= 35;
			}
			// Uma's Massage bonuses
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac && sac.value1 == UmasShop.MASSAGE_RELAXATION) {
				mult -= 100 * sac.value2;
			}
			//Caps damage reduction at 80/99%
			if (hasStatusEffect(StatusEffects.Defend) && hasPerk(PerkLib.PerfectDefenceStance) && tou >= 160 && mult < 1) mult = 1;
			if (!hasStatusEffect(StatusEffects.Defend) && mult < 20) mult = 20;
			return mult;
		}
		public override function takePhysDamage(damage:Number, display:Boolean = false):Number{
			return takeDamage(damage, 0, display);
		}
		public function reducePhysDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.Tactician) && CoC.instance.monster.inte >= 50) {
				if (CoC.instance.monster.inte <= 100) critChanceMonster += (CoC.instance.monster.inte - 50) / 5;
				if (CoC.instance.monster.inte > 100) critChanceMonster += 10;
			}
			if (CoC.instance.monster.hasPerk(PerkLib.VitalShot) && CoC.instance.monster.inte >= 50) critChanceMonster += 10;
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply damage resistance percentage.
			damage *= damagePercent() / 100;
			return damage;
		}

		public override function damageMagicalPercent():Number {
			var mult:Number = 100;
			var armorMMod:Number = armorMDef;
			//--BASE--
			mult -= armorMMod;
			//--PERKS--
			if (hasPerk(PerkLib.NakedTruth) && spe >= 75 && lib >= 60 && armor.hasTag(ItemTags.REVEALING)) {
				mult -= 10;
			}
			if (hasPerk(MutationsLib.DraconicBonesPrimitive)) {
				mult -= 5;
			}
			if (hasPerk(MutationsLib.DraconicBonesEvolved)) {
				mult -= 5;
			}
			if (hasPerk(MutationsLib.MelkieLung)) {
				mult -= 5;
			}
			if (hasPerk(MutationsLib.MelkieLungPrimitive)) {
				mult -= 10;
			}
			if (hasPerk(MutationsLib.MelkieLungEvolved)) {
				mult -= 15;
			}
			//--STATUS AFFECTS--
			if (statusEffectv1(StatusEffects.OniRampage) > 0) {
				mult -= 20;
			}
			if (statusEffectv4(StatusEffects.ZenjiZList) == 2) {
				mult -= 10;
			}
			if (hasStatusEffect(StatusEffects.DivineShield)) {
				mult -= 40;
			}
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			if (jewelryEffectId == JewelryLib.MODIFIER_MAGIC_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_MAGIC_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_MAGIC_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_MAGIC_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_MAGIC_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_MAGIC_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_MAGIC_R && jewelryEffectId2 == JewelryLib.MODIFIER_MAGIC_R && jewelryEffectId3 == JewelryLib.MODIFIER_MAGIC_R && jewelryEffectId4 == JewelryLib.MODIFIER_MAGIC_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_MAGIC_R && necklaceEffectId == NecklaceLib.MODIFIER_MAGIC_R) mult -= 6;
			//Defend = 35-95% reduction
			if (hasStatusEffect(StatusEffects.Defend)) {
				if (hasPerk(PerkLib.DefenceStance) && tou >= 80) {
					if (hasPerk(PerkLib.MasteredDefenceStance) && tou >= 120) {
						if (hasPerk(PerkLib.PerfectDefenceStance) && tou >= 160) mult -= 95;
						else mult -= 70;
					}
					else mult -= 50;
				}
				else mult -= 35;
			}
			// Uma's Massage bonuses
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac && sac.value1 == UmasShop.MASSAGE_RELAXATION) {
				mult -= 100 * sac.value2;
			}
			//Caps damage reduction at 80/99%
			if (hasStatusEffect(StatusEffects.Defend) && hasPerk(PerkLib.PerfectDefenceStance) && tou >= 160 && mult < 1) mult = 1;
			if (!hasStatusEffect(StatusEffects.Defend) && mult < 20) mult = 20;
			return mult;
		}
		public override function takeMagicDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 4, display);
		}
		public function reduceMagicDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply magic damage resistance percentage.
			damage *= damageMagicalPercent() / 100;
			return damage;
		}

		public override function damageFirePercent():Number {
			var mult:Number = damageMagicalPercent();
			if (upperGarmentName == "HB shirt") mult -= 10;
			if (lowerGarmentName == "HB shorts") mult -= 10;
			if (hasPerk(PerkLib.FromTheFrozenWaste) || hasPerk(PerkLib.ColdAffinity)) mult += 100;
			if (hasPerk(PerkLib.FireAffinity)) mult -= 50;
			if (hasStatusEffect(StatusEffects.ShiraOfTheEastFoodBuff1) && (statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff1) > 0)) mult -= statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff1);
			if (hasStatusEffect(StatusEffects.DaoOfFire) && (statusEffectv2(StatusEffects.DaoOfFire) > 2)) mult -= 10;
			if (jewelryEffectId == JewelryLib.MODIFIER_FIRE_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_FIRE_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_FIRE_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_FIRE_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_FIRE_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_FIRE_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_FIRE_R && jewelryEffectId2 == JewelryLib.MODIFIER_FIRE_R && jewelryEffectId3 == JewelryLib.MODIFIER_FIRE_R && jewelryEffectId4 == JewelryLib.MODIFIER_FIRE_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_FIRE_R && necklaceEffectId == NecklaceLib.MODIFIER_FIRE_R) mult -= 15;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			if (hasStatusEffect(StatusEffects.WinterClaw)) {
				mult += 100;
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeFireDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 5, display);
		}
		public function reduceFireDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply fire damage resistance percentage.
			damage *= damageFirePercent() / 100;
			return damage;
		}

		public override function damageIcePercent():Number {
			var mult:Number = damageMagicalPercent();
			if (upperGarmentName == "Fur bikini top") mult -= 10;
			if (lowerGarmentName == "Fur loincloth" || lowerGarmentName == "Fur panty") mult -= 10;
			if (upperGarmentName == "HB shirt") mult -= 10;
			if (lowerGarmentName == "HB shorts") mult -= 10;
			if (necklaceName == "Blue Winter scarf" || necklaceName == "Green Winter scarf" || necklaceName == "Purple Winter scarf" || necklaceName == "Red Winter scarf" || necklaceName == "Yellow Winter scarf") mult -= 20;
			if (hasPerk(PerkLib.FromTheFrozenWaste) || hasPerk(PerkLib.ColdAffinity)) mult -= 50;
			if (hasPerk(PerkLib.IcyFlesh)) mult -= 40;
			if (hasPerk(PerkLib.FireAffinity) || hasPerk(PerkLib.AffinityIgnis)) mult += 100;
			if (jewelryEffectId == JewelryLib.MODIFIER_ICE_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_ICE_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_ICE_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_ICE_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_ICE_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_ICE_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_ICE_R && jewelryEffectId2 == JewelryLib.MODIFIER_ICE_R && jewelryEffectId3 == JewelryLib.MODIFIER_ICE_R && jewelryEffectId4 == JewelryLib.MODIFIER_ICE_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_ICE_R && necklaceEffectId == NecklaceLib.MODIFIER_ICE_R) mult -= 15;
			if (hasStatusEffect(StatusEffects.ShiraOfTheEastFoodBuff1) && (statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff1) > 0)) mult -= statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff1);
			if (hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
				if (mouseScore() >= 12 && arms.type == Arms.HINEZUMI && lowerBody == LowerBody.HINEZUMI && (jewelryName == "Infernal Mouse ring" || jewelryName2 == "Infernal Mouse ring" || jewelryName3 == "Infernal Mouse ring" || jewelryName4 == "Infernal Mouse ring")) mult += 90;
				else mult += 100;
			}
			if (hasStatusEffect(StatusEffects.DaoOfIce) && (statusEffectv2(StatusEffects.DaoOfIce) > 2)) mult -= 10;
			if (rearBody.type == RearBody.YETI_FUR) mult -= 20;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			if (hasStatusEffect(StatusEffects.AlterBindScroll3)) mult = 0;
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeIceDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 6, display);
		}
		public function reduceIceDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply ice damage resistance percentage.
			damage *= damageIcePercent() / 100;
			return damage;
		}

		public override function damageLightningPercent():Number {
			var mult:Number = damageMagicalPercent();
			if (armorName == "Goblin Technomancer clothes") mult -= 25;
			if (upperGarmentName == "Technomancer bra") mult -= 15;
			if (lowerGarmentName == "Technomancer panties") mult -= 15;
			if (upperGarmentName == "HB shirt") mult -= 10;
			if (lowerGarmentName == "HB shorts") mult -= 10;
			if (hasPerk(PerkLib.LightningAffinity)) mult -= 50;
			if (hasPerk(MutationsLib.HeartOfTheStormPrimitive)) mult -= 10;
			if (hasPerk(MutationsLib.HeartOfTheStormEvolved)) mult -= 30;
			if (hasPerk(PerkLib.AquaticAffinity) || hasPerk(PerkLib.AffinityUndine)) mult += 100;
			if (jewelryEffectId == JewelryLib.MODIFIER_LIGH_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_LIGH_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_LIGH_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_LIGH_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_LIGH_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_LIGH_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_LIGH_R && jewelryEffectId2 == JewelryLib.MODIFIER_LIGH_R && jewelryEffectId3 == JewelryLib.MODIFIER_LIGH_R && jewelryEffectId4 == JewelryLib.MODIFIER_LIGH_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_LIGH_R && necklaceEffectId == NecklaceLib.MODIFIER_LIGH_R) mult -= 15;
			if (hasStatusEffect(StatusEffects.DaoOfLightning) && (statusEffectv2(StatusEffects.DaoOfLightning) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeLightningDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 7, display);
		}
		public function reduceLightningDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply lightning damage resistance percentage.
			damage *= damageLightningPercent() / 100;
			return damage;
		}

		public override function damageDarknessPercent():Number {
			var mult:Number = damageMagicalPercent();
			if (upperGarmentName == "HB shirt") mult -= 10;
			if (lowerGarmentName == "HB shorts") mult -= 10;
			if (hasPerk(PerkLib.DarknessAffinity)) mult -= 50;
			if (jewelryEffectId == JewelryLib.MODIFIER_DARK_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_DARK_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_DARK_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_DARK_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_DARK_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_DARK_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_DARK_R && jewelryEffectId2 == JewelryLib.MODIFIER_DARK_R && jewelryEffectId3 == JewelryLib.MODIFIER_DARK_R && jewelryEffectId4 == JewelryLib.MODIFIER_DARK_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_DARK_R && necklaceEffectId == NecklaceLib.MODIFIER_DARK_R) mult -= 15;
			if (hasStatusEffect(StatusEffects.DaoOfDarkness) && (statusEffectv2(StatusEffects.DaoOfDarkness) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeDarknessDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 8, display);
		}
		public function reduceDarknessDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply darkness damage resistance percentage.
			damage *= damageDarknessPercent() / 100;
			return damage;
		}

		public override function damagePoisonPercent():Number {
			var mult:Number = damageMagicalPercent();
			if (hasPerk(MutationsLib.VenomGlandsPrimitive)) mult -= 5;
			if (hasPerk(MutationsLib.VenomGlandsEvolved)) mult -= 10;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R && jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R && necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= 15;
			if (hasStatusEffect(StatusEffects.DaoOfPoison) && (statusEffectv2(StatusEffects.DaoOfPoison) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			if (hasStatusEffect(StatusEffects.AlterBindScroll3)) mult = 0;
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takePoisonDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 9, display);
		}
		public function reducePoisonDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply poison damage resistance percentage.
			damage *= damagePoisonPercent() / 100;
			return damage;
		}

		public override function damageWindPercent():Number {
			var mult:Number = damageMagicalPercent();/*
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R && jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R && necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= 15;*/
			if (hasStatusEffect(StatusEffects.DaoOfWind) && (statusEffectv2(StatusEffects.DaoOfWind) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeWindDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 10, display);
		}
		public function reduceWindDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply poison damage resistance percentage.
			damage *= damageWindPercent() / 100;
			return damage;
		}

		public override function damageWaterPercent():Number {
			var mult:Number = damageMagicalPercent();/*
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R && jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R && necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= 15;*/
			if (hasStatusEffect(StatusEffects.DaoOfWater) && (statusEffectv2(StatusEffects.DaoOfWater) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeWaterDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 11, display);
		}
		public function reduceWaterDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply poison damage resistance percentage.
			damage *= damagePoisonPercent() / 100;
			return damage;
		}

		public override function damageEarthPercent():Number {
			var mult:Number = damageMagicalPercent();/*
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R && jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R && necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= 15;*/
			if (hasStatusEffect(StatusEffects.DaoOfEarth) && (statusEffectv2(StatusEffects.DaoOfEarth) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeEarthDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 12, display);
		}
		public function reduceEarthDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply poison damage resistance percentage.
			damage *= damagePoisonPercent() / 100;
			return damage;
		}

		public override function damageAcidPercent():Number {
			var mult:Number = damageMagicalPercent();/*
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R && jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R && necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= 15;*/
			if (hasStatusEffect(StatusEffects.DaoOfAcid) && (statusEffectv2(StatusEffects.DaoOfAcid) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeAcidDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 13, display);
		}
		public function reduceAcidDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply poison damage resistance percentage.
			damage *= damagePoisonPercent() / 100;
			return damage;
		}

		public function eyesOfTheHunterAdeptBoost():Boolean {
			return CoC.instance.monster.hasPerk(PerkLib.EnemyHugeType) || CoC.instance.monster.hasPerk(PerkLib.EnemyGroupType) || CoC.instance.monster.hasPerk(PerkLib.EnemyBeastOrAnimalMorphType) || CoC.instance.monster.hasPerk(PerkLib.EnemyConstructType) || CoC.instance.monster.hasPerk(PerkLib.EnemyFeralType) || CoC.instance.monster.hasPerk(PerkLib.EnemyGooType)
			|| CoC.instance.monster.hasPerk(PerkLib.EnemyTrueDemon) || CoC.instance.monster.hasPerk(PerkLib.EnemyEliteType);
		}
		public function eyesOfTheHunterExpertBoost():Boolean {
			return CoC.instance.monster.hasPerk(PerkLib.EnemyGigantType) || CoC.instance.monster.hasPerk(PerkLib.EnemyLargeGroupType) || CoC.instance.monster.hasPerk(PerkLib.EnemyElementalType) || CoC.instance.monster.hasPerk(PerkLib.EnemyGhostType) || CoC.instance.monster.hasPerk(PerkLib.EnemyPlantType) || CoC.instance.monster.hasPerk(PerkLib.EnemyChampionType)
			|| CoC.instance.monster.hasPerk(PerkLib.FireVulnerability) || CoC.instance.monster.hasPerk(PerkLib.IceVulnerability) || CoC.instance.monster.hasPerk(PerkLib.LightningVulnerability) || CoC.instance.monster.hasPerk(PerkLib.DarknessVulnerability);
		}
		public function eyesOfTheHunterMasterBoost():Boolean {
			return CoC.instance.monster.hasPerk(PerkLib.EnemyColossalType) || CoC.instance.monster.hasPerk(PerkLib.EnemyFleshConstructType) || CoC.instance.monster.hasPerk(PerkLib.FireNature) || CoC.instance.monster.hasPerk(PerkLib.IceNature) || CoC.instance.monster.hasPerk(PerkLib.LightningNature) || CoC.instance.monster.hasPerk(PerkLib.DarknessNature);
		}
		public function eyesOfTheHunterGrandMasterBoost():Boolean {
			return CoC.instance.monster.hasPerk(PerkLib.EnemyGodType) || CoC.instance.monster.hasPerk(PerkLib.EnemyBossType);
		}

		public function henchmanBasedInvulnerabilityFrame():Boolean {
			if (statusEffectv3(StatusEffects.CombatFollowerZenji) == 1 || statusEffectv3(StatusEffects.CombatFollowerZenji) == 3) return true;
			else return false;
		}
		public function henchmanBasedInvulnerabilityFrameTexts():void {
			if (statusEffectv3(StatusEffects.CombatFollowerZenji) == 1 || statusEffectv3(StatusEffects.CombatFollowerZenji) == 3) {
				outputText(" Zenji grits his teeth as he shields you, enduring several strikes from your opponent.");
				addStatusValue(StatusEffects.CombatFollowerZenji, 3, 1);
			}
		}

		/**
		 * @return 0: did not avoid; 1-3: avoid with varying difference between
		 * speeds (1: narrowly avoid, 3: deftly avoid)
		 */
		public function speedDodge(monster:Monster):int{
			var diff:Number = spe - monster.spe;
			var rnd:int = int(Math.random() * ((diff / 4) + 80));
			if (rnd<=80) return 0;
			else if (diff<8) return 1;
			else if (diff<20) return 2;
			else return 3;
		}

		//Body Type
		public function bodyType():String
		{
			var desc:String = "";
			//OLD STUFF
			//SUPAH THIN
			if (thickness < 10)
			{
				//SUPAH BUFF
				if (tone > 150)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 100)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 90)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 75)
					desc += "an incredibly thin, well-muscled frame";
				else if (tone > 50)
					desc += "a very thin body that has a good bit of muscle definition";
				else if (tone > 25)
					desc += "a lithe body and only a little bit of muscle definition";
				else
					desc += "a waif-thin body, and soft, forgiving flesh";
			}
			//Pretty thin
			else if (thickness < 25)
			{
				if (tone > 150)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 100)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 90)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 75)
					desc += "a narrow frame that shows off your muscles";
				else if (tone > 50)
					desc += "a somewhat lithe body and a fair amount of definition";
				else if (tone > 25)
					desc += "a narrow, soft body that still manages to show off a few muscles";
				else
					desc += "a thin, soft body";
			}
			//Somewhat thin
			else if (thickness < 40)
			{
				if (tone > 150)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 100)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 90)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 75)
					desc += "a thinner-than-average frame and great muscle definition";
				else if (tone > 50)
					desc += "a somewhat narrow body and a decent amount of visible muscle";
				else if (tone > 25)
					desc += "a moderately thin body, soft curves, and only a little bit of muscle";
				else
					desc += "a fairly thin form and soft, cuddle-able flesh";
			}
			//average
			else if (thickness < 60)
			{
				if (tone > 150)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 100)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 90)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 75)
					desc += "an average-sized frame and great musculature";
				else if (tone > 50)
					desc += "a normal waistline and decently visible muscles";
				else if (tone > 25)
					desc += "an average body and soft, unremarkable flesh";
				else
					desc += "an average frame and soft, untoned flesh with a tendency for jiggle";
			}
			else if (thickness < 75)
			{
				if (tone > 150)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 100)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 90)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 75)
					desc += "a body that's a little bit wide and has some highly-visible muscles";
				else if (tone > 50)
					desc += "a solid build that displays a decent amount of muscle";
				else if (tone > 25)
					desc += "a slightly wide frame that displays your curves and has hints of muscle underneath";
				else
					desc += "a soft, plush body with plenty of jiggle";
			}
			else if (thickness < 90)
			{
				if (tone > 150)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 100)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 90)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 75)
					desc += "a burly form and plenty of muscle definition";
				else if (tone > 50)
					desc += "a solid, thick frame and a decent amount of muscles";
				else if (tone > 25)
					desc += "a wide-set body, some soft, forgiving flesh, and a hint of muscle underneath it";
				else
				{
					desc += "a wide, cushiony body";
					if (gender >= 2 || biggestTitSize() > 3 || hips.type > 7 || butt.type > 7)
						desc += " and plenty of jiggle on your curves";
				}
			}
			//Chunky monkey
			else
			{
				if (tone > 150)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 100)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 90)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 75)
					desc += "a very wide body and enough muscle to make you look like a tank";
				else if (tone > 50)
					desc += "an extremely substantial frame packing a decent amount of muscle";
				else if (tone > 25)
				{
					desc += "a very wide body";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += ", lots of curvy jiggles,";
					desc += " and hints of muscle underneath";
				}
				else
				{
					desc += "a thick";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += ", voluptuous";
					desc += " body and plush, ";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += " jiggly curves";
					else
						desc += " soft flesh";
				}
			}
			return desc;
		}

		//Camp Development Stage
		public function campDevelopmentStage():String {
			var descC:String;
			if (hasStatusEffect(StatusEffects.AdvancingCamp)) {
				/*if (statusEffectv1(StatusEffects.AdvancingCamp) ) descC = "city";
				else if (statusEffectv1(StatusEffects.AdvancingCamp) =) descC = "town";
				else if (statusEffectv1(StatusEffects.AdvancingCamp) ==) descC = "village";
				else */descC = "hamlet";
			}
			else descC = "camp";
			return descC;
		}

		public function race(generalType:Boolean = false):String {
			var race:String = "human";
			var ScoreList:Array = [
				{name: 'human', score: 1, minscore: 1},
				{name: 'alicorn', score: alicornScore(), minscore: 8},
				{name: 'alicornkin', score: alicornkinScore(), minscore: 12},
				{name: 'alraune', score: alrauneScore(), minscore: 13},
				{name: 'atlach nacha', score: atlachNachaScore(), minscore: 10},
				{name: 'angel', score: angelScore(), minscore: 11},
				{name: 'avian', score: avianScore(), minscore: 9},
				{name: 'bunny', score: bunnyScore(), minscore: 10},
				{name: 'banshee', score: bansheeScore(), minscore: 4},
				{name: 'bat', score: batScore(), minscore: 10},
				{name: 'bear and panda', score: bearpandaScore(), minscore: 10},
				{name: 'bee', score: beeScore(), minscore: 17},
				{name: 'cancer', score: cancerScore(), minscore: 13},
				{name: 'cat', score: catScore(), minscore: 8},
				{name: 'cave wyrm', score: cavewyrmScore(), minscore: 10},
				{name: 'centaur', score: centaurScore(), minscore: 8},
				{name: 'centipede', score: centipedeScore(), minscore: 8},
				{name: 'cheshire', score: cheshireScore(), minscore: 11},
				{name: 'couatl', score: couatlScore(), minscore: 11},
				{name: 'cow', score: cowScore(), minscore: 10},
				{name: 'cyclop', score: cyclopScore(), minscore: 12},
				{name: 'darkgoo', score: darkgooScore(), minscore: 13},
				{name: 'deer', score: deerScore(), minscore: 4},
				{name: 'demon', score: demonScore(), minscore: 11},
				{name: 'devil', score: devilkinScore(), minscore: 11},
				{name: 'displacer beast', score: displacerbeastScore(), minscore: 14},
				{name: 'dog', score: dogScore(), minscore: 4},
				{name: 'dragon', score: dragonScore(), minscore: 16},
				{name: 'dragonne', score: dragonneScore(), minscore: 6},
				{name: 'easter bunny', score: easterbunnyScore(), minscore: 12},
				{name: 'echidna', score: echidnaScore(), minscore: 4},
				{name: 'elemental fusion', score: fusedElementalScore(), minscore: 5},
				{name: 'elf', score: elfScore(), minscore: 11},
				{name: 'fairy', score: fairyScore(), minscore: 23},
				{name: 'female mindbreaker', score: femaleMindbreakerScore(), minscore: 20},
				{name: 'ferret', score: ferretScore(), minscore: 4},
				{name: 'fire snail', score: firesnailScore(), minscore: 15},
				{name: 'fox', score: foxScore(), minscore: 7},
				{name: 'frost wyrm', score: frostWyrmScore(), minscore: 18},
				{name: 'gargoyle', score: gargoyleScore(), minscore: 22},
				{name: 'gazer', score: gazerScore(), minscore: 14},
				{name: 'goblin', score: goblinScore(), minscore: 10},
				{name: 'goo', score: gooScore(), minscore: 11},
				{name: 'gorgon', score: gorgonScore(), minscore: 11},
				{name: 'gremlin', score: gremlinScore(), minscore: 15},
				{name: 'gryphon', score: gryphonScore(), minscore: 4},
				{name: 'harpy', score: harpyScore(), minscore: 8},
				{name: 'hellcat', score: hellcatScore(), minscore: 10},
				{name: 'horse', score: horseScore(), minscore: 7},
				{name: 'hydra', score: hydraScore(), minscore: 14},
				{name: 'jabberwocky', score: jabberwockyScore(), minscore: 10},
				{name: 'jiangshi', score: jiangshiScore(), minscore: 20},
				{name: 'kamaitachi', score: kamaitachiScore(), minscore: 14},
				{name: 'kangaroo', score: kangaScore(), minscore: 4},
				{name: 'kitsune', score: kitsuneScore(), minscore: 9},
				{name: 'kitshoo', score: kitshooScore(), minscore: 6},
				{name: 'lizard', score: lizardScore(), minscore: 8},
				{name: 'male mindbreaker', score: maleMindbreakerScore(), minscore: 20},
				{name: 'magmagoo', score: magmagooScore(), minscore: 13},
				{name: 'manticore', score: manticoreScore(), minscore: 15},
				{name: 'mantis', score: mantisScore(), minscore: 12},
				{name: 'melkie', score: melkieScore(), minscore: 18},
				{name: 'minotaur', score: minotaurScore(), minscore: 10},
				{name: 'mouse', score: mouseScore(), minscore: 8},
				{name: 'naga', score: nagaScore(), minscore: 8},
				{name: 'apophis', score: apophisScore(), minscore: 23},
				{name: 'nekomata', score: nekomataScore(), minscore: 10},
				{name: 'oni', score: oniScore(), minscore: 12},
				{name: 'oomukade', score: oomukadeScore(), minscore: 15},
				{name: 'orc', score: orcScore(), minscore: 11},
				{name: 'orca', score: orcaScore(), minscore: 14},
				{name: 'peacock', score: peacockScore(), minscore: 4},
				{name: 'phoenix', score: phoenixScore(), minscore: 10},
				{name: 'pig', score: pigScore(), minscore: 10},
				{name: 'plant', score: plantScore(), minscore: 4},
				{name: 'poltergeist', score: poltergeistScore(), minscore: 6},
				{name: 'raccoon', score: raccoonScore(), minscore: 8},
				{name: 'raiju', score: raijuScore(), minscore: 10},
				{name: 'ratatoskr', score: ratatoskrScore(), minscore: 12},
				{name: 'red panda', score: redpandaScore(), minscore: 8},
				{name: 'rhino', score: rhinoScore(), minscore: 4},
				{name: 'salamander', score: salamanderScore(), minscore: 7},
				{name: 'satyr', score: satyrScore(), minscore: 4},
				{name: 'scorpion', score: scorpionScore(), minscore: 4},
				{name: 'scylla', score: scyllaScore(), minscore: 7},
				{name: 'sea dragon', score: leviathanScore(), minscore: 20},
				{name: 'shark', score: sharkScore(), minscore: 10},
				{name: 'siren', score: sirenScore(), minscore: 10},
				{name: 'sphinx', score: sphinxScore(), minscore: 14},
				{name: 'spider', score: spiderScore(), minscore: 7},
				{name: 'thunderbird', score: thunderbirdScore(), minscore: 16},
				{name: 'troll', score: trollScore(), minscore: 10},
				{name: 'ushi-oni', score: ushionnaScore(), minscore: 11},
				{name: 'unicorn', score: unicornScore(), minscore: 8},
				{name: 'unicornkin', score: unicornkinScore(), minscore: 12},
				{name: 'vampire', score: vampireScore(), minscore: 10},
				{name: 'vouivre', score: vouivreScore(), minscore: 11},
				{name: 'wendigo', score: wendigoScore(), minscore: 10},
				{name: 'werewolf', score: werewolfScore(), minscore: 12},
				{name: 'wood elf', score: woodElfScore(), minscore: 22},
				{name: 'wolf', score: wolfScore(), minscore: 8},
				{name: 'yeti', score: yetiScore(), minscore: 14},
				{name: 'yggdrasil', score: yggdrasilScore(), minscore: 10},
				{name: 'yuki onna', score: yukiOnnaScore(), minscore: 14},
			];

			ScoreList = ScoreList.filter(function(element:Object, index:int, array:Array):Boolean {
				return element.score >= element.minscore;
			});
			ScoreList.sortOn('score', Array.NUMERIC | Array.DESCENDING);
			var TopRace:String = ScoreList[0].name;
			var TopScore:Number = ScoreList[0].score;

			//Determine race type:
			if (TopRace == "elemental fusion") {
				if (perkv1(PerkLib.ElementalBody) == 1) {
					if (perkv2(PerkLib.ElementalBody) == 1) race = "lesser sylph";
					if (perkv2(PerkLib.ElementalBody) == 2) race = "adept sylph";
					if (perkv2(PerkLib.ElementalBody) == 3) race = "greater sylph";
					if (perkv2(PerkLib.ElementalBody) == 4) race = "primordial sylph";
				}
				if (perkv1(PerkLib.ElementalBody) == 2) {
					if (perkv2(PerkLib.ElementalBody) == 1) race = "lesser gnome";
					if (perkv2(PerkLib.ElementalBody) == 2) race = "adept gnome";
					if (perkv2(PerkLib.ElementalBody) == 3) race = "greater gnome";
					if (perkv2(PerkLib.ElementalBody) == 4) race = "primordial gnome";
				}
				if (perkv1(PerkLib.ElementalBody) == 3) {
					if (perkv2(PerkLib.ElementalBody) == 1) race = "lesser ignis";
					if (perkv2(PerkLib.ElementalBody) == 2) race = "adept ignis";
					if (perkv2(PerkLib.ElementalBody) == 3) race = "greater ignis";
					if (perkv2(PerkLib.ElementalBody) == 4) race = "primordial ignis";
				}
				if (perkv1(PerkLib.ElementalBody) == 4) {
					if (perkv2(PerkLib.ElementalBody) == 1) race = "lesser undine";
					if (perkv2(PerkLib.ElementalBody) == 2) race = "adept undine";
					if (perkv2(PerkLib.ElementalBody) == 3) race = "greater undine";
					if (perkv2(PerkLib.ElementalBody) == 4) race = "primordial undine";
				}
			}
			if (TopRace == "cancer") {
				if (TopScore >= 20) {
					race = "cancer";
				}
				else {
					race = "lesser cancer";
				}
			}
			if (TopRace == "cat") {
				if (isTaur() && lowerBody == LowerBody.CAT) {
					race = "cat-taur";
				} else {
					race = "cat-morph";
				if (faceType == Face.HUMAN)
					race = "cat-" + mf("boy", "girl");
				}
			}
			if (TopRace == "nekomata") {
				if (TopScore >= 10) {
					if (tailType == 8 && tailCount >= 2 && TopScore >= 12) race = "elder nekomata";
					else race = "nekomata";
				}
			}
			if (TopRace == "cheshire") {
				if (TopScore >= 11) {
					race = "cheshire cat";
				}
			}
			if (TopRace == "hellcat") {
				if (TopScore >= 10) {
					if (TopScore >= 17) {
						race = "Kasha";
					} else {
						race = "hellcat";
					}
				}
			}
			if (TopRace == "displacer beast") {
				if (TopScore >= 14) {
					race = "displacer beast";
				}
			}
			if (TopRace == "female mindbreaker") {
				if (TopScore >= 20) {
					race = "mindbreaker";
				}
			}
			if (TopRace == "male mindbreaker") {
				if (TopScore >= 20) {
					race = "mindbreaker";
				}
			}
			if (TopRace == "sphinx") {
				if (TopScore >= 30) {
					race = "noble sphinx";
				}
				if (TopScore >= 21) {
					race = "greater sphinx";
				}
				if (TopScore >= 14) {
					race = "sphinx";
				}
			}
			if (TopRace == "centipede") {
				race = "centipede-" + mf("man", "girl");
			}
			if (TopRace == "oomukade") {
				if (TopScore >= 15) {
					if (TopScore >= 18) {
						race = "elder oomukade";
					}
					else if (TopScore >= 15) {
						race = "oomukade";
					}
				}
			}
			if (TopRace == "lizard") {
				if (isTaur()) race = "lizan-taur";
				else race = "lizan";
			}
			if (TopRace == "dragon") {
				if (TopScore >= 32) {
					if (isTaur()) race = "ancient dragon-taur";
					else {
						race = "ancient dragon";
						if (faceType == Face.HUMAN)
							race = "ancient dragon-" + mf("man", "girl");
					}
				}
				else if (TopScore >= 24) {
					if (isTaur()) race = " elder dragon-taur";
					else {
						race = "elder dragon";
						if (faceType == Face.HUMAN)
							race = "elder dragon-" + mf("man", "girl");
					}
				}
				else {
					if (isTaur()) race = "dragon-taur";
					else {
						race = "dragon";
						if (faceType == Face.HUMAN)
							race = "dragon-" + mf("man", "girl");
					}
				}
			}
			if (TopRace == "jabberwocky") {
				if (TopScore >= 10) {
					if (TopScore >= 30) {
						if (isTaur()) race = "primal jabberwocky-taur";
						else race = "primal jabberwocky";
					}
					else if (TopScore >= 25) {
						if (isTaur()) race = "greater jabberwocky-taur";
						else race = "greater jabberwocky";
					}
					else if (TopScore >= 20) {
						if (isTaur()) race = "jabberwocky-taur";
						else race = "jabberwocky";
					}
					else {
						if (isTaur()) race = "lesser jabberwocky-taur";
						else race = "lesser jabberwocky";
					}
				}
			}
			if (TopRace == "cyclop") {
				race = "cyclop";
			}
			if (TopRace == "gazer") {
				if (TopScore >= 21 && statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) race = "Eye Tyrant";
				else race = "gazer";
			}
			if (TopRace == "raccoon") {
				if (TopScore >= 4) {
					race = "raccoon-morph";
					if (balls > 0 && ballSize > 5 && TopScore >= 14) {
						race = "tanuki";
					}
				}
			}
			if (TopRace == "dog") {
				if (TopScore >= 4) {
					if (isTaur() && lowerBody == LowerBody.DOG)
						race = "dog-taur";
					else {
						race = "dog-morph";
						if (faceType == Face.HUMAN)
							race = "dog-" + mf("man", "girl");
					}
				}
			}
			if (TopRace == "wolf") {
				if (isTaur() && lowerBody == LowerBody.WOLF)
					race = "wolf-taur";
				else if (TopScore >= 21)
					race = "Fenrir";
				else if (TopScore >= 10 && hasFur() && coatColor == "glacial white")
					race = "winter wolf";
				else if (TopScore >= 8)
					race = "wolf-morph";
				else
					race = "wolf-" + mf("boy", "girl");
			}
			if (TopRace == "werewolf") {
				if (TopScore >= 12) {
					//if (werewolfScore() >= 12)
					//	race = "Werewolf";
					//else
					race = "Werewolf";
				}
			}
			if (TopRace == "fox") {
				if (TopScore >= 7 && isTaur() && lowerBody == LowerBody.FOX)
					race = "fox-taur";
				else
					race = "fox-morph";
			}
			if (TopRace == "fairy") {
				if (TopScore >= 23) {
					if (TopScore >= 29) race = "Titania";
					else if (TopScore >= 29) race = "fairy queen";
					else if (TopScore >= 26) race = "noble fairy";
					else race = "great fairy";
				}
			}
			if (TopRace == "ferret") {
				if (TopScore >= 4) {
					if (hasFur())
						race = "ferret-morph";
					else
						race = "ferret-" + mf("boy", "girl");
				}
			}
			if (TopRace == "kitsune") {
				if (tailType == 13 && tailCount >= 2 && kitsuneScore() >= 9) {
					if (TopScore >= 16 && tailCount == 9) {
						if (TopScore >= 21 && hasPerk(PerkLib.NinetailsKitsuneOfBalance)) {
							if (TopScore >= 26 && tailCount >= 9) {
								if (isTaur()) {
									race = "Inari-taur";
								} else {
									race = "Inari";
								}
							} else {
								if (isTaur()) {
									race = "nine tailed kitsune-taur of balance";
								} else {
									race = "nine tailed kitsune of balance";
								}
							}
						} else {
							if (isTaur()) {
								race = "nine tailed kitsune-taur";
							} else {
								race = "nine tailed kitsune";
							}
						}
					} else {
						if (isTaur()) {
							race = "kitsune-taur";
						} else {
							race = "kitsune";
						}
					}
				}
			}
			if (TopRace == "kitshoo") {
				if (TopScore >= 6) {
					if (isTaur()) race = "kitshoo-taur";
					else {
						race = "kitshoo";
					}
				}
			}
			if (TopRace == "troll") {
				race = "troll";
			}
			if (TopRace == "horse") {
				race = "equine-morph";
			}
			if (TopRace == "unicorn") {
				if (TopScore >= 8) {
					if (TopScore >= 27) {
						if (horns.type == Horns.UNICORN) {
							race = "true unicorn";
						} else {
							race = "true bicorn";
						}
					} else if (TopScore >= 18) {
						if (horns.type == Horns.UNICORN) {
							race = "unicorn";
						} else {
							race = "bicorn";
						}
					} else {
						if (horns.type == Horns.UNICORN) {
							race = "half unicorn";
						} else {
							race = "half bicorn";
						}
					}
				}
			}
			if (TopRace == "unicornkin") {
				if (TopScore >= 12) {
					if (horns.type == Horns.UNICORN) {
						race = "unicornkin";
					} else {
						race = "bicornkin";
					}
				}
			}
			if (TopRace == "alicorn") {
				if (TopScore >= 8) {
					if (TopScore >= 27) {
						if (horns.type == Horns.UNICORN) {
							race = "true alicorn";
						} else {
							race = "true nightmare";
						}
					} else if (TopScore >= 18) {
						if (horns.type == Horns.UNICORN) {
							race = "alicorn";
						} else {
							race = "nightmare";
						}
					} else {
						if (horns.type == Horns.UNICORN) {
							race = "half alicorn";
						} else {
							race = "half nightmare";
						}
					}
				}
			}
			if (TopRace == "alicornkin") {
				if (TopScore >= 12) {
					if (horns.type == Horns.UNICORN) {
						race = "alicornkin";
					} else {
						race = "nightmarekin";
					}
				}
			}
			if (TopRace == "centaur") {
				if (TopScore >= 8)
					race = "centaur";
			}
			//if (mutantScore() >= 5 && race == "human")
			//	race = "corrupted mutant";
			if (TopRace == "minotaur") {
				if (TopScore >= 15) {
					race = "Minotaur";
				}
				else {
					race = "bull-";
					race += mf("morph", "boy");
				}
			}
			if (TopRace == "cow") {
				if (TopScore >= 15) {
					race = "Lacta Bovine";
				}
				else {
					race = "cow-";
					race += mf("morph", "girl");
				}
			}
			if (TopRace == "bee") {
				race = "bee-morph";
			}
			if (TopRace == "goblin") {
				if (TopScore >= 10)
					race = "goblin";
			}
			if (TopRace == "gremlin") {
				if (TopScore >= 15) {
					if (TopScore >= 18) race = "high gremlin";
					else race = "gremlin";
				}
			}
			//if (humanScore() >= 5 && race == "corrupted mutant")
			//	race = "somewhat human mutant";
			if (TopRace == "demon") {
				if (TopScore >= 16 && hasPerk(PerkLib.Soulless)) {
					if (isTaur()) race += mf("incubi-taur", "succubi-taur");
					else race += mf("incubus", "succubus");
				} else if (TopScore >= 11) {
					if (isTaur()) race += mf("incubi-kintaur", "succubi-kintaur");
					else race += mf("incubi-kin", "succubi-kin");
				}
			}
			if (TopRace == "devil") {
				if (TopScore >= 16 && hasPerk(PerkLib.Phylactery)) {
					if (TopScore >= 21) {
						if (isTaur()) race = "archdevil-taur";
						else race = "archdevil";
					} else {
						if (isTaur()) race = "devil-taur";
						else race = "devil";
					}
				} else {
					if (isTaur()) race = "devilkin-taur";
					else race = "devilkin";
				}
			}
			if (TopRace == "shark") {
				if (TopScore >= 9 && vaginas.length > 0 && cocks.length > 0) {
					if (isTaur()) race = "tigershark-taur";
					else {
						race = "tigershark-morph";
					}
				} else if (TopScore >= 8) {
					if (isTaur()) race = "shark-taur";
					else {
						race = "shark-morph";
					}
				}
			}
			if (TopRace == "orca") {
				if (TopScore >= 20) {
					if (isTaur()) race = "great orca-taur";
					else {
						race = "great orca-";
						race += mf("boy", "girl");
					}
				} else {
					if (isTaur()) race = "orca-taur";
					else {
						race = "orca-";
						race += mf("boy", "girl");
					}
				}
			}
			if (TopRace == "sea dragon") {
				if (TopScore >= 20) {
					if (TopScore >= 30) {
						if (isTaur()) race = "leviathan-taur";
						else {
							race = "leviathan-";
							race += mf("boy", "girl");
						}
					} else {
						if (isTaur()) race = "sea dragon-taur";
						else {
							race = "sea dragon-";
							race += mf("boy", "girl");
						}
					}
				}
			}
			if (TopRace == "bunny") {
				if (TopScore >= 10) race = "bunny-" + mf("boy", "girl");
			}
			if (TopRace == "easter bunny") {
				if (TopScore >= 12) {
					if (TopScore >= 15) race = "true easter bunny-" + mf("boy", "girl");
					else race = "easter bunny-" + mf("boy", "girl");
				}
			}
			if (TopRace == "harpy") {
				if (gender >= 2) race = "harpy";
				else race = "avian";
			}
			if (TopRace == "spider") {
				race = "spider-morph";
				if (mf("no", "yes") == "yes")
					race = "spider-girl";
				if (isDrider())
					race = "drider";
			}
			if (TopRace == "kangaroo") {
				if (TopScore >= 4) race = "kangaroo-morph";
			}
			if (TopRace == "mouse") {
				if (TopScore >= 4) {
					if (TopScore >= 15 && arms.type == Arms.HINEZUMI && lowerBody == LowerBody.HINEZUMI) {
						if (isTaur()) race = "hinezumi-taur";
						race = "hinezumi";
					} else if (TopScore >= 12 && arms.type == Arms.HINEZUMI && lowerBody == LowerBody.HINEZUMI) {
						if (isTaur()) race = "hinezumi-taur";
						race = "hinezumi";
					} else if (TopScore >= 8) {
						if (isTaur()) race = "mouse-taur";
						race = "mouse-morph";
					} else {
						if (isTaur()) race = "mouse-" + mf("boy", "girl") + "-taur";
						else race = "mouse-" + mf("boy", "girl");
					}
				}
			}
			if (TopRace == "scorpion") {
				if (isTaur()) race = "scorpion-taur";
				else race = "scorpion-morph";
			}
			if (TopRace == "mantis") {
				if (isTaur()) race = "mantis-taur";
				else race = "mantis-morph";
			}
			if (TopRace == "salamander") {
				if (TopScore >= 16) {
					if (isTaur()) race = "primordial salamander-taur";
					else race = "primordial salamander";
				} else {
					if (isTaur()) race = "salamander-taur";
					else race = "salamander";
				}
			}
			if (TopRace == "cave wyrm") {
				if (isTaur()) race = "cave wyrm-taur";
				else race = "cave wyrm";
			}
			if (TopRace == "yeti") {
				if (TopScore >= 17) {
					if (isTaur()) race = "true yeti-taur";
					else race = "true yeti";
				}
				else {
					if (isTaur()) race = "yeti-taur";
					else race = "yeti";
				}
			}
			if (TopRace == "yuki onna") {
				if (TopScore >= 14) {
					race = "Yuki Onna";
				}
			}
			if (TopRace == "melkie") {
				if (TopScore >= 21) race = "elder melkie";
				else race = "melkie";
			}
			if (TopRace == "couatl") {
				if (TopScore >= 11) {
					if (TopScore >= 19) race = "greater couatl";
					else {
						race = "couatl";
					}
				}
			}
			if (TopRace == "vouivre") {
				if (TopScore >= 11) {
					if (TopScore >= 21) race = "greater vouivre";
					else {
						if (TopScore >= 16) race = "vouivre";
						else {
							race = "lesser vouivre";
						}
					}
				}
			}
			if (TopRace == "gorgon") {
				if (TopScore >= 11) {
					if (TopScore >= 19) race = "greater gorgon";
					else {
						race = "gorgon";
					}
				}
			}
			if (TopRace == "hydra") {
				if (lowerBody == 51 && TopScore >= 14) {
					if (TopScore >= 29) race = "legendary hydra";
					else if (TopScore >= 24) race = "ancient hydra";
					else if (TopScore >= 19) race = "greater hydra";
					else race = "hydra";
				}
			}
			if (TopRace == "naga") {
				race = "naga";
			}
			if (TopRace == "apophis") {
				if (lowerBody == 3 && TopScore >= 23) {
					if (TopScore >= 26) race = "unhallowed apophis";
					else race = "apophis";
				}
			}
			if (TopRace == "fire snail") {
				if (TopScore >= 15) {
					race = "fire snail";
				}
			}
			if (TopRace == "phoenix") {
				if (TopScore >= 10) {
					if (TopScore >= 21) {
						if (isTaur()) race = "Greater phoenix-taur";
						else race = "Greater phoenix";
					}
					else{
						if (isTaur()) race = "phoenix-taur";
						else race = "phoenix";
					}
				}
			}
			if (TopRace == "scylla") {
				if (TopScore >= 17) race = "elder kraken";
				else if (TopScore >= 12) race = "kraken";
				else race = "scylla";
			}
			if (TopRace == "plant") {
				if (TopScore >= 4) {
					if (isTaur()) {
						if (TopScore >= 6) race = mf("treant-taur", "dryad-taur");
						else race = "plant-taur";
					} else {
						if (TopScore >= 6) race = mf("treant", "dryad");
						else race = "plant-morph";
					}
				}
			}
			if (TopRace == "alraune") {
				if (TopScore >= 10 && lowerBody == LowerBody.PLANT_FLOWER) {
					race = "alraune";
				}
				else if (TopScore >= 10 && lowerBody == LowerBody.FLOWER_LILIRAUNE) {
					race = "liliraune";
				}
			}
			if (TopRace == "yggdrasil") {
				if (TopScore >= 10) {
					race = "yggdrasil";
				}
			}
			if (TopRace == "oni") {
				if (TopScore >= 18) {
					if (isTaur()) race = "elder oni-taur";
					else race = "elder oni";
				}
				else {
					if (isTaur()) race = "oni-taur";
					else race = "oni";
				}
			}
			if (TopRace == "elf") {
				if (isTaur()) race = "elf-taur";
				else race = "elf";
			}
			if (TopRace == "wood elf") {
				if (TopScore >= 17) {
					if (TopScore >= 25) {
						if (isTaur()) race = "wood elf-taur";
						else race = "wood elf";
					} else {
						if (isTaur()) race = "Wood Elf-taur";
						else race = "Wood elf little sister";
					}
				}
			}
			if (TopRace == "frost wyrm") {
				if (TopScore >= 29) race = "greater frost wyrm";
				else race = "frost wyrm";
			}
			if (TopRace == "orc") {
				if (isTaur()) race = "orc-taur";
				else race = "orc";
			}
			if (TopRace == "kamaitachi") {
				if (TopScore >= 18) {
					if (isTaur()) race = "greater kamaitachi-taur";
					else race = "greater kamaitachi";
				} else {
					if (isTaur()) race = "kamaitachi-taur";
					else race = "kamaitachi";
				}
			}
			if (TopRace == "ratatoskr") {
				if (TopScore >= 18) {
					if (isTaur()) race = "ratatoskr-taur";
					else race = "ratatoskr";
				} else {
					if (isTaur()) race = "squirrel-taur";
					else race = "squirrel morph";
				}
			}
			if (TopRace == "wendigo") {
				if (TopScore >= 10) {
					if (TopScore >= 22) race = "greater wendigo";
					else race = "wendigo";
				}
			}
			if (TopRace == "raiju") {
				if (TopScore >= 19) {
					if (isTaur()) race = "greater raiju-taur";
					else race = "greater raiju";
				}
				else {
						if (isTaur()) race = "raiju-taur";
					else race = "raiju";
				}
			}
			if (TopRace == "thunderbird") {
				if (TopScore >= 21) race = "greater thunderbird";
				else race = "thunderbird";
			}
			//<mod>
			if (TopRace == "pig") {
				if (TopScore >= 15) {
					race = "boar-morph";
				} else {
					race = "pig-morph";
				}
			}
			if (TopRace == "satyr") {
				if (TopScore >= 4) race = "satyr";
			}
			if (TopRace == "rhino") {
				if (TopScore >= 4) {
					race = "rhino-morph";
					if (faceType == Face.HUMAN) race = "rhino-" + mf("man", "girl");
				}
			}
			if (TopRace == "echidna") {
				if (TopScore >= 4) {
					race = "echidna";
					if (faceType == Face.HUMAN) race = "echidna-" + mf("boy", "girl");
				}
			}
			if (TopRace == "ushi-oni") {
				if (TopScore >= 5) {
					if (statusEffectv1(StatusEffects.UshiOnnaVariant) == 1) race = "fiery ushi-" + mf("oni", "onna");
					else if (statusEffectv1(StatusEffects.UshiOnnaVariant) == 2) race = "frozen ushi-" + mf("oni", "onna");
					else if (statusEffectv1(StatusEffects.UshiOnnaVariant) == 3) race = "sandy ushi-" + mf("oni", "onna");
					else if (statusEffectv1(StatusEffects.UshiOnnaVariant) == 4) race = "pure ushi-" + mf("oni", "onna");
					else if (statusEffectv1(StatusEffects.UshiOnnaVariant) == 5) race = "wicked ushi-" + mf("oni", "onna");
					else race = "ushi-" + mf("oni", "onna");
				}
			}
			if (TopRace == "deer") {
				if (TopScore >= 4) {
					if (isTaur()) race = "deer-taur";
					else {
						race = "deer-morph";
						if (faceType == Face.HUMAN) race = "deer-" + mf("morph", "girl");
					}
				}
			}
			if (TopRace == "dragonne") {
				if (TopScore >= 6) {
					if (isTaur()) race = "dragonne-taur";
					else {
						race = "dragonne";
						if (faceType == Face.HUMAN)
							race = "dragonne-" + mf("man", "girl");
					}
				}
			}
			if (TopRace == "manticore") {
				if (isTaur() && lowerBody == LowerBody.LION) {
					if (TopScore >= 22)
						race = "true manticore-taur";
					else
						race = "manticore-taur";
				}
				else if (TopScore >= 22)
					race = "true manticore";
				else
					race = "manticore";
			}
			if (TopRace == "red panda") {
				race = "red-panda-morph";
				if (faceType == Face.HUMAN)
					race = "red-panda-" + mf("boy", "girl");
				if (isTaur())
					race = "red-panda-taur";
			}
			if (TopRace == "bear and panda") {
				if (faceType == Face.PANDA) race = "panda-morph";
				else race = "bear-morph";
			}
			if (TopRace == "siren") {
				if (TopScore >= 10) {
					if (TopScore >= 20) {
						if (isTaur()) race = "Greater siren-taur";
						else race = "Greater siren";
					} else {
						if (isTaur()) race = "siren-taur";
						else race = "siren";
					}
				}
			}
			if (TopRace == "gargoyle") {
				if (TopScore >= 20) {
					if (hasPerk(PerkLib.GargoylePure)) race = "pure gargoyle";
					else race = "corrupted gargoyle";
				}
			}
			if (TopRace == "bat") {
				race = "bat ";
				race += mf("boy", "girl");
			}
			if (TopRace == "vampire") {
				if (TopScore >= 10) {
					if (TopScore >= 20) race = "pureblood vampire";
					else race = "vampire";
				}
			}
			if (TopRace == "avian") {
				race = "avian-morph";
			}
			if (TopRace == "poltergeist") {
				if (TopScore >= 6) {
					if (TopScore >= 18) race = "eldritch poltergeist";
					else if (TopScore >= 12) race = "poltergeist";
					else race = "phantom";
				}
			}
			//if (lowerBody == LowerBody.HOOFED && isTaur() && wings.type == Wings.FEATHERED_LARGE) {
			//	race = "pegataur";
			//}
			//if (lowerBody == LowerBody.PONY)
			//	race = "pony-kin";
			if (TopRace == "goo") {
				if (TopScore >= 11) {
					if (TopScore >= 15) race = "slime queen";
					else {
						race = "slime ";
						race += mf("boi", "girl");
					}
				}
			}
			if (TopRace == "magmagoo") {
				if (TopScore >= 13) {
					if (TopScore >= 17) race = "magma slime queen";
					else {
						race = "magma slime ";
						race += mf("boi", "girl");
					}
				}
			}
			if (TopRace == "darkgoo") {
				if (TopScore >= 13) {
					if (TopScore >= 17) race = "dark slime queen";
					else {
						race = "dark slime ";
						race += mf("boi", "girl");
					}
				}
			}
			if (TopRace == "jiangshi") {
				if (TopScore >= 20) {
					race = "Jiangshi";
				}
			}
			if (TopRace == "atlach nacha") {
				if (TopScore >= 30) {
					race = "greater Atlach Nacha"
				} else if (TopScore >= 18) {
					race = "Atlach Nacha"
				} else if (TopScore >= 10) {
					race = "incomplete Atlach Nacha"
				}
			}
			if (chimeraScore() >= 3)
			{
				race = "chimera";
			}
			if (grandchimeraScore() >= 3)
			{
				race = "grand chimera";
			}
			if (generalType){
				return TopRace;
			}
			else{
				return race;
			}

		}

		//Determine Human Rating
		public function humanScore():Number {
			Begin("Player","racialScore","human");
			var humanCounter:Number = 0;
			if (hasPlainSkinOnly() && skinAdj != "slippery")
				humanCounter++;
			if (hairType == Hair.NORMAL)
				humanCounter++;
			if (faceType == Face.HUMAN)
				humanCounter++;
			if (eyes.type == Eyes.HUMAN)
				humanCounter++;
			if (ears.type == Ears.HUMAN)
				humanCounter++;
			if (ears.type == Ears.ELVEN)
				humanCounter -= 7;
			if (tongue.type == 0)
				humanCounter++;
			if (gills.type == 0)
				humanCounter++;
			if (antennae.type == 0)
				humanCounter++;
			if (horns.count == 0)
				humanCounter++;
			if (wings.type == Wings.NONE)
				humanCounter++;
			if (tailType == 0)
				humanCounter++;
			if (arms.type == Arms.HUMAN)
				humanCounter++;
			if (lowerBody == LowerBody.HUMAN)
				humanCounter++;
			if (rearBody.type == RearBody.NONE)
				humanCounter++;
			if (normalCocks() >= 1 || (hasVagina() && vaginaType() == 0))
				humanCounter++;
			if (breastRows.length == 1 && hasPlainSkinOnly() && skinAdj != "slippery")
				humanCounter++;
			if (skin.base.pattern == Skin.PATTERN_NONE)
				humanCounter++;
			humanCounter += (121 - internalChimeraScore());
			if (isGargoyle()) humanCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) humanCounter = 0;
			End("Player","racialScore");
			return humanCounter;
		}

		public function humanMaxScore():Number {
			var humanMaxCounter:Number = 138;//17 + 115 z perków mutacyjnych (każdy nowy mutation perk wpisywać też do TempleOfTheDivine.as we fragmencie o zostaniu Gargoyle)
			return humanMaxCounter;
		}

		public function finalRacialScore(score: Number, race:Race):Number {
			if (hasPerk(PerkLib.RacialParagon)) {
				if (race != racialParagonSelectedRace()) {
					score = 0; // or score -= 100
				}
			}
			return score;
		}

		public function racialParagonSelectedRace():Race {
			return Race.ALL_RACES[flags[kFLAGS.APEX_SELECTED_RACE]];
		}

		//Determine Inner Chimera Rating
		public function internalChimeraRating():Number {
			Begin("Player","racialScore","internalChimeraRating");
			var internalChimeraRatingCounter:Number = 0;
			if (internalChimeraScore() > 0)
				internalChimeraRatingCounter += internalChimeraScore();
			if (hasPerk(PerkLib.ChimericalBodyInitialStage))
				internalChimeraRatingCounter -= 2;//	 2-r2
			if (hasPerk(PerkLib.ChimericalBodySemiBasicStage))
				internalChimeraRatingCounter -= 3;//	 5-r4
			if (hasPerk(PerkLib.ChimericalBodyBasicStage))
				internalChimeraRatingCounter -= 4;//	 9-r8
			if (hasPerk(PerkLib.ChimericalBodySemiImprovedStage))//+1 racials
				internalChimeraRatingCounter -= 5;//	14-r12
			if (hasPerk(PerkLib.ChimericalBodyImprovedStage))
				internalChimeraRatingCounter -= 6;//	20-r18
			if (hasPerk(PerkLib.ChimericalBodySemiAdvancedStage))
				internalChimeraRatingCounter -= 7;//	27-r24
			if (hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				internalChimeraRatingCounter -= 8;//	35-r32
			if (hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))//+1 racials
				internalChimeraRatingCounter -= 9;//	44-r40
			if (hasPerk(PerkLib.ChimericalBodySuperiorStage))
				internalChimeraRatingCounter -= 10;//	54-r50
			if (hasPerk(PerkLib.ChimericalBodySemiPeerlessStage))
				internalChimeraRatingCounter -= 11;//	65-r61
			if (hasPerk(PerkLib.ChimericalBodyPeerlessStage))
				internalChimeraRatingCounter -= 12;//	77-r72
			if (hasPerk(PerkLib.ChimericalBodySemiEpicStage))//+1 racials
				internalChimeraRatingCounter -= 13;//	90-r85
			if (hasPerk(PerkLib.ChimericalBodyEpicStage))
				internalChimeraRatingCounter -= 14;//	104-r99	119	135	152	180	199	219(potem legendary/mythical stages?)
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				internalChimeraRatingCounter -= 20;
			if (jewelryName == "Ezekiel's Signet") internalChimeraRatingCounter -= 1;
			if (jewelryName2 == "Ezekiel's Signet") internalChimeraRatingCounter -= 1;
			if (jewelryName3 == "Ezekiel's Signet") internalChimeraRatingCounter -= 1;
			if (jewelryName4 == "Ezekiel's Signet") internalChimeraRatingCounter -= 1;
			if (headjewelryName == "Ezekiel's Crown") internalChimeraRatingCounter -= 4;
			if (necklaceName == "Ezekiel's Necklace") internalChimeraRatingCounter -= 5;
			if (flags[kFLAGS.GAME_DIFFICULTY] == 0) internalChimeraRatingCounter -= 10;
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) internalChimeraRatingCounter -= 5;//tyle ile stopni perków rasowych
			if (internalChimeraRatingCounter < 0 || flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) internalChimeraRatingCounter = 0;
			End("Player","racialScore");
			return internalChimeraRatingCounter;
		}//każdy nowy chimerical body perk wpisywać też do TempleOfTheDivine.as we fragmencie o zostaniu Gargoyle

		//Determine Inner Chimera Score
		public function internalChimeraScore():Number {
			Begin("Player","racialScore","internalChimeraScore");
			var internalChimeraCounter:Number = 0;
			var pMutations:Array = MutationsLib.mutationsArray("", true);
			for each (var pPerk:PerkType in pMutations){
				if (hasPerk(pPerk)) internalChimeraCounter++;
			}
			End("Player","racialScore");
			return internalChimeraCounter;
		}

		public function increaseFromBloodlinePerks():Number {
			var incFBP:Number = 2;
			if (hasPerk(PerkLib.AscensionBloodlineHeritage)) incFBP += 2;
			return incFBP;
		}

		//Determine Chimera Race Rating
		public function chimeraScore():Number {
			Begin("Player","racialScore","chimera");
			var chimeraCounter:Number = 0;
			if (catScore() >= 8)
				chimeraCounter++;
			if (nekomataScore() >= 10)
				chimeraCounter++;
			if (cheshireScore() >= 11)
				chimeraCounter++;
			if (hellcatScore() >= 10)
				chimeraCounter++;
			if (displacerbeastScore() >= 14)
				chimeraCounter++;
			if (lizardScore() >= 8)
				chimeraCounter++;
			if (dragonScore() >= 16)
				chimeraCounter++;
			if (raccoonScore() >= 8)
				chimeraCounter++;
//			if (dogScore() >= 4)
//				chimeraCounter++;
            if (wolfScore() >= 8)
                chimeraCounter++;
			if (werewolfScore() >= 12)
				chimeraCounter++;
			if (foxScore() >= 7)
				chimeraCounter++;
//			if (ferretScore() >= 4)
//				chimeraCounter++;
			if (kitsuneScore() >= 9 && tailType == 13 && tailCount >= 2)
				chimeraCounter++;
			if (horseScore() >= 7)
				chimeraCounter++;
			if (unicornScore() >= 10)
				chimeraCounter++;
			if (alicornScore() >= 12)
				chimeraCounter++;
			if (centaurScore() >= 8)
				chimeraCounter++;
			if (minotaurScore() >= 10)
				chimeraCounter++;
			if (cowScore() >= 10)
				chimeraCounter++;
			if (cancerScore() >= 13)
				chimeraCounter++;
			if (beeScore() >= 17)
				chimeraCounter++;
			if (goblinScore() >= 10)
				chimeraCounter++;
			if (gremlinScore() >= 15)
				chimeraCounter++;
			if (demonScore() >= 11)
				chimeraCounter++;
			if (devilkinScore() >= 11)
				chimeraCounter++;
			if (sharkScore() >= 10)
				chimeraCounter++;
			if (orcaScore() >= 14)
				chimeraCounter++;
			if (oniScore() >= 12)
				chimeraCounter++;
			if (elfScore() >= 11)
				chimeraCounter++;
			if (woodElfScore() >= 22)
				chimeraCounter++;
			if (orcScore() >= 11)
				chimeraCounter++;
			if (raijuScore() >= 10)
				chimeraCounter++;
			if (thunderbirdScore() >= 16)
				chimeraCounter++;
			if (bunnyScore() >= 10)
				chimeraCounter++;
			if (easterbunnyScore() >= 12)
				chimeraCounter++;
			if (harpyScore() >= 8)
				chimeraCounter++;
			if (spiderScore() >= 7)
				chimeraCounter++;
//			if (kangaScore() >= 4)
//				chimeraCounter++;
			if (mouseScore() >= 8)
				chimeraCounter++;
			if (trollScore() >= 10)
				chimeraCounter++;
//			if (scorpionScore() >= 4)
//				chimeraCounter++;
			if (mantisScore() >= 12)
				chimeraCounter++;
			if (salamanderScore() >= 7)
				chimeraCounter++;
			if (cavewyrmScore() >= 10)
				chimeraCounter++;
			if (nagaScore() >= 8)
				chimeraCounter++;
			if (gorgonScore() >= 11)
				chimeraCounter++;
			if (vouivreScore() >= 11)
				chimeraCounter++;
			if (couatlScore() >= 11)
				chimeraCounter++;
			if (hydraScore() >= 14 && lowerBody == 51)
				chimeraCounter++;
			if (firesnailScore() >= 15)
				chimeraCounter++;
			if (phoenixScore() >= 10)
				chimeraCounter++;
			if (scyllaScore() >= 7)
				chimeraCounter++;
//			if (plantScore() >= 6)
//				chimeraCounter++;
			if (alrauneScore() >= 13)
				chimeraCounter++;
			if (yggdrasilScore() >= 10)
				chimeraCounter++;
			if (pigScore() >= 10)
				chimeraCounter++;
/*			if (satyrScore() >= 4)
				chimeraCounter++;
			if (rhinoScore() >= 4)
				chimeraCounter++;
			if (echidnaScore() >= 4)
				chimeraCounter++;
*/			if (ushionnaScore() >= 11)
				chimeraCounter++;
//			if (deerScore() >= 4)
//				chimeraCounter++;
			if (manticoreScore() >= 15)
				chimeraCounter += 2;
			if (redpandaScore() >= 8)
				chimeraCounter++;
			if (bearpandaScore() >= 10)
				chimeraCounter++;
			if (sirenScore() >= 10)
				chimeraCounter++;
			if (yetiScore() >= 14)
				chimeraCounter++;
			if (yukiOnnaScore() >= 14)
				chimeraCounter++;
			if (wendigoScore() >= 10)
				chimeraCounter++;
			if (melkieScore() >= 18)
				chimeraCounter++;
			if (batScore() >= 10)
				chimeraCounter++;
			if (vampireScore() >= 10)
				chimeraCounter++;
			if (jabberwockyScore() >= 10)
				chimeraCounter++;
			if (avianScore() >= 9)
				chimeraCounter++;
/*			if (gryphonScore() >= 9)
				chimeraCounter++;
			if (peacockScore() >= 9)
				chimeraCounter++;
*/			if (gargoyleScore() >= 22)
				chimeraCounter++;
			if (gooScore() >= 11)
				chimeraCounter++;
			if (magmagooScore() >= 13)
				chimeraCounter++;
			if (darkgooScore() >= 13)
				chimeraCounter++;
			if (kamaitachiScore() >= 14)
				chimeraCounter++;
			if (ratatoskrScore() >= 12)
				chimeraCounter++;
			if (atlachNachaScore() >= 12)
				chimeraCounter++;
			if (cyclopScore() >= 12)
				chimeraCounter++;
			if (gazerScore() >= 14 && statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 6)
				chimeraCounter++; 

			End("Player","racialScore");
			return chimeraCounter;
		}

		//Determine Grand Chimera Race Rating
		public function grandchimeraScore():Number {
			Begin("Player","racialScore","grandchimera");
			var grandchimeraCounter:Number = 0;
			if (nekomataScore() >= 12)
				grandchimeraCounter++;
			if (dragonScore() >= 24)
				grandchimeraCounter++;
			if (jabberwockyScore() >= 20)
				grandchimeraCounter++;
			if (wolfScore() >= 10 && hasFur() && coatColor == "glacial white")
				grandchimeraCounter++;
//			if (werewolfScore() >= 12)
//				grandchimeraCounter++;
//			if (ferretScore() >= 4)
//				grandchimeraCounter++;
			if (kitsuneScore() >= 16 && tailType == 13 && tailCount == 9)
				grandchimeraCounter++;
			if (demonScore() >= 16 && hasPerk(PerkLib.Phylactery))
				grandchimeraCounter++;
			if (devilkinScore() >= 16 && hasPerk(PerkLib.Phylactery))
				grandchimeraCounter++;
			if (sharkScore() >= 11 && vaginas.length > 0 && cocks.length > 0)
				grandchimeraCounter++;
			if (lowerBody == 51 && hydraScore() >= 19)
				grandchimeraCounter++;
			if (oniScore() >= 18)
				grandchimeraCounter++;
			if (orcaScore() >= 20)
				grandchimeraCounter++;
/*			if (elfScore() >= 11)
				grandchimeraCounter++;
			if (orcScore() >= 11)
				grandchimeraCounter++;
*/			if (thunderbirdScore() >= 21)
				grandchimeraCounter++;
			if (mouseScore() >= 12 && arms.type == Arms.HINEZUMI && lowerBody == LowerBody.HINEZUMI)
				grandchimeraCounter++;
//			if (mantisScore() >= 12)
//				grandchimeraCounter++;
			if (scyllaScore() >= 12)
				grandchimeraCounter++;
			if (pigScore() >= 15)
				grandchimeraCounter++;
			if (wendigoScore() >= 25)
				grandchimeraCounter++;
			if (melkieScore() >= 21)
				grandchimeraCounter++;
			if (gooScore() >= 15)
				grandchimeraCounter++;
			if (magmagooScore() >= 17)
				grandchimeraCounter++;
			if (darkgooScore() >= 17)
				grandchimeraCounter++;
			if (kamaitachiScore() >= 18)
				grandchimeraCounter++;
			if (ratatoskrScore() >= 18)
				grandchimeraCounter++;
			if (cancerScore() >= 20)
				grandchimeraCounter++;
			if (gazerScore() >= 21 && statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10)
				grandchimeraCounter++;

			End("Player","racialScore");
			return grandchimeraCounter;
		}

		//Determine Jiangshi Rating
		public function jiangshiScore():Number {
			Begin("Player","racialScore","jiangshi");
			var jiangshiCounter:Number = 0;
			if (hasPlainSkinOnly() && skinAdj != "slippery")
				jiangshiCounter++;
			if (InCollection(skin.base.color, ["ghostly pale", "light blue", "snow white"]))
				jiangshiCounter++;
			if (hairType == Hair.NORMAL)
				jiangshiCounter++;
			if (faceType == Face.JIANGSHI)
				jiangshiCounter++;
			if (eyes.type == Eyes.JIANGSHI)
				jiangshiCounter += 2;
			if (ears.type == Ears.HUMAN)
				jiangshiCounter++;
			if (tongue.type == 0)
				jiangshiCounter++;
			if (gills.type == 0)
				jiangshiCounter++;
			if (antennae.type == 0)
				jiangshiCounter++;
			if (horns.type == Horns.SPELL_TAG && horns.count > 0)
				jiangshiCounter++;
			if (wings.type == Wings.NONE)
				jiangshiCounter += 2;
			if (tailType == 0)
				jiangshiCounter++;
			if (arms.type == Arms.JIANGSHI)
				jiangshiCounter++;
			if (lowerBody == LowerBody.JIANGSHI)
				jiangshiCounter++;
			if (rearBody.type == RearBody.NONE)
				jiangshiCounter++;
			if (skin.base.pattern == Skin.PATTERN_NONE)
				jiangshiCounter++;
			if (hasPerk(PerkLib.Undeath))
				jiangshiCounter += 2;
			jiangshiCounter = finalRacialScore(jiangshiCounter, Race.JIANGSHI);
			End("Player","racialScore");
			return jiangshiCounter;
		}

		//determine demon rating
		public function demonScore():Number {
			Begin("Player","racialScore","demon");
			var demonCounter:Number = 0;
			var demonCounter2:Number = 0;
			if (horns.type == Horns.DEMON && horns.count > 0) {
				demonCounter++;
				demonCounter2++;
			}
			if (tailType == Tail.DEMONIC) {
				demonCounter++;
				demonCounter2++;
			}
			if (wings.type == Wings.BAT_LIKE_TINY) {
				demonCounter += 2;
				demonCounter2 += 2;
			}
			if (wings.type == Wings.BAT_LIKE_LARGE) {
				demonCounter += 4;
				demonCounter2 += 4;
			}
			if (tongue.type == Tongue.DEMONIC) {
				demonCounter++;
				demonCounter2++;
			}
			if (ears.type == Ears.ELFIN || ears.type == Ears.ELVEN || ears.type == Ears.HUMAN) {
				demonCounter++;
				demonCounter2++;
			}
			if (lowerBody == LowerBody.DEMONIC_HIGH_HEELS || lowerBody == LowerBody.DEMONIC_CLAWS) {
				demonCounter++;
				demonCounter2++;
			}
			if (demonCocks() > 0 || (hasVagina() && vaginaType() == VaginaClass.DEMONIC))
				demonCounter++;
			if (cor >= 50) {
				if (horns.type == Horns.DEMON && horns.count > 4) {
					demonCounter++;
					demonCounter2++;
				}
				if (hasPlainSkinOnly() && skinAdj != "slippery")
					demonCounter++;
				if (InCollection(skin.base.color, ["shiny black", "sky blue", "indigo", "ghostly white", "light purple", "purple", "red", "grey", "blue"]))
					demonCounter++;
				if (faceType == Face.HUMAN || faceType == Face.ANIMAL_TOOTHS || faceType == Face.DEVIL_FANGS) {
					demonCounter++;
					demonCounter2++;
				}
				if (arms.type == Arms.HUMAN)
					demonCounter++;
			}
			if (hasPerk(PerkLib.Phylactery))
				demonCounter += 5;
			if (horns.type == Horns.GOAT)
				demonCounter -= 10;
			if (hasPerk(MutationsLib.BlackHeart))
				demonCounter++;
			if (hasPerk(MutationsLib.BlackHeartPrimitive))
				demonCounter++;
			if (hasPerk(MutationsLib.BlackHeartEvolved))
				demonCounter++;
			if (hasPerk(MutationsLib.BlackHeart) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				demonCounter++;
			if (hasPerk(MutationsLib.BlackHeartPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				demonCounter++;
			if (hasPerk(MutationsLib.BlackHeartEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				demonCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				demonCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && demonCounter >= 4)
				demonCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && demonCounter >= 8)
				demonCounter += 1;
			if (hasPerk(PerkLib.DemonicLethicite))
				demonCounter+=1;
			if (demonCounter2 < 5) demonCounter = demonCounter2;
			if (isGargoyle()) demonCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) demonCounter = 0;
			demonCounter = finalRacialScore(demonCounter, Race.DEMON);
			End("Player","racialScore");
			return demonCounter;
		}

		//determine devil/infernal goat rating
		public function devilkinScore():Number {
			Begin("Player","racialScore","devil");
			var devilkinCounter:Number = 0;
			var devilkinCounter2:Number = 0;
			if (lowerBody == LowerBody.HOOFED) {
				devilkinCounter++;
				devilkinCounter2++;
			}
			if (tailType == Tail.GOAT || tailType == Tail.DEMONIC) {
				devilkinCounter++;
				devilkinCounter2++;
			}
			if (wings.type == Wings.BAT_LIKE_TINY || wings.type == Wings.BAT_LIKE_LARGE || wings.type == Wings.DEVILFEATHER) {
				devilkinCounter += 4;
				devilkinCounter2 += 4;
			}
			if (arms.type == Arms.DEVIL) {
				devilkinCounter++;
				devilkinCounter2++;
			}
			if (horns.type == Horns.GOAT || horns.type == Horns.GOATQUAD) {
				devilkinCounter++;
				devilkinCounter2++;
			}
			if (ears.type == Ears.GOAT) {
				devilkinCounter++;
				devilkinCounter2++;
			}
			if (faceType == Face.DEVIL_FANGS) {
				devilkinCounter++;
				devilkinCounter2++;
			}
			if (eyes.type == Eyes.DEVIL || eyes.type == Eyes.GOAT)
				devilkinCounter++;
			if (tallness < 48)
				devilkinCounter++;
			if (horseCocks() > 0 || (hasVagina() && vaginaType() == VaginaClass.DEMONIC))
				devilkinCounter++;
			if (cor >= 60)
				devilkinCounter++;
			if (hasPerk(PerkLib.Phylactery))
				devilkinCounter += 5;
			if (hasPerk(MutationsLib.ObsidianHeart))
				devilkinCounter++;
			if (hasPerk(MutationsLib.ObsidianHeartPrimitive))
				devilkinCounter++;
			if (hasPerk(MutationsLib.ObsidianHeartEvolved))
				devilkinCounter++;
			if (hasPerk(MutationsLib.ObsidianHeart) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				devilkinCounter++;
			if (hasPerk(MutationsLib.ObsidianHeartPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				devilkinCounter++;
			if (hasPerk(MutationsLib.ObsidianHeartEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				devilkinCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				devilkinCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && devilkinCounter >= 4)
				devilkinCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && devilkinCounter >= 8)
				devilkinCounter++;
			if (devilkinCounter2 < 5) devilkinCounter = devilkinCounter2;
			if (isGargoyle()) devilkinCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) devilkinCounter = 0;
			devilkinCounter = finalRacialScore(devilkinCounter, Race.DEVIL);
			End("Player","racialScore");
			return devilkinCounter;
		}

		//determine angel rating
		public function angelScore():Number {
			Begin("Player","racialScore","angel");
			var angelCounter:Number = 0;/*
			var demonCounter2:Number = 0;
			if (horns.type == Horns.DEMON && horns.count > 0) {
				demonCounter++;
				demonCounter2++;
			}
			if (tailType == Tail.DEMONIC) {
				demonCounter++;
				demonCounter2++;
			}
			if (wings.type == Wings.BAT_LIKE_TINY) {
				demonCounter += 2;
				demonCounter2 += 2;
			}
			if (wings.type == Wings.BAT_LIKE_LARGE) {
				demonCounter += 4;
				demonCounter2 += 4;
			}
			if (tongue.type == Tongue.DEMONIC) {
				demonCounter++;
				demonCounter2++;
			}
			if (ears.type == Ears.ELFIN || ears.type == Ears.ELVEN || ears.type == Ears.HUMAN) {
				demonCounter++;
				demonCounter2++;
			}
			if (lowerBody == LowerBody.DEMONIC_HIGH_HEELS || lowerBody == LowerBody.DEMONIC_CLAWS) {
				demonCounter++;
				demonCounter2++;
			}
			if (demonCocks() > 0 || (hasVagina() && vaginaType() == VaginaClass.DEMONIC))
				demonCounter++;
			if (cor >= 50) {
				if (horns.type == Horns.DEMON && horns.count > 4) {
					demonCounter++;
					demonCounter2++;
				}
				if (hasPlainSkinOnly() && skinAdj != "slippery")
					demonCounter++;
				if (InCollection(skin.base.color, ["shiny black", "sky blue", "indigo", "ghostly white", "light purple", "purple", "red", "grey", "blue"]))
					demonCounter++;
				if (faceType == Face.HUMAN || faceType == Face.ANIMAL_TOOTHS || faceType == Face.DEVIL_FANGS) {
					demonCounter++;
					demonCounter2++;
				}
				if (arms.type == Arms.HUMAN)
					demonCounter++;
			}
			if (hasPerk(PerkLib.Phylactery))
				demonCounter += 5;
			if (horns.type == Horns.GOAT)
				demonCounter -= 10;
			if (hasPerk(MutationsLib.BlackHeart))
				angelCounter++;
			if (hasPerk(MutationsLib.BlackHeartPrimitive))
				angelCounter++;
			if (hasPerk(MutationsLib.BlackHeartEvolved))
				angelCounter++;
			if (hasPerk(MutationsLib.BlackHeart) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				angelCounter++;
			if (hasPerk(MutationsLib.BlackHeartPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				angelCounter++;
			if (hasPerk(MutationsLib.BlackHeartEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				angelCounter++;*/
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				angelCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && angelCounter >= 4)
				angelCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && angelCounter >= 8)
				angelCounter += 1;/*
			if (hasPerk(PerkLib.DemonicLethicite))
				demonCounter+=1;
			if (demonCounter2 < 5) demonCounter = demonCounter2;*/
			if (isGargoyle()) angelCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) angelCounter = 0;
			angelCounter = finalRacialScore(angelCounter, Race.ANGEL);
			End("Player","racialScore");
			return angelCounter;
		}

		//Determine cow rating
		public function cowScore():Number {
			Begin("Player","racialScore","cow");
			var cowCounter:Number = 0;
			if (ears.type == Ears.COW)
				cowCounter++;
			if (tailType == Tail.COW)
				cowCounter++;
			if (lowerBody == LowerBody.HOOFED)
				cowCounter++;
			if (horns.type == Horns.COW_MINOTAUR)
				cowCounter++;
			if (cowCounter >= 4) {
				if (faceType == Face.HUMAN || faceType == Face.COW_MINOTAUR)
					cowCounter++;
				if (arms.type == Arms.HUMAN)
					cowCounter++;
				if (hasFur() || hasPartialCoat(Skin.FUR) || hasPlainSkinOnly())
					cowCounter++;
				if (biggestTitSize() > 4)
					cowCounter++;
				if (tallness >= 73)
					cowCounter++;
				if (cor >= 20)
					cowCounter++;
				if (vaginas.length > 0)
					cowCounter++;
				if (cocks.length > 0)
					cowCounter -= 8;
				if (balls > 0)
					cowCounter -= 8;
			}
			if (hasPerk(PerkLib.Feeder))
				cowCounter++;
			if (hasPerk(MutationsLib.LactaBovinaOvaries))
				cowCounter++;
			if (hasPerk(MutationsLib.LactaBovinaOvariesPrimitive))
				cowCounter++;
			if (hasPerk(MutationsLib.LactaBovinaOvariesEvolved))
				cowCounter++;
			if (hasPerk(MutationsLib.LactaBovinaOvaries) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				cowCounter++;
			if (hasPerk(MutationsLib.LactaBovinaOvariesPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				cowCounter++;
			if (hasPerk(MutationsLib.LactaBovinaOvariesEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				cowCounter++;
			if (hasPerk(PerkLib.MinotaursDescendant) || hasPerk(PerkLib.BloodlineMinotaur))
				cowCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				cowCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && cowCounter >= 4)
				cowCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && cowCounter >= 8)
				cowCounter += 1;
			if (isGargoyle()) cowCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) cowCounter = 0;
			cowCounter = finalRacialScore(cowCounter, Race.COW);
			End("Player","racialScore");
			return cowCounter;
		}

		//Determine minotaur rating
		public function minotaurScore():Number {
			Begin("Player","racialScore","minotaur");
			var minoCounter:Number = 0;
			if (ears.type == Ears.COW)
				minoCounter++;
			if (tailType == Tail.COW)
				minoCounter++;
			if (lowerBody == LowerBody.HOOFED)
				minoCounter++;
			if (horns.type == Horns.COW_MINOTAUR)
				minoCounter++;
			if (minoCounter >= 4) {
				if (faceType == Face.HUMAN || faceType == Face.COW_MINOTAUR)
					minoCounter++;
				if (arms.type == Arms.HUMAN)
					minoCounter++;
				if (hasFur() || hasPartialCoat(Skin.FUR))
					minoCounter++;
				if (cumQ() > 500)
					minoCounter++;
				if (tallness >= 81)
					minoCounter++;
				if (cor >= 20)
					minoCounter++;
				if (cocks.length > 0 && horseCocks() > 0)
					minoCounter++;
				if (vaginas.length > 0)
					minoCounter -= 8;
			}
			if (hasPerk(MutationsLib.MinotaurTesticles))
				minoCounter++;
			if (hasPerk(MutationsLib.MinotaurTesticlesPrimitive))
				minoCounter++;
			if (hasPerk(MutationsLib.MinotaurTesticlesEvolved))
				minoCounter++;
			if (hasPerk(MutationsLib.MinotaurTesticles) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				minoCounter++;
			if (hasPerk(MutationsLib.MinotaurTesticlesPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				minoCounter++;
			if (hasPerk(MutationsLib.MinotaurTesticlesEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				minoCounter++;
			if (hasPerk(PerkLib.MinotaursDescendant) || hasPerk(PerkLib.BloodlineMinotaur))
				minoCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				minoCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && minoCounter >= 4)
				minoCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && minoCounter >= 8)
				minoCounter += 1;
			if (isGargoyle()) minoCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) minoCounter = 0;
			minoCounter = finalRacialScore(minoCounter, Race.MINOTAUR);
			End("Player","racialScore");
			return minoCounter;
		}

		//Determine Sand trap Rating
		public function sandTrapScore():int {
			Begin("Player","racialScore","sandTrap");
			var counter:int = 0;
			if (hasStatusEffect(StatusEffects.BlackNipples))
				counter++;
			if (hasStatusEffect(StatusEffects.Uniball))
				counter++;
			if (hasVagina() && vaginaType() == VaginaClass.BLACK_SAND_TRAP)
				counter++;
			if (eyes.type == Eyes.BLACK_EYES_SAND_TRAP)
				counter++;
			if (wings.type == Wings.GIANT_DRAGONFLY)
				counter++;
			if (hasStatusEffect(StatusEffects.Uniball))
				counter++;
			if (isGargoyle()) counter = 0;
			if (hasPerk(PerkLib.ElementalBody)) counter = 0;
			counter = finalRacialScore(counter, Race.SANDTRAP);
			End("Player","racialScore");
			return counter;
		}

		//Determine Bee Rating
		public function beeScore():Number {
			Begin("Player","racialScore","bee");
			var beeCounter:Number = 0;
			if (InCollection(hairColor, BeeGirlScene.beeHair)) //TODO if hairColor2 == yellow && hairColor == black
				beeCounter++;
			if (InCollection(skin.coat.color, "yellow") && InCollection(skin.coat.color2, "black","ebony"))
				beeCounter++;
			if (eyes.type == Eyes.BLACK_EYES_SAND_TRAP)
				beeCounter += 2;//po dodaniu bee tongue wróci do +1
			if (antennae.type == Antennae.BEE) {
				beeCounter++;
				if (faceType == Face.HUMAN)
					beeCounter++;//ptem zamienić na specificzną dla pszczół wariant twarzy
			}
			if (horns.type == Horns.NONE)
				beeCounter++;
			if (arms.type == Arms.BEE)
				beeCounter++;
			if (lowerBody == LowerBody.BEE)
				beeCounter++;
			if (tailType == Tail.BEE_ABDOMEN)
				beeCounter++;
			if (wings.type == Wings.BEE_SMALL)
				beeCounter++;
			if (wings.type == Wings.BEE_LARGE)
				beeCounter += 4;
			if (rearBody.type == RearBody.NONE)
				beeCounter++;
			//chitin + correct color of it +1
			if (skin.base.pattern == Skin.PATTERN_BEE_STRIPES)
				beeCounter++;
			if (hasPerk(PerkLib.BeeOvipositor))
				beeCounter++;
			if (vaginas.length == 1 || (cocks.length > 0 && beeCocks() > 0))
				beeCounter++;
			if (beeCounter > 0 && hasPerk(MutationsLib.TrachealSystem))
				beeCounter++;
			if (beeCounter > 3 && hasPerk(MutationsLib.TrachealSystemPrimitive))
				beeCounter++;
			if (beeCounter > 6 && hasPerk(MutationsLib.TrachealSystemEvolved))
				beeCounter++;
			if (beeCounter > 9 && hasPerk(MutationsLib.TrachealSystemFinalForm))
				beeCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				beeCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && beeCounter >= 4)
				beeCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && beeCounter >= 8)
				beeCounter += 1;
			if (isGargoyle()) beeCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) beeCounter = 0;
			beeCounter = finalRacialScore(beeCounter, Race.BEE);
			End("Player","racialScore");
			return beeCounter;
		}

		//Determine Ferret Rating!
		public function ferretScore():Number {
			Begin("Player","racialScore","ferret");
			var counter:int = 0;
			if (faceType == Face.FERRET_MASK) counter++;
			if (faceType == Face.FERRET) counter+=2;
			if (ears.type == Ears.FERRET) counter++;
			if (tailType == Tail.FERRET) counter++;
			if (lowerBody == LowerBody.FERRET) counter++;
			if (hasFur() && counter > 0) counter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				counter += 50;
			if (isGargoyle()) counter = 0;
			if (hasPerk(PerkLib.ElementalBody)) counter = 0;
			counter = finalRacialScore(counter, Race.FERRET);
			End("Player","racialScore");
			return counter;
		}

		//Determine Dog Rating
		public function dogScore():Number {
			Begin("Player","racialScore","dog");
			var dogCounter:Number = 0;
			if (faceType == Face.DOG)
				dogCounter++;
			if (ears.type == Ears.DOG)
				dogCounter++;
			if (tailType == Tail.DOG)
				dogCounter++;
			if (lowerBody == LowerBody.DOG)
				dogCounter++;
			if (dogCocks() > 0)
				dogCounter++;
			if (breastRows.length > 1)
				dogCounter++;
			if (breastRows.length == 3)
				dogCounter++;
			if (breastRows.length > 3)
				dogCounter--;
			//Fur only counts if some canine features are present
			if (hasFur() && dogCounter > 0)
				dogCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				dogCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && dogCounter >= 4)
				dogCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && dogCounter >= 8)
				dogCounter += 1;
			if (isGargoyle()) dogCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) dogCounter = 0;
			dogCounter = finalRacialScore(dogCounter, Race.DOG);
			End("Player","racialScore");
			return dogCounter;
		}

		//Determine Mouse Rating
		public function mouseScore():Number {
			Begin("Player","racialScore","mouse");
			var mouseCounter:Number = 0;
			if (ears.type == Ears.MOUSE)
				mouseCounter++;
			if (tailType == Tail.MOUSE || tailType == Tail.HINEZUMI)
				mouseCounter++;
			if (faceType == Face.BUCKTEETH || faceType == Face.MOUSE)
				mouseCounter += 2;
			if (lowerBody == LowerBody.MOUSE || lowerBody == LowerBody.HINEZUMI)
				mouseCounter++;
			if (arms.type == Arms.HINEZUMI)
				mouseCounter++;
			if (eyes.type == Eyes.HINEZUMI && eyes.colour == "blazing red")
				mouseCounter++;
			if (hairType == Hair.BURNING)
				mouseCounter++;
			if (InCollection(hairColor, ["red", "orange", "pinkish orange", "platinum crimson"]))
				mouseCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR)) {
				mouseCounter++;
				if (tallness < 60)
					mouseCounter++;
				if (tallness < 52)
					mouseCounter++;
			}
			if (hasPerk(MutationsLib.HinezumiBurningBlood))
				mouseCounter++;
			if (hasPerk(MutationsLib.HinezumiBurningBloodPrimitive))
				mouseCounter++;
			if (hasPerk(MutationsLib.HinezumiBurningBloodEvolved))
				mouseCounter++;
			if (hasPerk(MutationsLib.HinezumiBurningBlood) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				mouseCounter++;
			if (hasPerk(MutationsLib.HinezumiBurningBloodPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				mouseCounter++;
			if (hasPerk(MutationsLib.HinezumiBurningBloodEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				mouseCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				mouseCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && mouseCounter >= 4)
				mouseCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && mouseCounter >= 8)
				mouseCounter += 1;
			if (isGargoyle()) mouseCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) mouseCounter = 0;
			mouseCounter = finalRacialScore(mouseCounter, Race.MOUSE);
			End("Player","racialScore");
			return mouseCounter;
		}

		//Determine Raccoon Rating
		public function raccoonScore():Number {
			Begin("Player","racialScore","raccoon");
			var coonCounter:Number = 0;
			if (faceType == Face.RACCOON_MASK || faceType == Face.RACCOON)
				coonCounter += 2;
			if (ears.type == Ears.RACCOON)
				coonCounter++;
			if (ears.type == Ears.RACCOON)
				coonCounter++;
			if (eyes.colour == "golden")
				coonCounter++;
			if (arms.type == Arms.RACCOON)
				coonCounter++;
			if (tailType == Tail.RACCOON)
				coonCounter++;
			if (lowerBody == LowerBody.RACCOON)
				coonCounter++;
			if (wings.type == Wings.NONE)
				coonCounter+= 2;
			if (cocks.length > 0)
				coonCounter++;
			if (coonCounter > 0 && balls > 0)
				coonCounter++;
			//Fur only counts if some canine features are present
			if ((hasFur() || hasPartialCoat(Skin.FUR)) && coonCounter > 0)
				coonCounter++;
			if (InCollection(skin.coat.color, "chocolate","brown","tan", "caramel"))
				coonCounter++;
			if (InCollection(hairColor, "chocolate","brown","tan", "caramel"))
				coonCounter++;
			if (hasPerk(MutationsLib.NukiNuts))
				coonCounter++;
			if (hasPerk(MutationsLib.NukiNutsPrimitive))
				coonCounter++;
			if (hasPerk(MutationsLib.NukiNutsEvolved))
				coonCounter++;
			if (hasPerk(MutationsLib.NukiNuts) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				coonCounter++;
			if (hasPerk(MutationsLib.NukiNutsPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				coonCounter++;
			if (hasPerk(MutationsLib.NukiNutsEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				coonCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				coonCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && coonCounter >= 4)
				coonCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && coonCounter >= 8)
				coonCounter += 1;
			if (tailType != Tail.RACCOON)
				coonCounter = 0;
			if (isGargoyle()) coonCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) coonCounter = 0;
			coonCounter = finalRacialScore(coonCounter, Race.RACCOON);
			End("Player","racialScore");
			return coonCounter;
		}

		//Determine Fox Rating
		public function foxScore():Number {
			Begin("Player","racialScore","fox");
			var foxCounter:Number = 0;
			if (faceType == Face.FOX)
				foxCounter++;
			if (eyes.type == Eyes.FOX)
				foxCounter++;
			if (ears.type == Ears.FOX)
				foxCounter++;
			if (tailType == Tail.FOX)
				foxCounter++;
			if (tailType == Tail.FOX && tailCount >= 2)
				foxCounter -= 7;
			if (arms.type == Arms.FOX)
				foxCounter++;
			if (lowerBody == LowerBody.FOX)
				foxCounter++;
			if (foxCocks() > 0 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length > 1 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 3 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 4 && foxCounter > 0)
				foxCounter++;
			//Fur only counts if some canine features are present
			if (hasFur() && foxCounter > 0)
				foxCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				foxCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && foxCounter >= 4)
				foxCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && foxCounter >= 8)
				foxCounter += 1;
			if (isGargoyle()) foxCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) foxCounter = 0;
			foxCounter = finalRacialScore(foxCounter, Race.FOX);
			End("Player","racialScore");
			return foxCounter;
		}

		//Determine Fairy Rating
		public function fairyScore():Number {
			Begin("Player","racialScore","fairy");
			var fairyCounter:Number = 0;
			if (faceType == Face.FAIRY)
				fairyCounter += 2;
			if (eyes.type == Eyes.FAIRY)
				fairyCounter += 2;
			if (hairType == Hair.FAIRY)
				fairyCounter += 2;
			if (ears.type == Ears.ELVEN)
				fairyCounter++;
			if (tailType == Tail.NONE)
				fairyCounter++;
			if (arms.type == Arms.ELF)
				fairyCounter++;
			if (lowerBody == LowerBody.ELF)
				fairyCounter++;
			if (tongue.type == Tongue.ELF)
				fairyCounter++;
			if (wings.type == Wings.FAIRY)
				fairyCounter += 3;
			if (breastRows.length > 0)
				fairyCounter++;
			if (!hasCock() && fairyCounter > 0)
				fairyCounter++;
			if (!hasCoat() && fairyCounter > 0)
				fairyCounter++;
			if (skinType == Skin.PLAIN && skinAdj == "flawless")
				fairyCounter++;
			if (hasPerk(MutationsLib.FeyArcaneBloodstream))
				fairyCounter += 3;
			if (hasPerk(MutationsLib.FeyArcaneBloodstreamPrimitive))
				fairyCounter += 3;
			if (hasPerk(MutationsLib.FeyArcaneBloodstreamEvolved))
				fairyCounter += 3;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				fairyCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && fairyCounter >= 4)
				fairyCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && fairyCounter >= 8)
				fairyCounter += 1;
			if (hasPerk(PerkLib.TransformationImmunityFairy))
				fairyCounter += 5;
			if (isGargoyle()) fairyCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) fairyCounter = 0;
			fairyCounter = finalRacialScore(fairyCounter, Race.FAIRY);
			End("Player","racialScore");
			return fairyCounter;
		}

		//Determine cat Rating
		public function catScore():Number {
			Begin("Player","racialScore","cat");
			var catCounter:Number = 0;
			if (faceType == Face.CAT || faceType == Face.CAT_CANINES)
				catCounter++;
			if (faceType == Face.CHESHIRE || faceType == Face.CHESHIRE_SMILE)
				catCounter -= 7;
			if (eyes.type == Eyes.CAT)
				catCounter++;
			if (ears.type == Ears.CAT)
				catCounter++;
			if (eyes.type == Eyes.FERAL)
				catCounter -= 11;
			if (tongue.type == Tongue.CAT)
				catCounter++;
			if (tailType == Tail.CAT)
				catCounter++;
			if (arms.type == Arms.CAT)
				catCounter++;
			if (lowerBody == LowerBody.CAT)
				catCounter++;
			if (catCocks() > 0)
				catCounter++;
			if (breastRows.length > 1 && catCounter > 0)
				catCounter++;
			if (breastRows.length == 3 && catCounter > 0)
				catCounter++;
			if (breastRows.length > 3)
				catCounter -= 2;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				catCounter++;
			if (horns.type == Horns.DEMON || horns.type == Horns.DRACONIC_X2 || horns.type == Horns.DRACONIC_X4_12_INCH_LONG)
				catCounter -= 2;
			if (wings.type == Wings.BAT_LIKE_TINY || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.BAT_LIKE_LARGE || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.BAT_LIKE_LARGE_2 || wings.type == Wings.DRACONIC_HUGE)
				catCounter -= 2;
			if (hasPerk(PerkLib.Flexibility))
				catCounter++;
			if (hasPerk(MutationsLib.CatlikeNimbleness))
				catCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessPrimitive))
				catCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessEvolved))
				catCounter++;
			if (hasPerk(MutationsLib.CatlikeNimbleness) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				catCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				catCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				catCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && catCounter >= 4)
				catCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && catCounter >= 8)
				catCounter += 1;
			if (arms.type == Arms.SPHINX || wings.type == Wings.FEATHERED_SPHINX || tailType == Tail.MANTICORE_PUSSYTAIL || tailType == Tail.NEKOMATA_FORKED_1_3 || tailType == Tail.NEKOMATA_FORKED_2_3 || (tailType == Tail.CAT && tailCount > 1) || rearBody.type == RearBody.LION_MANE || (hairColor == "lilac and white striped" && coatColor == "lilac and white striped") || eyes.type == Eyes.INFERNAL || hairType == Hair.BURNING || tailType == Tail.BURNING
			 || eyes.type == Eyes.DISPLACER || ears.type == Ears.DISPLACER || arms.type == Arms.DISPLACER || rearBody.type == RearBody.DISPLACER_TENTACLES) catCounter = 0;
			if (isGargoyle()) catCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) catCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				catCounter += 50;
			catCounter = finalRacialScore(catCounter, Race.CAT);
			End("Player","racialScore");
			return catCounter;
		}

		//Determine nekomata Rating
		public function nekomataScore():Number {
			Begin("Player","racialScore","nekomata");
			var nekomataCounter:Number = 0;
			if (faceType == Face.CAT_CANINES)
				nekomataCounter++;
			if (eyes.type == Eyes.CAT)
				nekomataCounter++;
			if (ears.type == Ears.CAT)
				nekomataCounter++;
			if (tongue.type == Tongue.CAT)
				nekomataCounter++;
			if (tailType == Tail.CAT)
				nekomataCounter++;
			if (rearBody.type == RearBody.LION_MANE)
				nekomataCounter++;
			if (tailType == Tail.NEKOMATA_FORKED_1_3)
				nekomataCounter += 2;
			if (tailType == Tail.NEKOMATA_FORKED_2_3)
				nekomataCounter += 3;
			if (tailType == Tail.CAT && tailCount == 2)
				nekomataCounter += 4;
			if (arms.type == Arms.CAT)
				nekomataCounter++;
			if (lowerBody == LowerBody.CAT)
				nekomataCounter++;
			if (hasPartialCoat(Skin.FUR))
				nekomataCounter++;
			if (hasPerk(PerkLib.Flexibility))
				nekomataCounter++;
			if (hasPerk(PerkLib.Necromancy))
				nekomataCounter++;
			if (hasPerk(MutationsLib.CatlikeNimbleness))
				nekomataCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessPrimitive))
				nekomataCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessEvolved))
				nekomataCounter++;
			if (hasPerk(MutationsLib.CatlikeNimbleness) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				nekomataCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				nekomataCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				nekomataCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && nekomataCounter >= 4)
				nekomataCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && nekomataCounter >= 8)
				nekomataCounter += 1;
			if (catScore() >= 8 || (hairColor == "lilac and white striped" && coatColor == "lilac and white striped") || eyes.type == Eyes.INFERNAL || hairType == Hair.BURNING || tailType == Tail.BURNING || eyes.type == Eyes.DISPLACER || ears.type == Ears.DISPLACER || arms.type == Arms.DISPLACER || rearBody.type == RearBody.DISPLACER_TENTACLES) nekomataCounter = 0;
			if (isGargoyle()) nekomataCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) nekomataCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				nekomataCounter += 50;
			nekomataCounter = finalRacialScore(nekomataCounter, Race.NEKOMATA);
			End("Player","racialScore");
			return nekomataCounter;
		}

		//Determine cheshire Rating
		public function cheshireScore():Number {
			Begin("Player","racialScore","cheshire");
			var cheshireCounter:Number = 0;
			if (faceType == Face.CHESHIRE || faceType == Face.CHESHIRE_SMILE)
				cheshireCounter += 2;
			if (eyes.type == Eyes.CAT)
				cheshireCounter++;
			if (ears.type == Ears.CAT)
				cheshireCounter++;
			if (tongue.type == Tongue.CAT)
				cheshireCounter++;
			if (tailType == Tail.CAT)
				cheshireCounter++;
			if (arms.type == Arms.CAT)
				cheshireCounter++;
			if (lowerBody == LowerBody.CAT)
				cheshireCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				cheshireCounter++;
			if (hairColor == "lilac and white striped" && coatColor == "lilac and white striped")
				cheshireCounter += 2;
			if (hasPerk(PerkLib.Flexibility))
				cheshireCounter++;
			if (hasPerk(MutationsLib.CatlikeNimbleness))
				cheshireCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessPrimitive))
				cheshireCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessEvolved))
				cheshireCounter++;
			if (hasPerk(MutationsLib.CatlikeNimbleness) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				cheshireCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				cheshireCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				cheshireCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && cheshireCounter >= 4)
				cheshireCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && cheshireCounter >= 8)
				cheshireCounter += 1;
			if (catScore() >= 8 || tailType == Tail.NEKOMATA_FORKED_1_3 || tailType == Tail.NEKOMATA_FORKED_2_3 || (tailType == Tail.CAT && tailCount > 1) || eyes.type == Eyes.INFERNAL || hairType == Hair.BURNING || tailType == Tail.BURNING || tailType == Tail.TWINKASHA
			 || eyes.type == Eyes.DISPLACER || ears.type == Ears.DISPLACER || arms.type == Arms.DISPLACER || rearBody.type == RearBody.DISPLACER_TENTACLES) cheshireCounter = 0;
			if (isGargoyle()) cheshireCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) cheshireCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				cheshireCounter += 50;
			cheshireCounter = finalRacialScore(cheshireCounter, Race.CHESHIRE);
			End("Player","racialScore");
			return cheshireCounter;
		}

		//Determine hellcat Rating
		public function hellcatScore():Number {
			Begin("Player","racialScore","hellcat");
			var hellcatCounter:Number = 0;
			if (faceType == Face.CAT || faceType == Face.CAT_CANINES)
				hellcatCounter++;
			if (eyes.type == Eyes.INFERNAL)
				hellcatCounter++;
			if (ears.type == Ears.CAT)
				hellcatCounter++;
			if (tongue.type == Tongue.CAT)
				hellcatCounter++;
			if (hairType == Hair.BURNING)
				hellcatCounter++;
			if (tailType == Tail.BURNING)
				hellcatCounter++;
			if (tailType == Tail.TWINKASHA && tailCount == 2)
				hellcatCounter+=3;
			if (arms.type == Arms.CAT)
				hellcatCounter++;
			if (lowerBody == LowerBody.CAT)
				hellcatCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				hellcatCounter++;
			if (coatColor == "midnight black")
				hellcatCounter++;
			if (skin.base.color == "ashen")
				hellcatCounter++;
			if (hasPerk(PerkLib.Flexibility))
				hellcatCounter++;
			if (hasPerk(MutationsLib.CatlikeNimbleness))
				hellcatCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessPrimitive))
				hellcatCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessEvolved))
				hellcatCounter++;
			if (hasPerk(MutationsLib.CatlikeNimbleness) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				hellcatCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				hellcatCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				hellcatCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && hellcatCounter >= 4)
				hellcatCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && hellcatCounter >= 8)
				hellcatCounter += 1;
			if (catScore() >= 8 || tailType == Tail.NEKOMATA_FORKED_1_3 || tailType == Tail.NEKOMATA_FORKED_2_3 || (tailType == Tail.CAT && tailCount > 1) || (hairColor == "lilac and white striped" && coatColor == "lilac and white striped") || eyes.type != Eyes.INFERNAL || hairType != Hair.BURNING || (tailType != Tail.BURNING && tailType != Tail.TWINKASHA)
			 || eyes.type == Eyes.DISPLACER || ears.type == Ears.DISPLACER || arms.type == Arms.DISPLACER || rearBody.type == RearBody.DISPLACER_TENTACLES) hellcatCounter = 0;
			if (isGargoyle()) hellcatCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) hellcatCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				hellcatCounter += 50;
			hellcatCounter = finalRacialScore(hellcatCounter, Race.HELLCAT);
			End("Player","racialScore");
			return hellcatCounter;
		}

		//Determine displacer beast Rating
		public function displacerbeastScore():Number {
			Begin("Player","racialScore","displacerbeast");
			var displacerbeastCounter:Number = 0;
			if (faceType == Face.CAT || faceType == Face.CAT_CANINES)
				displacerbeastCounter++;
			if (eyes.type == Eyes.DISPLACER && eyes.colour == "yellow")
				displacerbeastCounter++;
			if (tongue.type == Tongue.CAT)
				displacerbeastCounter++;
			if (ears.type == Ears.DISPLACER)
				displacerbeastCounter++;
			if (tailType == Tail.CAT)
				displacerbeastCounter++;
			if (lowerBody == LowerBody.LION)
				displacerbeastCounter++;
			if (arms.type == Arms.DISPLACER)
				displacerbeastCounter += 3;
			if (rearBody.type == RearBody.DISPLACER_TENTACLES)
				displacerbeastCounter += 2;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				displacerbeastCounter++;
			if (InCollection(coatColor, ["black", "midnight black", "midnight"]))
				displacerbeastCounter++;
			if (skin.base.color == "dark gray")
				displacerbeastCounter++;
			if (hasPerk(PerkLib.Flexibility))
				displacerbeastCounter++;
			if (hasPerk(MutationsLib.CatlikeNimbleness))
				displacerbeastCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessPrimitive))
				displacerbeastCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessEvolved))
				displacerbeastCounter++;
			if (hasPerk(MutationsLib.DisplacerMetabolism))
				displacerbeastCounter++;
			if (hasPerk(MutationsLib.DisplacerMetabolismPrimitive))
				displacerbeastCounter++;
			if ((hasPerk(MutationsLib.CatlikeNimbleness) || hasPerk(MutationsLib.DisplacerMetabolism)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				displacerbeastCounter++;
			if ((hasPerk(MutationsLib.CatlikeNimblenessPrimitive) || hasPerk(MutationsLib.DisplacerMetabolismPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				displacerbeastCounter++;
			if (hasPerk(MutationsLib.LactaBovinaOvariesEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				displacerbeastCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && displacerbeastCounter >= 4)
				displacerbeastCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && displacerbeastCounter >= 8)
				displacerbeastCounter += 1;
			if (catScore() >= 8 || tailType == Tail.NEKOMATA_FORKED_1_3 || tailType == Tail.NEKOMATA_FORKED_2_3 || (tailType == Tail.CAT && tailCount > 1) || rearBody.type == RearBody.LION_MANE || (hairColor == "lilac and white striped" && coatColor == "lilac and white striped") || eyes.type == Eyes.INFERNAL || hairType == Hair.BURNING || tailType == Tail.BURNING) displacerbeastCounter = 0;
			if (isGargoyle()) displacerbeastCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) displacerbeastCounter = 0;
			if (arms.type != Arms.DISPLACER || rearBody.type != RearBody.DISPLACER_TENTACLES) displacerbeastCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage)) displacerbeastCounter += 50;
			displacerbeastCounter = finalRacialScore(displacerbeastCounter, Race.DISPLACERBEAST);
			End("Player","racialScore");
			return displacerbeastCounter;
		}

		//Determine lizard rating
		public function lizardScore():Number {
			Begin("Player","racialScore","lizard");
			var lizardCounter:Number = 0;
			if (faceType == Face.LIZARD)
				lizardCounter++;
			if (ears.type == Ears.LIZARD)
				lizardCounter++;
			if (eyes.type == Eyes.LIZARD)
				lizardCounter++;
			if (tailType == Tail.LIZARD)
				lizardCounter++;
			if (arms.type == Arms.LIZARD)
				lizardCounter++;
			if (lowerBody == LowerBody.LIZARD)
				lizardCounter++;
			if (horns.count > 0 && (horns.type == Horns.DRACONIC_X2 || horns.type == Horns.DRACONIC_X4_12_INCH_LONG))
				lizardCounter++;
			if (hasScales())
				lizardCounter++;
			if (lizardCocks() > 0)
				lizardCounter++;
			if (lizardCounter > 0 && hasPerk(PerkLib.LizanRegeneration))
				lizardCounter++;
			if (hasPerk(MutationsLib.LizanMarrow))
				lizardCounter++;
			if (hasPerk(MutationsLib.LizanMarrowPrimitive))
				lizardCounter++;
			if (hasPerk(MutationsLib.LizanMarrowEvolved))
				lizardCounter++;
			if (hasPerk(MutationsLib.LizanMarrow) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				lizardCounter++;
			if (hasPerk(MutationsLib.LizanMarrowPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				lizardCounter++;
			if (hasPerk(MutationsLib.LizanMarrowEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				lizardCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				lizardCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && lizardCounter >= 4)
				lizardCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && lizardCounter >= 8)
				lizardCounter += 1;
			if (isGargoyle()) lizardCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) lizardCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage)) lizardCounter += 50;
			lizardCounter = finalRacialScore(lizardCounter, Race.LIZARD);
			End("Player","racialScore");
			return lizardCounter;
		}

		public function spiderScore():Number {
			Begin("Player","racialScore","spider");
			var spiderCounter:Number = 0;
			var spiderCounter2:Number = 0;
			if (eyes.type == Eyes.SPIDER) {
				spiderCounter++;
				spiderCounter2++;
			}
			if (faceType == Face.SPIDER_FANGS) {
				spiderCounter++;
				spiderCounter2++;
			}
			if (ears.type == Ears.ELFIN)
				spiderCounter++;
			if (arms.type == Arms.SPIDER) {
				spiderCounter++;
				spiderCounter2++;
			}
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS) {
				spiderCounter++;
				spiderCounter2++;
			}
			if (lowerBody == LowerBody.DRIDER) {
				spiderCounter += 2;
				spiderCounter2 += 2;
			}
			if (tailType == Tail.SPIDER_ADBOMEN) {
				spiderCounter++;
				spiderCounter2++;
			}
			if (hasPartialCoat(Skin.CHITIN))
				spiderCounter++;
			if (hasStatusEffect(StatusEffects.BlackNipples))
				spiderCounter++;
			if (hasPerk(PerkLib.SpiderOvipositor))
				spiderCounter++;
			if (hasPerk(MutationsLib.VenomGlands))
				spiderCounter++;
			if (hasPerk(MutationsLib.VenomGlandsPrimitive))
				spiderCounter++;
			if (hasPerk(MutationsLib.VenomGlandsEvolved))
				spiderCounter++;
			if (hasPerk(MutationsLib.ArachnidBookLung))
				spiderCounter+=2;
			if (hasPerk(MutationsLib.ArachnidBookLungPrimitive))
				spiderCounter+=2;
			if (hasPerk(MutationsLib.ArachnidBookLungEvolved))
				spiderCounter+=2;
			if (spiderCounter > 0 && hasPerk(MutationsLib.TrachealSystem))
				spiderCounter++;
			if (spiderCounter > 3 && hasPerk(MutationsLib.TrachealSystemPrimitive))
				spiderCounter++;
			if (spiderCounter > 6 && hasPerk(MutationsLib.TrachealSystemEvolved))
				spiderCounter++;
			if (spiderCounter > 9 && hasPerk(MutationsLib.TrachealSystemFinalForm))
				spiderCounter++;
			if ((hasPerk(MutationsLib.VenomGlands) || hasPerk(MutationsLib.ArachnidBookLung) || hasPerk(MutationsLib.TrachealSystem)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				spiderCounter++;
			if ((hasPerk(MutationsLib.VenomGlandsPrimitive) || hasPerk(MutationsLib.ArachnidBookLungPrimitive) || hasPerk(MutationsLib.TrachealSystemPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				spiderCounter++;
			if ((hasPerk(MutationsLib.VenomGlandsEvolved) || hasPerk(MutationsLib.ArachnidBookLungEvolved) || hasPerk(MutationsLib.TrachealSystemEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				spiderCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				spiderCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && spiderCounter >= 4)
				spiderCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && spiderCounter >= 8)
				spiderCounter += 1;
			if (spiderCounter2 < 4) spiderCounter = spiderCounter2;
			if (spiderCounter < 0) spiderCounter = 0;
			if (isGargoyle()) spiderCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) spiderCounter = 0;
			spiderCounter = finalRacialScore(spiderCounter, Race.SPIDER);
			End("Player","racialScore");
			return spiderCounter;
		}

		//Determine Horse Rating
		public function horseScore():Number {
			Begin("Player","racialScore","horse");
			var horseCounter:Number = 0;
			if (faceType == Face.HORSE)
				horseCounter++;
			if (ears.type == Ears.HORSE)
				horseCounter++;
			if (horns.type == Horns.UNICORN)
				horseCounter = 0;
			if (tailType == Tail.HORSE)
				horseCounter++;
			if (lowerBody == LowerBody.HOOFED || lowerBody == LowerBody.CENTAUR)
				horseCounter++;
			if (horseCocks() > 0)
				horseCounter++;
			if (hasVagina() && vaginaType() == VaginaClass.EQUINE)
				horseCounter++;
			if (hasFur()) {
				horseCounter++;
				if (arms.type == Arms.HUMAN)
					horseCounter++;
			}
			if (isTaur()) {
				if (horseCounter >= 7) horseCounter -= 7;
				else horseCounter = 0;
			}
			if (unicornScore() > 9 || alicornScore() > 11) {
				if (horseCounter >= 7) horseCounter -= 7;
				else horseCounter = 0;
			}
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				horseCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && horseCounter >= 4)
				horseCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && horseCounter >= 8)
				horseCounter += 1;
			if (isGargoyle()) horseCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) horseCounter = 0;
			horseCounter = finalRacialScore(horseCounter, Race.HORSE);
			End("Player","racialScore");
			return horseCounter;
		}

		//Determine kitsune Rating
		public function kitsuneScore():Number {
			Begin("Player","racialScore","kitsune");
			var kitsuneCounter:Number = 0;
			var kitsuneCounter2:Number = 0;
			if (eyes.type == Eyes.FOX) {
				kitsuneCounter++;
				kitsuneCounter2++;
			}
			if (ears.type == Ears.FOX) {
				kitsuneCounter++;
				kitsuneCounter2++;
			}
			//If the character has ears other than fox ears, -1
			if (ears.type != Ears.FOX)
				kitsuneCounter--;
			if (tailType == Tail.FOX && tailCount >= 2) {
				kitsuneCounter += tailCount;
				kitsuneCounter2 += tailCount;
			}
			if (tailType != Tail.FOX || (tailType == Tail.FOX && tailCount < 2))
				kitsuneCounter -= 7;
			if (skin.base.pattern == Skin.PATTERN_MAGICAL_TATTOO || hasFur()) {
				kitsuneCounter++;
				kitsuneCounter2++;
			}
			if (skin.base.type == Skin.PLAIN)
				kitsuneCounter ++;
			if (InCollection(hairColor, KitsuneScene.basicKitsuneHair) || InCollection(hairColor, KitsuneScene.elderKitsuneColors))
				kitsuneCounter++;
			if (hasCoat() && !hasCoatOfType(Skin.FUR))
				kitsuneCounter -= 2;
			if (skin.base.type != Skin.PLAIN)
				kitsuneCounter -= 3;
			if (arms.type == Arms.HUMAN || arms.type == Arms.KITSUNE || arms.type == Arms.FOX) {
				kitsuneCounter++;
				kitsuneCounter2++;
			}
			if (lowerBody == LowerBody.FOX || lowerBody == LowerBody.HUMAN) {
				kitsuneCounter++;
				kitsuneCounter2++;
			}
			if (lowerBody != LowerBody.HUMAN && lowerBody != LowerBody.FOX)
				kitsuneCounter--;
			if (faceType == Face.ANIMAL_TOOTHS || faceType == Face.HUMAN || faceType == Face.FOX) {
				kitsuneCounter++;
				kitsuneCounter2++;
			}
			if (faceType != Face.ANIMAL_TOOTHS || faceType != Face.HUMAN && faceType != Face.FOX)
				kitsuneCounter--;
			//If the character has a 'vag of holding', +1
			if (vaginalCapacity() >= 8000)
				kitsuneCounter++;
			//When character get Hoshi no tama
			if (hasPerk(PerkLib.StarSphereMastery))
				kitsuneCounter++;
			if (hasPerk(PerkLib.EnlightenedKitsune) || hasPerk(PerkLib.CorruptedKitsune))
				kitsuneCounter++;
			if (hasPerk(PerkLib.NinetailsKitsuneOfBalance))
				kitsuneCounter++;
			if (hasPerk(MutationsLib.KitsuneThyroidGland))
				kitsuneCounter++;
			if (hasPerk(MutationsLib.KitsuneThyroidGlandPrimitive))
				kitsuneCounter++;
			if (hasPerk(MutationsLib.KitsuneThyroidGlandEvolved))
				kitsuneCounter++;
			if (hasPerk(MutationsLib.KitsuneParathyroidGlands))
				kitsuneCounter++;
			if (hasPerk(MutationsLib.KitsuneParathyroidGlandsEvolved))
				kitsuneCounter++;
			if (hasPerk(MutationsLib.KitsuneParathyroidGlandsFinalForm))
				kitsuneCounter++;
			if ((hasPerk(MutationsLib.KitsuneThyroidGland) || hasPerk(MutationsLib.KitsuneParathyroidGlands)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				kitsuneCounter++;
			if ((hasPerk(MutationsLib.KitsuneThyroidGlandPrimitive) || hasPerk(MutationsLib.KitsuneParathyroidGlandsEvolved)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				kitsuneCounter++;
			if ((hasPerk(MutationsLib.KitsuneThyroidGlandEvolved) || hasPerk(MutationsLib.KitsuneParathyroidGlandsFinalForm)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				kitsuneCounter++;
			if (hasPerk(PerkLib.KitsunesDescendant) || hasPerk(PerkLib.BloodlineKitsune))
				kitsuneCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				kitsuneCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && kitsuneCounter >= 4)
				kitsuneCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && kitsuneCounter >= 8)
				kitsuneCounter++;
			if (kitsuneCounter2 < 5) kitsuneCounter = kitsuneCounter2;
			if (isGargoyle()) kitsuneCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) kitsuneCounter = 0;
			kitsuneCounter = finalRacialScore(kitsuneCounter, Race.KITSUNE);
			End("Player","racialScore");
			return kitsuneCounter;
		}

		//Determine Dragon Rating
		public function dragonScore():Number {
			Begin("Player","racialScore","dragon");
			var dragonCounter:Number = 0;
			var dragonCounter2:Number = 0;
			if (faceType == Face.DRAGON || faceType == Face.DRAGON_FANGS) {
				dragonCounter++;
				dragonCounter2++;
			}
			if (faceType == Face.JABBERWOCKY || faceType == Face.BUCKTOOTH)
				dragonCounter -= 10;
			if (eyes.type == Eyes.DRACONIC) {
				dragonCounter++;
				dragonCounter2++;
			}
			if (ears.type == Ears.DRAGON) {
				dragonCounter++;
				dragonCounter2++;
			}
			if (tailType == Tail.DRACONIC) {
				dragonCounter++;
				dragonCounter2++;
			}
			if (tongue.type == Tongue.DRACONIC) {
				dragonCounter++;
				dragonCounter2++;
			}
			if (wings.type == Wings.DRACONIC_SMALL) {
				dragonCounter++;
				dragonCounter2++;
			}
			if (wings.type == Wings.DRACONIC_LARGE) {
				dragonCounter += 2;
				dragonCounter2 += 2;
			}
			if (wings.type == Wings.DRACONIC_HUGE) {
				dragonCounter += 4;
				dragonCounter2 += 4;
			}
			if (wings.type == Wings.FEY_DRAGON || lowerBody == LowerBody.FROSTWYRM)
				dragonCounter -= 10;
			if (lowerBody == LowerBody.DRAGON) {
				dragonCounter++;
				dragonCounter2++;
			}
			if (arms.type == Arms.DRACONIC) {
				dragonCounter++;
				dragonCounter2++;
			}
			if (hasPartialCoat(Skin.DRAGON_SCALES) || hasCoatOfType(Skin.DRAGON_SCALES)) {
				dragonCounter++;
				dragonCounter2++;
			}
			if (horns.type == Horns.DRACONIC_X4_12_INCH_LONG) {
				dragonCounter += 2;
				dragonCounter2 += 2;
			}
			if (horns.type == Horns.DRACONIC_X2) {
				dragonCounter++;
				dragonCounter2++;
			}
			if (horns.type == Horns.FROSTWYRM)
				dragonCounter -= 3;
			if (dragonCocks() > 0 || hasVagina())
				dragonCounter++;
			if (tallness > 120 && dragonCounter >= 8)
				dragonCounter++;
			if (dragonCounter >= 8 && (hasPerk(PerkLib.DragonFireBreath) || hasPerk(PerkLib.DragonIceBreath) || hasPerk(PerkLib.DragonLightningBreath) || hasPerk(PerkLib.DragonDarknessBreath))) {
				dragonCounter++;
				if (hasPerk(PerkLib.DragonFireBreath) && hasPerk(PerkLib.DragonIceBreath) && hasPerk(PerkLib.DragonLightningBreath) && hasPerk(PerkLib.DragonDarknessBreath)) {
					dragonCounter++;
				}
			}
			if (hasPerk(MutationsLib.DraconicBones))
				dragonCounter++;
			if (hasPerk(MutationsLib.DraconicBonesPrimitive))
				dragonCounter++;
			if (hasPerk(MutationsLib.DraconicBonesEvolved))
				dragonCounter++;
			if (hasPerk(MutationsLib.DraconicHeart))
				dragonCounter++;
			if (hasPerk(MutationsLib.DraconicHeartPrimitive))
				dragonCounter++;
			if (hasPerk(MutationsLib.DraconicHeartEvolved))
				dragonCounter++;
			if (hasPerk(MutationsLib.DraconicLungs))
				dragonCounter++;
			if (hasPerk(MutationsLib.DraconicLungsPrimitive))
				dragonCounter++;
			if (hasPerk(MutationsLib.DraconicLungsEvolved))
				dragonCounter++;
			if ((hasPerk(MutationsLib.DraconicBones) || hasPerk(MutationsLib.DraconicHeart) || hasPerk(MutationsLib.DraconicLungs)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				dragonCounter++;
			if ((hasPerk(MutationsLib.DraconicBonesPrimitive) || hasPerk(MutationsLib.DraconicHeartPrimitive) || hasPerk(MutationsLib.DraconicLungsPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				dragonCounter++;
			if ((hasPerk(MutationsLib.DraconicBonesEvolved) || hasPerk(MutationsLib.DraconicHeartEvolved) || hasPerk(MutationsLib.DraconicLungsEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				dragonCounter++;
			if (hasPerk(PerkLib.DragonsDescendant) || hasPerk(PerkLib.BloodlineDragon))
				dragonCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				dragonCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && dragonCounter >= 4)
				dragonCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && dragonCounter >= 8)
				dragonCounter++;
			if (dragonCounter2 < 5) dragonCounter = dragonCounter2;
			if (isGargoyle()) dragonCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) dragonCounter = 0;
			dragonCounter = finalRacialScore(dragonCounter, Race.DRAGON);
			End("Player","racialScore");
			return dragonCounter;
		}

		//Determine Jabberwocky Rating
		public function jabberwockyScore():Number {
			Begin("Player","racialScore","jabberwocky");
			var jabberwockyCounter:Number = 0;
			var jabberwockyCounter2:Number = 0;
			if (faceType == Face.JABBERWOCKY || faceType == Face.BUCKTOOTH) {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (faceType == Face.DRAGON || faceType == Face.DRAGON_FANGS)
				jabberwockyCounter -= 10;
			if (eyes.type == Eyes.DRACONIC) {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (eyes.colour == "red") {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (InCollection(hairColor, ["purplish-pink"])) {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (InCollection(coatColor, ["magenta"])) {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (InCollection(skinTone, ["caramel"])) {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (ears.type == Ears.BUNNY) {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (tailType == Tail.DRACONIC) {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (tongue.type == Tongue.DRACONIC) {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (antennae.type == Antennae.JABBERWOCKY) {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (wings.type == Wings.FEY_DRAGON) {
				jabberwockyCounter += 4;
				jabberwockyCounter2 += 4;
			}
			if (wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE)
				jabberwockyCounter -= 10;
			if (lowerBody == LowerBody.JABBERWOCKY) {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (arms.type == Arms.JABBERWOCKY) {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (tallness > 120 && jabberwockyCounter >= 10)
				jabberwockyCounter++;
			if (hasPartialCoat(Skin.DRAGON_SCALES) || hasCoatOfType(Skin.DRAGON_SCALES)) {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (InCollection(coatColor, ["pink"])) {
				jabberwockyCounter++;
				jabberwockyCounter2++;
			}
			if (horns.type == Horns.JABBERWOCKY) {
				jabberwockyCounter += 2;
				jabberwockyCounter2 += 2;
			}
			if (dragonCocks() > 0 || hasVagina())
				jabberwockyCounter++;
			if (jabberwockyCounter >= 5 && (hasPerk(PerkLib.DragonLustPoisonBreath)))
				jabberwockyCounter++;
			if (hasPerk(PerkLib.Insanity))
				jabberwockyCounter++;
			//if (hasPerk(PerkLib.JabberwockyMarrow)) (regeneration)
			//	jabberwockyCounter++;
			//if (hasPerk(PerkLib.JabberwockyMarrowEvolved)) (regeneration)
			//	jabberwockyCounter++;
			//if (hasPerk(PerkLib.JabberwockyMarrowFinalForm)) (regeneration)
			//	jabberwockyCounter++;
			if (hasPerk(MutationsLib.DraconicBones))
				jabberwockyCounter++;
			if (hasPerk(MutationsLib.DraconicBonesPrimitive))
				jabberwockyCounter++;
			if (hasPerk(MutationsLib.DraconicBonesEvolved))
				jabberwockyCounter++;
			if (hasPerk(MutationsLib.DraconicHeart))
				jabberwockyCounter++;
			if (hasPerk(MutationsLib.DraconicHeartPrimitive))
				jabberwockyCounter++;
			if (hasPerk(MutationsLib.DraconicHeartEvolved))
				jabberwockyCounter++;
			if (hasPerk(MutationsLib.DrakeLungs))
				jabberwockyCounter++;
			if (hasPerk(MutationsLib.DrakeLungsPrimitive))
				jabberwockyCounter++;
			if (hasPerk(MutationsLib.DrakeLungsEvolved))
				jabberwockyCounter++;
			if ((hasPerk(MutationsLib.DraconicBones) || hasPerk(MutationsLib.DraconicHeart) || hasPerk(MutationsLib.DrakeLungs)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				jabberwockyCounter++;
			if ((hasPerk(MutationsLib.DraconicBonesPrimitive) || hasPerk(MutationsLib.DraconicHeartPrimitive) || hasPerk(MutationsLib.DrakeLungsPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				jabberwockyCounter++;
			if ((hasPerk(MutationsLib.DraconicBonesEvolved) || hasPerk(MutationsLib.DraconicHeartEvolved) || hasPerk(MutationsLib.DrakeLungsEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				jabberwockyCounter++;
			if (hasPerk(PerkLib.DragonsDescendant) || hasPerk(PerkLib.BloodlineDragon))
				jabberwockyCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.AscensionHybridTheory) && jabberwockyCounter >= 4)
				jabberwockyCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && jabberwockyCounter >= 8)
				jabberwockyCounter += 1;
			if ((faceType != Face.JABBERWOCKY && faceType != Face.BUCKTOOTH) || wings.type != Wings.FEY_DRAGON || lowerBody == LowerBody.FROSTWYRM) jabberwockyCounter = 0;
			if (jabberwockyCounter2 < 5) jabberwockyCounter = jabberwockyCounter2;
			if (isGargoyle()) jabberwockyCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) jabberwockyCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				jabberwockyCounter += 50;
			jabberwockyCounter = finalRacialScore(jabberwockyCounter, Race.JABBERWOCKY);
			End("Player","racialScore");
			return jabberwockyCounter;
		}

		//Goblin score
		public function goblinScore():Number
		{
			Begin("Player","racialScore","goblin");
			var goblinCounter:Number = 0;
			if (faceType == Face.HUMAN || faceType == Face.ANIMAL_TOOTHS)
				goblinCounter++;
			if (ears.type == Ears.ELFIN)
				goblinCounter++;
			if (tallness < 48)
				goblinCounter++;
			if (hasVagina())
				goblinCounter++;
			if (hasPlainSkinOnly()) {
				goblinCounter++;
				if (InCollection(skin.base.color, ["pale yellow", "grayish-blue", "green", "dark green", "emerald"]))
					goblinCounter++;
				if (eyes.type == Eyes.HUMAN && (InCollection(eyes.colour, ["red", "yellow", "purple"])))
					goblinCounter++;
				if (InCollection(hairColor, ["red", "purple", "green", "blue", "pink", "orange"]))
					goblinCounter++;
				if (arms.type == Arms.HUMAN)
					goblinCounter++;
				if (lowerBody == LowerBody.HUMAN)
					goblinCounter++;
				if (antennae.type == Antennae.NONE)
					goblinCounter++;
			}
			if (hasPerk(PerkLib.GoblinoidBlood))
				goblinCounter++;
			if (hasPerk(PerkLib.BouncyBody))
				goblinCounter++;
			if (hasPerk(MutationsLib.NaturalPunchingBag))
				goblinCounter++;
			if (hasPerk(MutationsLib.NaturalPunchingBagPrimitive))
				goblinCounter++;
			if (hasPerk(MutationsLib.NaturalPunchingBagEvolved))
				goblinCounter++;
			if (hasPerk(MutationsLib.NaturalPunchingBag) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				goblinCounter++;
			if (hasPerk(MutationsLib.NaturalPunchingBagPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				goblinCounter++;
			if (hasPerk(MutationsLib.NaturalPunchingBagEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				goblinCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && goblinCounter >= 4)
				goblinCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && goblinCounter >= 8)
				goblinCounter += 1;
			if (hasPerk(PerkLib.GoblinsDescendant) || hasPerk(PerkLib.BloodlineGoblin))
				goblinCounter += increaseFromBloodlinePerks();
			if (!InCollection(skin.base.color, ["pale yellow", "grayish-blue", "green", "dark green", "emerald"]))
				goblinCounter = 0;
			if (ears.type != Ears.ELFIN)
				goblinCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				goblinCounter += 50;
			if (isGargoyle()) goblinCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) goblinCounter = 0;
			goblinCounter = finalRacialScore(goblinCounter, Race.GOBLIN);
			End("Player","racialScore");
			return goblinCounter;
		}

		//Goblin score
		public function gremlinScore():Number
		{
			Begin("Player","racialScore","gremlin");
			var gremlinCounter:Number = 0;
			if (faceType == Face.CRAZY)
				gremlinCounter++;
			if (ears.type == Ears.GREMLIN)
				gremlinCounter++;
			if (hairType == Hair.CRAZY)
				gremlinCounter++;
			if (InCollection(eyes.colour, ["red", "yellow", "purple", "orange"]))
				gremlinCounter++;
			if (tallness < 48)
				gremlinCounter+=2;
			if (hasVagina())
				gremlinCounter++;
			if (hasPlainSkinOnly()) {
				gremlinCounter++;
				if (InCollection(skin.base.color, ["light", "tan", "dark"]))
					gremlinCounter++;
				if (InCollection(hairColor, ["emerald", "green", "dark green", "aqua", "light green"]))
					gremlinCounter++;
				if (arms.type == Arms.HUMAN)
					gremlinCounter++;
				if (lowerBody == LowerBody.HUMAN)
					gremlinCounter++;
				if (antennae.type == Antennae.NONE)
					gremlinCounter++;
				if (wings.type == Wings.NONE)
					gremlinCounter++;
				if (tail.type == Tail.NONE)
					gremlinCounter++;
			}
			if (femininity > 70)
				gremlinCounter+=2;
			if (cor >= 20)
				gremlinCounter++;
			if (cor >= 40)
				gremlinCounter++;
			if (hasPerk(PerkLib.GoblinoidBlood))
				gremlinCounter++;
			if (hasPerk(PerkLib.BouncyBody))
				gremlinCounter++;
			if (hasPerk(MutationsLib.NaturalPunchingBag))
				gremlinCounter++;
			if (hasPerk(MutationsLib.NaturalPunchingBagPrimitive))
				gremlinCounter++;
			if (hasPerk(MutationsLib.NaturalPunchingBagEvolved))
				gremlinCounter++;
			if (hasPerk(MutationsLib.NaturalPunchingBag) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				gremlinCounter++;
			if (hasPerk(MutationsLib.NaturalPunchingBagPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				gremlinCounter++;
			if (hasPerk(MutationsLib.NaturalPunchingBagEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				gremlinCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && gremlinCounter >= 4)
				gremlinCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && gremlinCounter >= 8)
				gremlinCounter += 1;
			if (hasPerk(PerkLib.GoblinsDescendant) || hasPerk(PerkLib.BloodlineGoblin))
				gremlinCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				gremlinCounter += 50;
		/*	if (hasPerk(PerkLib.Phylactery))
				gremlinCounter += 5;
			if (hasPerk(MutationsLib.BlackHeart))
				gremlinCounter++;
			if (hasPerk(MutationsLib.BlackHeartPrimitive))
				gremlinCounter++;
			if (hasPerk(MutationsLib.BlackHeartEvolved))
				gremlinCounter++;
			if (hasPerk(MutationsLib.BlackHeart) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				gremlinCounter++;
			if (hasPerk(MutationsLib.BlackHeartPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				gremlinCounter++;
			if (hasPerk(PerkLib.DemonicLethicite))
				gremlinCounter+=1;
		*/	if (!InCollection(skin.base.color, ["light", "tan", "dark"]))
				gremlinCounter=0;
			if (ears.type != Ears.GREMLIN)
				gremlinCounter=0;
			if (isGargoyle()) gremlinCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) gremlinCounter = 0;
			gremlinCounter = finalRacialScore(gremlinCounter, Race.GREMLIN);
			End("Player","racialScore");
			return gremlinCounter;
		}

		//Goo score
		public function gooScore():Number
		{
			Begin("Player","racialScore","goo");
			var gooCounter:Number = 0;
			if (InCollection(skin.base.color, ["green", "magenta", "blue", "cerulean", "emerald", "pink", "milky white"])) {
				gooCounter++;
				if (hairType == Hair.GOO)
					gooCounter++;
				if (arms.type == Arms.GOO)
					gooCounter++;
				if (lowerBody == LowerBody.GOO)
					gooCounter += 3;
				if (rearBody.type == RearBody.METAMORPHIC_GOO)
					gooCounter += 2;
				if (hasGooSkin() && skinAdj == "slimy") {
					gooCounter++;
					if (faceType == Face.HUMAN)
						gooCounter++;
					if (eyes.type == Eyes.HUMAN)
						gooCounter++;
					if (ears.type == Ears.HUMAN || ears.type == Ears.ELFIN)
						gooCounter++;
					if (tallness > 107)
						gooCounter++;
					if (hasVagina())
						gooCounter++;
					if (antennae.type == Antennae.NONE)
						gooCounter++;
					if (wings.type == Wings.NONE)
						gooCounter++;
					if (gills.type == Gills.NONE)
						gooCounter++;
				}
			}
			if (vaginalCapacity() >= 9000)
				gooCounter++;
			if (hasStatusEffect(StatusEffects.SlimeCraving))
				gooCounter++;
			if (hasPerk(PerkLib.SlimeCore))
				gooCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				gooCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && gooCounter >= 4)
				gooCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && gooCounter >= 8)
				gooCounter += 1;
			if (isGargoyle()) gooCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) gooCounter = 0;
			gooCounter = finalRacialScore(gooCounter, Race.SLIME);
			End("Player","racialScore");
			return gooCounter;
		}

		//Magma Goo score
		public function magmagooScore():Number
		{
			Begin("Player","racialScore","magmagoo");
			var magmagooCounter:Number = 0;
			if (InCollection(skin.base.color, ["red", "orange", "reddish orange"])) {
				magmagooCounter += 2;
				if (hairType == Hair.GOO)
					magmagooCounter++;
				if (arms.type == Arms.GOO)
					magmagooCounter++;
				if (lowerBody == LowerBody.GOO)
					magmagooCounter += 3;
				if (rearBody.type == RearBody.METAMORPHIC_GOO)
					magmagooCounter += 2;
				if (hasGooSkin() && skinAdj == "slimy") {
					magmagooCounter++;
					if (faceType == Face.HUMAN)
						magmagooCounter++;
					if (eyes.type == Eyes.HUMAN)
						magmagooCounter++;
					if (ears.type == Ears.HUMAN || ears.type == Ears.ELFIN)
						magmagooCounter++;
					if (tallness > 107)
						magmagooCounter++;
					if (hasVagina())
						magmagooCounter++;
					if (antennae.type == Antennae.NONE)
						magmagooCounter++;
					if (wings.type == Wings.NONE)
						magmagooCounter++;
					if (gills.type == Gills.NONE)
						magmagooCounter++;
				}
			}
			if (vaginalCapacity() >= 9000)
				magmagooCounter++;
			if (hasStatusEffect(StatusEffects.SlimeCraving))
				magmagooCounter++;
			if (hasPerk(PerkLib.MagmaSlimeCore))
				magmagooCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				magmagooCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && magmagooCounter >= 4)
				magmagooCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && magmagooCounter >= 8)
				magmagooCounter += 1;
			if (isGargoyle()) magmagooCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) magmagooCounter = 0;
			magmagooCounter = finalRacialScore(magmagooCounter, Race.MAGMASLIME);
			End("Player","racialScore");
			return magmagooCounter;
		}

		//Dark Goo score
		public function darkgooScore():Number
		{
			Begin("Player","racialScore","darkgoo");
			var darkgooCounter:Number = 0;
			if (InCollection(skin.base.color, ["indigo", "light purple", "purple", "purplish black", "dark purple"])) {
				darkgooCounter++;
				if (hairType == Hair.GOO)
					darkgooCounter++;
				if (arms.type == Arms.GOO)
					darkgooCounter++;
				if (lowerBody == LowerBody.GOO)
					darkgooCounter += 3;
				if (eyes.colour == "red")
					darkgooCounter ++;
				if (rearBody.type == RearBody.METAMORPHIC_GOO)
					darkgooCounter += 2;
				if (hasGooSkin() && skinAdj == "slimy") {
					darkgooCounter++;
					if (faceType == Face.HUMAN)
						darkgooCounter++;
					if (eyes.type == Eyes.HUMAN || eyes.type == Eyes.FIENDISH)
						darkgooCounter++;
					if (ears.type == Ears.HUMAN || ears.type == Ears.ELFIN)
						darkgooCounter++;
					if (tallness > 107)
						darkgooCounter++;
					if (hasVagina())
						darkgooCounter++;
					if (antennae.type == Antennae.NONE)
						darkgooCounter++;
					if (wings.type == Wings.NONE)
						darkgooCounter++;
					if (gills.type == Gills.NONE)
						darkgooCounter++;
				}
			}
			if (vaginalCapacity() >= 9000)
				darkgooCounter++;
			if (hasStatusEffect(StatusEffects.SlimeCraving))
				darkgooCounter++;
			if (hasPerk(PerkLib.DarkSlimeCore))
				darkgooCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				darkgooCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && darkgooCounter >= 4)
				darkgooCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && darkgooCounter >= 8)
				darkgooCounter += 1;
			if (isGargoyle()) darkgooCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) darkgooCounter = 0;
			darkgooCounter = finalRacialScore(darkgooCounter, Race.DARKSLIME);
			End("Player","racialScore");
			return darkgooCounter;
		}

		//Naga score
		public function nagaScore():Number {
			Begin("Player","racialScore","naga");
			var nagaCounter:Number = 0;
			if (isNaga()) {
				nagaCounter += 3;
				if (arms.type == Arms.HUMAN)
					nagaCounter++;
			}
			if (tongue.type == Tongue.SNAKE)
				nagaCounter++;
			if (faceType == Face.SNAKE_FANGS)
				nagaCounter++;
			if (hasPartialCoat(Skin.SCALES))
				nagaCounter++;
			if (eyes.type == Eyes.SNAKE)
				nagaCounter++;
			if (ears.type == Ears.SNAKE)
				nagaCounter++;
			if (hasVagina() && (vaginaType() == VaginaClass.NAGA) || (lizardCocks() > 0))
				nagaCounter++;
			if (hasPerk(MutationsLib.VenomGlands))
				nagaCounter++;
			if (hasPerk(MutationsLib.VenomGlandsPrimitive))
				nagaCounter++;
			if (hasPerk(MutationsLib.VenomGlandsEvolved))
				nagaCounter++;
			if (hasPerk(MutationsLib.VenomGlands) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				nagaCounter++;
			if (hasPerk(MutationsLib.VenomGlandsPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				nagaCounter++;
			if (hasPerk(MutationsLib.VenomGlandsEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				nagaCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && nagaCounter >= 4)
				nagaCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && nagaCounter >= 8)
				nagaCounter += 1;
			if (!isNaga() || hairType == Hair.GORGON || eyes.type == Eyes.GORGON || horns.type == Horns.DRACONIC_X4_12_INCH_LONG || horns.type == Horns.DRACONIC_X2 || tongue.type == Tongue.DRACONIC || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE || hairType == Hair.FEATHER || arms.type == Arms.HARPY || wings.type == Wings.FEATHERED_LARGE
			 || lowerBody == LowerBody.HYDRA || arms.type == Arms.HYDRA)
				nagaCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				nagaCounter += 50;
			if (isGargoyle()) nagaCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) nagaCounter = 0;
			nagaCounter = finalRacialScore(nagaCounter, Race.NAGA);
			End("Player","racialScore");
			return nagaCounter;
		}

		//Naga score
		public function apophisScore():Number {
			Begin("Player","racialScore","apophis");
			var ApophisCounter:Number = 0;
			if (isNaga()) {
				ApophisCounter += 3;
				if (arms.type == Arms.HUMAN)
					ApophisCounter++;
			}
			if (InCollection(hairColor, ("black", "midnight","midnight black")))
				ApophisCounter++;
			if (skinTone == "light purple")
				ApophisCounter++;
			if (InCollection(coatColor, ["black", "midnight", "midnight black"]))
				ApophisCounter++;
			if (tongue.type == Tongue.SNAKE)
				ApophisCounter++;
			if (faceType == Face.SNAKE_FANGS)
				ApophisCounter++;
			if (hasPartialCoat(Skin.SCALES))
				ApophisCounter++;
			if (eyes.type == Eyes.SNAKEFIENDISH && InCollection(eyes.colour,"yellow"))
				ApophisCounter+=2;
			if (ears.type == Ears.SNAKE)
				ApophisCounter++;
			if (rearBody.type == RearBody.COBRA_HOOD)
				ApophisCounter++;
			if (wings.type == Wings.NONE)
				ApophisCounter+=4;
			if (hasVagina() && (vaginaType() == VaginaClass.NAGA) || (lizardCocks() > 0))
				ApophisCounter++;
			if (cor >= 20)
				ApophisCounter++;
			if (cor >= 50)
				ApophisCounter++;
			if (cor >= 100)
				ApophisCounter+=2;
			if (hasPerk(MutationsLib.VenomGlands))
				ApophisCounter++;
			if (hasPerk(MutationsLib.VenomGlandsPrimitive))
				ApophisCounter++;
			if (hasPerk(MutationsLib.VenomGlandsEvolved))
				ApophisCounter++;
			if (hasPerk(MutationsLib.VenomGlands) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				ApophisCounter++;
			if (hasPerk(MutationsLib.VenomGlandsPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				ApophisCounter++;
			if (hasPerk(MutationsLib.VenomGlandsEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				ApophisCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && ApophisCounter >= 4)
				ApophisCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && ApophisCounter >= 8)
				ApophisCounter += 1;
			if (!isNaga() || hairType == Hair.GORGON || eyes.type == Eyes.GORGON || horns.type == Horns.DRACONIC_X4_12_INCH_LONG || horns.type == Horns.DRACONIC_X2 || tongue.type == Tongue.DRACONIC || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE || hairType == Hair.FEATHER || arms.type == Arms.HARPY || wings.type == Wings.FEATHERED_LARGE
					|| lowerBody == LowerBody.HYDRA || arms.type == Arms.HYDRA)
				ApophisCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				ApophisCounter += 50;
			if (isGargoyle()) ApophisCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) ApophisCounter = 0;
			ApophisCounter = finalRacialScore(ApophisCounter, Race.APOPHIS);
			End("Player","racialScore");
			return ApophisCounter;
		}

		//Gorgon score
		public function gorgonScore():Number {
			Begin("Player","racialScore","gorgon");
			var gorgonCounter:Number = 0;
			if (isNaga())
				gorgonCounter += 3;
			if (tongue.type == Tongue.SNAKE)
				gorgonCounter++;
			if (faceType == Face.SNAKE_FANGS)
				gorgonCounter++;
			if (arms.type == Arms.HUMAN)
				gorgonCounter++;
			if (hasCoatOfType(Skin.SCALES) || hasPartialCoat(Skin.SCALES))
				gorgonCounter++;
			if (ears.type == Ears.SNAKE)
				gorgonCounter++;
			if (eyes.type == Eyes.SNAKE)
				gorgonCounter++;
			if (eyes.type == Eyes.GORGON)
				gorgonCounter += 2;
			if (hairType == Hair.GORGON)
				gorgonCounter += 2;
			if (hasVagina() && (vaginaType() == VaginaClass.NAGA) || (lizardCocks() > 0))
				gorgonCounter++;
			if (hasPerk(MutationsLib.GorgonsEyes))
				gorgonCounter++;
			if (hasPerk(MutationsLib.GorgonsEyesPrimitive))
				gorgonCounter++;
			if (hasPerk(MutationsLib.VenomGlands))
				gorgonCounter++;
			if (hasPerk(MutationsLib.VenomGlandsPrimitive))
				gorgonCounter++;
			if (hasPerk(MutationsLib.VenomGlandsEvolved))
				gorgonCounter++;
			if ((hasPerk(MutationsLib.GorgonsEyes) || hasPerk(MutationsLib.VenomGlands)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				gorgonCounter++;
			if ((hasPerk(MutationsLib.GorgonsEyesPrimitive) || hasPerk(MutationsLib.VenomGlandsPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				gorgonCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && gorgonCounter >= 4)
				gorgonCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && gorgonCounter >= 8)
				gorgonCounter += 1;
			if (nagaScore() > 10 || horns.type == Horns.DRACONIC_X4_12_INCH_LONG || horns.type == Horns.DRACONIC_X2 || tongue.type == Tongue.DRACONIC || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE || hairType == Hair.FEATHER || arms.type == Arms.HARPY || wings.type == Wings.FEATHERED_LARGE
			 || lowerBody == LowerBody.HYDRA || arms.type == Arms.HYDRA)
				gorgonCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				gorgonCounter += 50;
			if (isGargoyle()) gorgonCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) gorgonCounter = 0;
			if (lowerBody != LowerBody.NAGA || wings.type == Wings.FEATHERED_LARGE || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE) gorgonCounter = 0;
			gorgonCounter = finalRacialScore(gorgonCounter, Race.GORGON);
			End("Player","racialScore");
			return gorgonCounter;
		}

		//Vouivre score
		public function vouivreScore():Number {
			Begin("Player","racialScore","vouivre");
			var vouivreCounter:Number = 0;
			if (isNaga())
				vouivreCounter += 3;
			if (tongue.type == Tongue.SNAKE || tongue.type == Tongue.DRACONIC)
				vouivreCounter++;
			if (faceType == Face.SNAKE_FANGS)
				vouivreCounter++;
			if (arms.type == Arms.DRACONIC)
				vouivreCounter++;
			if (hasCoatOfType(Skin.DRAGON_SCALES))
				vouivreCounter++;
			if (eyes.type == Eyes.SNAKE)
				vouivreCounter++;
			if (ears.type == Ears.DRAGON)
				vouivreCounter++;
			if (horns.type == Horns.DRACONIC_X4_12_INCH_LONG)
				vouivreCounter+= 2;
			if (horns.type == Horns.DRACONIC_X2)
				vouivreCounter++;
			if (wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE)
				vouivreCounter += 4;
			if (hasVagina() && (vaginaType() == VaginaClass.NAGA) || (lizardCocks() > 0))
				vouivreCounter++;
			if (vouivreCounter >= 11 && hasPerk(PerkLib.DragonFireBreath))
				vouivreCounter++;
			if (hasPerk(MutationsLib.DrakeLungs))
				vouivreCounter++;
			if (hasPerk(MutationsLib.DrakeLungsPrimitive))
				vouivreCounter++;
			if (hasPerk(MutationsLib.DrakeLungsEvolved))
				vouivreCounter++;
			if (hasPerk(MutationsLib.VenomGlands))
				vouivreCounter++;
			if (hasPerk(MutationsLib.VenomGlandsPrimitive))
				vouivreCounter++;
			if (hasPerk(MutationsLib.VenomGlandsEvolved))
				vouivreCounter++;
			if ((hasPerk(MutationsLib.DrakeLungs) || hasPerk(MutationsLib.VenomGlands)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				vouivreCounter++;
			if ((hasPerk(MutationsLib.DrakeLungsPrimitive) || hasPerk(MutationsLib.VenomGlandsPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				vouivreCounter++;
			if ((hasPerk(MutationsLib.DrakeLungsEvolved) || hasPerk(MutationsLib.VenomGlandsEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				vouivreCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && vouivreCounter >= 4)
				vouivreCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && vouivreCounter >= 8)
				vouivreCounter += 1;
			if (nagaScore() > 10 || hairType == Hair.GORGON || eyes.type == Eyes.GORGON || hairType == Hair.FEATHER || arms.type == Arms.HARPY || wings.type == Wings.FEATHERED_LARGE || lowerBody == LowerBody.HYDRA || arms.type == Arms.HYDRA)
				vouivreCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				vouivreCounter += 50;
			if (isGargoyle()) vouivreCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) vouivreCounter = 0;
			if (lowerBody != LowerBody.NAGA || wings.type == Wings.FEATHERED_LARGE || (wings.type != Wings.DRACONIC_SMALL && wings.type != Wings.DRACONIC_LARGE && wings.type != Wings.DRACONIC_HUGE)) vouivreCounter = 0;
			vouivreCounter = finalRacialScore(vouivreCounter, Race.VOUIVRE);
			End("Player","racialScore");
			return vouivreCounter;
		}

		//Couatl score
		public function couatlScore():Number {
			Begin("Player","racialScore","couatl");
			var couatlCounter:Number = 0;
			if (isNaga())
				couatlCounter += 3;
			if (tongue.type == Tongue.SNAKE)
				couatlCounter++;
			if (faceType == Face.SNAKE_FANGS)
				couatlCounter++;
			if (arms.type == Arms.HARPY)
				couatlCounter++;
			if (hasCoatOfType(Skin.SCALES))
				couatlCounter++;
			if (ears.type == Ears.SNAKE)
				couatlCounter++;
			if (eyes.type == Eyes.SNAKE)
				couatlCounter++;
			if (hairType == Hair.FEATHER)
				couatlCounter++;
			if (wings.type == Wings.FEATHERED_LARGE)
				couatlCounter += 4;
			if (hasVagina() && (vaginaType() == VaginaClass.NAGA) || (lizardCocks() > 0))
				couatlCounter++;
			if (hasPerk(MutationsLib.VenomGlands))
				couatlCounter++;
			if (hasPerk(MutationsLib.VenomGlandsPrimitive))
				couatlCounter++;
			if (hasPerk(MutationsLib.VenomGlandsEvolved))
				couatlCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStorm))
				couatlCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStormPrimitive))
				couatlCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStormEvolved))
				couatlCounter++;
			if ((hasPerk(MutationsLib.VenomGlands) || hasPerk(MutationsLib.HeartOfTheStorm)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				couatlCounter++;
			if ((hasPerk(MutationsLib.VenomGlandsPrimitive) || hasPerk(MutationsLib.HeartOfTheStormPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				couatlCounter++;
			if ((hasPerk(MutationsLib.VenomGlandsEvolved) || hasPerk(MutationsLib.HeartOfTheStormEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				couatlCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && couatlCounter >= 4)
				couatlCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && couatlCounter >= 8)
				couatlCounter += 1;
			if (nagaScore() > 10 || hairType == Hair.GORGON || eyes.type == Eyes.GORGON || horns.type == Horns.DRACONIC_X4_12_INCH_LONG || horns.type == Horns.DRACONIC_X2 || tongue.type == Tongue.DRACONIC || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE || lowerBody == LowerBody.HYDRA || arms.type == Arms.HYDRA)
				couatlCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				couatlCounter += 50;
			if (isGargoyle()) couatlCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) couatlCounter = 0;
			if (lowerBody != LowerBody.NAGA || wings.type != Wings.FEATHERED_LARGE || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE) couatlCounter = 0;
			couatlCounter = finalRacialScore(couatlCounter, Race.COUATL);
			End("Player","racialScore");
			return couatlCounter;
		}

		//hydra score
		public function hydraScore():Number {
			Begin("Player","racialScore","hydra");
			var hydraCounter:Number = 0;
			if (lowerBody == LowerBody.HYDRA && statusEffectv1(StatusEffects.HydraTailsPlayer) >= 2) {
				hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 3)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 4)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 5)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 6)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 7)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 8)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 9)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 10)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 11)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 12)
					hydraCounter++;
			}
			if (arms.type == Arms.HYDRA)
				hydraCounter++;
			if (hairType == Hair.NORMAL || hairType == Hair.GORGON)
				hydraCounter++;
			if (tongue.type == Tongue.SNAKE)
				hydraCounter++;
			if (faceType == Face.SNAKE_FANGS)
				hydraCounter++;
			if (hasPartialCoat(Skin.SCALES))
				hydraCounter++;
			if (eyes.type == Eyes.SNAKE)
				hydraCounter++;
			if (ears.type == Ears.SNAKE)
				hydraCounter++;
			if (wings.type == Wings.NONE)
				hydraCounter += 2;
			if (tallness >= 120)
				hydraCounter++;
			if (hasVagina() && (vaginaType() == VaginaClass.NAGA) || (lizardCocks() > 0))
				hydraCounter++;
			if (hasPerk(PerkLib.LizanRegeneration))
				hydraCounter++;
			if (hasPerk(PerkLib.HydraRegeneration))
				hydraCounter++;
			if (hasPerk(PerkLib.HydraAcidBreath))
				hydraCounter++;
			if (hasPerk(MutationsLib.VenomGlands))
				hydraCounter++;
			if (hasPerk(MutationsLib.VenomGlandsPrimitive))
				hydraCounter++;
			if (hasPerk(MutationsLib.VenomGlandsEvolved))
				hydraCounter++;
			if (hasPerk(MutationsLib.VenomGlands) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				hydraCounter++;
			if (hasPerk(MutationsLib.VenomGlandsPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				hydraCounter++;
			if (hasPerk(MutationsLib.VenomGlandsEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				hydraCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && hydraCounter >= 4)
				hydraCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && hydraCounter >= 8)
				hydraCounter += 1;
			if (nagaScore() > 10 || eyes.type == Eyes.GORGON || horns.type == Horns.DRACONIC_X4_12_INCH_LONG || horns.type == Horns.DRACONIC_X2 || tongue.type == Tongue.DRACONIC || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE || hairType == Hair.FEATHER || arms.type == Arms.HARPY || wings.type == Wings.FEATHERED_LARGE)
				hydraCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				hydraCounter += 50;
			if (isGargoyle()) hydraCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) hydraCounter = 0;
			hydraCounter = finalRacialScore(hydraCounter, Race.HYDRA);
			End("Player","racialScore");
			return hydraCounter;
		}

		//Fire snail score
		public function firesnailScore():Number {
			Begin("Player","racialScore","firesnail");
			var firesnailCounter:Number = 0;
			if (antennae.type == Antennae.FIRE_SNAIL)
				firesnailCounter++;
			if (eyes.type == Eyes.FIRE_SNAIL)
				firesnailCounter++;
			if (InCollection(skin.base.color, ["red", "orange","yellow"]))
				firesnailCounter++;
			if (eyes.type == Eyes.FIRE_SNAIL)
				firesnailCounter++;
			if (hasPlainSkinOnly() && skinAdj == "sticky glistering")
				firesnailCounter++;
			if (InCollection(skin.base.color, ["red", "orange"]))
				firesnailCounter++;
			if (hairType == Hair.BURNING)
				firesnailCounter++;
			if (faceType == Face.FIRE_SNAIL)
				firesnailCounter++;
			if (lowerBody == LowerBody.FIRE_SNAIL) {
				firesnailCounter++;
				if (tailType == Tail.NONE)
					firesnailCounter += 2;
			}
			if (rearBody.type == RearBody.SNAIL_SHELL) {
				firesnailCounter++;
				if (wings.type == Wings.NONE)
					firesnailCounter += 4;
			}
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				firesnailCounter += 50;
			if (isGargoyle()) firesnailCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) firesnailCounter = 0;
			firesnailCounter = finalRacialScore(firesnailCounter, Race.FIRESNAILS);
			End("Player","racialScore");
			return firesnailCounter;
		}

		//poltergeist score
		public function poltergeistScore():Number {
			Begin("Player","racialScore","poltergeist");
			var poltergeistCounter:Number = 0;
			if (hairType == Hair.GHOST)
				poltergeistCounter++;
			if (eyes.type == Eyes.GHOST)
				poltergeistCounter++;
			if (faceType == Face.GHOST)
				poltergeistCounter++;
			if (tongue.type == Tongue.GHOST)
				poltergeistCounter++;
			if (horns.type == Horns.GHOSTLY_WISPS)
				poltergeistCounter++;
			if (arms.type == Arms.GHOST)
				poltergeistCounter++;
			if (lowerBody == LowerBody.GHOST)
				poltergeistCounter++;
			if (lowerBody == LowerBody.GHOST_2)
				poltergeistCounter += 2;
			if (wings.type == Wings.ETHEREAL)
				poltergeistCounter += 2;
			if (tailType == Tail.NONE)
				poltergeistCounter++;
			if (antennae.type == Antennae.NONE)
				poltergeistCounter++;
			if (rearBody.type == RearBody.GHOSTLY_AURA)
				poltergeistCounter++;
			if (skin.base.pattern == Skin.PATTERN_WHITE_BLACK_VEINS)
				poltergeistCounter++;
			if (hasPlainSkinOnly() && (skinAdj == "milky" && skin.base.color == "white") || (skinAdj == "ashen" && skin.base.color == "sable"))
				poltergeistCounter++;
			if (hasGhostSkin() && (skinAdj == "milky" || skinAdj == "ashen"))
				poltergeistCounter++;
			if (hasPerk(PerkLib.Incorporeality))
				poltergeistCounter++;
			if (hasPerk(PerkLib.Ghostslinger))
				poltergeistCounter++;
			if (hasPerk(PerkLib.PhantomShooting))
				poltergeistCounter++;
			if (hasPerk(PerkLib.Telekinesis))
				poltergeistCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && poltergeistCounter >= 4)
				poltergeistCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && poltergeistCounter >= 8)
				poltergeistCounter += 1;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				poltergeistCounter += 50;
			if (isGargoyle()) poltergeistCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) poltergeistCounter = 0;
			poltergeistCounter = finalRacialScore(poltergeistCounter, Race.POLTERGEIST);
			End("Player","racialScore");
			return poltergeistCounter;
		}

		//Banshee score
		public function bansheeScore():Number {
			Begin("Player","racialScore","banshee");
			var bansheeCounter:Number = 0;
			if (hairType == Hair.GHOST)
				bansheeCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				bansheeCounter += 50;
			if (isGargoyle()) bansheeCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) bansheeCounter = 0;
			bansheeCounter = finalRacialScore(bansheeCounter, Race.BANSHEE);
			End("Player","racialScore");
			return bansheeCounter;
		}

		//Bunny score
		public function bunnyScore():Number {
			Begin("Player","racialScore","bunny");
			var bunnyCounter:Number = 0;
			if (faceType == Face.BUNNY)
				bunnyCounter++;
			if (ears.type == Ears.BUNNY)
				bunnyCounter++;
			if (lowerBody == LowerBody.BUNNY)
				bunnyCounter++;
			if (hasPartialCoat(Skin.FUR) || hasFullCoatOfType(Skin.FUR))
				bunnyCounter++;
			if (tailType == Tail.RABBIT)
				bunnyCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				bunnyCounter++;
			if (bunnyCounter > 4) {
				if (eyes.type == Eyes.HUMAN)
					bunnyCounter++;
				if (arms.type == Arms.HUMAN)
					bunnyCounter++;
			}
			if (bunnyCounter > 0 && antennae.type == 0)
				bunnyCounter++;
			if (bunnyCounter > 0 && wings.type == Wings.NONE)
				bunnyCounter++;
			if (tallness < 72)
				bunnyCounter++;
			if (balls > 2 && bunnyCounter > 0)
				bunnyCounter--;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				bunnyCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && bunnyCounter >= 4)
				bunnyCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && bunnyCounter >= 8)
				bunnyCounter += 1;
			if (hasPerk(PerkLib.EasterBunnyBalls) && balls >= 2)
				bunnyCounter = 0;
			if (ears.type != Ears.BUNNY)
				bunnyCounter = 0;
			if (isGargoyle()) bunnyCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) bunnyCounter = 0;
			bunnyCounter = finalRacialScore(bunnyCounter, Race.BUNNY);
			End("Player","racialScore");
			return bunnyCounter;
		}

		//Centipede score
		public function centipedeScore():Number {
			Begin("Player","racialScore","centipede");
			var centipedeCounter:Number = 0;
			if (faceType == Face.ANIMAL_TOOTHS)
				centipedeCounter++;
			if (lowerBody == LowerBody.CENTIPEDE)
				centipedeCounter += 2;
			if (hasCoatOfType(Skin.COVERAGE_NONE))
				centipedeCounter++;
			if (arms.type == Arms.HUMAN)
				centipedeCounter++;
			if (antennae.type == Antennae.CENTIPEDE)
				centipedeCounter++;
			if (rearBody.type == RearBody.CENTIPEDE)
				centipedeCounter++;
			if (ears.type == Ears.ELFIN)
				centipedeCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				centipedeCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && centipedeCounter >= 4)
				centipedeCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && centipedeCounter >= 8)
				centipedeCounter += 1;
			if (hasPerk(PerkLib.EasterBunnyBalls) && balls >= 2)
				centipedeCounter = 0;
			if (isGargoyle()) centipedeCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) centipedeCounter = 0;
			centipedeCounter = finalRacialScore(centipedeCounter, Race.CENTIPEDE);
			End("Player","racialScore");
			return centipedeCounter;
		}

		//Easter Bunny score
		public function easterbunnyScore():Number {
			Begin("Player","racialScore","bunny");
			var EbunnyCounter:Number = 0;
			if (faceType == Face.BUNNY || faceType == Face.BUCKTEETH)
				EbunnyCounter++;
			if (ears.type == Ears.BUNNY)
				EbunnyCounter++;
			if (lowerBody == LowerBody.BUNNY)
				EbunnyCounter++;
			if (hasPartialCoat(Skin.FUR) || hasFullCoatOfType(Skin.FUR) || hasFur())
				EbunnyCounter++;
			if (tailType == Tail.RABBIT)
				EbunnyCounter++;
			if (eyes.type == Eyes.HUMAN)
				EbunnyCounter++;
			if (arms.type == Arms.HUMAN)
				EbunnyCounter++;
			if (antennae.type == 0)
				EbunnyCounter++;
			if (wings.type == Wings.NONE)
				EbunnyCounter++;
			if (tallness < 72)
				EbunnyCounter++;
			if (hasCock() && normalCocks())
				EbunnyCounter++;
			if (hasPerk(PerkLib.EasterBunnyBalls) && balls >= 2)
				EbunnyCounter++;
			if (hasPerk(MutationsLib.EasterBunnyEggBag) && balls >= 2)
				EbunnyCounter++;
			if (hasPerk(MutationsLib.EasterBunnyEggBagPrimitive) && balls >= 2)
				EbunnyCounter++;
			if (hasPerk(MutationsLib.EasterBunnyEggBagEvolved) && balls >= 2)
				EbunnyCounter++;
			if (hasPerk(MutationsLib.EasterBunnyEggBag) && balls >= 2 && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				EbunnyCounter++;
			if (hasPerk(MutationsLib.EasterBunnyEggBagPrimitive) && balls >= 2 && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				EbunnyCounter++;
			if (hasPerk(MutationsLib.EasterBunnyEggBagEvolved) && balls >= 2 && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				EbunnyCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				EbunnyCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && EbunnyCounter >= 4)
				EbunnyCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && EbunnyCounter >= 8)
				EbunnyCounter += 1;
			if (ears.type != Ears.BUNNY)
				EbunnyCounter = 0;
			if (isGargoyle()) EbunnyCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) EbunnyCounter = 0;
			EbunnyCounter = finalRacialScore(EbunnyCounter, Race.EASTERBUNNY);
			End("Player","racialScore");
			return EbunnyCounter;
		}

		//Harpy score
		public function harpyScore():Number {
			Begin("Player","racialScore","harpy");
			var harpy:Number = 0;
			if (arms.type == Arms.HARPY)
				harpy++;
			if (hairType == Hair.FEATHER)
				harpy++;
			if (wings.type == Wings.FEATHERED_LARGE)
				harpy += 4;
			if (tailType == Tail.HARPY)
				harpy++;
			if (lowerBody == LowerBody.HARPY)
				harpy++;
			if (hasVagina())
				harpy++;
			if (harpy >= 2 && (faceType == Face.HUMAN || faceType == Face.ANIMAL_TOOTHS))
				harpy++;
			if (harpy >= 2 && (ears.type == Ears.HUMAN || ears.type == Ears.ELFIN))
				harpy++;
			if (hasCoatOfType(Skin.COVERAGE_NONE))
				harpy++;
			if (hasPerk(PerkLib.HarpyWomb))
				harpy += 2;
			if (hasPerk(MutationsLib.HarpyHollowBones))
				harpy++;
			if (hasPerk(MutationsLib.HarpyHollowBonesPrimitive))
				harpy++;
			if (hasPerk(MutationsLib.HarpyHollowBonesEvolved))
				harpy++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				harpy += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && harpy >= 4)
				harpy += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && harpy >= 8)
				harpy += 1;
			if (isGargoyle()) harpy = 0;
			if (tailType == Tail.SHARK || tailType == Tail.SALAMANDER || lowerBody == LowerBody.SALAMANDER || faceType == Face.SHARK_TEETH || wings.type == Wings.FEATHERED_PHOENIX || tail.type == Tail.THUNDERBIRD)
				harpy = 0;
			if (hasPerk(PerkLib.ElementalBody)) harpy = 0;
			harpy = finalRacialScore(harpy, Race.HARPY);
			End("Player","racialScore");
			return harpy;
		}

		//Kanga score
		public function kangaScore():Number {
			Begin("Player","racialScore","kanga");
			var kanga:Number = 0;
			if (kangaCocks() > 0)
				kanga++;
			if (ears.type == Ears.KANGAROO)
				kanga++;
			if (tailType == Tail.KANGAROO)
				kanga++;
			if (lowerBody == LowerBody.KANGAROO)
				kanga++;
			if (faceType == Face.KANGAROO)
				kanga++;
			if (kanga >= 2 && hasFur())
				kanga++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				kanga += 50;
			if (isGargoyle()) kanga = 0;
			if (hasPerk(PerkLib.ElementalBody)) kanga = 0;
			kanga = finalRacialScore(kanga, Race.KANGAROO);
			End("Player","racialScore");
			return kanga;
		}

		//shark score
		public function sharkScore():Number {
			Begin("Player","racialScore","shark");
			var sharkCounter:Number = 0;
			if (faceType == Face.SHARK_TEETH)
				sharkCounter++;
			if (gills.type == Gills.FISH)
				sharkCounter++;
			if (ears.type == Ears.SHARK)
				sharkCounter++;
			if (rearBody.type == RearBody.SHARK_FIN)
				sharkCounter++;
			if (wings.type == Wings.SHARK_FIN)
				sharkCounter -= 7;
			if (arms.type == Arms.SHARK)
				sharkCounter++;
			if (lowerBody == LowerBody.SHARK)
				sharkCounter++;
			if (tailType == Tail.SHARK)
				sharkCounter++;
			if (hairType == Hair.NORMAL && hairColor == "silver")
				sharkCounter++;
			if (hasScales() && InCollection(skin.coat.color, "rough gray","orange","dark gray","iridescent gray","ashen grayish-blue","gray"))
				sharkCounter++;
			if (eyes.type == Eyes.HUMAN && hairType == Hair.NORMAL && hairColor == "silver" && hasScales() && InCollection(skin.coat.color, "rough gray","orange","dark gray","iridescent gray","ashen grayish-blue","gray"))
				sharkCounter++;
			if (vaginas.length > 0 && cocks.length > 0)
				sharkCounter++;
			if (vaginaType() == VaginaClass.SHARK)
				sharkCounter++;
			if (hasPerk(MutationsLib.SharkOlfactorySystem))
				sharkCounter++;
			if (hasPerk(MutationsLib.SharkOlfactorySystemPrimitive))
				sharkCounter++;
			if (hasPerk(MutationsLib.SharkOlfactorySystemEvolved))
				sharkCounter++;
			if (hasPerk(MutationsLib.SharkOlfactorySystem) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				sharkCounter++;
			if (hasPerk(MutationsLib.SharkOlfactorySystemPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				sharkCounter++;
			if (hasPerk(MutationsLib.SharkOlfactorySystemEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				sharkCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				sharkCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && sharkCounter >= 4)
				sharkCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && sharkCounter >= 8)
				sharkCounter += 1;
			if (isGargoyle()) sharkCounter = 0;
			if (wings.type == Wings.FEATHERED_LARGE)
				sharkCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) sharkCounter = 0;
			sharkCounter = finalRacialScore(sharkCounter, Race.SHARK);
			End("Player","racialScore");
			return sharkCounter;
		}

		//Orca score
		public function orcaScore():Number {
			Begin("Player","racialScore","orca");
			var orcaCounter:Number = 0;
			if (ears.type == Ears.ORCA || ears.type == Ears.ORCA2)
				orcaCounter++;
			if (tailType == Tail.ORCA)
				orcaCounter++;
			if (faceType == Face.ORCA)
				orcaCounter++;
			if (eyes.type == Eyes.HUMAN)
				orcaCounter++;
			if (eyes.colour == "orange")
				orcaCounter++;
			if (hairType == Hair.NORMAL)
				orcaCounter++;
			if (lowerBody == LowerBody.ORCA)
				orcaCounter++;
			if (arms.type == Arms.ORCA)
				orcaCounter++;
			if (rearBody.type == RearBody.ORCA_BLOWHOLE)
				orcaCounter++;
			if (hasPlainSkinOnly())
				orcaCounter++;
			if (skinAdj == "glossy")
				orcaCounter++;
			if (skin.base.pattern == Skin.PATTERN_ORCA_UNDERBODY)
				orcaCounter++;
			if (wings.type == Wings.NONE)
				orcaCounter += 2;
			if (tone < 10)
				orcaCounter++;
			if (tallness >= 84)
				orcaCounter++;
			if (biggestTitSize() > 19 || (cocks.length > 18))
				orcaCounter++;
			if (hasPerk(MutationsLib.WhaleFat))
				orcaCounter++;
			if (hasPerk(MutationsLib.WhaleFatPrimitive))
				orcaCounter++;
			if (hasPerk(MutationsLib.WhaleFatEvolved))
				orcaCounter++;
			if (hasPerk(MutationsLib.WhaleFat) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				orcaCounter++;
			if (hasPerk(MutationsLib.WhaleFatPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				orcaCounter++;
			if (hasPerk(MutationsLib.WhaleFatEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				orcaCounter++;
			if (faceType != Face.ORCA)
				orcaCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				orcaCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && orcaCounter >= 4)
				orcaCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && orcaCounter >= 8)
				orcaCounter += 1;
			if (isGargoyle()) orcaCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) orcaCounter = 0;
			if (wings.type == Wings.SEA_DRAGON || lowerBody == LowerBody.SEA_DRAGON || arms.type == Arms.SEA_DRAGON)
				orcaCounter = 0;
			orcaCounter = finalRacialScore(orcaCounter, Race.ORCA);
			End("Player","racialScore");
			return orcaCounter;
		}

		//Leviathan score
		public function leviathanScore():Number {
			Begin("Player","racialScore","orca");
			var LeviathanCounter:Number = 0;
			if (horns.type == Horns.SEA_DRAGON)
				LeviathanCounter++;
			if (antennae.type == Antennae.SEA_DRAGON)
				LeviathanCounter++;
			if (ears.type == Ears.ORCA)
				LeviathanCounter++;
			if (tailType == Tail.ORCA)
				LeviathanCounter++;
			if (faceType == Face.ORCA)
				LeviathanCounter++;
			if (tongue.type == Tongue.DRACONIC)
				LeviathanCounter++;
			if (eyes.type == Eyes.DRACONIC)
				LeviathanCounter++;
			if (InCollection(eyes.colour,"orange","yellow","light green"))
				LeviathanCounter++;
			if (hairType == Hair.PRISMATIC)
				LeviathanCounter++;
			if (lowerBody == LowerBody.SEA_DRAGON)
				LeviathanCounter++;
			if (arms.type == Arms.SEA_DRAGON)
				LeviathanCounter++;
			if (rearBody.type == RearBody.ORCA_BLOWHOLE)
				LeviathanCounter++;
			if (hasPlainSkinOnly())
				LeviathanCounter++;
			if (skinAdj == "glossy")
				LeviathanCounter++;
			if (skin.base.pattern == Skin.PATTERN_SEA_DRAGON_UNDERBODY)
				LeviathanCounter++;
			if (wings.type == Wings.SEA_DRAGON)
				LeviathanCounter += 4;
			if (tone < 10)
				LeviathanCounter++;
			if (tallness >= 84)
				LeviathanCounter++;
			if ((hasVagina() && biggestTitSize() > 19) || (cocks.length > 18 && dragonCocks() > 0))
				LeviathanCounter++;
			if (hasPerk(MutationsLib.DrakeLungs))
				LeviathanCounter++;
			if (hasPerk(MutationsLib.DrakeLungsPrimitive))
				LeviathanCounter++;
			if (hasPerk(MutationsLib.DrakeLungsEvolved))
				LeviathanCounter++;
			if (hasPerk(MutationsLib.DraconicBones))
				LeviathanCounter++;
			if (hasPerk(MutationsLib.DraconicBonesPrimitive))
				LeviathanCounter++;
			if (hasPerk(MutationsLib.DraconicBonesEvolved))
				LeviathanCounter++;
			if (hasPerk(MutationsLib.WhaleFat))
				LeviathanCounter++;
			if (hasPerk(MutationsLib.WhaleFatPrimitive))
				LeviathanCounter++;
			if (hasPerk(MutationsLib.WhaleFatEvolved))
				LeviathanCounter++;
			if (hasPerk(PerkLib.DragonWaterBreath))
				LeviathanCounter++;
			if (hasPerk(MutationsLib.WhaleFat) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				LeviathanCounter++;
			if (hasPerk(MutationsLib.WhaleFatPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				LeviathanCounter++;
			if (hasPerk(MutationsLib.WhaleFatEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				LeviathanCounter++;
			if (faceType != Face.ORCA)
				LeviathanCounter = 0;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				LeviathanCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && LeviathanCounter >= 4)
				LeviathanCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && LeviathanCounter >= 8)
				LeviathanCounter += 1;
			if (isGargoyle()) LeviathanCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) LeviathanCounter = 0;
			if (wings.type == Wings.NONE || lowerBody != LowerBody.SEA_DRAGON || arms.type != Arms.SEA_DRAGON)
				LeviathanCounter = 0;
			LeviathanCounter = finalRacialScore(LeviathanCounter, Race.SEA_DRAGON);
			End("Player","racialScore");
			return LeviathanCounter;
		}


		//Oni score
		public function oniScore():Number {
			Begin("Player","racialScore","oni");
			var oniCounter:Number = 0;
			if (ears.type == Ears.ONI)
				oniCounter++;
			if (faceType == Face.ONI_TEETH)
				oniCounter++;
			if (horns.type == Horns.ONI || horns.type == Horns.ONI_X2)
				oniCounter++;
			if (arms.type == Arms.ONI)
				oniCounter++;
			if (lowerBody == LowerBody.ONI)
				oniCounter++;
			if (eyes.type == Eyes.ONI && InCollection(eyes.colour,Mutations.oniEyeColors))
				oniCounter++;
			if (InCollection(skin.base.color, ["red", "reddish-orange","purple", "blue"]))
				oniCounter++;
			if (skin.base.pattern == Skin.PATTERN_BATTLE_TATTOO)
				oniCounter++;
			if (rearBody.type == RearBody.NONE)
				oniCounter++;
			if (tailType == Tail.NONE)
				oniCounter++;
			if (tone >= 80)
				oniCounter++;
			if (tone >= 120 && oniCounter >= 4)
				oniCounter++;
			if (tone >= 160 && oniCounter >= 8)
				oniCounter++;
			if ((hasVagina() && biggestTitSize() >= 19) || (cocks.length > 18))
				oniCounter++;
			if (tallness >= 108)
				oniCounter++;
			if (hasPerk(MutationsLib.OniMusculature))
				oniCounter++;
			if (hasPerk(MutationsLib.OniMusculaturePrimitive))
				oniCounter++;
			if (hasPerk(MutationsLib.OniMusculatureEvolved))
				oniCounter++;
			if (hasPerk(MutationsLib.OniMusculature) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				oniCounter++;
			if (hasPerk(MutationsLib.OniMusculaturePrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				oniCounter++;
			if (hasPerk(MutationsLib.OniMusculatureEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				oniCounter++;
			if (hasPerk(PerkLib.OnisDescendant) || hasPerk(PerkLib.BloodlineOni))
				oniCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				oniCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && oniCounter >= 4)
				oniCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && oniCounter >= 8)
				oniCounter += 1;
			if (isGargoyle()) oniCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) oniCounter = 0;
			oniCounter = finalRacialScore(oniCounter, Race.ONI);
			End("Player","racialScore");
			return oniCounter;
		}

		//Oomukade  score
		public function oomukadeScore():Number {
			Begin("Player","racialScore","oomukade");
			var oomukadeCounter:Number = 0;
			if (faceType == Face.ANIMAL_TOOTHS)
				oomukadeCounter++;
			if (eyes.type == Eyes.CENTIPEDE)
				oomukadeCounter++;
			if (lowerBody == LowerBody.CENTIPEDE)
				oomukadeCounter++;
			if (hasPlainSkinOnly())
				oomukadeCounter++;
			if (arms.type == Arms.CENTIPEDE)
				oomukadeCounter++;
			if (antennae.type == Antennae.CENTIPEDE)
				oomukadeCounter++;
			if (rearBody.type == RearBody.CENTIPEDE)
				oomukadeCounter += 4;
			if (ears.type == Ears.ELFIN)
				oomukadeCounter++;
			if (skin.hasVenomousMarking())
				oomukadeCounter += 2;
			if (hasCock() && countCocksOfType(CockTypesEnum.OOMUKADE) > 0 || hasVagina() && vaginaType() == VaginaClass.VENOM_DRIPPING)
				oomukadeCounter += 2;
			//if (hasPerk(PerkLib.OomukadeGlands)
			//oomukadeCounter++;
			//if (hasPerk(PerkLib.OomukadeGlandsEvolved)
			//oomukadeCounter++;
			//if (hasPerk(PerkLib.OomukadeGlandsFinalForm)
			//oomukadeCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				oomukadeCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && oomukadeCounter >= 4)
				oomukadeCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && oomukadeCounter >= 8)
				oomukadeCounter += 1;
			if (isGargoyle()) oomukadeCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) oomukadeCounter = 0;
			oomukadeCounter = finalRacialScore(oomukadeCounter, Race.OOMUKADE);
			End("Player","racialScore");
			return oomukadeCounter;
		}

		//Elf score
		public function elfScore():Number {
			Begin("Player","racialScore","elf");
			var elfCounter:Number = 0;
			if (ears.type == Ears.ELVEN)
				elfCounter++;
			if (eyes.type == Eyes.ELF)
				elfCounter++;
			if (faceType == Face.ELF)
				elfCounter++;
			if (tongue.type == Tongue.ELF)
				elfCounter++;
			if (arms.type == Arms.ELF)
				elfCounter++;
			if (lowerBody == LowerBody.ELF)
				elfCounter++;
			if (hairType == Hair.SILKEN)
				elfCounter++;
			if (wings.type == Wings.NONE)
				elfCounter++;
			if (elfCounter >= 2) {
				if (InCollection(hairColor, ["black", "leaf green", "golden blonde", "silver"]))
					elfCounter++;
				if (InCollection(skin.base.color, ["dark", "light","tan"]))
					elfCounter++;
				if (skinType == Skin.PLAIN && skinAdj == "flawless")
					elfCounter++;
				if (tone <= 60)
					elfCounter++;
				if (thickness <= 50)
					elfCounter++;
				if (hasCock() && cocks.length < 6)
					elfCounter++;
				if (hasVagina() && biggestTitSize() >= 3)
					elfCounter++;
			}
			if (hasPerk(PerkLib.FlawlessBody))
				elfCounter++;
			if (hasPerk(PerkLib.ElvenSense))
				elfCounter++;
			if (hasPerk(MutationsLib.ElvishPeripheralNervSys))
				elfCounter++;
			if (hasPerk(MutationsLib.ElvishPeripheralNervSysPrimitive))
				elfCounter++;
			if (hasPerk(MutationsLib.ElvishPeripheralNervSysEvolved))
				elfCounter++;
			if (hasPerk(MutationsLib.ElvishPeripheralNervSys) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				elfCounter++;
			if (hasPerk(MutationsLib.ElvishPeripheralNervSysPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				elfCounter++;
			if (hasPerk(MutationsLib.ElvishPeripheralNervSysEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				elfCounter++;/*
			if (elfCounter >= 11) {
				if (wings.type == Wings.)
					elfCounter++;
			}*/
			if (hasPerk(PerkLib.ElfsDescendant) || hasPerk(PerkLib.BloodlineElf))
				elfCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				elfCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && elfCounter >= 4)
				elfCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && elfCounter >= 8)
				elfCounter += 1;
			if (isGargoyle()) elfCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) elfCounter = 0;
			if (hasPerk(PerkLib.BlessingOfTheAncestorTree)) elfCounter = 0;
			elfCounter = finalRacialScore(elfCounter, Race.ELF);
			End("Player","racialScore");
			return elfCounter;
		}

		//WoodElf score
		public function woodElfScore():Number {
			Begin("Player","racialScore","wood elf");
			var WoodElfCounter:Number = 0;
			if (hasPerk(PerkLib.BlessingOfTheAncestorTree)) {
				WoodElfCounter += 4;
				if (ears.type == Ears.ELVEN)
					WoodElfCounter++;
				if (eyes.type == Eyes.ELF)
					WoodElfCounter++;
				if (faceType == Face.ELF)
					WoodElfCounter++;
				if (tongue.type == Tongue.ELF)
					WoodElfCounter++;
				if (arms.type == Arms.ELF)
					WoodElfCounter++;
				if (lowerBody == LowerBody.ELF)
					WoodElfCounter++;
				if (hairType == Hair.SILKEN)
					WoodElfCounter++;
				if (wings.type == Wings.NONE)
					WoodElfCounter++;
				if (InCollection(hairColor, ["golden blonde"]))
					WoodElfCounter++;
				if (eyes.colour == "light green")
					WoodElfCounter++;
				if (InCollection(skin.base.color, ["light"]))
					WoodElfCounter++;
				if (skinType == Skin.PLAIN && skinAdj == "flawless")
					WoodElfCounter++;
				if (tone <= 60)
					WoodElfCounter++;
				if (thickness <= 50)
					WoodElfCounter++;
				if ((hasCock() && cocks.length < 6) || (hasVagina() && biggestTitSize() >= 3))
					WoodElfCounter++;
				if (cor >= 50)
					WoodElfCounter++;
				if (hasPerk(PerkLib.FlawlessBody))
					WoodElfCounter++;
				if (hasPerk(PerkLib.ElvenSense))
					WoodElfCounter++;
			}
			if (hasPerk(MutationsLib.ElvishPeripheralNervSys))
				WoodElfCounter += 3;
			if (hasPerk(MutationsLib.ElvishPeripheralNervSysPrimitive))
				WoodElfCounter += 3;
			if (hasPerk(MutationsLib.ElvishPeripheralNervSysEvolved))
				WoodElfCounter += 3;
			if (hasPerk(PerkLib.ElfsDescendant) || hasPerk(PerkLib.BloodlineElf))
				WoodElfCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				WoodElfCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && WoodElfCounter >= 4)
				WoodElfCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && WoodElfCounter >= 8)
				WoodElfCounter += 1;
			if (isGargoyle()) WoodElfCounter = 0;
			if (cor < 50 || eyes.colour != "light green" || !InCollection(hairColor, ["golden blonde"]) || hasPerk(PerkLib.ElementalBody)) WoodElfCounter = 0;
			WoodElfCounter = finalRacialScore(WoodElfCounter, Race.WOODELF);
			End("Player","racialScore");
			return WoodElfCounter;
		}

		//Frost Wyrm score
		public function frostWyrmScore():Number {
			Begin("Player","racialScore","frost wyrm");
			var frostWyrmCounter:Number = 0;
			var frostWyrmCounter2:Number = 0;
			if (ears.type == Ears.SNAKE || ears.type == Ears.DRAGON) {
				frostWyrmCounter++;
				frostWyrmCounter2++;
			}
			if (eyes.type == Eyes.FROSTWYRM) {
				frostWyrmCounter++;
				frostWyrmCounter2++;
			}
			if (faceType == Face.ANIMAL_TOOTHS) {
				frostWyrmCounter++;
				frostWyrmCounter2++;
			}
			if (tongue.type == Tongue.DRACONIC) {
				frostWyrmCounter++;
				frostWyrmCounter2++;
			}
			if (arms.type == Arms.FROSTWYRM) {
				frostWyrmCounter++;
				frostWyrmCounter2++;
			}
			if (lowerBody == LowerBody.FROSTWYRM) {
				frostWyrmCounter += 3;
				frostWyrmCounter2 += 3;
			}
			if (rearBody.type == RearBody.FROSTWYRM) {
				frostWyrmCounter++;
				frostWyrmCounter2++;
			}
			if (wings.type == Wings.NONE)
				frostWyrmCounter += 4;
			if (hasPartialCoat(Skin.DRAGON_SCALES) || hasCoatOfType(Skin.DRAGON_SCALES)) {
				frostWyrmCounter++;
				frostWyrmCounter2++;
			}
			if (horns.type == Horns.FROSTWYRM) {
				frostWyrmCounter += 2;
				frostWyrmCounter2 += 2;
			}
			if (horns.type == Horns.DRACONIC_X4_12_INCH_LONG || horns.type == Horns.DRACONIC_X2)
				frostWyrmCounter -= 2;
			if (InCollection(hairColor, ["white", "snow white", "glacial white", "silver", "platinum silver"]))
				frostWyrmCounter++;
			if (InCollection(coatColor, ["bluish black", "dark gray", "black", "midnight black", "midnight"]))
				frostWyrmCounter++;
			if (dragonCocks() > 0)
				frostWyrmCounter++;
			if (hasCock() && cocks.length < 6)
				frostWyrmCounter++;
			if (hasVagina() && biggestTitSize() >= 3)
				frostWyrmCounter++;
			if (horns.type != Horns.FROSTWYRM)
				frostWyrmCounter2--;
			if (arms.type != Arms.FROSTWYRM)
				frostWyrmCounter2--;
			if (lowerBody != LowerBody.FROSTWYRM)
				frostWyrmCounter2 -= 3;
			if (tallness > 120 && frostWyrmCounter >= 10)
				frostWyrmCounter++;
			if (hasPerk(PerkLib.DragonIceBreath))
				frostWyrmCounter++;
			if (hasPerk(MutationsLib.DraconicBones))
				frostWyrmCounter++;
			if (hasPerk(MutationsLib.DraconicBonesPrimitive))
				frostWyrmCounter++;
			if (hasPerk(MutationsLib.DraconicBonesEvolved))
				frostWyrmCounter++;
			if (hasPerk(MutationsLib.DraconicHeart))
				frostWyrmCounter++;
			if (hasPerk(MutationsLib.DraconicHeartPrimitive))
				frostWyrmCounter++;
			if (hasPerk(MutationsLib.DraconicHeartEvolved))
				frostWyrmCounter++;
			if (hasPerk(MutationsLib.DrakeLungs))
				frostWyrmCounter++;
			if (hasPerk(MutationsLib.DrakeLungsPrimitive))
				frostWyrmCounter++;
			if (hasPerk(MutationsLib.DrakeLungsEvolved))
				frostWyrmCounter++;
			if ((hasPerk(MutationsLib.DraconicBones) || hasPerk(MutationsLib.DraconicHeart) || hasPerk(MutationsLib.DrakeLungs)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				frostWyrmCounter++;
			if ((hasPerk(MutationsLib.DraconicBonesPrimitive) || hasPerk(MutationsLib.DraconicHeartPrimitive) || hasPerk(MutationsLib.DrakeLungsPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				frostWyrmCounter++;
			if ((hasPerk(MutationsLib.DraconicBonesEvolved) || hasPerk(MutationsLib.DraconicHeartEvolved) || hasPerk(MutationsLib.DrakeLungsEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				frostWyrmCounter++;
			if (hasPerk(PerkLib.DragonsDescendant) || hasPerk(PerkLib.BloodlineDragon))
				frostWyrmCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				frostWyrmCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && frostWyrmCounter >= 4)
				frostWyrmCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && frostWyrmCounter >= 8)
				frostWyrmCounter += 1;
			if (frostWyrmCounter2 < 5) frostWyrmCounter = frostWyrmCounter2;
			if (isGargoyle()) frostWyrmCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) frostWyrmCounter = 0;
			frostWyrmCounter = finalRacialScore(frostWyrmCounter, Race.FROSTWYRM);
			End("Player","racialScore");
			return frostWyrmCounter;
		}

		//Orc score
		public function orcScore():Number {
			Begin("Player","racialScore","orc");
			var orcCounter:Number = 0;
			if (ears.type == Ears.ELFIN)
				orcCounter++;
			if (eyes.type == Eyes.ORC)
				orcCounter++;
			if (faceType == Face.ORC_FANGS)
				orcCounter++;
			if (arms.type == Arms.ORC)
				orcCounter++;
			if (lowerBody == LowerBody.ORC)
				orcCounter++;
			if (skin.base.pattern == Skin.PATTERN_SCAR_SHAPED_TATTOO)
				orcCounter++;
			if (tailType == Tail.NONE)
				orcCounter++;
			if (orcCounter >= 2) {
				if (InCollection(hairColor, ["green", "gray", "brown", "red", "sandy tan"]))
					orcCounter++;
				if (skinType == Skin.PLAIN)
					orcCounter++;
				if (tone >= 70)
					orcCounter++;
				if (tone >= 105)
					orcCounter++;
				if (thickness <= 60)
					orcCounter++;
				if (thickness <= 20)
					orcCounter++;
			}
			if (hasPerk(PerkLib.Ferocity))
				orcCounter += 2;
			if (hasPerk(MutationsLib.OrcAdrenalGlands))
				orcCounter++;
			if (hasPerk(MutationsLib.OrcAdrenalGlandsPrimitive))
				orcCounter++;
			if (hasPerk(MutationsLib.OrcAdrenalGlandsEvolved))
				orcCounter++;
			if (hasPerk(MutationsLib.OrcAdrenalGlands) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				orcCounter++;
			if (hasPerk(MutationsLib.OrcAdrenalGlandsPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				orcCounter++;
			if (hasPerk(MutationsLib.OrcAdrenalGlandsEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				orcCounter++;/*
			if (orcCounter >= 11) {
				if (tailType == Tail.)
					orcCounter++;
			}*/
			if (hasPerk(PerkLib.OrcsDescendant) || hasPerk(PerkLib.BloodlineOrc))
				orcCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				orcCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && orcCounter >= 4)
				orcCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && orcCounter >= 8)
				orcCounter += 1;
			if (isGargoyle()) orcCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) orcCounter = 0;
			if (tallness < 48) orcCounter = 0;
			orcCounter = finalRacialScore(orcCounter, Race.ORC);
			End("Player","racialScore");
			return orcCounter;
		}

		//Raiju score
		public function raijuScore():Number {
			Begin("Player","racialScore","raiju");
			var raijuCounter:Number = 0;
			if (ears.type == Ears.RAIJU || ears.type == Ears.WEASEL)
				raijuCounter++;
			if (eyes.type == Eyes.RAIJU)
				raijuCounter++;
			if (InCollection(eyes.colour, "blue","green", "turquoise","light green"))
				raijuCounter++;
			if (faceType == Face.WEASEL)
				raijuCounter++;
			if (arms.type == Arms.RAIJU || arms.type == Arms.RAIJU_PAWS)
				raijuCounter++;
			if (lowerBody == LowerBody.RAIJU)
				raijuCounter++;
			if (tailType == Tail.RAIJU)
				raijuCounter++;
			if (wings.type == Wings.THUNDEROUS_AURA)
				raijuCounter++;
			if (rearBody.type == RearBody.RAIJU_MANE)
				raijuCounter++;
			if (skin.base.pattern == Skin.PATTERN_LIGHTNING_SHAPED_TATTOO)
				raijuCounter++;
			if (hairType == Hair.STORM)
				raijuCounter++;
			if (InCollection(hairColor, ["purple", "light blue", "yellow", "white", "lilac", "green", "stormy blue"]))
				raijuCounter++;
			if (hasStatusEffect(StatusEffects.GlowingNipples) || hasStatusEffect(StatusEffects.GlowingAsshole))
				raijuCounter++;
			if (raijuCocks() > 0 || vaginaType() == VaginaClass.RAIJU)
				raijuCounter++;
			if (hasPerk(MutationsLib.RaijuCathode))
				raijuCounter++;
			if (hasPerk(MutationsLib.RaijuCathodePrimitive))
				raijuCounter++;
			if (hasPerk(MutationsLib.RaijuCathodeEvolved))
				raijuCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStorm))
				raijuCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStormPrimitive))
				raijuCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStormEvolved))
				raijuCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStorm) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				raijuCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStormPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				raijuCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStormEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				raijuCounter++;
			if (hasPerk(PerkLib.RaijusDescendant) || hasPerk(PerkLib.BloodlineRaiju))
				raijuCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				raijuCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && raijuCounter >= 4)
				raijuCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && raijuCounter >= 8)
				raijuCounter += 1;
			if (isGargoyle()) raijuCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) raijuCounter = 0;
			raijuCounter = finalRacialScore(raijuCounter, Race.RAIJU);
			End("Player","racialScore");
			return raijuCounter;
		}

		//Ratatoskr score
		public function ratatoskrScore():Number {
			Begin("Player","racialScore","ratatoskr");
			var ratatoskrCounter:Number = 0;
			if (ears.type == Ears.SQUIRREL)
				ratatoskrCounter++;
			if (eyes.type == Eyes.RATATOSKR)
				ratatoskrCounter++;
			if (eyes.colour == "green" || eyes.colour == "light green" || eyes.colour == "emerald")
				ratatoskrCounter++;
			if (faceType == Face.SMUG || faceType == Face.SQUIRREL)
				ratatoskrCounter++;
			if (arms.type == Arms.SQUIRREL)
				ratatoskrCounter++;
			if (tongue.type == Tongue.RATATOSKR)
				ratatoskrCounter++;
			if (lowerBody == LowerBody.SQUIRREL)
				ratatoskrCounter++;
			if (tailType == Tail.SQUIRREL)
				ratatoskrCounter++;
			if (wings.type == Wings.NONE)
				ratatoskrCounter++;
			if (rearBody.type == RearBody.NONE)
				ratatoskrCounter++;
			if (hairType == Hair.RATATOSKR)
				ratatoskrCounter++;
			if (InCollection(hairColor, ["brown", "light brown", "caramel", "chocolate", "russet"]))
				ratatoskrCounter++;
			if (InCollection(coatColor, ["brown", "light brown", "caramel", "chocolate", "russet"]))
				ratatoskrCounter++;
			if (hasCoatOfType(Skin.FUR) || hasPartialCoat(Skin.FUR))
				ratatoskrCounter++;
			if (tallness < 48)
				ratatoskrCounter++;
			if (hasPerk(MutationsLib.RatatoskrSmarts))
				ratatoskrCounter++;
			if (hasPerk(MutationsLib.RatatoskrSmartsPrimitive))
				ratatoskrCounter++;
			if (hasPerk(MutationsLib.RatatoskrSmartsEvolved))
				ratatoskrCounter++;
			if (hasPerk(MutationsLib.RatatoskrSmarts) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				ratatoskrCounter++;
			if (hasPerk(MutationsLib.RatatoskrSmartsPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				ratatoskrCounter++;
			if (hasPerk(MutationsLib.RatatoskrSmartsEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				ratatoskrCounter++;
			//if (hasPerk(PerkLib.RatatoskrsDescendant) || hasPerk(PerkLib.BloodlineRatatoskr))
			//	ratatoskrCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				ratatoskrCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && ratatoskrCounter >= 4)
				ratatoskrCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && ratatoskrCounter >= 8)
				ratatoskrCounter += 1;
			if (isGargoyle()) ratatoskrCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) ratatoskrCounter = 0;
			ratatoskrCounter = finalRacialScore(ratatoskrCounter, Race.RATATOSKR);
			End("Player","racialScore");
			return ratatoskrCounter;
		}

		//Thunderbird score
		public function thunderbirdScore():Number {
			Begin("Player","racialScore","thunderbird");
			var thunderbirdCounter:Number = 0;
			if (ears.type == Ears.ELFIN)
				thunderbirdCounter++;
			if (eyes.type == Eyes.RAIJU)
				thunderbirdCounter++;
			if (faceType == Face.HUMAN || faceType == Face.WEASEL)
				thunderbirdCounter++;
			if (arms.type == Arms.HARPY)
				thunderbirdCounter++;
			if (wings.type == Wings.FEATHERED_LARGE)
				thunderbirdCounter += 4;
			if (lowerBody == LowerBody.HARPY)
				thunderbirdCounter++;
			if (tailType == Tail.THUNDERBIRD)
				thunderbirdCounter++;
			if (rearBody.type == RearBody.RAIJU_MANE)
				thunderbirdCounter++;
			if (skin.base.pattern == Skin.PATTERN_LIGHTNING_SHAPED_TATTOO)
				thunderbirdCounter++;
			if (hairType == Hair.STORM)
				thunderbirdCounter++;
			if (InCollection(hairColor, ["purple", "light blue", "yellow", "white", "emerald", "turquoise"]))
				thunderbirdCounter++;
			if (hasPerk(PerkLib.HarpyWomb))
				thunderbirdCounter += 2;
			if (hasPerk(MutationsLib.HeartOfTheStorm))
				thunderbirdCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStormPrimitive))
				thunderbirdCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStormEvolved))
				thunderbirdCounter++;
			if (hasPerk(MutationsLib.HarpyHollowBones))
				thunderbirdCounter++;
			if (hasPerk(MutationsLib.HarpyHollowBonesPrimitive))
				thunderbirdCounter++;
			if (hasPerk(MutationsLib.HarpyHollowBonesEvolved))
				thunderbirdCounter++;
			if ((hasPerk(MutationsLib.HeartOfTheStorm) || hasPerk(MutationsLib.HarpyHollowBones)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				thunderbirdCounter++;
			if ((hasPerk(MutationsLib.HeartOfTheStormPrimitive) || hasPerk(MutationsLib.HarpyHollowBonesPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				thunderbirdCounter++;
			if ((hasPerk(MutationsLib.HeartOfTheStormEvolved) || hasPerk(MutationsLib.HarpyHollowBonesEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				thunderbirdCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				thunderbirdCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && thunderbirdCounter >= 4)
				thunderbirdCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && thunderbirdCounter >= 8)
				thunderbirdCounter += 1;
			if (isGargoyle()) thunderbirdCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) thunderbirdCounter = 0;
			if (tailType != Tail.THUNDERBIRD || hairType != Hair.STORM) thunderbirdCounter = 0;
			thunderbirdCounter = finalRacialScore(thunderbirdCounter, Race.THUNDERBIRD);
			End("Player","racialScore");
			return thunderbirdCounter;
		}

		//Kamaitachi score
		public function kamaitachiScore():Number {
			Begin("Player","racialScore","kamaitachi");
			var KamaitachiCounter:Number = 0;
			if (ears.type == Ears.WEASEL)
				KamaitachiCounter++;
			if (eyes.type == Eyes.WEASEL)
				KamaitachiCounter++;
			if (eyes.colour == "golden")
				KamaitachiCounter++;
			if (faceType == Face.WEASEL)
				KamaitachiCounter++;
			if (arms.type == Arms.KAMAITACHI)
				KamaitachiCounter++;
			if (hasCoatOfType(Skin.FUR) || hasPartialCoat(Skin.FUR))
				KamaitachiCounter += 1;
			if (wings.type == Wings.WINDY_AURA)
				KamaitachiCounter += 3;
			if (lowerBody == LowerBody.WEASEL)
				KamaitachiCounter++;
			if (tailType == Tail.WEASEL)
				KamaitachiCounter++;
			if (skin.base.pattern == Skin.PATTERN_SCAR_WINDSWEPT)
				KamaitachiCounter++;
			if (hairType == Hair.WINDSWEPT)
				KamaitachiCounter++;
			if (InCollection(hairColor, ["blonde", "yellow", "caramel", "brown", "emerald"]))
				KamaitachiCounter++;
			if (InCollection(coatColor, ["blonde", "yellow", "caramel", "brown", "emerald"]))
				KamaitachiCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStorm))
				KamaitachiCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStormPrimitive))
				KamaitachiCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStormEvolved))
				KamaitachiCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStorm) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				KamaitachiCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStormPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				KamaitachiCounter++;
			if (hasPerk(MutationsLib.HeartOfTheStormEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				KamaitachiCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				KamaitachiCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && KamaitachiCounter >= 4)
				KamaitachiCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && KamaitachiCounter >= 8)
				KamaitachiCounter += 1;
			if (isGargoyle()) KamaitachiCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) KamaitachiCounter = 0;
			KamaitachiCounter = finalRacialScore(KamaitachiCounter, Race.KAMAITACHI);
			End("Player","racialScore");
			return KamaitachiCounter;
		}

		//Cyclop score
		public function cyclopScore():Number {
			Begin("Player","racialScore","cyclop");
			var cyclopCounter:Number = 0;
			if (hasCoatOfType(Skin.COVERAGE_NONE))
				cyclopCounter++;
			if (eyes.type == Eyes.MONOEYE) {
				cyclopCounter += 3;
				if (arms.type == Arms.HUMAN)
					cyclopCounter++;
				if (lowerBody == LowerBody.HUMAN)
					cyclopCounter++;
			}
			if (faceType == Face.ANIMAL_TOOTHS)
				cyclopCounter++;
			if (wings.type == Wings.NONE)
				cyclopCounter++;
			if (tailType == Tail.NONE)
				cyclopCounter++;
			if (tone >= 90)
				cyclopCounter++;
			if (tone >= 120 && cyclopCounter >= 4)
				cyclopCounter++;
			if (tallness > 72 && cyclopCounter >= 4)
				cyclopCounter++;
			if (tallness > 96 && cyclopCounter >= 6)
				cyclopCounter++;
			if (tallness > 120 && cyclopCounter >= 8)
				cyclopCounter++;
			if (rearBody.type == RearBody.TENTACLE_EYESTALKS && statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 2)
				cyclopCounter -= 10;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				cyclopCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && cyclopCounter >= 4)
				cyclopCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && cyclopCounter >= 8)
				cyclopCounter += 1;
			if (isGargoyle()) cyclopCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) cyclopCounter = 0;
			cyclopCounter = finalRacialScore(cyclopCounter, Race.CYCLOP);
			End("Player","racialScore");
			return cyclopCounter;
		}

		//Gazer score
		public function gazerScore():Number {
			Begin("Player","racialScore","gazer");
			var gazerCounter:Number = 0;
			if (InCollection(hairColor, ["black", "midnight", "midnight black"]))
				gazerCounter++;
			if (InCollection(skin.base.color, ["snow white", "red", "pale white"]))
				gazerCounter++;
			if (hasCoatOfType(Skin.COVERAGE_NONE))
				gazerCounter++;
			if (eyes.type == Eyes.MONOEYE)
				gazerCounter++;
			if (eyes.colour == "red")
				gazerCounter++;
			if (skin.base.pattern == Skin.PATTERN_OIL)
				gazerCounter++;
			if (faceType == Face.ANIMAL_TOOTHS)
				gazerCounter++;
			if (arms.type == Arms.GAZER)
				gazerCounter++;
			if (lowerBody == LowerBody.GAZER)
				gazerCounter++;
			if (tailType == Tail.NONE)
				gazerCounter++;
			if (wings.type == Wings.LEVITATION)
				gazerCounter += 3;
			if (rearBody.type == RearBody.TENTACLE_EYESTALKS && statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 2) {
				gazerCounter += 2;
				if (statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 4)
					gazerCounter += 2;
				if (statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 6)
					gazerCounter += 2;
				if (statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 8)
					gazerCounter += 2;
				if (statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10)
					gazerCounter += 2;
			}
			if (hasPerk(MutationsLib.GazerEye))
				gazerCounter++;
			if (hasPerk(MutationsLib.GazerEyePrimitive))
				gazerCounter++;
			if (hasPerk(MutationsLib.GazerEyeEvolved))
				gazerCounter++;
			if (hasPerk(MutationsLib.GazerEye) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				gazerCounter++;
			if (hasPerk(MutationsLib.GazerEyePrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				gazerCounter++;
			if (hasPerk(MutationsLib.GazerEyeEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				gazerCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				gazerCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && gazerCounter >= 4)
				gazerCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && gazerCounter >= 8)
				gazerCounter += 1;
			if (isGargoyle()) gazerCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) gazerCounter = 0;
			gazerCounter = finalRacialScore(gazerCounter, Race.GAZER);
			End("Player","racialScore");
			return gazerCounter;
		}

		//Determine Mutant Rating
		public function mutantScore():Number{
			Begin("Player","racialScore","mutant");
			var mutantCounter:Number = 0;
			if (faceType != Face.HUMAN)
				mutantCounter++;
			if (!hasPlainSkinOnly())
				mutantCounter++;
			if (tailType != Tail.NONE)
				mutantCounter++;
			if (cockTotal() > 1)
				mutantCounter++;
			if (hasCock() && hasVagina())
				mutantCounter++;
			if (hasFuckableNipples())
				mutantCounter++;
			if (breastRows.length > 1)
				mutantCounter++;
			if (faceType == Face.HORSE)
			{
				if (hasFur())
					mutantCounter--;
				if (tailType == Tail.HORSE)
					mutantCounter--;
			}
			if (faceType == Face.DOG)
			{
				if (hasFur())
					mutantCounter--;
				if (tailType == Tail.DOG)
					mutantCounter--;
			}
			if (isGargoyle()) mutantCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) mutantCounter = 0;
			End("Player","racialScore");
			return mutantCounter;
		}

		//Troll score
		public function trollScore():Number {
			Begin("Player","racialScore","troll");
			var trollCounter:Number = 0;
		//	if (hasCoatOfType(Skin.CHITIN))
		//		trollCounter++;
		//	if (tailType == Tail.SCORPION)
		//		trollCounter++;
		//	if (scorpionCounter > 0 && hasPerk(PerkLib.TrachealSystem))
		//		trollCounter++;
		//	if (scorpionCounter > 4 && hasPerk(PerkLib.TrachealSystemEvolved))
		//		trollCounter++;
		//	if (scorpionCounter > 8 && hasPerk(PerkLib.TrachealSystemFinalForm))
		//		trollCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				trollCounter += 50;
			if (isGargoyle()) trollCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) trollCounter = 0;
			trollCounter = finalRacialScore(trollCounter, Race.TROLL);
			End("Player","racialScore");
			return trollCounter;
		}

		//Scorpion score
		public function scorpionScore():Number {
			Begin("Player","racialScore","scorpion");
			var scorpionCounter:Number = 0;
			if (hasCoatOfType(Skin.CHITIN))
				scorpionCounter++;
			if (tailType == Tail.SCORPION)
				scorpionCounter++;
			if (scorpionCounter > 0 && hasPerk(MutationsLib.TrachealSystem))
				scorpionCounter++;
			if (scorpionCounter > 3 && hasPerk(MutationsLib.TrachealSystemPrimitive))
				scorpionCounter++;
			if (scorpionCounter > 6 && hasPerk(MutationsLib.TrachealSystemEvolved))
				scorpionCounter++;
			if (scorpionCounter > 9 && hasPerk(MutationsLib.TrachealSystemFinalForm))
				scorpionCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				scorpionCounter += 50;
			if (isGargoyle()) scorpionCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) scorpionCounter = 0;
			scorpionCounter = finalRacialScore(scorpionCounter, Race.SCORPION);
			End("Player","racialScore");
			return scorpionCounter;
		}

		//Mantis score
		public function mantisScore():Number {
			Begin("Player","racialScore","mantis");
			var mantisCounter:Number = 0;
			if (hasCoatOfType(Skin.CHITIN) || hasPartialCoat(Skin.CHITIN))
				mantisCounter += 3;//mantisCounter++;
			if (antennae.type == Antennae.MANTIS)
			{
				mantisCounter++;
				if (faceType == Face.HUMAN)
					mantisCounter++;
			}
			if (coatColor == "green" || "emerald" || "turquoise")
				mantisCounter++;
			if (arms.type == Arms.MANTIS)
				mantisCounter++;
			if (lowerBody == LowerBody.MANTIS)
				mantisCounter++;
			if (tailType == Tail.MANTIS_ABDOMEN)
				mantisCounter++;
			if (wings.type == Wings.MANTIS_SMALL)
				mantisCounter++;
			if (wings.type == Wings.MANTIS_LARGE)
				mantisCounter += 2;
			if (wings.type == Wings.MANTIS_LARGE_2)
				mantisCounter += 4;
			if (hasPerk(PerkLib.MantisOvipositor))
				mantisCounter++;
			if (hasPerk(MutationsLib.MantislikeAgility))
				mantisCounter++;
			if (hasPerk(MutationsLib.MantislikeAgilityPrimitive))
				mantisCounter++;
			if (hasPerk(MutationsLib.MantislikeAgilityEvolved))
				mantisCounter++;
			if (mantisCounter > 0 && hasPerk(MutationsLib.TrachealSystem))
				mantisCounter++;
			if (mantisCounter > 3 && hasPerk(MutationsLib.TrachealSystemPrimitive))
				mantisCounter++;
			if (mantisCounter > 6 && hasPerk(MutationsLib.TrachealSystemEvolved))
				mantisCounter++;
			if (mantisCounter > 9 && hasPerk(MutationsLib.TrachealSystemFinalForm))
				mantisCounter++;
			if ((hasPerk(MutationsLib.TrachealSystem) || hasPerk(MutationsLib.MantislikeAgility)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				mantisCounter++;
			if ((hasPerk(MutationsLib.TrachealSystemPrimitive) || hasPerk(MutationsLib.MantislikeAgilityPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				mantisCounter++;
			if ((hasPerk(MutationsLib.TrachealSystemEvolved) || hasPerk(MutationsLib.MantislikeAgilityEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				mantisCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				mantisCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && mantisCounter >= 4)
				mantisCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && mantisCounter >= 8)
				mantisCounter += 1;
			if (isGargoyle()) mantisCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) mantisCounter = 0;
			mantisCounter = finalRacialScore(mantisCounter, Race.MANTIS);
			End("Player","racialScore");
			return mantisCounter;
		}

		//Thunder Mantis score
		//4 eyes - adj spider 4 eyes desc
		//var. of arms, legs, wings, tail, ears

		//Salamander score
		public function salamanderScore():Number {
			Begin("Player","racialScore","salamander");
			var salamanderCounter:Number = 0;
			if (hasPartialCoat(Skin.SCALES)) {
				salamanderCounter++;
				if (InCollection(coatColor, ["red", "blazing red", "orange", "reddish-orange"]))
					salamanderCounter++;
				if (InCollection(skin.base.color, ["tan", "light", "dark", "mohagany", "russet"]))
					salamanderCounter++;
			}
			if (faceType == Face.SALAMANDER_FANGS) {
				salamanderCounter++;
				if (ears.type == Ears.HUMAN || ears.type == Ears.LIZARD)
					salamanderCounter++;
			}
			if (eyes.type == Eyes.LIZARD)
				salamanderCounter++;
			if (arms.type == Arms.SALAMANDER)
				salamanderCounter++;
			if (lowerBody == LowerBody.SALAMANDER)
				salamanderCounter++;
			if (tailType == Tail.SALAMANDER) {
				salamanderCounter += 2;
				if (wings.type == Wings.NONE)
					salamanderCounter++;
				if (horns.type == Horns.NONE)
					salamanderCounter++;
				if (rearBody.type == RearBody.NONE)
					salamanderCounter++;
			}
			if (lizardCocks() > 0)
				salamanderCounter++;
			if (hasPerk(PerkLib.Lustzerker))
				salamanderCounter++;
			if (hasPerk(MutationsLib.SalamanderAdrenalGlands))
				salamanderCounter++;
			if (hasPerk(MutationsLib.SalamanderAdrenalGlandsPrimitive))
				salamanderCounter++;
			if (hasPerk(MutationsLib.SalamanderAdrenalGlandsEvolved))
				salamanderCounter++;
			if (hasPerk(MutationsLib.SalamanderAdrenalGlands) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				salamanderCounter++;
			if (hasPerk(MutationsLib.SalamanderAdrenalGlandsPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				salamanderCounter++;
			if (hasPerk(MutationsLib.SalamanderAdrenalGlandsEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				salamanderCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				salamanderCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && salamanderCounter >= 4)
				salamanderCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && salamanderCounter >= 8)
				salamanderCounter += 1;
			if (isGargoyle()) salamanderCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) salamanderCounter = 0;
			if (wings.type == Wings.FEATHERED_PHOENIX)
				salamanderCounter = 0;
			salamanderCounter = finalRacialScore(salamanderCounter, Race.SALAMANDER);
			End("Player","racialScore");
			return salamanderCounter;
		}

		//Cave Wyrm score
		public function cavewyrmScore():Number {
			Begin("Player","racialScore","cavewyrm");
			var cavewyrmCounter:Number = 0;
			if (hasPartialCoat(Skin.SCALES)) {
				if (coatColor == "midnight black") cavewyrmCounter++;
				cavewyrmCounter++;
			}
			if (skin.base.color == "grayish-blue")
				cavewyrmCounter++;
			if (ears.type == Ears.CAVE_WYRM)
				cavewyrmCounter++;
			if (eyes.type == Eyes.CAVE_WYRM)
				cavewyrmCounter++;
			if (eyes.colour == "neon blue")
				cavewyrmCounter++;
			if (tongue.type == Tongue.CAVE_WYRM)
				cavewyrmCounter++;
			if (faceType == Face.SALAMANDER_FANGS)
				cavewyrmCounter++;
			if (arms.type == Arms.CAVE_WYRM)
				cavewyrmCounter++;
			if (lowerBody == LowerBody.CAVE_WYRM)
				cavewyrmCounter++;
			if (tailType == Tail.CAVE_WYRM)
				cavewyrmCounter++;
			if (hasStatusEffect(StatusEffects.GlowingNipples) || hasStatusEffect(StatusEffects.GlowingAsshole))
				cavewyrmCounter++;
			if (cavewyrmCocks() > 0 || vaginaType() == VaginaClass.CAVE_WYRM)
				cavewyrmCounter++;
			if (hasPerk(PerkLib.AcidSpit))
				cavewyrmCounter++;
			if (hasPerk(PerkLib.AzureflameBreath))
				cavewyrmCounter++;
			if (hasPerk(MutationsLib.CaveWyrmLungs))
				cavewyrmCounter++;
			if (hasPerk(MutationsLib.CaveWyrmLungsEvolved))
				cavewyrmCounter++;
			if (hasPerk(MutationsLib.CaveWyrmLungsFinalForm))
				cavewyrmCounter++;
			if (hasPerk(MutationsLib.CaveWyrmLungs) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				cavewyrmCounter++;
			if (hasPerk(MutationsLib.CaveWyrmLungsEvolved) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				cavewyrmCounter++;
			if (hasPerk(MutationsLib.CaveWyrmLungsFinalForm) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				cavewyrmCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				cavewyrmCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && cavewyrmCounter >= 4)
				cavewyrmCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && cavewyrmCounter >= 8)
				cavewyrmCounter += 1;
			if (isGargoyle()) cavewyrmCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) cavewyrmCounter = 0;
			cavewyrmCounter = finalRacialScore(cavewyrmCounter, Race.CAVEWYRM);
			End("Player","racialScore");
			return cavewyrmCounter;
		}

		//Yeti score
		public function yetiScore():Number {
			Begin("Player","racialScore","yeti");
			var yetiCounter:Number = 0;
			if (skin.base.color == "dark" || skin.base.color == "tan")
				yetiCounter++;
			if (eyes.colour == "silver" || eyes.colour == "grey" || eyes.colour == "gray")
				yetiCounter++;
			if (lowerBody == LowerBody.YETI)
				yetiCounter++;
			if (arms.type == Arms.YETI)
				yetiCounter++;
			if (rearBody.type == RearBody.YETI_FUR)
				yetiCounter++;
			if (eyes.type == Eyes.HUMAN)
				yetiCounter++;
			if (ears.type == Ears.YETI)
				yetiCounter++;
			if (faceType == Face.YETI_FANGS)
				yetiCounter++;
			if (hairType == Hair.FLUFFY)
				yetiCounter++;
			if (hairColor == "white")
				yetiCounter++;
			if (hasPartialCoat(Skin.FUR))
				yetiCounter++;
			if (hasFur() && coatColor == "white")
				yetiCounter++;
			if (tallness >= 78)
				yetiCounter++;
			if (butt.type >= 10)
				yetiCounter++;
			if (hasPerk(MutationsLib.YetiFat))
				yetiCounter++;
			if (hasPerk(MutationsLib.YetiFatPrimitive))
				yetiCounter++;
			if (hasPerk(MutationsLib.YetiFatEvolved))
				yetiCounter++;
			if (hasPerk(MutationsLib.YetiFat) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				yetiCounter++;
			if (hasPerk(MutationsLib.YetiFatPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				yetiCounter++;
			if (hasPerk(MutationsLib.YetiFatEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				yetiCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				yetiCounter += 50;
			if (isGargoyle()) yetiCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) yetiCounter = 0;
			yetiCounter = finalRacialScore(yetiCounter, Race.YETI);
			End("Player","racialScore");
			return yetiCounter;
		}

		//Yuki Onna score
		public function yukiOnnaScore():Number {
			Begin("Player","racialScore","yuki onna");
			var yukiOnnaCounter:Number = 0;
			if (InCollection(skin.base.color, ["snow white", "light blue", "glacial white"]))
				yukiOnnaCounter++;
			if (skinAdj == "cold")
				yukiOnnaCounter++;
			if (eyes.colour == "light purple")
				yukiOnnaCounter++;
			if (InCollection(hairColor, ["snow white", "silver white", "platinum blonde", "quartz white"]))
				yukiOnnaCounter++;
			if (hairType == Hair.SNOWY)
				yukiOnnaCounter++;
			if (lowerBody == LowerBody.YUKI_ONNA)
				yukiOnnaCounter++;
			if (arms.type == Arms.YUKI_ONNA)
				yukiOnnaCounter++;
			if (faceType == Face.YUKI_ONNA)
				yukiOnnaCounter++;
			if (rearBody.type == RearBody.GLACIAL_AURA)
				yukiOnnaCounter += 2;
			if (wings.type == Wings.LEVITATION)
				yukiOnnaCounter += 3;
			if (femininity > 99)
				yukiOnnaCounter++;
			if (!hasCock())
				yukiOnnaCounter++;
			if (hasVagina())
				yukiOnnaCounter++;
			if (hasPerk(MutationsLib.FrozenHeart))
				yukiOnnaCounter++;
			if (hasPerk(MutationsLib.FrozenHeartPrimitive))
				yukiOnnaCounter++;
			if (hasPerk(MutationsLib.FrozenHeartEvolved))
				yukiOnnaCounter++;
			if (hasPerk(MutationsLib.FrozenHeart) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				yukiOnnaCounter++;
			if (hasPerk(MutationsLib.FrozenHeartPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				yukiOnnaCounter++;
			if (hasPerk(MutationsLib.FrozenHeartEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				yukiOnnaCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				yukiOnnaCounter += 50;
			if (isGargoyle()) yukiOnnaCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) yukiOnnaCounter = 0;
			yukiOnnaCounter = finalRacialScore(yukiOnnaCounter, Race.YUKIONNA);
			End("Player","racialScore");
			return yukiOnnaCounter;
		}

		//Wendigo score
		public function wendigoScore():Number {
			Begin("Player","racialScore","wendigo");
			var wendigoCounter:Number = 0;
			if (hairColor == "silver-white")
				wendigoCounter++;
			if (coatColor == "snow white")
				wendigoCounter++;
			if (eyes.type == Eyes.DEAD)
				wendigoCounter++;
			if (eyes.colour == "spectral blue")
				wendigoCounter++;
			if (tongue.type == Tongue.RAVENOUS_TONGUE)
				wendigoCounter++;
			if (horns.type == Horns.ANTLERS && horns.count >= 4)
				wendigoCounter += 2;
			if (ears.type == Ears.DEER)
				wendigoCounter++;
			if (tailType == Tail.WENDIGO)
				wendigoCounter++;
			if (lowerBody == LowerBody.WENDIGO)
				wendigoCounter++;
			if (arms.type == Arms.WENDIGO)
				wendigoCounter++;
			if (faceType == Face.DEER || faceType == Face.ANIMAL_TOOTHS)
				wendigoCounter++;
			if (rearBody.type == RearBody.FUR_COAT)
				wendigoCounter += 2;
			if (wings.type == Wings.LEVITATION)
				wendigoCounter += 3;
			if (hasPlainSkinOnly() || hasPartialCoat(Skin.FUR))
				wendigoCounter++;
			if ((hasVagina() && biggestTitSize() >= 8) || biggestTitSize() == 0)
				wendigoCounter++;
			if (horseCocks() > 0 || (hasVagina() && vaginaType() == VaginaClass.EQUINE))
				wendigoCounter++;
			if (hasPerk(PerkLib.EndlessHunger))
				wendigoCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				wendigoCounter += 50;
			if (isGargoyle()) wendigoCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) wendigoCounter = 0;
			wendigoCounter = finalRacialScore(wendigoCounter, Race.WENDIGO);
			End("Player","racialScore");
			return wendigoCounter;
		}

		//Melkie score
		public function melkieScore():Number {
			Begin("Player","racialScore","melkie");
			var melkieCounter:Number = 0;
			if (InCollection(skin.base.color, ["light", "fair", "pale"]))
				melkieCounter++;
			if (InCollection(coatColor, ["grey", "silver", "white", "glacial white", "light gray"]))
				melkieCounter++;
			if (hairType == Hair.NORMAL)
				melkieCounter++;
			if (InCollection(hairColor, ["blonde", "platinum blonde"]))
				melkieCounter++;
			if (eyes.type == Eyes.HUMAN)
				melkieCounter++;
			if (eyes.colour == "blue")
				melkieCounter++;
			if (faceType == Face.ANIMAL_TOOTHS)
				melkieCounter++;
			if (ears.type == Ears.MELKIE)
				melkieCounter++;
			if (tongue.type == Tongue.MELKIE)
				melkieCounter++;
			if (lowerBody == LowerBody.MELKIE)
				melkieCounter += 3;
			if (arms.type == Arms.MELKIE)
				melkieCounter++;
			if (femininity > 80)
				melkieCounter++;
			if (hasVagina())
				melkieCounter++;
			if (hasPartialCoat(Skin.FUR))
				melkieCounter++;
			if (biggestTitSize() > 3)
				melkieCounter++;
			if (tallness >= 73)
				melkieCounter++;
			if (hasPerk(MutationsLib.MelkieLung))
				melkieCounter++;
			if (hasPerk(MutationsLib.MelkieLungPrimitive))
				melkieCounter++;
			if (hasPerk(MutationsLib.MelkieLungEvolved))
				melkieCounter++;
			if (lowerBody != LowerBody.MELKIE)
				melkieCounter = 0;
			if (hasPerk(MutationsLib.MelkieLung) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				melkieCounter++;
			if (hasPerk(MutationsLib.MelkieLungPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				melkieCounter++;
			if (hasPerk(MutationsLib.MelkieLungEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				melkieCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				melkieCounter += 50;
			if (hasPerk(PerkLib.MelkiesDescendant) || hasPerk(PerkLib.BloodlineMelkie))
				melkieCounter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.AscensionHybridTheory) && melkieCounter >= 4)
				melkieCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && melkieCounter >= 8)
				melkieCounter += 1;
			if (isGargoyle()) melkieCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) melkieCounter = 0;
			melkieCounter = finalRacialScore(melkieCounter, Race.MELKIE);
			End("Player","racialScore");
			return melkieCounter;
		}

		//Centaur score
		public function centaurScore():Number
		{
			if (horns.type == Horns.UNICORN || horns.type == Horns.BICORN)
				return 0;
			Begin("Player","racialScore","centaur");
			var centaurCounter:Number = 0;
			if (isTaur()) {
				centaurCounter += 2;
				if (arms.type == Arms.HUMAN)
					centaurCounter++;
				if (ears.type == Ears.HUMAN)
					centaurCounter++;
				if (faceType == Face.HUMAN)
					centaurCounter++;
				if (hasPerk(MutationsLib.TwinHeart))
					centaurCounter++;
				if (hasPerk(MutationsLib.TwinHeartPrimitive))
					centaurCounter++;
				if (hasPerk(MutationsLib.TwinHeartEvolved))
					centaurCounter++;
			}
			if (horns.type == Horns.UNICORN)
				centaurCounter = 0;
			if (lowerBody == LowerBody.HOOFED || lowerBody == LowerBody.CLOVEN_HOOFED)
				centaurCounter++;
			if (tailType == Tail.HORSE)
				centaurCounter++;
			if (hasPlainSkinOnly())
				centaurCounter++;
			if (horseCocks() > 0)
				centaurCounter++;
			if (hasVagina() && vaginaType() == VaginaClass.EQUINE)
				centaurCounter++;
			if (wings.type != Wings.NONE)
				centaurCounter -= 3;
			if (hasPerk(MutationsLib.TwinHeart))
				centaurCounter++;
			if (hasPerk(MutationsLib.TwinHeartPrimitive))
				centaurCounter++;
			if (hasPerk(MutationsLib.TwinHeartEvolved))
				centaurCounter++;
			if (hasPerk(MutationsLib.TwinHeart) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				centaurCounter++;
			if (hasPerk(MutationsLib.TwinHeartPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				centaurCounter++;
			if (hasPerk(MutationsLib.TwinHeartEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				centaurCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				centaurCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && centaurCounter >= 4)
				centaurCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && centaurCounter >= 8)
				centaurCounter += 1;
			if (isGargoyle()) centaurCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) centaurCounter = 0;
			centaurCounter = finalRacialScore(centaurCounter, Race.CENTAUR);
			End("Player","racialScore");
			return centaurCounter;
		}

		//Cancer score
		public function cancerScore():Number {
			Begin("Player","racialScore","Cancer");
			var cancerCounter:Number = 0;
			if (ears.type == Ears.HUMAN)
				cancerCounter++;
			if (hairType == Hair.NORMAL)
				cancerCounter++;
			if (eyes.type == Eyes.CANCER)
				cancerCounter++;
			if (faceType == Face.KUDERE)
				cancerCounter++;
			if (hasStatusEffect(StatusEffects.CancerCrabStance))
				cancerCounter++;
			if (lowerBody == LowerBody.CRAB)
				cancerCounter+=1;
			if (lowerBody == LowerBody.CANCER)
				cancerCounter+=4;
			if (lowerBody != LowerBody.CANCER && lowerBody != LowerBody.CRAB)
				cancerCounter = 0;
			if (wings.type == Wings.NONE)
				cancerCounter ++;
			if (eyes.colour == "orange")
				cancerCounter++;
			if (foamingCocks() > 0 || (hasVagina() && vaginaType() == VaginaClass.CANCER))
				cancerCounter++;
			if (biggestTitSize() <= 3)
				cancerCounter++;
			if (hasPerk(MutationsLib.TwinHeart))
				cancerCounter += 2;
			if (hasPerk(MutationsLib.TwinHeartPrimitive))
				cancerCounter += 2;
			if (hasPerk(MutationsLib.TwinHeartEvolved))
				cancerCounter += 2;
			if (cancerCounter > 0 && hasPerk(MutationsLib.TrachealSystem))
				cancerCounter++;
			if (cancerCounter > 3 && hasPerk(MutationsLib.TrachealSystemPrimitive))
				cancerCounter++;
			if (cancerCounter > 6 && hasPerk(MutationsLib.TrachealSystemEvolved))
				cancerCounter++;
			if (cancerCounter > 9 && hasPerk(MutationsLib.TrachealSystemFinalForm))
				cancerCounter++;
			if ((hasPerk(MutationsLib.TwinHeart) || hasPerk(MutationsLib.TrachealSystem)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				cancerCounter++;
			if ((hasPerk(MutationsLib.TwinHeartPrimitive) || hasPerk(MutationsLib.TrachealSystemPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				cancerCounter++;
			if ((hasPerk(MutationsLib.TwinHeartEvolved) || hasPerk(MutationsLib.TrachealSystemEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				cancerCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				cancerCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && cancerCounter >= 4)
				cancerCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && cancerCounter >= 8)
				cancerCounter += 1;
			if (isGargoyle()) cancerCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) cancerCounter = 0;
			if (lowerBody != LowerBody.CRAB && lowerBody != LowerBody.CANCER) cancerCounter = 0;
			cancerCounter = finalRacialScore(cancerCounter, Race.CANCER);
			End("Player","racialScore");
			return cancerCounter;
		}

		public function sphinxScore():Number
		{
			Begin("Player","racialScore","sphinx");
			var sphinxCounter:Number = 0;
			var SphinxSkinColor:Array = ["dark", "tan"];
			if (isTaur()) {
				if (lowerBody == LowerBody.CAT)
					sphinxCounter += 2;
				if (tailType == Tail.CAT && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
				if (skinType == 0 && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
				if (arms.type == Arms.SPHINX && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
				if (ears.type == Ears.LION && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
				if (faceType == Face.CAT_CANINES && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
			}
			if (InCollection(skinTone, SphinxSkinColor))
				sphinxCounter++;
			if (eyes.type == Eyes.CAT)
				sphinxCounter++;
			if (tongue.type == Tongue.CAT)
				sphinxCounter++;
			if (tailType == Tail.CAT)
				sphinxCounter++;
			if (tailType == Tail.LION)
				sphinxCounter++;
			if (lowerBody == LowerBody.CAT)
				sphinxCounter++;
			if (faceType == Face.CAT_CANINES)
				sphinxCounter++;
			if (wings.type == Wings.FEATHERED_SPHINX)
				sphinxCounter += 4;
			if (catCocks() > 0 || hasVagina())
				sphinxCounter++;
			if (hasPartialCoat(Skin.FUR) || hasPlainSkinOnly())
				sphinxCounter++;
			if (hasPerk(MutationsLib.TwinHeart))
				sphinxCounter += 2;
			if (hasPerk(MutationsLib.TwinHeartPrimitive))
				sphinxCounter += 2;
			if (hasPerk(MutationsLib.TwinHeartEvolved))
				sphinxCounter += 2;
			if (hasPerk(PerkLib.Flexibility))
				sphinxCounter++;
			if (hasPerk(MutationsLib.CatlikeNimbleness))
				sphinxCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessPrimitive))
				sphinxCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessEvolved))
				sphinxCounter++;
			if (hasPerk(MutationsLib.CatlikeNimbleness) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				sphinxCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				sphinxCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				sphinxCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				sphinxCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && sphinxCounter >= 4)
				sphinxCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && sphinxCounter >= 8)
				sphinxCounter += 1;
			if (isGargoyle()) sphinxCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) sphinxCounter = 0;
			if (arms.type != Arms.SPHINX || wings.type != Wings.FEATHERED_SPHINX) sphinxCounter = 0;
			sphinxCounter = finalRacialScore(sphinxCounter, Race.SPHINX);
			End("Player","racialScore");
			return sphinxCounter;
		}

		//Determine Unicornkin Rating
		public function unicornkinScore():Number {
			var bicornColorPalette:Array = ["black", "midnight black", "midnight"];
			var bicornHairPalette:Array = ["silver","black", "midnight black", "midnight"];
			var unicornColorPalette:Array = ["white", "pure white"];
			var unicornHairPalette:Array = ["platinum blonde","silver", "white", "pure white"];
			Begin("Player","racialScore","unicornkin");
			var unicornCounter:Number = 0;
			if (faceType == Face.HORSE)
				unicornCounter += 2;
			if (ears.type == Ears.HORSE)
				unicornCounter++;
			if (tailType == Tail.HORSE)
				unicornCounter++;
			if (lowerBody == LowerBody.HOOFED)
				unicornCounter++;
			if (eyes.type == Eyes.HUMAN)
				unicornCounter++;
			if (wings.type == Wings.NONE)
				unicornCounter += 4;
			if (horns.type == Horns.UNICORN) {
				if (horns.count < 6)
					unicornCounter++;
				if (horns.count >= 6)
					unicornCounter += 2;
				if (InCollection(hairColor, unicornHairPalette) && InCollection(coatColor, unicornColorPalette))
					unicornCounter++;
				if (eyes.colour == "blue")
					unicornCounter++;
				if (hasPerk(PerkLib.AvatorOfPurity))
					unicornCounter++;
			}
			if (horns.type == Horns.BICORN) {
				if (horns.count < 6)
					unicornCounter++;
				if (horns.count >= 6)
					unicornCounter += 2;
				if (InCollection(hairColor, bicornHairPalette) && InCollection(coatColor, bicornColorPalette))
					unicornCounter++;
				if (eyes.colour == "red")
					unicornCounter++;
				if (hasPerk(PerkLib.AvatorOfCorruption))
					unicornCounter++;
			}
			if (hasFur())
				unicornCounter++;
			if (horseCocks() > 0)
				unicornCounter++;
			if (hasVagina() && vaginaType() == VaginaClass.EQUINE)
				unicornCounter++;
			if (horns.type != Horns.UNICORN && horns.type != Horns.BICORN && (wings.type == Wings.FEATHERED_ALICORN || wings.type == Wings.NIGHTMARE))
				unicornCounter = 0;
			if (hasPerk(MutationsLib.EclipticMind))
				unicornCounter++;
			if (hasPerk(MutationsLib.EclipticMindPrimitive))
				unicornCounter++;
			if (hasPerk(MutationsLib.EclipticMindEvolved))
				unicornCounter++;
			if (hasPerk(MutationsLib.EclipticMind) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				unicornCounter++;
			if (hasPerk(MutationsLib.EclipticMindPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				unicornCounter++;
			if (hasPerk(MutationsLib.EclipticMindEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				unicornCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				unicornCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && unicornCounter >= 4)
				unicornCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && unicornCounter >= 8)
				unicornCounter += 1;
			if (wings.type == Wings.FEATHERED_ALICORN || wings.type == Wings.NIGHTMARE)
				unicornCounter = 0;
			if (faceType != Face.HORSE)
				unicornCounter = 0;
			if (horns.type != Horns.UNICORN && horns.type != Horns.BICORN)
				unicornCounter = 0;
			if (isGargoyle()) unicornCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) unicornCounter = 0;
			unicornCounter = finalRacialScore(unicornCounter, Race.UNICORN);
			End("Player","racialScore");
			return unicornCounter;
		}

		//Determine Unicorn Rating
		public function unicornScore():Number {
			var bicornColorPalette:Array = ["silver", "black", "midnight black", "midnight"];
			var bicornHairPalette:Array = ["silver","black", "midnight black", "midnight"];
			var unicornColorPalette:Array = ["white", "pure white"];
			var unicornHairPalette:Array = ["platinum blonde","silver", "white", "pure white"];
			Begin("Player","racialScore","unicorn");
			var unicornCounter:Number = 0;
			if (faceType == Face.HUMAN)
				unicornCounter++;
			if (ears.type == Ears.HORSE)
				unicornCounter++;
			if (tailType == Tail.HORSE)
				unicornCounter++;
			if (isTaur())
				unicornCounter++;
			if (lowerBody == LowerBody.HOOFED)
				unicornCounter++;
			if (eyes.type == Eyes.HUMAN)
				unicornCounter++;
			if (horns.type == Horns.UNICORN) {
				if (horns.count < 6)
					unicornCounter++;
				if (horns.count >= 6)
					unicornCounter += 2;
				if (InCollection(hairColor, unicornHairPalette) && InCollection(coatColor, unicornColorPalette))
					unicornCounter++;
				if (eyes.colour == "blue")
					unicornCounter++;
				if (hasPerk(PerkLib.AvatorOfPurity))
					unicornCounter++;
			}
			if (horns.type == Horns.BICORN) {
				if (horns.count < 6)
					unicornCounter++;
				if (horns.count >= 6)
					unicornCounter += 2;
				if (InCollection(hairColor, bicornHairPalette) && InCollection(coatColor, bicornColorPalette))
					unicornCounter++;
				if (eyes.colour == "red")
					unicornCounter++;
				if (hasPerk(PerkLib.AvatorOfCorruption))
					unicornCounter++;
			}
			if (wings.type == Wings.NONE)
				unicornCounter += 4;
			if (horseCocks() > 0)
				unicornCounter++;
			if (hasVagina() && vaginaType() == VaginaClass.EQUINE)
				unicornCounter++;
			if (hasPlainSkinOnly())
				unicornCounter++;
			if (hasPerk(MutationsLib.TwinHeart))
				unicornCounter += 2;
			if (hasPerk(MutationsLib.TwinHeartPrimitive))
				unicornCounter += 2;
			if (hasPerk(MutationsLib.TwinHeartEvolved))
				unicornCounter += 2;
			if (hasPerk(MutationsLib.EclipticMind))
				unicornCounter++;
			if (hasPerk(MutationsLib.EclipticMindPrimitive))
				unicornCounter++;
			if (hasPerk(MutationsLib.EclipticMindEvolved))
				unicornCounter++;
			if ((hasPerk(MutationsLib.TwinHeart) || hasPerk(MutationsLib.EclipticMind)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				unicornCounter++;
			if ((hasPerk(MutationsLib.TwinHeartPrimitive) || hasPerk(MutationsLib.EclipticMindPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				unicornCounter++;
			if ((hasPerk(MutationsLib.TwinHeartEvolved) || hasPerk(MutationsLib.EclipticMindEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				unicornCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				unicornCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && unicornCounter >= 4)
				unicornCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && unicornCounter >= 8)
				unicornCounter += 1;
			if (wings.type == Wings.FEATHERED_ALICORN || wings.type == Wings.NIGHTMARE)
				unicornCounter = 0;
			if (faceType != Face.HUMAN)
				unicornCounter = 0;
			if (horns.type != Horns.UNICORN && horns.type != Horns.BICORN)
				unicornCounter = 0;
			if (isGargoyle()) unicornCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) unicornCounter = 0;
			unicornCounter = finalRacialScore(unicornCounter, Race.UNICORN);
			End("Player","racialScore");
			return unicornCounter;
		}

		//Determine Alicornkin Rating
		public function alicornkinScore():Number {
			var bicornColorPalette:Array = ["silver", "black", "midnight black", "midnight"];
			var bicornHairPalette:Array = ["silver","black", "midnight black", "midnight"];
			var unicornColorPalette:Array = ["white", "pure white"];
			var unicornHairPalette:Array = ["platinum blonde","silver", "white", "pure white"];
			Begin("Player","racialScore","alicorn");
			var alicornCounter:Number = 0;
			if (faceType == Face.HORSE)
				alicornCounter += 2;
			if (ears.type == Ears.HORSE)
				alicornCounter++;
			if (tailType == Tail.HORSE)
				alicornCounter++;
			if (lowerBody == LowerBody.HOOFED)
				alicornCounter++;
			if (eyes.type == Eyes.HUMAN)
				alicornCounter++;
			if (horns.type == Horns.UNICORN) {
				if (horns.count < 6)
					alicornCounter++;
				if (horns.count >= 6)
					alicornCounter += 2;
				if (wings.type == Wings.FEATHERED_ALICORN)
					alicornCounter += 4;
				if (InCollection(hairColor, unicornHairPalette) && InCollection(coatColor, unicornColorPalette))
					alicornCounter++;
				if (eyes.colour == "blue")
					alicornCounter++;
				if (hasPerk(PerkLib.AvatorOfPurity))
					alicornCounter++;
			}
			if (horns.type == Horns.BICORN) {
				if (horns.count < 6)
					alicornCounter++;
				if (horns.count >= 6)
					alicornCounter += 2;
				if (wings.type == Wings.NIGHTMARE)
					alicornCounter += 4;
				if (InCollection(hairColor, bicornHairPalette) && InCollection(coatColor, bicornColorPalette))
					alicornCounter++;
				if (eyes.colour == "red")
					alicornCounter++;
				if (hasPerk(PerkLib.AvatorOfCorruption))
					alicornCounter++;
			}
			if (hasFur())
				alicornCounter++;
			if (horseCocks() > 0)
				alicornCounter++;
			if (hasVagina() && vaginaType() == VaginaClass.EQUINE)
				alicornCounter++;
			if (hasPerk(MutationsLib.EclipticMind))
				alicornCounter++;
			if (hasPerk(MutationsLib.EclipticMindPrimitive))
				alicornCounter++;
			if (hasPerk(MutationsLib.EclipticMindEvolved))
				alicornCounter++;
			if (hasPerk(MutationsLib.EclipticMind) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				alicornCounter++;
			if (hasPerk(MutationsLib.EclipticMindPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				alicornCounter++;
			if (hasPerk(MutationsLib.EclipticMindEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				alicornCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				alicornCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && alicornCounter >= 4)
				alicornCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && alicornCounter >= 8)
				alicornCounter += 1;
			if (faceType != Face.HORSE)
				alicornCounter = 0;
			if (horns.type != Horns.BICORN && horns.type != Horns.UNICORN)
				alicornCounter = 0;
			if (horns.type == Horns.BICORN) {
				if (wings.type != Wings.NIGHTMARE)
					alicornCounter = 0;
			}
			if (horns.type == Horns.UNICORN) {
				if (wings.type != Wings.FEATHERED_ALICORN)
					alicornCounter = 0;
			}
			if (isGargoyle()) alicornCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) alicornCounter = 0;
			alicornCounter = finalRacialScore(alicornCounter, Race.UNICORN);
			End("Player","racialScore");
			return alicornCounter;
		}

		//Determine Alicorn Rating
		public function alicornScore():Number {
			var bicornColorPalette:Array = ["silver", "black", "midnight black", "midnight"];
			var bicornHairPalette:Array = ["silver","black", "midnight black", "midnight"];
			var unicornColorPalette:Array = ["white", "pure white"];
			var unicornHairPalette:Array = ["platinum blonde","silver", "white", "pure white"];
			Begin("Player","racialScore","alicorn");
			var alicornCounter:Number = 0;
			if (faceType == Face.HUMAN)
				alicornCounter++;
			if (ears.type == Ears.HORSE)
				alicornCounter++;
			if (tailType == Tail.HORSE)
				alicornCounter++;
			if (lowerBody == LowerBody.HOOFED)
				alicornCounter++;
			if (eyes.type == Eyes.HUMAN)
				alicornCounter++;
			if (isTaur())
				alicornCounter++;
			if (horns.type == Horns.UNICORN) {
				if (horns.count < 6)
					alicornCounter++;
				if (horns.count >= 6)
					alicornCounter += 2;
				if (wings.type == Wings.FEATHERED_ALICORN)
					alicornCounter += 4;
				if (InCollection(hairColor, unicornHairPalette) && InCollection(coatColor, unicornColorPalette))
					alicornCounter++;
				if (eyes.colour == "blue")
					alicornCounter++;
				if (hasPerk(PerkLib.AvatorOfPurity))
					alicornCounter++;
			}
			if (horns.type == Horns.BICORN) {
				if (horns.count < 6)
					alicornCounter++;
				if (horns.count >= 6)
					alicornCounter += 2;
				if (wings.type == Wings.NIGHTMARE)
					alicornCounter += 4;
				if (InCollection(hairColor, bicornHairPalette) && InCollection(coatColor, bicornColorPalette))
					alicornCounter++;
				if (eyes.colour == "red")
					alicornCounter++;
				if (hasPerk(PerkLib.AvatorOfCorruption))
					alicornCounter++;
			}
			if (hasPlainSkinOnly())
				alicornCounter++;
			if (horseCocks() > 0)
				alicornCounter++;
			if (hasVagina() && vaginaType() == VaginaClass.EQUINE)
				alicornCounter++;
			if (hasPerk(MutationsLib.TwinHeart))
				alicornCounter += 2;
			if (hasPerk(MutationsLib.TwinHeartPrimitive))
				alicornCounter += 2;
			if (hasPerk(MutationsLib.TwinHeartEvolved))
				alicornCounter += 2;
			if (hasPerk(MutationsLib.EclipticMind))
				alicornCounter++;
			if (hasPerk(MutationsLib.EclipticMindPrimitive))
				alicornCounter++;
			if (hasPerk(MutationsLib.EclipticMindEvolved))
				alicornCounter++;
			if ((hasPerk(MutationsLib.TwinHeart) || hasPerk(MutationsLib.EclipticMind)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				alicornCounter++;
			if ((hasPerk(MutationsLib.TwinHeartPrimitive) || hasPerk(MutationsLib.EclipticMindPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				alicornCounter++;
			if ((hasPerk(MutationsLib.TwinHeartEvolved) || hasPerk(MutationsLib.EclipticMindEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				alicornCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				alicornCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && alicornCounter >= 4)
				alicornCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && alicornCounter >= 8)
				alicornCounter += 1;
			if (faceType != Face.HUMAN)
				alicornCounter = 0;
			if (horns.type != Horns.BICORN && horns.type != Horns.UNICORN)
				alicornCounter = 0;
			if (horns.type == Horns.BICORN) {
				if (wings.type != Wings.NIGHTMARE)
					alicornCounter = 0;
			}
			if (horns.type == Horns.UNICORN) {
				if (wings.type != Wings.FEATHERED_ALICORN)
					alicornCounter = 0;
			}
			if (isGargoyle()) alicornCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) alicornCounter = 0;
			alicornCounter = finalRacialScore(alicornCounter, Race.UNICORN);
			End("Player","racialScore");
			return alicornCounter;
		}

		//Determine Phoenix Rating
		public function phoenixScore():Number {
			Begin("Player","racialScore","phoenix");
			var phoenixCounter:Number = 0;
			if (wings.type == Wings.FEATHERED_PHOENIX)
				phoenixCounter += 4;
			if (arms.type == Arms.PHOENIX)
				phoenixCounter++;
			if (hairType == Hair.FEATHER) {
				phoenixCounter++;
				if ((faceType == Face.HUMAN || faceType == Face.SALAMANDER_FANGS) && phoenixCounter > 2)
					phoenixCounter++;
				if ((ears.type == Ears.HUMAN || ears.type == Ears.ELFIN || ears.type == Ears.LIZARD) && phoenixCounter > 2)
					phoenixCounter++;
			}
			if (eyes.type == Eyes.LIZARD)
				phoenixCounter++;
			if (lowerBody == LowerBody.SALAMANDER || lowerBody == LowerBody.HARPY)
				phoenixCounter++;
			if (tailType == Tail.SALAMANDER)
				phoenixCounter++;
			if (hasPartialCoat(Skin.SCALES))
				phoenixCounter++;
			if (lizardCocks() > 0)
				phoenixCounter++;
			if (hasPerk(PerkLib.PhoenixFireBreath))
				phoenixCounter++;
			if (hasPerk(PerkLib.HarpyWomb))
				phoenixCounter += 2;
			if (hasPerk(MutationsLib.HarpyHollowBones))
				phoenixCounter++;
			if (hasPerk(MutationsLib.HarpyHollowBonesPrimitive))
				phoenixCounter++;
			if (hasPerk(MutationsLib.HarpyHollowBonesEvolved))
				phoenixCounter++;
			if (hasPerk(MutationsLib.SalamanderAdrenalGlands))
				phoenixCounter++;
			if (hasPerk(MutationsLib.SalamanderAdrenalGlandsPrimitive))
				phoenixCounter++;
			if (hasPerk(MutationsLib.SalamanderAdrenalGlandsEvolved))
				phoenixCounter++;
			if ((hasPerk(MutationsLib.HarpyHollowBones) || hasPerk(MutationsLib.SalamanderAdrenalGlands)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				phoenixCounter++;
			if ((hasPerk(MutationsLib.HarpyHollowBonesPrimitive) || hasPerk(MutationsLib.SalamanderAdrenalGlandsPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				phoenixCounter++;
			if ((hasPerk(MutationsLib.HarpyHollowBonesEvolved) || hasPerk(MutationsLib.SalamanderAdrenalGlandsEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				phoenixCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				phoenixCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && phoenixCounter >= 4)
				phoenixCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && phoenixCounter >= 8)
				phoenixCounter += 1;
			if (isGargoyle()) phoenixCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) phoenixCounter = 0;
			phoenixCounter = finalRacialScore(phoenixCounter, Race.PHOENIX);
			if (wings.type != Wings.FEATHERED_PHOENIX) phoenixCounter = 0;
			End("Player","racialScore");
			return phoenixCounter;
		}

		//Scylla score
		public function scyllaScore():Number {
			Begin("Player","racialScore","scylla");
			var scyllaCounter:Number = 0;
			var krakenEyeColor:Array = ["Bright pink", "light purple", "purple"];
			if (faceType != Face.HUMAN)
				scyllaCounter--;
			if (eyes.type == Eyes.KRAKEN || eyes.type == Eyes.HUMAN)
				scyllaCounter++;
			if (ears.type == Ears.ELFIN)
				scyllaCounter++;
			if (horns.type == Horns.KRAKEN)
				scyllaCounter+= 2;
			if (arms.type == Arms.KRAKEN)
				scyllaCounter++;
			if (hasPlainSkinOnly() && skinAdj == "slippery")
				scyllaCounter++;
			if (rearBody.type == RearBody.KRAKEN)
				scyllaCounter++;
			if (skin.base.color == "ghostly pale")
				scyllaCounter++;
			if (InCollection(eyes.colour, krakenEyeColor))
				scyllaCounter++;
			if (tallness > 96)
				scyllaCounter++;
			if (hasVagina() && (vaginaType() == VaginaClass.SCYLLA))
				scyllaCounter++;
			if (isScylla() || isKraken()) {
				scyllaCounter += 2;
				if (isKraken())
					scyllaCounter += 2;
				if (faceType == Face.HUMAN)
					scyllaCounter++;
				if (hairType == Hair.NORMAL)
					scyllaCounter++;
				if (wings.type > Wings.NONE)
					scyllaCounter += 2;
			}
			if (hasPerk(PerkLib.InkSpray))
				scyllaCounter++;
			if (hasPerk(MutationsLib.ScyllaInkGlands))
				scyllaCounter++;
			if (hasPerk(MutationsLib.ScyllaInkGlandsPrimitive))
				scyllaCounter++;
			if (hasPerk(MutationsLib.ScyllaInkGlands) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				scyllaCounter++;
			if (hasPerk(MutationsLib.ScyllaInkGlandsPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				scyllaCounter++;
			//if (hasPerk(PerkLib.) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
			//	scyllaCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				scyllaCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && scyllaCounter >= 4)
				scyllaCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && scyllaCounter >= 8)
				scyllaCounter += 1;
			if (isGargoyle()) scyllaCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) scyllaCounter = 0;
			if (!isScylla() && !isKraken()) scyllaCounter = 0;
			scyllaCounter = finalRacialScore(scyllaCounter, Race.SCYLLA);
			End("Player","racialScore");
			return scyllaCounter;
		}//potem tentacle dick lub scylla vag też bedą sie liczyć do wyniku)

		//Determine Kitshoo Rating
		public function kitshooScore():Number {
			Begin("Player","racialScore","kitshoo");
			var kitshooCounter:int = 0;
			//If the character has fox ears, +1
			if (ears.type == Ears.FOX)
				kitshooCounter++;
			//If the character has a fox tail, +1
		//	if (tailType == FOX)
		//		kitshooCounter++;
			//If the character has two to eight fox tails, +2
		//	if (tailType == FOX && tailCount >= 2 && tailCount < 9)
		//		kitshooCounter += 2;
			//If the character has nine fox tails, +3
		//	if (tailType == FOX && tailCount == 9)
		//		kitshooCounter += 3;
			//If the character has tattooed skin, +1
			//9999
			//If the character has a 'vag of holding', +1
		//	if (vaginalCapacity() >= 8000)
		//		kitshooCounter++;
			//If the character's kitshoo score is greater than 0 and:
			//If the character has a normal face, +1
			if (kitshooCounter > 0 && (faceType == Face.HUMAN || faceType == Face.FOX))
				kitshooCounter++;
			//If the character's kitshoo score is greater than 1 and:
			//If the character has "blonde","black","red","white", or "silver" hair, +1
			if (kitshooCounter > 0 && hasFur() && (InCollection(coatColor, KitsuneScene.basicKitsuneHair) || InCollection(coatColor, KitsuneScene.elderKitsuneColors)))
				kitshooCounter++;
			//If the character's femininity is 40 or higher, +1
		//	if (kitshooCounter > 0 && femininity >= 40)
		//		kitshooCounter++;
			//If the character has fur, chitin, or gooey skin, -1
		//	if (skinType == FUR && !InCollection(furColor, KitsuneScene.basicKitsuneFur) && !InCollection(furColor, KitsuneScene.elderKitsuneColors))
		//		kitshooCounter--;
		//	if (skinType == SCALES)
		//		kitshooCounter -= 2; - czy bedzie pozytywny do wyniku czy tez nie?
			if (hasCoatOfType(Skin.CHITIN))
				kitshooCounter -= 2;
			if (hasGooSkin())
				kitshooCounter -= 3;
			//If the character has abnormal legs, -1
		//	if (lowerBody != HUMAN && lowerBody != FOX)
		//		kitshooCounter--;
			//If the character has a nonhuman face, -1
		//	if (faceType != HUMAN && faceType != FOX)
		//		kitshooCounter--;
			//If the character has ears other than fox ears, -1
		//	if (earType != FOX)
		//		kitshooCounter--;
			//If the character has tail(s) other than fox tails, -1
		//	if (tailType != FOX)
		//		kitshooCounter--;
			//When character get one of 9-tail perk
		//	if (kitshooCounter >= 3 && (hasPerk(PerkLib.EnlightenedNinetails) || hasPerk(PerkLib.CorruptedNinetails)))
		//		kitshooCounter += 2;
			//When character get Hoshi no tama
		//	if (hasPerk(MutationsLib.KitsuneThyroidGland))
		//		kitshooCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				kitshooCounter += 50;
			if (isGargoyle()) kitshooCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) kitshooCounter = 0;
			End("Player","racialScore");
			return kitshooCounter;
		}

		//plant score
		public function plantScore():Number {
			Begin("Player","racialScore","plant");
			var plantCounter:Number = 0;
			if (faceType == Face.HUMAN)
				plantCounter++;
			if (faceType == Face.PLANT_DRAGON)
				plantCounter--;
			if (horns.type == Horns.OAK || horns.type == Horns.ORCHID)
				plantCounter++;
			if (ears.type == Ears.ELFIN)
				plantCounter++;
			if (ears.type == Ears.LIZARD)
				plantCounter--;
			if ((hairType == Hair.LEAF || hairType == Hair.GRASS) && hairColor == "green")
				plantCounter++;
			if (hasPlainSkinOnly() && (InCollection(skin.base.color, ["leaf green", "lime green", "turquoise", "light green"])))
				plantCounter++;
		//	if (skinType == 6)/zielona skóra +1, bark skin +2
		//		plantCounter += 2;
			if (arms.type == Arms.PLANT)
				plantCounter++;
			if (lowerBody == LowerBody.PLANT_HIGH_HEELS || lowerBody == LowerBody.PLANT_ROOT_CLAWS) {
				if (tentacleCocks() > 0) {
					plantCounter++;
				}
				plantCounter++;
			}
			if (wings.type == Wings.PLANT)
				plantCounter++;
			if (alrauneScore() >= 13)
				plantCounter -= 7;
			if (yggdrasilScore() >= 10)
				plantCounter -= 4;
		//	if (scorpionCounter > 0 && hasPerk(MutationsLib.TrachealSystemEvolved))
		//		plantCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				plantCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && plantCounter >= 4)
				plantCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && plantCounter >= 8)
				plantCounter += 1;
			if (isGargoyle()) plantCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) plantCounter = 0;
			plantCounter = finalRacialScore(plantCounter, Race.PLANT);
			End("Player","racialScore");
			return plantCounter;
		}

		public function alrauneScore():Number {
			Begin("Player","racialScore","alraune");
			var alrauneCounter:Number = 0;
			if (faceType == Face.HUMAN)
				alrauneCounter++;
			if (eyes.type == Eyes.HUMAN)
				alrauneCounter++;
			if (eyes.colour == "light purple" || "green" || "light green")
				alrauneCounter++;
			if (ears.type == Ears.ELFIN)
				alrauneCounter++;
			if ((hairType == Hair.LEAF || hairType == Hair.GRASS) && (InCollection(skin.base.color, ["green", "light purple"])))
				alrauneCounter++;
			if (hasPlainSkinOnly() && (InCollection(skin.base.color, ["leaf green", "lime green", "turquoise", "light green"])))
				alrauneCounter++;
			if (arms.type == Arms.PLANT)
				alrauneCounter++;
			if (wings.type == Wings.NONE)
				alrauneCounter++;
			if (isAlraune())
				alrauneCounter += 5;
			if (stamenCocks() > 0)
				alrauneCounter++;
			if (hasVagina() && (vaginaType() == VaginaClass.ALRAUNE))
				alrauneCounter++;
			if (hasPerk(MutationsLib.FloralOvaries))
				alrauneCounter++;
			if (hasPerk(MutationsLib.FloralOvariesPrimitive))
				alrauneCounter++;
			if (hasPerk(MutationsLib.FloralOvariesEvolved))
				alrauneCounter++;
			if (hasPerk(MutationsLib.FloralOvaries) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				alrauneCounter++;
			if (hasPerk(MutationsLib.FloralOvariesPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				alrauneCounter++;
			if (hasPerk(MutationsLib.FloralOvariesEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				alrauneCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				alrauneCounter += 50;
			if (isGargoyle()) alrauneCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) alrauneCounter = 0;
			alrauneCounter = finalRacialScore(alrauneCounter, Race.ALRAUNE);
			End("Player","racialScore");
			return alrauneCounter;
		}

		public function yggdrasilScore():Number {
			Begin("Player","racialScore","yggdrasil");
			var yggdrasilCounter:Number = 0;
			if (faceType == Face.PLANT_DRAGON)
				yggdrasilCounter += 2;
			if ((hairType == Hair.ANEMONE || hairType == Hair.LEAF || hairType == Hair.GRASS) && hairColor == "green")
				yggdrasilCounter++;
			if (ears.type == Ears.LIZARD)
				yggdrasilCounter++;
			if (ears.type == Ears.ELFIN)
				yggdrasilCounter -= 2;
			if (arms.type == Arms.PLANT || arms.type == Arms.PLANT2)
				yggdrasilCounter += 2;//++ - untill claws tf added arms tf will count for both arms and claws tf
			//claws?

			if (wings.type == Wings.PLANT)
				yggdrasilCounter++;
			//skin(fur(moss), scales(bark))
			if (skinType == Skin.SCALES)
				yggdrasilCounter++;
			if (tentacleCocks() > 0 || stamenCocks() > 0)
				yggdrasilCounter++;
			if (lowerBody == LowerBody.YGG_ROOT_CLAWS)
				yggdrasilCounter++;
			if (tailType == Tail.YGGDRASIL)
				yggdrasilCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				yggdrasilCounter += 50;
			if (isGargoyle()) yggdrasilCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) yggdrasilCounter = 0;
			yggdrasilCounter = finalRacialScore(yggdrasilCounter, Race.YGGDRASIL);
			End("Player","racialScore");
			return yggdrasilCounter;
		}

		//Wolf/Fenrir score
		public function wolfScore():Number {
			Begin("Player","racialScore","wolf");
			var wolfCounter:Number = 0;
			if (faceType == Face.WOLF || faceType == Face.ANIMAL_TOOTHS)
				wolfCounter++;
			if (eyes.type == Eyes.FENRIR)
				wolfCounter += 3;//from collar
			if (eyes.colour == "glacial blue")
				wolfCounter += 2;
			if (eyes.type == Eyes.FERAL)
				wolfCounter -= 11;
			if (ears.type == Ears.WOLF)
				wolfCounter++;
			if (arms.type == Arms.WOLF)
				wolfCounter++;
			if (lowerBody == LowerBody.WOLF)
				wolfCounter++;
			if (tailType == Tail.WOLF)
				wolfCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				wolfCounter++;
			if (wings.type == Wings.NONE)
				wolfCounter++;
			if (hairColor == "glacial white")
				wolfCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				wolfCounter++;
			if (coatColor == "glacial white")
				wolfCounter++;
			if (rearBody.type == RearBody.FENRIR_ICE_SPIKES)
				wolfCounter += 6;//from collar
			if (wolfCocks() > 0 && wolfCounter > 0)
				wolfCounter++;
			if (hasPerk(PerkLib.FreezingBreath))
				wolfCounter += 3;
			if (hasPerk(PerkLib.AscensionHybridTheory) && wolfCounter >= 4)
				wolfCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && wolfCounter >= 8)
				wolfCounter += 1;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				wolfCounter += 50;
			if (isGargoyle()) wolfCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) wolfCounter = 0;
			wolfCounter = finalRacialScore(wolfCounter, Race.WOLF);
			End("Player","racialScore");
			return wolfCounter;
		}

		//Werewolf score
		public function werewolfScore():Number {
			Begin("Player","racialScore","werewolf");
			var werewolfCounter:Number = 0;
			if (faceType == Face.WOLF_FANGS)
				werewolfCounter++;
			if (eyes.type == Eyes.FERAL)
				werewolfCounter++;
			if (eyes.type == Eyes.FENRIR)
				werewolfCounter -= 7;
			if (ears.type == Ears.WOLF)
				werewolfCounter++;
			if (tongue.type == Tongue.DOG)
				werewolfCounter++;
			if (arms.type == Arms.WOLF)
				werewolfCounter++;
			if (lowerBody == LowerBody.WOLF)
				werewolfCounter++;
			if (tailType == Tail.WOLF)
				werewolfCounter++;
			if (hasPartialCoat(Skin.FUR))
				werewolfCounter++;
			if (rearBody.type == RearBody.WOLF_COLLAR)
				werewolfCounter++;
			if (rearBody.type == RearBody.FENRIR_ICE_SPIKES)
				werewolfCounter -= 7;
			if (wolfCocks() > 0 && werewolfCounter > 0)
				werewolfCounter++;
			if (cor >= 20)
				werewolfCounter += 2;
			if (hasPerk(PerkLib.Lycanthropy))
				werewolfCounter++;
			//if (hasPerk(PerkLib.LycanthropyDormant))
				//werewolfCounter -= 11;
			if (hasPerk(PerkLib.AscensionHybridTheory) && werewolfCounter >= 4)
				werewolfCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && werewolfCounter >= 8)
				werewolfCounter += 1;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				werewolfCounter += 50;
			if (isGargoyle()) werewolfCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) werewolfCounter = 0;
			werewolfCounter = finalRacialScore(werewolfCounter, Race.WEREWOLF);
			End("Player","racialScore");
			return werewolfCounter;
		}

		public function sirenScore():Number {
			Begin("Player","racialScore","siren");
			var sirenCounter:Number = 0;
			if (faceType == Face.SHARK_TEETH)
				sirenCounter++;
			if (hairType == Hair.FEATHER)
				sirenCounter++;
			if (hairColor == "silver")
				sirenCounter++;
			if (ears.type == Ears.SHARK || ears.type == Ears.HUMAN || ears.type == Ears.ELFIN)
				sirenCounter++;
			if (tailType == Tail.SHARK)
				sirenCounter++;
			if (wings.type == Wings.FEATHERED_LARGE)
				sirenCounter += 4;
			if (arms.type == Arms.HARPY || arms.type == Arms.SHARK)
				sirenCounter++;
			if (lowerBody == LowerBody.SHARK || lowerBody == LowerBody.HARPY)
				sirenCounter++;
			if (skinType == Skin.AQUA_SCALES && (InCollection(coatColor, ["rough gray", "orange", "dark gray", "grayish-blue", "iridescent gray", "ashen grayish-blue", "gray"])))
				sirenCounter += 2;
			if (gills.type == Gills.FISH)
				sirenCounter++;
			if (eyes.type == Eyes.HUMAN)
				sirenCounter++;
			if (vaginaType() == VaginaClass.SHARK)
				sirenCounter++;
			if (hasPerk(MutationsLib.HarpyHollowBones))
				sirenCounter++;
			if (hasPerk(MutationsLib.HarpyHollowBonesPrimitive))
				sirenCounter++;
			if (hasPerk(MutationsLib.HarpyHollowBonesEvolved))
				sirenCounter++;
			if (hasPerk(MutationsLib.SharkOlfactorySystem))
				sirenCounter++;
			if (hasPerk(MutationsLib.SharkOlfactorySystemPrimitive))
				sirenCounter++;
			if (hasPerk(MutationsLib.SharkOlfactorySystemEvolved))
				sirenCounter++;
			if ((hasPerk(MutationsLib.HarpyHollowBones) || hasPerk(MutationsLib.SharkOlfactorySystem)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				sirenCounter++;
			if ((hasPerk(MutationsLib.HarpyHollowBonesPrimitive) || hasPerk(MutationsLib.SharkOlfactorySystemPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				sirenCounter++;
			if ((hasPerk(MutationsLib.HarpyHollowBonesEvolved) || hasPerk(MutationsLib.SharkOlfactorySystemEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				sirenCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				sirenCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && sirenCounter >= 4)
				sirenCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && sirenCounter >= 8)
				sirenCounter += 1;
			if (wings.type != Wings.FEATHERED_LARGE)
				sirenCounter = 0;
			if (isGargoyle()) sirenCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) sirenCounter = 0;
			sirenCounter = finalRacialScore(sirenCounter, Race.SIREN);
			End("Player","racialScore");
			return sirenCounter;
		}

		public function pigScore():Number {
			Begin("Player","racialScore","pig");
			var pigCounter:Number = 0;
			if (ears.type == Ears.PIG)
				pigCounter++;
			if (tailType == Tail.PIG)
				pigCounter++;
			if (faceType == Face.PIG)
				pigCounter++;
			if (arms.type == Arms.PIG)
				pigCounter += 2;
			if (lowerBody == LowerBody.CLOVEN_HOOFED)
				pigCounter++;
			if (hasPlainSkinOnly())
				pigCounter++;
			if (InCollection(skin.base.color, ["pink", "tan", "sable"]))
				pigCounter++;
			if (thickness >= 75)
				pigCounter++;
			if (pigCocks() > 0)
				pigCounter++;
			if (pigCounter >= 4) {
				if (arms.type == Arms.HUMAN)
					pigCounter++;
				if (wings.type == Wings.NONE)
					pigCounter++;
				if (thickness >= 150)
					pigCounter++;
			}
			if (faceType == Face.BOAR || arms.type == Arms.BOAR) {
				if (faceType == Face.BOAR)
					pigCounter += 2;
				if (arms.type == Arms.BOAR)
					pigCounter += 2;
				if (InCollection(skin.base.color, ["pink", "dark blue"]))
					pigCounter += 2;
				if (hasFur() && (InCollection(coatColor, ["dark brown", "brown", "black", "red", "grey"])))
					pigCounter += 2;
			}
			if (hasPerk(MutationsLib.PigBoarFat))
				pigCounter++;
			if (hasPerk(MutationsLib.PigBoarFatPrimitive))
				pigCounter++;
			if (hasPerk(MutationsLib.PigBoarFatEvolved))
				pigCounter++;
			if (hasPerk(MutationsLib.PigBoarFat) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				pigCounter++;
			if (hasPerk(MutationsLib.PigBoarFatPrimitive) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				pigCounter++;
			if (hasPerk(MutationsLib.PigBoarFatEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				pigCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				pigCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && pigCounter >= 5)
				pigCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && pigCounter >= 10)
				pigCounter += 1;
			if (isGargoyle()) pigCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) pigCounter = 0;
			pigCounter = finalRacialScore(pigCounter, Race.PIG);
			End("Player","racialScore");
			return pigCounter;
		}

		public function satyrScore():Number {
			Begin("Player","racialScore","satyr");
			var satyrCounter:Number = 0;
			if (lowerBody == LowerBody.HOOFED)
				satyrCounter++;
			if (tailType == Tail.GOAT)
				satyrCounter++;
			if (ears.type == Ears.ELFIN)
				satyrCounter++;
			if (satyrCounter >= 3) {
				if (faceType == Face.HUMAN)
					satyrCounter++;
				if (countCocksOfType(CockTypesEnum.HUMAN) > 0)
					satyrCounter++;
				if (balls > 0 && ballSize >= 3)
					satyrCounter++;
			}
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				satyrCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && satyrCounter >= 4)
				satyrCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && satyrCounter >= 8)
				satyrCounter += 1;
			if (isGargoyle()) satyrCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) satyrCounter = 0;
			satyrCounter = finalRacialScore(satyrCounter, Race.SATYR);
			End("Player","racialScore");
			return satyrCounter;
		}

		public function rhinoScore():Number {
			Begin("Player","racialScore","rhino");
			var rhinoCounter:Number = 0;
			if (ears.type == Ears.RHINO)
				rhinoCounter++;
			if (tailType == Tail.RHINO)
				rhinoCounter++;
			if (faceType == Face.RHINO)
				rhinoCounter++;
			if (horns.type == Horns.RHINO)
				rhinoCounter++;
			if (rhinoCounter >= 2 && skin.base.color == "gray")
				rhinoCounter++;
			if (rhinoCounter >= 2 && hasCock() && countCocksOfType(CockTypesEnum.RHINO) > 0)
				rhinoCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				rhinoCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && rhinoCounter >= 4)
				rhinoCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis)  && rhinoCounter >= 8)
				rhinoCounter += 1;
			if (isGargoyle()) rhinoCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) rhinoCounter = 0;
			rhinoCounter = finalRacialScore(rhinoCounter, Race.RHINO);
			End("Player","racialScore");
			return rhinoCounter;
		}

		public function echidnaScore():Number {
			Begin("Player","racialScore","echidna");
			var echidnaCounter:Number = 0;
			if (ears.type == Ears.ECHIDNA)
				echidnaCounter++;
			if (tailType == Tail.ECHIDNA)
				echidnaCounter++;
			if (faceType == Face.ECHIDNA)
				echidnaCounter++;
			if (tongue.type == Tongue.ECHIDNA)
				echidnaCounter++;
			if (lowerBody == LowerBody.ECHIDNA)
				echidnaCounter++;
			if (echidnaCounter >= 2 && skinType == Skin.FUR)
				echidnaCounter++;
			if (echidnaCounter >= 2 && countCocksOfType(CockTypesEnum.ECHIDNA) > 0)
				echidnaCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				echidnaCounter += 50;
			if (isGargoyle()) echidnaCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) echidnaCounter = 0;
			echidnaCounter = finalRacialScore(echidnaCounter, Race.ECHIDNA);
			End("Player","racialScore");
			return echidnaCounter;
		}

		public function ushionnaScore():Number {
			Begin("Player","racialScore","ushionna");
			var ushionnaCounter:Number = 0;
			if (ears.type == Ears.COW)
				ushionnaCounter++;
			if (tailType == Tail.USHI_ONI)
				ushionnaCounter++;
			if (faceType == Face.USHI_ONI)
				ushionnaCounter++;
			if (horns.type == Horns.USHI_ONI)
				ushionnaCounter++;
			if (arms.type == Arms.USHI_ONI)
				ushionnaCounter++;
			if (lowerBody == LowerBody.USHI_ONI)
				ushionnaCounter += 2;
			if (skin.base.pattern == Skin.PATTERN_RED_PANDA_UNDERBODY)
				ushionnaCounter += 2;

			if (hasPlainSkinOnly() && (InCollection(skin.base.color, ["green", "red", "grey", "sandy-tan", "pale", "purple"])))
				ushionnaCounter++;
			if (hairType == Hair.NORMAL && (InCollection(hairColor, ["dark green", "dark red", "blue", "brown", "white", "black"])))
				ushionnaCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				ushionnaCounter += 50;
			if (isGargoyle()) ushionnaCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) ushionnaCounter = 0;
			ushionnaCounter = finalRacialScore(ushionnaCounter, Race.USHIONNA);
			End("Player","racialScore");
			return ushionnaCounter;
		}

		public function deerScore():Number {
			Begin("Player","racialScore","deer");
			var deerCounter:Number = 0;
			if (ears.type == Ears.DEER)
				deerCounter++;
			if (tailType == Tail.DEER)
				deerCounter++;
			if (faceType == Face.DEER)
				deerCounter++;
			if (lowerBody == LowerBody.CLOVEN_HOOFED || lowerBody == LowerBody.DEERTAUR)
				deerCounter++;
			if (horns.type == Horns.ANTLERS && horns.count >= 4)
				deerCounter++;
			if (deerCounter >= 2 && skinType == Skin.FUR)
				deerCounter++;
			if (deerCounter >= 3 && countCocksOfType(CockTypesEnum.HORSE) > 0)
				deerCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				deerCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory)  && deerCounter >= 4)
				deerCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && deerCounter >= 8)
				deerCounter += 1;
			if (isGargoyle()) deerCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) deerCounter = 0;
			deerCounter = finalRacialScore(deerCounter, Race.DEER);
			End("Player","racialScore");
			return deerCounter;
		}

		//Dragonne
		public function dragonneScore():Number {
			Begin("Player","racialScore","dragonne");
			var dragonneCounter:Number = 0;
			if (faceType == Face.CAT)
				dragonneCounter++;
			if (ears.type == Ears.CAT)
				dragonneCounter++;
			if (tailType == Tail.CAT)
				dragonneCounter++;
			if (tongue.type == Tongue.DRACONIC)
				dragonneCounter++;
			if (wings.type == Wings.DRACONIC_LARGE)
				dragonneCounter += 2;
			if (wings.type == Wings.DRACONIC_SMALL)
				dragonneCounter++;
			if (lowerBody == LowerBody.CAT)
				dragonneCounter++;
			if (skinType == Skin.SCALES && dragonneCounter > 0)
				dragonneCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				dragonneCounter += 50;
			if (isGargoyle()) dragonneCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) dragonneCounter = 0;
			dragonneCounter = finalRacialScore(dragonneCounter, Race.DRAGONNE);
			End("Player","racialScore");
			return dragonneCounter;
		}

		//Manticore
		public function manticoreScore():Number {
			Begin("Player","racialScore","manticore");
			var manticoreCounter:Number = 0;
			if (faceType == Face.MANTICORE)
				manticoreCounter++;
			if (eyes.type == Eyes.MANTICORE)
				manticoreCounter++;
			if (ears.type == Ears.LION)
				manticoreCounter++;
			if (tailType == Tail.MANTICORE_PUSSYTAIL)
				manticoreCounter += 2;
			if (rearBody.type == RearBody.LION_MANE)
				manticoreCounter++;
			if (arms.type == Arms.LION)
				manticoreCounter++;
			if (lowerBody == LowerBody.LION)
				manticoreCounter++;
			if (tongue.type == Tongue.CAT)
				manticoreCounter++;
			if (wings.type == Wings.MANTICORE_SMALL)
				manticoreCounter++;
			if (wings.type == Wings.MANTICORE_LARGE)
				manticoreCounter += 4;
			if (!hasCock())
				manticoreCounter++;
			if (cocks.length > 0)
				manticoreCounter -= 3;
			if (vaginaType() == VaginaClass.MANTICORE)
				manticoreCounter++;
			if (cor >= 20)
				manticoreCounter++;
			if (hasPerk(MutationsLib.CatlikeNimbleness))
				manticoreCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessPrimitive))
				manticoreCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessEvolved))
				manticoreCounter++;
			if (hasPerk(MutationsLib.ManticoreMetabolism))
				manticoreCounter++;
			if (hasPerk(MutationsLib.ManticoreMetabolismPrimitive))
				manticoreCounter++;
			if (hasPerk(MutationsLib.ManticoreMetabolismEvolved))
				manticoreCounter++;
			if ((hasPerk(MutationsLib.ManticoreMetabolism) || hasPerk(MutationsLib.CatlikeNimbleness)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				manticoreCounter++;
			if ((hasPerk(MutationsLib.ManticoreMetabolismPrimitive) || hasPerk(MutationsLib.CatlikeNimblenessPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				manticoreCounter++;
			if (hasPerk(MutationsLib.CatlikeNimblenessEvolved) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				manticoreCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				manticoreCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && manticoreCounter >= 4)
				manticoreCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && manticoreCounter >= 8)
				manticoreCounter += 1;
			if (isGargoyle()) manticoreCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) manticoreCounter = 0;
			if (tailType != Tail.MANTICORE_PUSSYTAIL) manticoreCounter = 0;
			manticoreCounter = finalRacialScore(manticoreCounter, Race.MANTICORE);
			End("Player","racialScore");
			return manticoreCounter;
		}

		public function femaleMindbreakerScore():Number {
			Begin("Player","racialScore","Mindbreaker");
			var femaleMindbreakerCounter:Number = 0;
			if (faceType == Face.HUMAN)
				femaleMindbreakerCounter++;
			if (eyes.type == Eyes.MINDBREAKER)
				femaleMindbreakerCounter++;
			if (InCollection(eyes.colour, ["yellow", "orange", "light green"]))
				femaleMindbreakerCounter++;
			if (ears.type == Ears.HUMAN)
				femaleMindbreakerCounter++;
			if (tailType == Tail.NONE)
				femaleMindbreakerCounter++;
			if (rearBody.type == RearBody.MINDBREAKER)
				femaleMindbreakerCounter+= 4;
			if (arms.type == Arms.MINDBREAKER)
				femaleMindbreakerCounter++;
			if (lowerBody == LowerBody.MINDBREAKER)
				femaleMindbreakerCounter++;
			if (tongue.type == Tongue.MINDBREAKER)
				femaleMindbreakerCounter++;
			if (wings.type == Wings.NONE)
				femaleMindbreakerCounter+= 3;
			if (vaginaType() == VaginaClass.MINDBREAKER)
				femaleMindbreakerCounter++;
			if ((hairType == Hair.MINDBREAKER) && hairColor == "purple")
				femaleMindbreakerCounter++;
			if (hasPlainSkinOnly() && (InCollection(skin.base.color, ["pale", "ghostly white", "light purple"])))
				femaleMindbreakerCounter++;
			if (skinAdj == "slippery")
				femaleMindbreakerCounter++;
			if (hasPerk(PerkLib.Insanity))
				femaleMindbreakerCounter++;
			if (hasPerk(PerkLib.MindbreakerBrain1toX))
				femaleMindbreakerCounter+= perkv1(PerkLib.MindbreakerBrain1toX);
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				femaleMindbreakerCounter+= 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && femaleMindbreakerCounter >= 4)
				femaleMindbreakerCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && femaleMindbreakerCounter >= 8)
				femaleMindbreakerCounter++;
			if (isGargoyle()) femaleMindbreakerCounter = 0;
			if (hasCock()) femaleMindbreakerCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) femaleMindbreakerCounter = 0;
			femaleMindbreakerCounter = finalRacialScore(femaleMindbreakerCounter, Race.FMINDBREAKER);
			End("Player","racialScore");
			return femaleMindbreakerCounter;
		}

		public function maleMindbreakerScore():Number {
			Begin("Player","racialScore","Mindbreaker");
			var MaleMindbreakerCounter:Number = 0;
			if (faceType == Face.HUMAN)
				MaleMindbreakerCounter++;
			if (eyes.type == Eyes.MINDBREAKERMALE)
				MaleMindbreakerCounter++;
			if (InCollection(eyes.colour, ["yellow", "orange", "light green"]))
				MaleMindbreakerCounter++;
			if (ears.type == Ears.HUMAN)
				MaleMindbreakerCounter++;
			if (tailType == Tail.NONE)
				MaleMindbreakerCounter ++;
			if (rearBody.type == RearBody.MINDBREAKER)
				MaleMindbreakerCounter+= 4;
			if (arms.type == Arms.MINDBREAKER)
				MaleMindbreakerCounter++;
			if (lowerBody == LowerBody.MINDBREAKERMALE)
				MaleMindbreakerCounter++;
			if (tongue.type == Tongue.MINDBREAKERMALE)
				MaleMindbreakerCounter++;
			if (wings.type == Wings.NONE)
				MaleMindbreakerCounter += 3;
			if (countCocksOfType(CockTypesEnum.MINDBREAKER) > 0)
				MaleMindbreakerCounter++;
			if ((hairType == Hair.MINDBREAKERMALE) && hairColor == "purple")
				MaleMindbreakerCounter++;
			if (hasPlainSkinOnly() && (InCollection(skin.base.color, ["eldritch purple"])))
				MaleMindbreakerCounter++;
			if (skinAdj == "slippery")
				MaleMindbreakerCounter ++;
			if (hasPerk(PerkLib.Insanity))
				MaleMindbreakerCounter++;
			if (hasPerk(PerkLib.MindbreakerBrain1toX))
				MaleMindbreakerCounter+= perkv1(PerkLib.MindbreakerBrain1toX);
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				MaleMindbreakerCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && MaleMindbreakerCounter >= 4)
				MaleMindbreakerCounter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && MaleMindbreakerCounter >= 8)
				MaleMindbreakerCounter += 1;
			if (isGargoyle()) MaleMindbreakerCounter = 0;
			if (hasVagina()) MaleMindbreakerCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) MaleMindbreakerCounter = 0;
			MaleMindbreakerCounter = finalRacialScore(MaleMindbreakerCounter, Race.MMINDBREAKER);
			End("Player","racialScore");
			return MaleMindbreakerCounter;
		}

		//Red Panda
		public function redpandaScore():Number {
			Begin("Player","racialScore","redpanda");
			var redpandaCounter:Number = 0;
			if (faceType == Face.RED_PANDA)
				redpandaCounter += 2;
			if (ears.type == Ears.RED_PANDA)
				redpandaCounter++;
			if (tailType == Tail.RED_PANDA)
				redpandaCounter++;
			if (arms.type == Arms.RED_PANDA)
				redpandaCounter++;
			if (lowerBody == LowerBody.RED_PANDA)
				redpandaCounter++;
			if (redpandaCounter >= 2 && skin.base.pattern == Skin.PATTERN_RED_PANDA_UNDERBODY)
				redpandaCounter++;
			if (redpandaCounter >= 2 && skinType == Skin.FUR)
				redpandaCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && redpandaCounter >= 4)
				redpandaCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && redpandaCounter >= 8)
				redpandaCounter += 1;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				redpandaCounter += 50;
			if (isGargoyle()) redpandaCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) redpandaCounter = 0;
			redpandaCounter = finalRacialScore(redpandaCounter, Race.REDPANDA);
			End("Player","racialScore");
			return redpandaCounter;
		}

		//Bear or Panda
		public function bearpandaScore():Number {
			Begin("Player","racialScore","bearpanda");
			var bearpandaCounter:Number = 0;
			if (faceType == Face.BEAR || faceType == Face.PANDA)
				bearpandaCounter++;
			if (ears.type == Ears.BEAR || ears.type == Ears.PANDA)
				bearpandaCounter++;
			if (tailType == Tail.BEAR)
				bearpandaCounter++;
			if (arms.type == Arms.BEAR)
				bearpandaCounter++;
			if (lowerBody == LowerBody.BEAR)
				bearpandaCounter++;
			if (eyes.type == Eyes.BEAR)
				bearpandaCounter++;
			if (skinType == Skin.FUR)
				bearpandaCounter++;
			if (InCollection(skin.coat.color, "black","brown","white") || (skin.coat.color == "white" && skin.coat.color2 == "black"))
				bearpandaCounter++;
			if (tallness > 72)
				bearpandaCounter += 2;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				bearpandaCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && bearpandaCounter >= 4)
				bearpandaCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && bearpandaCounter >= 8)
				bearpandaCounter += 1;
			if (isGargoyle()) bearpandaCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) bearpandaCounter = 0;
			bearpandaCounter = finalRacialScore(bearpandaCounter, Race.BEARANDPANDA);
			End("Player","racialScore");
			return bearpandaCounter;
		}

		//Determine Avian Rating
		public function avianScore():Number {
			Begin("Player","racialScore","avian");
			var avianCounter:Number = 0;
			if (hairType == Hair.FEATHER)
				avianCounter++;
			if (faceType == Face.AVIAN)
				avianCounter++;
			if (ears.type == Ears.AVIAN)
				avianCounter++;
			if (tailType == Tail.AVIAN)
				avianCounter++;
			if (arms.type == Arms.AVIAN)
				avianCounter++;
			if (lowerBody == LowerBody.AVIAN)
				avianCounter++;
			if (wings.type == Wings.FEATHERED_AVIAN)
				avianCounter += 2;
			if (hasCoatOfType(Skin.FEATHER))
				avianCounter++;
			if (avianCocks() > 0)
				avianCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				avianCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && avianCounter >= 4)
				avianCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && avianCounter >= 8)
				avianCounter += 1;
			if (isGargoyle()) avianCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) avianCounter = 0;
			avianCounter = finalRacialScore(avianCounter, Race.AVIAN);
			End("Player","racialScore");
			return avianCounter;
		}

		//Determine Gryphon Rating
		public function gryphonScore():Number {
			Begin("Player","racialScore","gryphon");
			var gryphonCounter:Number = 0;
			if (hairType == Hair.FEATHER)
				gryphonCounter++;
			if (faceType == Face.AVIAN)
				gryphonCounter++;
			if (ears.type == Ears.GRYPHON)
				gryphonCounter++;
			if (eyes.type == Eyes.GRYPHON)
				gryphonCounter++;
			if (tailType == Tail.GRIFFIN)
				gryphonCounter++;
			if (arms.type == Arms.GRYPHON)
				gryphonCounter++;
			if (lowerBody == LowerBody.GRYPHON)
				gryphonCounter++;
			if (wings.type == Wings.FEATHERED_AVIAN)
				gryphonCounter += 2;
			if (hasCoatOfType(Skin.FEATHER))
				gryphonCounter++;
			if (gryphonCocks() > 0)
				gryphonCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				gryphonCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && gryphonCounter >= 4)
				gryphonCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && gryphonCounter >= 8)
				gryphonCounter += 1;
			if (isGargoyle()) gryphonCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) gryphonCounter = 0;
			gryphonCounter = finalRacialScore(gryphonCounter, Race.GRYPHON);
			End("Player","racialScore");
			return gryphonCounter;
		}

		//Determine Peacock Rating
		public function peacockScore():Number {
			Begin("Player","racialScore","peacock");
			var peacockCounter:Number = 0;
			if (hairType == Hair.FEATHER)
				peacockCounter++;
			if (faceType == Face.AVIAN)
				peacockCounter++;
			if (ears.type == Ears.AVIAN)
				peacockCounter++;
			if (tailType == Tail.AVIAN)
				peacockCounter++;
			if (arms.type == Arms.AVIAN)
				peacockCounter++;
			if (lowerBody == LowerBody.AVIAN)
				peacockCounter++;
			if (wings.type == Wings.FEATHERED_AVIAN)
				peacockCounter += 2;
			if (hasCoatOfType(Skin.FEATHER))
				peacockCounter++;
			if (avianCocks() > 0)
				peacockCounter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				peacockCounter += 50;
			if (hasPerk(PerkLib.AscensionHybridTheory) && peacockCounter >= 4)
				peacockCounter += 1;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && peacockCounter >= 8)
				peacockCounter += 1;
			if (isGargoyle()) peacockCounter = 0;
			if (hasPerk(PerkLib.ElementalBody)) peacockCounter = 0;
			peacockCounter = finalRacialScore(peacockCounter, Race.PEACOCK);
			End("Player","racialScore");
			return peacockCounter;
		}

		//Bat
		public function batScore():int {
            Begin("Player","racialScore","bat");
			var counter:int = 0;
			if (ears.type == Ears.BAT)
				counter++;
			if (ears.type == Ears.VAMPIRE)
				counter -= 10;
			if (arms.type == Arms.BAT)
				counter += 5;
			if (faceType == Face.VAMPIRE)
				counter += 2;
			if (eyes.type == Eyes.VAMPIRE)
				counter++;
			if (rearBody.type == RearBody.BAT_COLLAR)
				counter++;
			if (counter >= 8) {
				if (lowerBody == LowerBody.HUMAN)
					counter++;
			}
			if (hasPerk(PerkLib.AscensionHybridTheory) && counter >= 4)
				counter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && counter >= 8)
				counter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				counter += 50;
			if (isGargoyle()) counter = 0;
			if (hasPerk(PerkLib.ElementalBody)) counter = 0;
			counter = finalRacialScore(counter, Race.BAT);
			End("Player","racialScore");
			return counter < 0? 0:counter;
		}

		//Vampire
		public function vampireScore():int {
            Begin("Player","racialScore","vampire");
            var counter:int = 0;
            if (ears.type == Ears.BAT)
				counter -= 10;
            if (ears.type == Ears.VAMPIRE)
				counter++;
			if (wings.type == Wings.VAMPIRE)
				counter += 4;
            if (faceType == Face.VAMPIRE)
				counter += 2;
			if (eyes.type == Eyes.VAMPIRE)
				counter++;
			if (eyes.colour == "blood-red")
				counter++;
			if (InCollection(skinTone, "pale"))
				counter++;
			if (counter >= 8) {
				if (arms.type == Arms.HUMAN)
					counter++;
				if (lowerBody == LowerBody.HUMAN)
					counter++;
			}
			if (tail.type == Tail.NONE)
				counter++;
			if (horns.type == Horns.NONE)
				counter++;
			if (antennae.type == Antennae.NONE)
				counter++;
			if (hasPerk(MutationsLib.VampiricBloodsteam))
				counter++;
			if (hasPerk(MutationsLib.VampiricBloodsteamPrimitive))
				counter++;
			if (hasPerk(MutationsLib.VampiricBloodsteamEvolved))
				counter++;
			if (hasPerk(MutationsLib.HollowFangs))
				counter++;
			if (hasPerk(MutationsLib.HollowFangsPrimitive))
				counter++;
			if (hasPerk(MutationsLib.HollowFangsEvolved))
				counter++;
			if ((hasPerk(MutationsLib.VampiricBloodsteam) || hasPerk(MutationsLib.HollowFangs)) && hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
				counter++;
			if ((hasPerk(MutationsLib.VampiricBloodsteamPrimitive) || hasPerk(MutationsLib.HollowFangsPrimitive)) && hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
				counter++;
			if ((hasPerk(MutationsLib.VampiricBloodsteamEvolved) || hasPerk(MutationsLib.HollowFangsEvolved)) && hasPerk(PerkLib.ChimericalBodySemiEpicStage))
				counter++;
			if (hasPerk(PerkLib.VampiresDescendant) || hasPerk(PerkLib.BloodlineVampire))
				counter += increaseFromBloodlinePerks();
			if (hasPerk(PerkLib.AscensionHybridTheory) && counter >= 4)
				counter++;
			if (hasPerk(PerkLib.AscensionCruelChimerasThesis) && counter >= 8)
				counter++;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				counter += 50;
			if (isGargoyle()) counter = 0;
			if (hasPerk(PerkLib.ElementalBody)) counter = 0;
			counter = finalRacialScore(counter, Race.VAMPIRE);
			End("Player","racialScore");
			return counter < 0? 0:counter;
		}

		//Gargoyle
		public function gargoyleScore():Number {
			Begin("Player","racialScore","gargoyle");
			var gargoyleCounter:Number = 0;
			if (InCollection(hairColor, ["light gray", "quartz white", "gray", "dark gray", "black", "caramel"]))
				gargoyleCounter++;
			if (InCollection(skin.base.color, ["light gray", "quartz white", "gray", "dark gray", "black", "caramel"]))
				gargoyleCounter++;
			if (hairType == Hair.NORMAL)
				gargoyleCounter++;
			if (skinType == Skin.STONE)
				gargoyleCounter++;
			if (horns.type == Horns.GARGOYLE)
				gargoyleCounter++;
			if (eyes.type == Eyes.GEMSTONES)
				gargoyleCounter++;
			if (ears.type == Ears.ELFIN)
				gargoyleCounter++;
			if (faceType == Face.DEVIL_FANGS)
				gargoyleCounter++;
			if (tongue.type == Tongue.DEMONIC)
				gargoyleCounter++;
			if (arms.type == Arms.GARGOYLE || arms.type == Arms.GARGOYLE_2)
				gargoyleCounter++;
			if (tailType == Tail.GARGOYLE || tailType == Tail.GARGOYLE_2)
				gargoyleCounter++;
			if (lowerBody == LowerBody.GARGOYLE || lowerBody == LowerBody.GARGOYLE_2)
				gargoyleCounter++;
			if (wings.type == Wings.GARGOYLE_LIKE_LARGE || Wings.FEATHERED_LARGE)
				gargoyleCounter += 4;
			if (gills.type == Gills.NONE)
				gargoyleCounter++;
			if (rearBody.type == RearBody.NONE)
				gargoyleCounter++;
			if (antennae.type == Antennae.NONE)
				gargoyleCounter++;
			if (hasPerk(PerkLib.GargoylePure) || hasPerk(PerkLib.GargoyleCorrupted))
				gargoyleCounter++;
			if (hasPerk(PerkLib.TransformationImmunity))
				gargoyleCounter += 5;
			gargoyleCounter = finalRacialScore(gargoyleCounter, Race.GARGOYLE);
			End("Player","racialScore");
			return gargoyleCounter;
		}

		public function atlachFullTfCheck():Boolean {
			return lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS && arms.type == Arms.SPIDER && eyes.type == Eyes.SPIDER && ears.type == Ears.ELFIN
			&& rearBody.type == RearBody.ATLACH_NACHA && faceType == Face.SPIDER_FANGS && hasCoatOfType(Skin.CHITIN)
			&& eyes.colour == "red" && coatColor == "midnight purple" && hairColor == "midnight purple";
		}

		public function atlachNachaScore():int {
			var score:int = 0;
			Begin("Player","racialScore","atlachNacha");
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS) {
				// Chitin glove leg 1
				score++;
			} else if (lowerBody == LowerBody.ATLACH_NACHA) {
				// Atlach drider body with tentacle 2 (From merge)
				score += 2;
			}
			// Chitin glove arm 1
			if (arms.type == Arms.SPIDER)
				score++;
			// Omni Eye on forehead 1
			if (eyes.type == Eyes.SPIDER) {
				score++;
				// Red eye color 1
				if (eyes.colour == "red")
					score++;
			}
			if (tailType == Tail.SPIDER_ADBOMEN)
				score++;
			// Atlach Spider leg wings 4
			if (rearBody.type == RearBody.ATLACH_NACHA)
				score += 4;
			// Spider fang face 1
			if (faceType == Face.SPIDER_FANGS)
				score++;
			// Partial chitin//chitin 1
			if (hasCoatOfType(Skin.CHITIN)) {
				score++;
				// Midnight purple chitin color 1
				if (coatColor == "midnight purple")
					score++;
			}
			// Midnight purple hair 1
			if (hairColor == "midnight purple")
				score++;
			// elfin ears
			if (ears.type == Ears.ELFIN)
				score++;
			// Corruption 50+ 1
			if (cor >= 50)
				score++;
			// Ovipositor +1
			if (canOvipositSpider())
				score++
			// Insanity +1 (Gained from merging)
			if (hasPerk(PerkLib.Insanity))
				score++;
			// Perk +3 (TransformationImmunity)
			if (hasPerk(PerkLib.TransformationImmunityAtlach))
				score+=3;
			if (hasPerk(MutationsLib.ArachnidBookLung))
				score+=2;
			if (hasPerk(MutationsLib.ArachnidBookLungPrimitive))
				score+=2;
			if (hasPerk(MutationsLib.ArachnidBookLungEvolved))
				score+=2;
			if (hasPerk(MutationsLib.TrachealSystem))
				score++;
			if (hasPerk(MutationsLib.TrachealSystemPrimitive))
				score++;
			if (hasPerk(MutationsLib.TrachealSystemEvolved))
				score++;
			if (hasPerk(MutationsLib.TrachealSystemFinalForm))
				score++;
			if (hasPerk(MutationsLib.VenomGlands))
				score++;
			if (hasPerk(MutationsLib.VenomGlandsPrimitive))
				score++;
			if (hasPerk(MutationsLib.VenomGlandsEvolved))
				score++;
			if (isGargoyle()) score = 0;
			if (hasPerk(PerkLib.ElementalBody)) score = 0;
			End("Player","racialScore");
			return score;
		}

		public function fusedElementalScore():Number {
			Begin("Player","racialScore","fusedElemental");
			var fusedEelementalCounter:Number = 0;
			if (hasPerk(PerkLib.ElementalBody))
				fusedEelementalCounter += 5;
			End("Player","racialScore");
			return fusedEelementalCounter;
		}

		public function currentBasicJobs():Number {
			var basicJobs:Number = 0;
			if (hasPerk(PerkLib.JobAllRounder))
				basicJobs++;
			if (hasPerk(PerkLib.JobBeastWarrior))
				basicJobs++;
			if (hasPerk(PerkLib.JobGuardian))
				basicJobs++;
			if (hasPerk(PerkLib.JobLeader))
				basicJobs++;
			if (hasPerk(PerkLib.JobRanger))
				basicJobs++;
			if (hasPerk(PerkLib.JobSeducer))
				basicJobs++;
			if (hasPerk(PerkLib.JobSorcerer))
				basicJobs++;
			if (hasPerk(PerkLib.JobSoulCultivator))
				basicJobs++;
			if (hasPerk(PerkLib.JobWarrior))
				basicJobs++;
			return basicJobs;
		}
		public function currentAdvancedJobs():Number {
			var advancedJobs1:Number = 0;
			if (hasPerk(PerkLib.JobBrawler))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobCourtesan))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobDefender))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobDervish))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobElementalConjurer))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobEnchanter))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobEromancer))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobGolemancer))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobGunslinger))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobHealer))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobHunter))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobKnight))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobMonk))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobRogue))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobSwordsman))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobWarlord))
				advancedJobs1++;
			return advancedJobs1;
		}
		public function maxAdvancedJobs():Number {
			var advancedJobs2:Number = 3;
			if (hasPerk(PerkLib.BasicAllRounderEducation))
				advancedJobs2 += 3;
			if (hasPerk(PerkLib.IntermediateAllRounderEducation))
				advancedJobs2 += 3;
			if (hasPerk(PerkLib.AdvancedAllRounderEducation))
				advancedJobs2 += 3;
			if (hasPerk(PerkLib.ExpertAllRounderEducation))
				advancedJobs2 += 3;
			if (hasPerk(PerkLib.MasterAllRounderEducation))
				advancedJobs2 += 3;
			return advancedJobs2;
		}
		public function freeAdvancedJobsSlots():Number {
			var advancedJobs3:Number = 0;
			advancedJobs3 += maxAdvancedJobs();
			advancedJobs3 -= currentAdvancedJobs();
			return advancedJobs3;
		}
		public function currentPrestigeJobs():Number {
			var prestigeJobs1:Number = 0;
			if (hasPerk(PerkLib.PrestigeJobArcaneArcher))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobArchpriest))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobBerserker))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobBindmaster))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobDruid))
				prestigeJobs1++;
		//	if (hasPerk(PerkLib.PrestigeJobGreySage))
		//		prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobNecromancer))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobSeer))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobSentinel))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobSoulArcher))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobSoulArtMaster))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobSpellKnight))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobStalker))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobTempest))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobWarlock))
				prestigeJobs1++;
			return prestigeJobs1;
		}
		public function maxPrestigeJobs():Number {
			var prestigeJobs2:Number = 2;
			if (hasPerk(PerkLib.MunchkinAtWork))
				prestigeJobs2 += 2;
			if (hasPerk(PerkLib.AscensionBuildingPrestigeX))
				prestigeJobs2 += perkv1(PerkLib.AscensionBuildingPrestigeX);
			return prestigeJobs2;
		}
		public function freePrestigeJobsSlots():Number {
			var prestigeJobs3:Number = 0;
			prestigeJobs3 += maxPrestigeJobs();
			prestigeJobs3 -= currentPrestigeJobs();
			return prestigeJobs3;
		}
		public function currentHiddenJobs():Number {
			var hiddenJobs1:Number = 0;
			if (hasPerk(PerkLib.HiddenJobBloodDemon))
				hiddenJobs1++;
			if (hasPerk(PerkLib.HiddenJobAsura))
				hiddenJobs1++;
			return hiddenJobs1;
		}
		public function maxHiddenJobs():Number {
			var hiddenJobs2:Number = 1;
			if (hasPerk(PerkLib.MunchkinAtWork))
				hiddenJobs2++;
			return hiddenJobs2;
		}
		public function freeHiddenJobsSlots():Number {
			var hiddenJobs3:Number = 0;
			hiddenJobs3 += maxHiddenJobs();
			hiddenJobs3 -= currentHiddenJobs();
			return hiddenJobs3;
		}

		public function maxHeartMutations():Number {
			var heartMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Heart")){
				if (hasPerk(pPerk[0])) {
					heartMutations--;
				}
			}
			heartMutations = heartMutations += maxAscensionBoost()
			return heartMutations;
		}
		public function maxMusclesMutations():Number {
			var musclesMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Muscle")){
				if (hasPerk(pPerk[0])) {
					musclesMutations--;
				}
			}
			musclesMutations = musclesMutations += maxAscensionBoost()
			return musclesMutations;
		}
		public function maxMouthMutations():Number {
			var mouthMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Mouth")){
				if (hasPerk(pPerk[0])) {
					mouthMutations--;
				}
			}
			mouthMutations = mouthMutations += maxAscensionBoost()
			return mouthMutations;
		}
		public function maxAdrenalGlandsMutations():Number {
			var adrenalglandsMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Adrenals")){
				if (hasPerk(pPerk[0])) {
					adrenalglandsMutations--;
				}
			}
			adrenalglandsMutations = adrenalglandsMutations += maxAscensionBoost()
			return adrenalglandsMutations;
		}
		public function maxBloodsteamMutations():Number {
			var bloodsteamMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Bloodstream")){
				if (hasPerk(pPerk[0])) {
					bloodsteamMutations--;
				}
			}
			bloodsteamMutations = bloodsteamMutations += maxAscensionBoost()
			return bloodsteamMutations;
		}
		public function maxFatTissueMutations():Number {
			var fattissueMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("FaT")){
				if (hasPerk(pPerk[0])) {
					fattissueMutations--;
				}
			}
			fattissueMutations = fattissueMutations += maxAscensionBoost()
			return fattissueMutations;
		}
		public function maxLungsMutations():Number {
			var lungsMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Lungs")){
				if (hasPerk(pPerk[0])) {
					lungsMutations--;
				}
			}
			lungsMutations = lungsMutations += maxAscensionBoost()
			return lungsMutations;
		}
		public function maxMetabolismMutations():Number {
			var metabolismMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Metabolism")){
				if (hasPerk(pPerk[0])) {
					metabolismMutations--;
				}
			}
			metabolismMutations = metabolismMutations += maxAscensionBoost()
			return metabolismMutations;
		}
		public function maxOvariesMutations():Number {
			var ovariesMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Ovaries")){
				if (hasPerk(pPerk[0])) {
					ovariesMutations--;
				}
			}
			ovariesMutations = ovariesMutations += maxAscensionBoost()
			return ovariesMutations;
		}
		public function maxBallsMutations():Number {
			var ballsMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Testicles")){
				if (hasPerk(pPerk[0])) {
					ballsMutations--;
				}
			}
			ballsMutations = ballsMutations += maxAscensionBoost()
			return ballsMutations;
		}
		public function maxEyesMutations():Number {
			var eyesMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Eyes")){
				if (hasPerk(pPerk[0])) {
					eyesMutations--;
				}
			}
			eyesMutations = eyesMutations += maxAscensionBoost()
			return eyesMutations;
		}
		public function maxPeripheralNervSysMutations():Number {
			var nervsysMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Nerv/Sys")){
				if (hasPerk(pPerk[0])) {
					nervsysMutations--;
				}
			}
			nervsysMutations = nervsysMutations += maxAscensionBoost()
			return nervsysMutations;
		}
		public function maxBonesAndMarrowMutations():Number {
			var bonesandmarrowMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Bone")){
				if (hasPerk(pPerk[0])) {
					bonesandmarrowMutations--;
				}
			}
			bonesandmarrowMutations = bonesandmarrowMutations += maxAscensionBoost()
			return bonesandmarrowMutations;
		}
		public function maxThyroidGlandMutations():Number {
			var thyroidglandMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Thyroid")){
				if (hasPerk(pPerk[0])) {
					thyroidglandMutations--;
				}
			}
			thyroidglandMutations = thyroidglandMutations += maxAscensionBoost()
			return thyroidglandMutations;
		}
		public function maxParathyroidGlandMutations():Number {
			var parathyroidglandMutations:Number = 1;
			for each (var pPerk:Array in MutationsLib.mutationsArray("PThyroid")){
				if (hasPerk(pPerk[0])) {
					parathyroidglandMutations--;
				}
			}
			parathyroidglandMutations = parathyroidglandMutations += maxAscensionBoost()
			return parathyroidglandMutations;
		}
		public function maxAdaptationsMutations():Number {
			var adaptationsMutations:Number = 2;
			for each (var pPerk:Array in MutationsLib.mutationsArray("Adaptations")){
				if (hasPerk(pPerk[0])) {
					adaptationsMutations--;
				}
			}
			adaptationsMutations = adaptationsMutations += maxAscensionBoost()
			return adaptationsMutations;
		}
		public function maxDragonMutations():Number {
			var dragonMutations:Number = 1;
			if (hasPerk(MutationsLib.DraconicBones)) dragonMutations--;
			if (hasPerk(MutationsLib.DraconicHeart)) dragonMutations--;
			if (hasPerk(MutationsLib.DraconicLungs)) dragonMutations--;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) dragonMutations++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2) dragonMutations++;
			return dragonMutations;
		}
		public function maxKitsuneMutations():Number {
			var kitsuneMutations:Number = 1;
			if (hasPerk(MutationsLib.KitsuneParathyroidGlands)) kitsuneMutations--;
			if (hasPerk(MutationsLib.KitsuneThyroidGland)) kitsuneMutations--;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) kitsuneMutations++;
			return kitsuneMutations;
		}
		public function maxAscensionBoost():Number {
			return perkv1(PerkLib.AscensionAdditionalOrganMutationX);
		}

		public function lactationQ():Number
		{
			if (biggestLactation() < 1)
				return 0;
			//(Milk production TOTAL= breastSize x 10 * lactationMultiplier * breast total * milking-endurance (1- default, maxes at 2.  Builds over time as milking as done)
			//(Small – 0.01 mLs – Size 1 + 1 Multi)
			//(Large – 0.8 - Size 10 + 4 Multi)
			//(HUGE – 2.4 - Size 12 + 5 Multi + 4 tits)
			var total:Number;
			if (!hasStatusEffect(StatusEffects.LactationEndurance))
				createStatusEffect(StatusEffects.LactationEndurance, 1, 0, 0, 0);
			total = biggestTitSize() * 10 * averageLactation() * statusEffectv1(StatusEffects.LactationEndurance) * totalBreasts();
			if (hasPerk(PerkLib.MilkMaid))
				total += 200 + (perkv1(PerkLib.MilkMaid) * 100);
			if (hasPerk(MutationsLib.LactaBovinaOvariesPrimitive))
				total += 200;
			if (hasPerk(PerkLib.ProductivityDrugs))
				total += (perkv3(PerkLib.ProductivityDrugs));
			if (hasPerk(PerkLib.AscensionMilkFaucet))
				total += (perkv1(PerkLib.AscensionMilkFaucet) * 200);
			if (hasPerk(MutationsLib.LactaBovinaOvariesEvolved))
				total *= 2.5;
			if (necklaceName == "Cow bell")
				total *= 1.5;
			if (upperGarment == game.undergarments.COW_BRA)
				total *= 1.5;
			if (lowerGarment == game.undergarments.COW_PANTY)
				total *= 1.5;
			if (statusEffectv1(StatusEffects.LactationReduction) >= 48)
				total = total * 1.5;
			if (total > int.MAX_VALUE)
				total = int.MAX_VALUE;
			return total;
		}

		public function isLactating():Boolean
		{
			return lactationQ() > 0;

		}

		public function cuntChange(cArea:Number, display:Boolean, spacingsF:Boolean = false, spacingsB:Boolean = true):Boolean {
			if (vaginas.length==0) return false;
			var wasVirgin:Boolean = vaginas[0].virgin;
			var stretched:Boolean = cuntChangeNoDisplay(cArea);
			var devirgined:Boolean = wasVirgin && !vaginas[0].virgin;
			if (devirgined){
				if(spacingsF) outputText("  ");
				outputText("<b>Your hymen is torn, robbing you of your virginity.</b>");
				if(spacingsB) outputText("  ");
			}
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(display && stretched) {
				//Virgins get different formatting
				if(devirgined) {
					//If no spaces after virgin loss
					if(!spacingsB) outputText("  ");
				}
				//Non virgins as usual
				else if(spacingsF) outputText("  ");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR) outputText("<b>Your " + Appearance.vaginaDescript(this,0)+ " is stretched painfully wide, large enough to accommodate most beasts and demons.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched so wide that it gapes continually.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " painfully stretches, the lips now wide enough to gape slightly.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now very loose.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now a little loose.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched out to a more normal size.</b>");
				if(spacingsB) outputText("  ");
			}
			return stretched;
		}

		public function buttChange(cArea:Number, display:Boolean, spacingsF:Boolean = true, spacingsB:Boolean = true):Boolean
		{
			var stretched:Boolean = buttChangeNoDisplay(cArea);
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(stretched && display) {
				if (spacingsF) outputText("  ");
				buttChangeDisplay();
				if (spacingsB) outputText("  ");
			}
			return stretched;
		}

		/**
		 * Refills player's hunger. 'amnt' is how much to refill, 'nl' determines if new line should be added before the notification.
		 * @param	amnt
		 * @param	nl
		 */
		public function refillHunger(amnt:Number = 0, nl:Boolean = true):void {
			var hungerActive:Boolean = false;
			if (flags[kFLAGS.HUNGER_ENABLED] > 0) hungerActive = true;
			if (hungerActive) {
				if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 2 || flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 3) hungerActive = false;
				else if (hasPerk(PerkLib.DeadMetabolism)) hungerActive = false;
				else if (hasPerk(PerkLib.GargoylePure) || hasPerk(PerkLib.GargoyleCorrupted)) hungerActive = false;
			}
			if (flags[kFLAGS.IN_PRISON] > 0) hungerActive = true;
			if (hungerActive) {
				var oldHunger:Number = hunger;
				var weightChange:int = 0;
				var overeatingLimit:int = 0;
				overeatingLimit += 10;
				if (hasPerk(PerkLib.IronStomach)) overeatingLimit += 5;
				if (hasPerk(PerkLib.IronStomachEx)) overeatingLimit += 10;
				if (hasPerk(PerkLib.IronStomachSu)) overeatingLimit += 15;/*(perki muszą dać zwiekszenie limitu przejedzenia sie bez przyrostu wagi powyżej 10 ^^)
				overeatingLimit += 10;overating perk chyba			perki overating dające stałe utrzymywanie hunger powyżej limitu max hunger dopóki hunger naturalnie nie zostanie zużyty xD
				overeatingLimit += 20;overeating ex perk chyba		achiev polegający na przeżyciu x dni bez jedzenie czegokolwiek wiec każde podniesienie hunger resetuje ten timer xD
				overeatingLimit += 40;overeating su perk chyba*/
				hunger += amnt;
				if (hunger > maxHunger()) {
					while (hunger > (maxHunger() + overeatingLimit) && !SceneLib.prison.inPrison) {
						weightChange++;
						hunger -= overeatingLimit;
					}
					modThickness(maxThicknessCap(), weightChange);
					hunger = maxHunger();
				}
				if (hunger > oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatUp('hunger');
				//game.dynStats("lus", 0, "scale", false);
				if (nl) outputText("\n\n");
				//Messages
				if (hunger < maxHunger() * 0.1) outputText("<b>You still need to eat more. </b>");
				else if (hunger >= maxHunger() * 0.1 && hunger < maxHunger() * 0.25) outputText("<b>You are no longer starving but you still need to eat more. </b>");
				else if (hunger >= maxHunger() * 0.25 && hunger < maxHunger() * 0.5) outputText("<b>The growling sound in your stomach seems to quiet down. </b>");
				else if (hunger >= maxHunger() * 0.5 && hunger < maxHunger() * 0.75) outputText("<b>Your stomach no longer growls. </b>");
				else if (hunger >= maxHunger() * 0.75 && hunger < maxHunger() * 0.9) outputText("<b>You feel so satisfied. </b>");
				else if (hunger >= maxHunger() * 0.9) outputText("<b>Your stomach feels so full. </b>");
				if (weightChange > 0) outputText("<b>You feel like you've put on some weight. </b>");
				EngineCore.awardAchievement("Tastes Like Chicken ", kACHIEVEMENTS.REALISTIC_TASTES_LIKE_CHICKEN);
				if (oldHunger < 1 && hunger >= 100) EngineCore.awardAchievement("Champion Needs Food Badly (1)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD);
				if (oldHunger < 1 && hunger >= 250) EngineCore.awardAchievement("Champion Needs Food Badly (2)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD_2);
				if (oldHunger < 1 && hunger >= 500) EngineCore.awardAchievement("Champion Needs Food Badly (3)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD_3);
				if (oldHunger < 1 && hunger >= 1000) EngineCore.awardAchievement("Champion Needs Food Badly (4)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD_4);
				if (oldHunger >= 90) EngineCore.awardAchievement("Glutton ", kACHIEVEMENTS.REALISTIC_GLUTTON);
				if (oldHunger >= 240) EngineCore.awardAchievement("Epic Glutton ", kACHIEVEMENTS.REALISTIC_EPIC_GLUTTON);
				if (oldHunger >= 490) EngineCore.awardAchievement("Legendary Glutton ", kACHIEVEMENTS.REALISTIC_LEGENDARY_GLUTTON);
				if (oldHunger >= 990) EngineCore.awardAchievement("Mythical Glutton ", kACHIEVEMENTS.REALISTIC_MYTHICAL_GLUTTON);
				if (hunger > oldHunger) CoC.instance.mainView.statsView.showStatUp("hunger");
				dynStats("lus", 0, "scale", false);
				EngineCore.statScreenRefresh();
			}
		}
		public function refillGargoyleHunger(amnt:Number = 0, nl:Boolean = true):void {
			var oldHunger:Number = hunger;
			hunger += amnt;
			if (hunger > maxHunger()) hunger = maxHunger();
			if (hunger > oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatUp('hunger');
			//game.dynStats("lus", 0, "scale", false);
			if (nl) outputText("\n");
			if (hunger > oldHunger) CoC.instance.mainView.statsView.showStatUp("hunger");
			dynStats("lus", 0, "scale", false);
			EngineCore.statScreenRefresh();
		}

		/**
		 * Damages player's hunger. 'amnt' is how much to deduct.
		 * @param	amnt
		 */
		public function damageHunger(amnt:Number = 0):void {
			var oldHunger:Number = hunger;
			hunger -= amnt;
			if (hunger < 0) hunger = 0;
			if (hunger < oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatDown('hunger');
			dynStats("lus", 0, "scale", false);
		}

		public function get corruptionTolerance():int {
			var temp:int = perkv1(PerkLib.AscensionTolerance) * 5;
			if (flags[kFLAGS.MEANINGLESS_CORRUPTION] > 0) temp += 100;
			return temp;
		}
		public function get corAdjustedUp():Number {
			return boundFloat(0, cor + corruptionTolerance, 100);
		}
		public function get corAdjustedDown():Number {
			return boundFloat(0, cor - corruptionTolerance, 100);
		}

		public function playerMinionsCount():Number {
			var minions:Number = 0;
			if (hasStatusEffect(StatusEffects.SummonedElementals)) {
				minions += statusEffectv1(StatusEffects.SummonedElementals);
				minions += statusEffectv2(StatusEffects.SummonedElementals);
				minions += statusEffectv3(StatusEffects.SummonedElementals);
			}
			if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] > 0) minions += flags[kFLAGS.PERMANENT_GOLEMS_BAG];
			if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] > 0) minions += flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG];
			if (flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] > 0) minions += flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG];
			if (hasPerk(PerkLib.PrestigeJobNecromancer)) {
				minions += perkv2(PerkLib.PrestigeJobNecromancer);
				minions += perkv1(PerkLib.GreaterHarvest);
				minions += perkv2(PerkLib.GreaterHarvest);
			}
			return minions;
		}

		public function newGamePlusMod():int {
			var temp:int = flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			//Constrains value between 0 and 5.
			if (temp < 0) temp = 0;
			if (temp > 5) temp = 5;
			return temp;
		}

		public function buttChangeDisplay():void
		{	//Allows the test for stretching and the text output to be separated
			if (ass.analLooseness == 5) outputText("<b>Your " + Appearance.assholeDescript(this) + " is stretched even wider, capable of taking even the largest of demons and beasts.</b>");
			if (ass.analLooseness == 4) outputText("<b>Your " + Appearance.assholeDescript(this) + " becomes so stretched that it gapes continually.</b>");
			if (ass.analLooseness == 3) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now very loose.</b>");
			if (ass.analLooseness == 2) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now a little loose.</b>");
			if (ass.analLooseness == 1) outputText("<b>You have lost your anal virginity.</b>");
		}

		public function slimeFeed():void{
			if (hasStatusEffect(StatusEffects.SlimeCraving)) {
				//Reset craving value
				changeStatusValue(StatusEffects.SlimeCraving,1,0);
				//Flag to display feed update and restore stats in event parser
				if(!hasStatusEffect(StatusEffects.SlimeCravingFeed)) {
					createStatusEffect(StatusEffects.SlimeCravingFeed,0,0,0,0);
				}
				var Ammount:Number = 30;
				if ((hunger+Ammount)>maxHunger()) Ammount = (maxHunger()-hunger-1);
				refillHunger(Ammount);
				slimeGrowth();
			}
			if (hasPerk(PerkLib.Diapause)) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228] += 3 + rand(3);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] = 1;
			}
			if (isGargoyle() && hasPerk(PerkLib.GargoyleCorrupted)) refillGargoyleHunger(30);
			if (jiangshiScore() >= 20 && hasPerk(PerkLib.EnergyDependent)) EnergyDependentRestore();
		}

		public function minoCumAddiction(raw:Number = 10):void {
			//Increment minotaur cum intake count
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340]++;
			//Fix if variables go out of range.
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;

			//Turn off withdrawal
			//if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 1;
			//Reset counter
			flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] = 0;
			//If highly addicted, rises slower
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 60) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 80) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 90) raw /= 2;
			if(hasPerk(PerkLib.MinotaurCumResistance) || hasPerk(PerkLib.ManticoreCumAddict) || hasPerk(PerkLib.HaltedVitals) || hasPerk(PerkLib.LactaBovineImmunity)) raw *= 0;
			//If in withdrawl, readdiction is potent!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) raw += 10;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) raw += 5;
			raw = Math.round(raw * 100)/100;
			//PUT SOME CAPS ON DAT' SHIT
			if(raw > 50) raw = 50;
			if(raw < -50) raw = -50;
			if(!hasPerk(PerkLib.ManticoreCumAddict) || !hasPerk(PerkLib.LactaBovineImmunity) || necklaceName != "Cow bell") flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] += raw;
			//Recheck to make sure shit didn't break
			if(hasPerk(PerkLib.MinotaurCumResistance)) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0; //Never get addicted!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;
		}

		public function hasSpells():Boolean
		{
			return spellCount() > 0 || hasPerk(PerkLib.JobSorcerer);
		}

		public function spellCount():Number
		{
			return [StatusEffects.KnowsAcidRain, StatusEffects.KnowsAcidSpray, StatusEffects.KnowsAegis, StatusEffects.KnowsArcticGale, StatusEffects.KnowsArouse, StatusEffects.KnowsBalanceOfLife, StatusEffects.KnowsBlind, StatusEffects.KnowsBlink, StatusEffects.KnowsBlizzard, StatusEffects.KnowsBloodChains, StatusEffects.KnowsBloodExplosion, StatusEffects.KnowsBloodField,
			StatusEffects.KnowsBloodMissiles, StatusEffects.KnowsBloodShield, StatusEffects.KnowsBloodWave, StatusEffects.KnowsBoneArmor, StatusEffects.KnowsBoneshatter, StatusEffects.KnowsBoneSpirit, StatusEffects.KnowsChainLighting, StatusEffects.KnowsCharge, StatusEffects.KnowsChargeA, StatusEffects.KnowsClearMind, StatusEffects.KnowsCorrosiveWave, StatusEffects.KnowsCure,
			StatusEffects.KnowsConsumingDarkness, StatusEffects.KnowsCurseOfDesire, StatusEffects.KnowsCurseOfWeeping, StatusEffects.KnowsDarknessShard, StatusEffects.KnowsDivineShield, StatusEffects.KnowsDuskWave, StatusEffects.KnowsExorcise, StatusEffects.KnowsEnergyDrain, StatusEffects.KnowsFireStorm, StatusEffects.KnowsHeal, StatusEffects.KnowsHydroAcid,
			StatusEffects.KnowsIceRain, StatusEffects.KnowsIceSpike, StatusEffects.KnowsLifeSiphon, StatusEffects.KnowsLifestealEnchantment, StatusEffects.KnowsLifetap, StatusEffects.KnowsLightningBolt, StatusEffects.KnowsManaShield, StatusEffects.KnowsMentalShield, StatusEffects.KnowsMight, StatusEffects.KnowsNosferatu, StatusEffects.KnowsRegenerate, StatusEffects.KnowsRestore,
			StatusEffects.KnowsShatterstone, StatusEffects.KnowsStalagmite, StatusEffects.KnowsTearsOfDenial, StatusEffects.KnowsThunderstorm, StatusEffects.KnowsWaterBall, StatusEffects.KnowsWaterSphere, StatusEffects.KnowsWhitefire, StatusEffects.KnowsWindBlast, StatusEffects.KnowsWindBullet]
					.filter(function(item:StatusEffectType, index:int, array:Array):Boolean{
						return this.hasStatusEffect(item);},this)
					.length;
		}
		public function spellCountWhiteBlack():Number
		{
			return [StatusEffects.KnowsIceSpike, StatusEffects.KnowsDarknessShard, StatusEffects.KnowsMight, StatusEffects.KnowsBlink, StatusEffects.KnowsRegenerate, StatusEffects.KnowsArouse, StatusEffects.KnowsWhitefire, StatusEffects.KnowsLightningBolt, StatusEffects.KnowsCharge, StatusEffects.KnowsChargeA, StatusEffects.KnowsHeal, StatusEffects.KnowsBlind,
			StatusEffects.KnowsPyreBurst, StatusEffects.KnowsChainLighting, StatusEffects.KnowsArcticGale, StatusEffects.KnowsDuskWave, StatusEffects.KnowsBlizzard, StatusEffects.KnowsNosferatu, StatusEffects.KnowsCure, StatusEffects.KnowsMentalShield, StatusEffects.KnowsFireStorm, StatusEffects.KnowsIceRain]
					.filter(function(item:StatusEffectType, index:int, array:Array):Boolean{
						return this.hasStatusEffect(item);},this)
					.length;
		}

		public function armorDescript(nakedText:String = "gear"):String
		{
			var textArray:Array = [];
			var text:String = "";
			//if (armor != ArmorLib.NOTHING) text += armorName;
			//Join text.
			if (armor != ArmorLib.NOTHING) textArray.push(armor.name);
			if (upperGarment != UndergarmentLib.NOTHING) textArray.push(upperGarmentName);
			if (lowerGarment != UndergarmentLib.NOTHING) textArray.push(lowerGarmentName);
			if (textArray.length > 0) text = formatStringArray(textArray);
			//Naked?
			if (upperGarment == UndergarmentLib.NOTHING && lowerGarment == UndergarmentLib.NOTHING && armor == ArmorLib.NOTHING) text = nakedText;
			return text;
		}

		public function clothedOrNaked(clothedText:String, nakedText:String = ""):String
		{
			return (armorDescript() != "gear" ? clothedText : nakedText);
		}

		public function clothedOrNakedLower(clothedText:String, nakedText:String = ""):String
		{
			return (armorName != "gear" && !(armorName == "lethicite armor" && lowerGarmentName == "nothing") && !isTaur() ? clothedText : nakedText);
		}

		public function addToWornClothesArray(armor:Armor):void {
			for (var i:int = 0; i < previouslyWornClothes.length; i++) {
				if (previouslyWornClothes[i] == armor.shortName) return; //Already have?
			}
			previouslyWornClothes.push(armor.shortName);
		}

		public function shrinkTits(ignore_hyper_happy:Boolean=false):void
		{
			if (flags[kFLAGS.HYPER_HAPPY] && !ignore_hyper_happy)
			{
				return;
			}
			if(breastRows.length == 1) {
				if(breastRows[0].breastRating > 0) {
					//Shrink if bigger than N/A cups
					var temp:Number;
					temp = 1;
					breastRows[0].breastRating--;
					//Shrink again 50% chance
					if(breastRows[0].breastRating >= 1 && rand(2) == 0 && !hasPerk(PerkLib.BigTits)) {
						temp++;
						breastRows[0].breastRating--;
					}
					if(breastRows[0].breastRating < 0) breastRows[0].breastRating = 0;
					//Talk about shrinkage
					if(temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your breasts have shrunk!  With a quick measure, you determine they're now " + breastCup(0) + "s.");
					if(temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are much smaller!  With a quick measure, you determine they're now " + breastCup(0) + "s.");
				}
			}
			else if(breastRows.length > 1) {
				//multiple
				outputText("\n");
				//temp2 = amount changed
				//temp3 = counter
				var temp2:Number = 0;
				var temp3:Number = breastRows.length;
				while(temp3 > 0) {
					temp3--;
					if(breastRows[temp3].breastRating > 0) {
						breastRows[temp3].breastRating--;
						if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
						temp2++;
						outputText("\n");
						if(temp3 < breastRows.length - 1) outputText("...and y");
						else outputText("Y");
						outputText("our " + breastDescript(temp3) + " shrink, dropping to " + breastCup(temp3) + "s.");
					}
					if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
				}
				if(temp2 == 2) outputText("\nYou feel so much lighter after the change.");
				if(temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.");
				if(temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
			}
		}

		public function growTits(amount:Number, rowsGrown:Number, display:Boolean, growthType:Number):void
		{
			if(breastRows.length == 0) return;
			//GrowthType 1 = smallest grows
			//GrowthType 2 = Top Row working downward
			//GrowthType 3 = Only top row
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Chance for "big tits" perked characters to grow larger!
			if(hasPerk(PerkLib.BigTits) && rand(3) == 0 && amount < 1) amount=1;

			// Needs to be a number, since uint will round down to 0 prevent growth beyond a certain point
			var temp:Number = breastRows.length;
			if(growthType == 1) {
				//Select smallest breast, grow it, move on
				while(rowsGrown > 0) {
					//Temp = counter
					temp = breastRows.length;
					//Temp2 = smallest tits index
					temp2 = 0;
					//Find smallest row
					while(temp > 0) {
						temp--;
						if(breastRows[temp].breastRating < breastRows[temp2].breastRating) temp2 = temp;
					}
					//Temp 3 tracks total amount grown
					temp3 += amount;
					trace("Breastrow chosen for growth: " + String(temp2) + ".");
					//Reuse temp to store growth amount for diminishing returns.
					temp = amount;
					if (!flags[kFLAGS.HYPER_HAPPY])
					{
						//Diminishing returns!
						if(breastRows[temp2].breastRating > 3)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=1.5;
							else
								temp /=1.3;
						}

						// WHy are there three options here. They all have the same result.
						if(breastRows[temp2].breastRating > 7)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 9)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 12)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=2;
							else
								temp  /=1.5;
						}
					}

					//Grow!
					trace("Growing breasts by ", temp);
					breastRows[temp2].breastRating += temp;
					rowsGrown--;
				}
			}

			if (!flags[kFLAGS.HYPER_HAPPY])
			{
				//Diminishing returns!
				if(breastRows[0].breastRating > 3) {
					if(!hasPerk(PerkLib.BigTits)) amount/=1.5;
					else amount/=1.3;
				}
				if(breastRows[0].breastRating > 7) {
					if(!hasPerk(PerkLib.BigTits)) amount/=2;
					else amount /= 1.5;
				}
				if(breastRows[0].breastRating > 12) {
					if(!hasPerk(PerkLib.BigTits)) amount/=2;
					else amount /= 1.5;
				}
			}
			/*if(breastRows[0].breastRating > 12) {
				if(hasPerk("Big Tits") < 0) amount/=2;
				else amount /= 1.5;
			}*/
			if(growthType == 2) {
				temp = 0;
				//Start at top and keep growing down, back to top if hit bottom before done.
				while(rowsGrown > 0) {
					if(temp+1 > breastRows.length) temp = 0;
					breastRows[temp].breastRating += amount;
					trace("Breasts increased by " + amount + " on row " + temp);
					temp++;
					temp3 += amount;
					rowsGrown--;
				}
			}
			if(growthType == 3) {
				while(rowsGrown > 0) {
					rowsGrown--;
					breastRows[0].breastRating += amount;
					temp3 += amount;
				}
			}
			//Breast Growth Finished...talk about changes.
			trace("Growth amount = ", amount);
			if(display) {
				if(growthType < 3) {
					if(amount <= 2)
					{
						if(breastRows.length > 1) outputText("Your rows of " + breastDescript(0) + " jiggle with added weight, growing a bit larger.");
						if(breastRows.length == 1) outputText("Your " + breastDescript(0) + " jiggle with added weight as they expand, growing a bit larger.");
					}
					else if(amount <= 4)
					{
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of " + breastDescript(0) + " expand significantly.");
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.");
					}
					else
					{
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your " + breastDescript(0) + " tingle strongly, growing disturbingly large.");
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.");
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .5;
					}
				}
				else
				{
					if(amount <= 2) {
						if(breastRows.length > 1) outputText("Your top row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.");
						if(breastRows.length == 1) outputText("Your row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.");
					}
					if(amount > 2 && amount <= 4) {
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your top row of " + breastDescript(0) + " expand significantly.");
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.");
					}
					if(amount > 4) {
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your top row of " + breastDescript(0) + " tingle strongly, growing disturbingly large.");
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.");
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .5;
					}
				}
			}
		}

		public override function getAllMinStats():Object {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var minStr:int = 1;
			var minTou:int = 1;
			var minSpe:int = 1;
			var minInt:int = 1;
			var minWis:int = 1;
			var minLib:int = 0;
			var minSen:int = 10;
			var minCor:int = 0;
			//Minimum Libido
			if (this.gender > 0) minLib += 5;

			if (this.armorName == "lusty maiden's armor") {
				if (minLib < 50) minLib = 50;
			}
			if (minLib < (minLust() * 2 / 3) && this.hasPerk(PerkLib.GargoylePure))
			{
				minLib = (minLust() * 2 / 3);
			}
			if (this.jewelryEffectId == JewelryLib.PURITY)
			{
				minLib -= this.jewelryEffectMagnitude;
			}
			if (this.hasPerk(PerkLib.PurityBlessing)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.HistoryReligious) || this.hasPerk(PerkLib.PastLifeReligious)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.PewWarmer)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.Acolyte)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.Priest)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.Pastor)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.Saint)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.Cardinal)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.Pope)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.GargoylePure)) {
				minLib = 5;
				minSen = 5;
			}
			if (this.hasPerk(PerkLib.GargoyleCorrupted)) {
				minSen += 15;
			}
			if (beeScore() >= 17) minLib += 20;
			//Factory Perks
			if (this.hasPerk(PerkLib.DemonicLethicite)) {minCor+=10;minLib+=10;}
			if (this.hasPerk(PerkLib.ProductivityDrugs)) {minLib+=this.perkv1(PerkLib.ProductivityDrugs);minCor+=10;}
			//Minimum Sensitivity
			//Rings
			if (this.jewelryName == "Ring of Libido") minLib += 5;
			if (this.jewelryName2 == "Ring of Libido") minLib += 5;
			if (this.jewelryName3 == "Ring of Libido") minLib += 5;
			if (this.jewelryName4 == "Ring of Libido") minLib += 5;
			if (this.jewelryName == "Ring of Sensitivity") minSen += 5;
			if (this.jewelryName2 == "Ring of Sensitivity") minSen += 5;
			if (this.jewelryName3 == "Ring of Sensitivity") minSen += 5;
			if (this.jewelryName4 == "Ring of Sensitivity") minSen += 5;
			//Other
			if (this.hasPerk(PerkLib.GoblinoidBlood)) {
				if (this.hasKeyItem("Drug injectors") >= 0) {
					minLib += 25;
					minSen += 5;
				}
				if (this.hasKeyItem("Improved Drug injectors") >= 0) {
					minLib += 50;
					minSen += 10;
				}
				if (this.hasKeyItem("Potent Drug injectors") >= 0) {
					minLib += 75;
					minSen += 15;
				}
				if (this.hasKeyItem("Power bracer") >= 0) minSen += 5;
				if (this.hasKeyItem("Powboy") >= 0) minSen += 10;
				if (this.hasKeyItem("M.G.S. bracer") >= 0) minSen += 15;
			}
			if (hasPerk(PerkLib.Soulless)) minCor += 50;
			if (hasPerk(PerkLib.Phylactery)) minCor = 100;
			if (hasPerk(PerkLib.BlessingOfTheAncestorTree)) minCor = 50;
			if (this.hasPerk(PerkLib.PurityElixir)) minCor -= (this.perkv1(PerkLib.PurityElixir) * 20);
			if (minLib < 1) minLib = 1;
			if (minCor < 0) minCor = 0;
			if (minCor > 100) minCor = 100;
			return {
				str:minStr,
				tou:minTou,
				spe:minSpe,
				inte:minInt,
				wis:minWis,
				lib:minLib,
				sens:minSen,
				cor:minCor
			};
		}

		//Determine minimum lust
		public override function minLust():Number
		{
			var min:Number = 0;
			var minCap:Number = maxLust();
			//Bimbo body boosts minimum lust by 40
			if (hasPerk(PerkLib.BimboBody) || hasPerk(PerkLib.BroBody) || hasPerk(PerkLib.FutaForm)) min += Math.round(minCap * 0.2);
			if (hasStatusEffect(StatusEffects.BimboChampagne)) min += Math.round(minCap * 0.1);
			//Omnibus' Gift
			if (hasPerk(PerkLib.OmnibusGift)) min += Math.round(minCap * 0.35);
			//Easter bunny eggballs
			if (hasPerk(PerkLib.EasterBunnyBalls)) min += 10*ballSize;
			//Fera Blessing
			if (hasStatusEffect(StatusEffects.BlessingOfDivineFera)) min += Math.round(minCap * 0.15);
			//Nymph perk raises to 30
			if (hasPerk(PerkLib.Nymphomania)) min += Math.round(minCap * 0.15);
			//Oh noes anemone!
			if (hasStatusEffect(StatusEffects.AnemoneArousal)) min += Math.round(minCap * 0.3);
			//Hot blooded perk raises min lust!
			if (hasPerk(PerkLib.HotBlooded)) min += Math.round(minCap * 0.2);
			if (hasPerk(PerkLib.LuststickAdapted)) min += Math.round(minCap * 0.1);
			if (hasStatusEffect(StatusEffects.Infested)) min += min += Math.round(minCap * 0.5);
			//Add points for Crimstone
			min += Math.round(minCap * perkv1(PerkLib.PiercedCrimstone) * 0.01);
			//Subtract points for Icestone!
			min -= Math.round(minCap * perkv1(PerkLib.PiercedIcestone) * 0.01);
			min += Math.round(minCap * perkv1(PerkLib.PentUp) * 0.01);
			//Cold blooded perk reduces min lust, to a minimum of 20! Takes effect after piercings.
			if (hasPerk(PerkLib.ColdBlooded)) {
				if (min >= Math.round(minCap * 0.2)) min -= Math.round(minCap * 0.2);
				else min = 0;
			}
			//Purity Blessing perk reduce min lust, to a minimum of 10! Takes effect after piercings.
			if (hasPerk(PerkLib.PurityBlessing)) {
				if (min >= Math.round(minCap * 0.1)) min -= Math.round(minCap * 0.1);
				else min = 0;
			}
			//Harpy Lipstick and Drunken Power statuses rise minimum lust by 50.
			if(hasStatusEffect(StatusEffects.Luststick)) min += min += Math.round(minCap * 0.5);
			if(hasStatusEffect(StatusEffects.DrunkenPower)) min += min += Math.round(minCap * 0.5);
			//SHOULDRA BOOSTS
			//+20
			if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -168 && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75) {
				min += Math.round(minCap * 0.1);
				if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -216)
					min += Math.round(minCap * 0.15);
			}
			//cumOmeter
			if (tailType == Tail.MANTICORE_PUSSYTAIL && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25) {
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 20) min += Math.round(minCap * 0.05);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 20 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 15) min += Math.round(minCap * 0.1);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 15 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 10) min += Math.round(minCap * 0.15);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 10 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 5) min += Math.round(minCap * 0.2);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 5) min += Math.round(minCap * 0.25);
			}
			//MilkOMeter
			if (rearBody.type == RearBody.DISPLACER_TENTACLES && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25) {
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 20) min += Math.round(minCap * 0.05);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 20 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 15) min += Math.round(minCap * 0.1);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 15 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 10) min += Math.round(minCap * 0.15);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 10 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 5) min += Math.round(minCap * 0.2);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 5) min += Math.round(minCap * 0.25);
			}
			//SPOIDAH BOOSTS
			if(eggs() >= 20) {
				min += Math.round(minCap * 0.1);
				if(eggs() >= 40) min += Math.round(minCap * 0.1);
			}
			//Werebeast
			if (hasPerk(PerkLib.Lycanthropy)) min += Math.round(minCap * perkv1(PerkLib.Lycanthropy) * 0.01);
			//Jewelry effects
			if (jewelryEffectId == JewelryLib.MODIFIER_MINIMUM_LUST)
			{
				min += jewelryEffectMagnitude;
				if (min > (minCap - jewelryEffectMagnitude) && jewelryEffectMagnitude < 0)
				{
					minCap += jewelryEffectMagnitude;
				}
			}
			if (armorName == "lusty maiden's armor") min += Math.round(minCap * 0.3);
			if (armorName == "tentacled bark armor") min += Math.round(minCap * 0.2);
			//Constrain values
			if (min < 0) min = 0;
			if (min > minCap) min = minCap;
			return min;
		}

		public function maxToneCap():Number {
			var maxToneCap:Number = 100;
			if (hasPerk(MutationsLib.OniMusculature)) maxToneCap += 10;
			if (hasPerk(MutationsLib.OniMusculaturePrimitive)) maxToneCap += 20;
			if (hasPerk(MutationsLib.OniMusculatureEvolved)) maxToneCap += 30;
			if (hasPerk(MutationsLib.OrcAdrenalGlandsPrimitive)) maxToneCap += 10;
			return maxToneCap;
		}
		public function maxThicknessCap():Number {
			var maxThicknessCap:Number = 100;
			if (hasPerk(MutationsLib.PigBoarFat)) maxThicknessCap += 10;
			if (hasPerk(MutationsLib.PigBoarFatPrimitive)) maxThicknessCap += 20;
			if (hasPerk(MutationsLib.PigBoarFatEvolved)) maxThicknessCap += 30;
			if (hasPerk(MutationsLib.ElvishPeripheralNervSysPrimitive)) maxThicknessCap += 10;
			return maxThicknessCap;
		}

		public function strtouspeintwislibsenCalculation2():void {
			var score:int;
			removeStatusEffect(StatusEffects.StrTouSpeCounter2);
			createStatusEffect(StatusEffects.StrTouSpeCounter2,0,0,0,0);
			removeStatusEffect(StatusEffects.IntWisCounter2);
			createStatusEffect(StatusEffects.IntWisCounter2,0,0,0,0);
			removeStatusEffect(StatusEffects.LibSensCounter2);
			createStatusEffect(StatusEffects.LibSensCounter2,0,0,0,0);
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var maxStrCap2:Number = 0;
			var maxTouCap2:Number = 0;
			var maxSpeCap2:Number = 0;
			var maxIntCap2:Number = 0;
			var maxWisCap2:Number = 0;
			var maxLibCap2:Number = 0;
			var currentSen:Number = 0;
			//Alter max stats depending on race (+15 za pkt)
			if (cowScore() >= 10) {
				if (cowScore() >= 15) {
					maxStrCap2 += 170;
					maxTouCap2 += 45;
					maxSpeCap2 -= 40;
					maxIntCap2 -= 20;
					maxLibCap2 += 70;
				}
				else {
					maxStrCap2 += 120;
					maxTouCap2 += 45;
					maxSpeCap2 -= 40;
					maxIntCap2 -= 20;
					maxLibCap2 += 45;
				}
			}//+20/10-20
			if (minotaurScore() >= 10) {
				if (minotaurScore() >= 15) {
					maxStrCap2 += 170;
					maxTouCap2 += 45;
					maxSpeCap2 -= 20;
					maxIntCap2 -= 40;
					maxLibCap2 += 70;
				}
				else {
					maxStrCap2 += 120;
					maxTouCap2 += 45;
					maxSpeCap2 -= 20;
					maxIntCap2 -= 40;
					maxLibCap2 += 45;
				}
			}//+20/10-20
			if (lizardScore() >= 8) {
				maxTouCap2 += 70;
				maxIntCap2 += 50;
			}//+10/10-20
			if (dragonScore() >= 16) {
				if (dragonScore() >= 32) {
					maxStrCap2 += 100;
					maxTouCap2 += 100;
					maxSpeCap2 += 100;
					maxIntCap2 += 80;
					maxWisCap2 += 80;
					maxLibCap2 += 60;
					currentSen += 40;
				}
				else if (dragonScore() >= 24) {
					maxStrCap2 += 80;
					maxTouCap2 += 80;
					maxSpeCap2 += 80;
					maxIntCap2 += 70;
					maxWisCap2 += 70;
					maxLibCap2 += 40;
					currentSen += 30;
				}
				else {
					maxStrCap2 += 50;
					maxTouCap2 += 50;
					maxSpeCap2 += 50;
					maxIntCap2 += 40;
					maxWisCap2 += 40;
					maxLibCap2 += 30;
					currentSen += 20;
				}
			}
			if (jabberwockyScore() >= 10) {
				if (jabberwockyScore() >= 30) {
					maxStrCap2 += 125;
					maxTouCap2 += 95;
					maxSpeCap2 += 100;
					maxIntCap2 += 40;
					maxWisCap2 -= 50;
					maxLibCap2 += 140;
				}
				else if (jabberwockyScore() >= 25) {
					maxStrCap2 += 105;
					maxTouCap2 += 80;
					maxSpeCap2 += 90;
					maxIntCap2 += 40;
					maxWisCap2 -= 40;
					maxLibCap2 += 100;
				}
				else if (jabberwockyScore() >= 20) {
					maxStrCap2 += 90;
					maxTouCap2 += 70;
					maxSpeCap2 += 80;
					maxIntCap2 += 30;
					maxWisCap2 -= 30;
					maxLibCap2 += 60;
				}
				else {
					maxStrCap2 += 50;
					maxTouCap2 += 40;
					maxSpeCap2 += 50;
					maxIntCap2 += 20;
					maxWisCap2 -= 20;
					maxLibCap2 += 10;
				}
			}
			if (dogScore() >= 4) {
				maxSpeCap2 += 15;
				maxIntCap2 -= 5;
			}//+10/10-20
			if (mouseScore() >= 8) {
				if (mouseScore() >= 15 && arms.type == Arms.HINEZUMI && lowerBody == LowerBody.HINEZUMI) {
					maxStrCap2 += 75;
					maxTouCap2 -= 10;
					maxSpeCap2 += 80;
					maxWisCap2 += 80;
				}
				else if (mouseScore() >= 12 && arms.type == Arms.HINEZUMI && lowerBody == LowerBody.HINEZUMI) {
					maxStrCap2 += 60;
					maxTouCap2 -= 10;
					maxSpeCap2 += 80;
					maxWisCap2 += 50;
				}
				else {
					maxTouCap2 -= 10;
					maxSpeCap2 += 80;
					maxWisCap2 += 50;
				}
			}
			if (wolfScore() >= 8) {
				if (wolfScore() >= 21) {
					maxStrCap2 += 145;
					maxTouCap2 += 80;
					maxSpeCap2 += 100;
					maxIntCap2 -= 10;
				}
				else if (wolfScore() >= 10 && hasFur() && coatColor == "glacial white") {
					maxStrCap2 += 65;
					maxTouCap2 += 40;
					maxSpeCap2 += 55;
					maxIntCap2 -= 10;
				}
				else {
					maxStrCap2 += 50;
					maxTouCap2 += 30;
					maxSpeCap2 += 50;
					maxIntCap2 -= 10;
				}
			}//+15(60)((70))(((140))) / 10 - 20(50 - 60)((70 - 80))(((130 - 140)))
			if (werewolfScore() >= 12) {
				/*if (werewolfScore() >= 12) {
					maxStrCap2 += 100;
					maxTouCap2 += 40;
					maxSpeCap2 += 60;
					maxIntCap2 -= 20;
				}
				else {*/
					maxStrCap2 += 100;
					maxTouCap2 += 40;
					maxSpeCap2 += 60;
					maxIntCap2 -= 20;
				//}
			}
			if (foxScore() >= 7) {
				maxStrCap2 -= 30;
				maxSpeCap2 += 80;
				maxIntCap2 += 55;
			}
			if (cancerScore() >= 13) {
				if (cancerScore() >= 20) {
					maxStrCap2 += 125;
					maxSpeCap2 += 105;
					maxTouCap2 += 115;
					maxIntCap2 -= 30;
					maxWisCap2 -= 15;
				}
				else {
					maxStrCap2 += 105;
					maxSpeCap2 += 55;
					maxTouCap2 += 80;
					maxIntCap2 -= 30;
					maxWisCap2 -= 15;
				}
			}//+10 / 10 - 20
			if (catScore() >= 8) {
				if (hasPerk(PerkLib.Flexibility)) maxSpeCap2 += 70;
				else maxSpeCap2 += 60;
				maxLibCap2 += 60;
			}//+10 / 10 - 20
			if (sphinxScore() >= 14) {
				if (sphinxScore() >= 30) {
					maxStrCap2 += 110;
					maxTouCap2 -= 20;
					if (hasPerk(PerkLib.Flexibility)) maxSpeCap2 += 70;
					else maxSpeCap2 += 60;
					maxIntCap2 += 150;
					maxWisCap2 += 150;
				}
				if (sphinxScore() >= 21) {
					maxStrCap2 += 90;
					maxTouCap2 -= 20;
					if (hasPerk(PerkLib.Flexibility)) maxSpeCap2 += 60;
					else maxSpeCap2 += 50;
					maxIntCap2 += 100;
					maxWisCap2 += 95;
				}
				else {
					maxStrCap2 += 50;
					maxTouCap2 -= 10;
					if (hasPerk(PerkLib.Flexibility)) maxSpeCap2 += 50;
					else maxSpeCap2 += 40;
					maxIntCap2 += 90;
					maxWisCap2 += 40;
				}
			}//+50/-20/+40/+100/+40
			if (nekomataScore() >= 10) {
				if (hasPerk(PerkLib.Flexibility)) maxSpeCap2 += 50;
				else maxSpeCap2 += 40;
				if (tailType == 8 && tailCount >= 2 && nekomataScore() >= 12) {
					maxIntCap2 += 40;
					maxWisCap2 += 100;
				}
				else {
					maxIntCap2 += 30;
					maxWisCap2 += 80;
				}
			}
			if (cheshireScore() >= 11) {
				if (hasPerk(PerkLib.Flexibility)) maxSpeCap2 += 70;
				else maxSpeCap2 += 60;
				maxIntCap2 += 80;
				currentSen += 25;
			}
			if (hellcatScore() >= 10) {
				if (hellcatScore() >= 17) {
					if (hasPerk(PerkLib.Flexibility)) maxSpeCap2 += 80;
					else maxSpeCap2 += 70;
					maxIntCap2 += 135;
					maxLibCap2 += 100;
					currentSen += 50;
				}
				else {
					if (hasPerk(PerkLib.Flexibility)) maxSpeCap2 += 50;
					else maxSpeCap2 += 40;
					maxIntCap2 += 85;
					maxLibCap2 += 50;
					currentSen += 25;
				}
			}
			if (displacerbeastScore() >= 14){
				if (displacerbeastScore() >= 20) {
					maxStrCap2 += 140
					if (hasPerk(PerkLib.Flexibility)) maxSpeCap2 += 150;
					else maxSpeCap2 += 140;
					maxIntCap2 -= 30;
					maxWisCap2 -= 30;
					maxLibCap2 += 80;
				}
				else{
					maxStrCap2 += 95
					if (hasPerk(PerkLib.Flexibility)) maxSpeCap2 += 110;
					else maxSpeCap2 += 100;
					maxIntCap2 -= 25;
					maxWisCap2 -= 20;
					maxLibCap2 += 60;
				}
			}
			if (bunnyScore() >= 10) {
					maxStrCap2 -= 20;
					maxTouCap2 -= 10;
					maxSpeCap2 += 90;
					maxLibCap2 += 90;
			}
			if (easterbunnyScore() >= 12 && hasPerk(PerkLib.EasterBunnyBalls)) {
				if (easterbunnyScore() >= 15) {
					maxStrCap2 -= 20;
					maxTouCap2 -= 10;
					maxSpeCap2 += 105;
					maxLibCap2 += 150;
				}
				else {
					maxStrCap2 -= 20;
					maxTouCap2 -= 10;
					maxSpeCap2 += 90;
					maxLibCap2 += 120;
				}
			}//-20/-10+105+150
			if (raccoonScore() >= 8) {
				if (raccoonScore() >= 17) {
					maxSpeCap2 += 105;
					maxIntCap2 += 150;
				}
				else if (raccoonScore() >= 14) {
					maxSpeCap2 += 90;
					maxIntCap2 += 120;
				}
				else {
					maxSpeCap2 += 90;
					maxIntCap2 += 30;
				}
			}//+15/10-20
			if (horseScore() >= 7) {
				maxSpeCap2 += 70;
				maxTouCap2 += 35;
			}//+15/10-20
			if (goblinScore() >= 10) {
				maxStrCap2 -= 50;
				maxSpeCap2 += 75;
				maxIntCap2 += 100;
				maxLibCap2 += 25;
			}
			if (gremlinScore() >= 15) {
				if (gremlinScore() >= 18) {
					maxStrCap2 -= 50;
					maxSpeCap2 += 90;
					maxIntCap2 += 135;
					maxLibCap2 += 115;
					currentSen += 20;
					//minCor += 10;
				}
				else {
					maxStrCap2 -= 50;
					maxSpeCap2 += 75;
					maxIntCap2 += 120;
					maxLibCap2 += 100;
					currentSen += 20;
					//minCor += 10;
				}
			}
			if (gooScore() >= 11) {
				if (gooScore() >= 15) {
					maxTouCap2 += 115;
					maxSpeCap2 -= 50;
					maxLibCap2 += 160;
				}
				else {
					maxTouCap2 += 100;
					maxSpeCap2 -= 40;
					maxLibCap2 += 105;
				}
			}//+20/10-20
			if (magmagooScore() >= 13) {
				if (magmagooScore() >= 17) {
					maxStrCap2 += 45;
					maxTouCap2 += 115;
					maxSpeCap2 -= 50;
					maxLibCap2 += 145;
				}
				else {
					maxStrCap2 += 35;
					maxTouCap2 += 100;
					maxSpeCap2 -= 40;
					maxLibCap2 += 100;
				}
			}//+20/10-20
			if (darkgooScore() >= 13) {
				if (darkgooScore() >= 17) {
					maxTouCap2 += 115;
					maxSpeCap2 -= 50;
					maxIntCap2 += 45;
					maxLibCap2 += 145;
				}
				else {
					maxTouCap2 += 90;
					maxSpeCap2 -= 40;
					maxIntCap2 += 45;
					maxLibCap2 += 100;
				}
			}//+20/10-20
			if (kitsuneScore() >= 9 && tailType == 13 && tailCount >= 2) {
				if (kitsuneScore() >= 16 && tailCount == 9) {
					if (kitsuneScore() >= 21 && hasPerk(PerkLib.NinetailsKitsuneOfBalance)) {
						if (kitsuneScore() >= 26) {
							maxStrCap2 -= 50;
							maxSpeCap2 += 50;
							maxIntCap2 += 140;
							maxWisCap2 += 200;
							maxLibCap2 += 110;
							currentSen += 60;
						}
						else {
							maxStrCap2 -= 45;
							maxSpeCap2 += 40;
							maxIntCap2 += 125;
							maxWisCap2 += 160;
							maxLibCap2 += 80;
							currentSen += 45;
						}
					}
					else {
						maxStrCap2 -= 40;
						maxSpeCap2 += 30;
						maxIntCap2 += 110;
						maxWisCap2 += 125;
						maxLibCap2 += 45;
						currentSen += 30;
					}
				}
				else {
					maxStrCap2 -= 35;
					maxSpeCap2 += 25;
					maxIntCap2 += 60;
					maxWisCap2 += 75;
					maxLibCap2 += 30;
					currentSen += 20;
				}
			}//+50/50-60
		/*	if (kitshooScore() >= 6) {
				if (tailType == 26) {
					if (tailCount == 1) {
						maxStrCap2 -= 2;
						maxSpeCap2 += 2;
						maxIntCap2 += 4;
					}
					else if (tailCount >= 2 && tailCount < 9) {
						maxStrCap2 -= ((tailCount + 1);
						maxSpeCap2 += (tailCount + 1);
						maxIntCap2 += (tailCount/2) + 2);
					}
					else if (tailCount >= 9) {
						maxStrCap2 -= 10;
						maxSpeCap2 += 10;
						maxIntCap2 += 20;
					}
				}
			}
		*/	if (beeScore() >= 17) {
				maxTouCap2 += 80;
				maxSpeCap2 += 80;
				maxIntCap2 += 50;
				maxLibCap2 += 65;
			}//+40/30-40
			if (spiderScore() >= 7) {
				maxStrCap2 -= 20;
				maxTouCap2 += 50;
				maxIntCap2 += 75;
			}//+10/10-20
			if (kangaScore() >= 4) {
				maxTouCap2 += 5;
				maxSpeCap2 += 15;
			}//+20/10-20
			if (sharkScore() >= 10) {
				if (sharkScore() >= 11 && vaginas.length > 0 && cocks.length > 0) {
					maxStrCap2 += 60;
					maxSpeCap2 += 100;
					maxLibCap2 += 20;
				}
				else {
					maxStrCap2 += 40;
					maxSpeCap2 += 100;
					maxLibCap2 += 10;
				}
			}//+10/10-20
			if (harpyScore() >= 8) {
				if (harpyScore() >= 15) {
					maxTouCap2 -= 30;
					maxSpeCap2 += 150;
					maxLibCap2 += 105;
				}
				else {
					maxTouCap2 -= 20;
					maxSpeCap2 += 80;
					maxLibCap2 += 60;
				}
			}//+10/10-20
			if (kamaitachiScore() >= 14) {
				if (kamaitachiScore() >= 18) {
					maxStrCap2 -= 35;
					maxSpeCap2 += 200;
					maxIntCap2 += 55;
					maxWisCap2 += 100;
					currentSen += 50;
				}
				else {
					maxStrCap2 -= 20;
					maxSpeCap2 += 140;
					maxIntCap2 += 45;
					maxWisCap2 += 70;
					currentSen += 25;
				}
			}
			if (cyclopScore() >= 12) {
				maxStrCap2 += 90;
				maxTouCap2 += 90;
			}
			if (gazerScore() >= 14 && statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 6) {
				if (gazerScore() >= 21 && statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) {
					maxTouCap2 += 80;
					maxSpeCap2 -= 75;
					maxIntCap2 += 180;
					maxLibCap2 += 130;
				}
				else {
					maxTouCap2 += 55;
					maxSpeCap2 -= 65;
					maxIntCap2 += 130;
					maxLibCap2 += 90;
				}
			}
			if (ratatoskrScore() >= 12) {
				if (ratatoskrScore() >= 18) {
					maxStrCap2 -= 25;
					maxSpeCap2 += 140;
					maxIntCap2 += 155;
				}
				else {
					maxStrCap2 -= 20;
					maxSpeCap2 += 95;
					maxIntCap2 += 105;
				}
			}
			if (sirenScore() >= 10) {
				if (sirenScore() >= 20) {
					maxStrCap2 += 80;
					maxSpeCap2 += 120;
					maxLibCap2 += 100;
				}
				else {
					maxStrCap2 += 50;
					maxSpeCap2 += 70;
					maxLibCap2 += 30;
				}
			}//+20/10-20
			if (orcaScore() >= 14) {
				if (orcaScore() >= 20) {
					maxStrCap2 += 140;
					maxTouCap2 += 70;
					maxSpeCap2 += 100;
				}
				else {
					maxStrCap2 += 100;
					maxTouCap2 += 40;
					maxSpeCap2 += 70;
				}
			}//+10/10-20
			if (leviathanScore() >= 20) {
				if (leviathanScore() >= 30) {
					maxStrCap2 += 200;
					maxSpeCap2 += 100;
					maxTouCap2 += 100;
					maxIntCap2 += 50;
				} else {
					maxStrCap2 += 110;
					maxSpeCap2 += 70;
					maxTouCap2 += 70;
					maxIntCap2 += 50;
				}
			}//+60/50-60
			if (oniScore() >= 12) {
				if (oniScore() >= 18) {
					maxStrCap2 += 150;
					maxTouCap2 += 90;
					maxIntCap2 -= 30;
					maxWisCap2 += 60;
				}
				else {
					maxStrCap2 += 100;
					maxTouCap2 += 60;
					maxIntCap2 -= 20;
					maxWisCap2 += 40;
				}
			}//+10/10-20
			if (elfScore() >= 11) {
				maxStrCap2 -= 10;
				maxTouCap2 -= 15;
				maxSpeCap2 += 80;
				maxIntCap2 += 80;
				maxWisCap2 += 60;
				currentSen += 30;
			}
			if (woodElfScore() >= 22) {
				if (woodElfScore() >= 31) {
					maxStrCap2 -= 10;
					maxTouCap2 -= 15;
					maxSpeCap2 += 550;
					maxIntCap2 += 495;
					maxLibCap2 += 455;
					currentSen += 80;
				} else if (woodElfScore() >= 28) {
					maxStrCap2 -= 10;
					maxTouCap2 -= 15;
					maxSpeCap2 += 495;
					maxIntCap2 += 445;
					maxLibCap2 += 415;
					currentSen += 70;
				} else if (woodElfScore() >= 25) {
					maxStrCap2 -= 10;
					maxTouCap2 -= 15;
					maxSpeCap2 += 430;
					maxIntCap2 += 405;
					maxLibCap2 += 375;
					currentSen += 60;
				} else {
					maxStrCap2 -= 10;
					maxTouCap2 -= 15;
					maxSpeCap2 += 375;
					maxIntCap2 += 355;
					maxLibCap2 += 335;
					currentSen += 50;
				}
			}
			if (femaleMindbreakerScore() >= 20) {
				maxStrCap2 -= 60;
				maxSpeCap2 -= 10;
				maxTouCap2 += 100;
				maxIntCap2 += 550;
				maxLibCap2 += 400;
				maxWisCap2 -= 30;
				currentSen += 50;
			}
			if (maleMindbreakerScore() >= 20) {
				maxStrCap2 += 70;
				maxSpeCap2 -= 40;
				maxTouCap2 += 100;
				maxIntCap2 += 450;
				maxLibCap2 += 400;
				maxWisCap2 -= 30;
				currentSen += 50;
			}
			if (frostWyrmScore() >= 18) {
				if (frostWyrmScore() >= 26) {
					maxStrCap2 += 180;
					maxSpeCap2 += 90;
					maxTouCap2 += 150;
					maxIntCap2 -= 100;
					maxLibCap2 += 70;
				} else {
					maxStrCap2 += 130;
					maxSpeCap2 += 70;
					maxTouCap2 += 110;
					maxIntCap2 -= 90;
					maxLibCap2 += 50;
				}
			}
			if (orcScore() >= 11) {
				/*if (orcScore() >= 12 && tailType == Tail.NONE) {
					maxStrCap2 += 130;
					maxTouCap2 += 30;
					maxSpeCap2 += 10;
					maxIntCap2 -= 30;
					maxLibCap2 += 25;
				}
				else {*/
					maxStrCap2 += 130;
					maxTouCap2 += 30;
					maxSpeCap2 += 10;
					maxIntCap2 -= 30;
					maxLibCap2 += 25;
				//}
			}//+10/10-20
			if (raijuScore() >= 10) {
				if (raijuScore() >= 20) {
					maxSpeCap2 += 150;
					maxIntCap2 += 50;
					maxLibCap2 += 160;
					currentSen += 60;
				} else {
					maxSpeCap2 += 70;
					maxIntCap2 += 50;
					maxLibCap2 += 80;
					currentSen += 50;
				}
			}//+10/10-20
			if (thunderbirdScore() >= 16) {
				if (thunderbirdScore() >= 21) {
					maxTouCap2 -= 25;
					maxSpeCap2 += 155;
					maxLibCap2 += 185;
				} else {
					maxTouCap2 -= 20;
					maxSpeCap2 += 120;
					maxLibCap2 += 140;
				}
			}//+10/10-20
			if (angelScore() >= 11) {
				/*if (angelScore() >= 16 && hasPerk(PerkLib.Phylactery)) {
					maxStrCap2 += 40;
					maxTouCap2 += 60;
					maxWisCap2 += 140;
				} else {*/
					maxStrCap2 += 30;
					maxTouCap2 += 35;
					maxWisCap2 += 100;
				//}
			}//+60/50-60
			if (demonScore() >= 11) {
				if (demonScore() >= 16 && hasPerk(PerkLib.Soulless)) {
					maxSpeCap2 += 40;
					maxIntCap2 += 60;
					maxLibCap2 += 140;
				} else {
					maxSpeCap2 += 30;
					maxIntCap2 += 35;
					maxLibCap2 += 100;
				}
			}//+60/50-60
			if (devilkinScore() >= 11) {
				if (devilkinScore() >= 16 && hasPerk(PerkLib.Phylactery)) {
					if (devilkinScore() >= 21) {
						maxStrCap2 += 95;
						maxSpeCap2 -= 30;
						maxIntCap2 += 180;
						maxLibCap2 += 120;
						currentSen += 50;
					} else {
						maxStrCap2 += 75;
						maxSpeCap2 -= 25;
						maxIntCap2 += 130;
						maxLibCap2 += 100;
						currentSen += 40;
					}
				} else {
					maxStrCap2 += 55;
					maxSpeCap2 -= 20;
					maxIntCap2 += 80;
					maxLibCap2 += 65;
					currentSen += 15;
				}
			}//+60/50-60
			if (rhinoScore() >= 4) {
				maxStrCap2 += 15;
				maxTouCap2 += 15;
				maxSpeCap2 -= 10;
				maxIntCap2 -= 10;
			}//+10/10-20
			if (satyrScore() >= 4) {
				maxStrCap2 += 5;
				maxSpeCap2 += 5;
			}//+10/10-20
			if (manticoreScore() >= 15) {
				if (manticoreScore() >= 22) {
					maxSpeCap2 += 160;
					maxIntCap2 += 90;
					maxLibCap2 += 140;
					currentSen += 60;
				} else {
					maxSpeCap2 += 110;
					maxIntCap2 += 70;
					maxLibCap2 += 90;
					currentSen += 45;
				}
			}//+60/50-60
			if (redpandaScore() >= 8) {
				maxStrCap2 += 15;
				maxSpeCap2 += 75;
				maxIntCap2 += 30;
			}
			if (bearpandaScore() >= 10) {
				maxStrCap2 += 100;
				maxTouCap2 += 70;
				maxIntCap2 -= 20;
			}
			if (pigScore() >= 10) {
				if (pigScore() >= 15) {
					maxStrCap2 += 125;
					maxTouCap2 += 125;
					maxSpeCap2 -= 15;
					maxIntCap2 -= 10;
				} else {
					maxStrCap2 += 60;
					maxTouCap2 += 120;
					maxSpeCap2 -= 15;
					maxIntCap2 -= 10;
					maxWisCap2 -= 5;
				}
			}
			if (trollScore() >= 10) {
				maxStrCap2 += 30;
				maxSpeCap2 += 40;
				maxIntCap2 += 30;
				maxWisCap2 += 50;
			}
			if (mantisScore() >= 12) {
				maxStrCap2 -= 40;
				maxTouCap2 += 60;
				maxSpeCap2 += 140;
				maxIntCap2 += 20;
			}//+35/30-40
			if (hasPerk(MutationsLib.MantislikeAgility)) {
				if (hasCoatOfType(Skin.CHITIN) && hasPerk(PerkLib.ThickSkin)) maxSpeCap2 += 15;
				if ((skinType == Skin.SCALES && hasPerk(PerkLib.ThickSkin)) || hasCoatOfType(Skin.CHITIN)) maxSpeCap2 += 10;
				if (skinType == Skin.SCALES || hasPerk(PerkLib.ThickSkin)) maxSpeCap2 += 5;
			}
			if (hasPerk(MutationsLib.MantislikeAgilityPrimitive)) {
				if (hasCoatOfType(Skin.CHITIN) && hasPerk(PerkLib.ThickSkin)) maxSpeCap2 += 30;
				if ((skinType == Skin.SCALES && hasPerk(PerkLib.ThickSkin)) || hasCoatOfType(Skin.CHITIN)) maxSpeCap2 += 20;
				if (skinType == Skin.SCALES || hasPerk(PerkLib.ThickSkin)) maxSpeCap2 += 10;
			}
			if (hasPerk(MutationsLib.MantislikeAgilityEvolved)) {
				if (hasCoatOfType(Skin.CHITIN) && hasPerk(PerkLib.ThickSkin)) maxSpeCap2 += 45;
				if ((skinType == Skin.SCALES && hasPerk(PerkLib.ThickSkin)) || hasCoatOfType(Skin.CHITIN)) maxSpeCap2 += 30;
				if (skinType == Skin.SCALES || hasPerk(PerkLib.ThickSkin)) maxSpeCap2 += 15;
			}
			if (salamanderScore() >= 7) {
				if (salamanderScore() >= 16) {
					maxStrCap2 += 105;
					maxTouCap2 += 80;
					maxLibCap2 += 130;
					currentSen += 75;
				} else {
					maxStrCap2 += 25;
					maxTouCap2 += 25;
					maxLibCap2 += 40;
				}
			}//+15/10-20
			if (cavewyrmScore() >= 10) {
				maxStrCap2 += 60;
				maxTouCap2 += 70;
				maxWisCap2 -= 30;
				maxLibCap2 += 50;
			}//+15/10-20
			if (unicornScore() >= 8) {
				if (unicornScore() >= 27) {
					maxStrCap2 += 60;
					maxTouCap2 += 90;
					maxSpeCap2 += 115;
					maxIntCap2 += 140;
				} else if (unicornScore() >= 18) {
					maxTouCap2 += 55;
					maxSpeCap2 += 90;
					maxIntCap2 += 125;
				} else {
					maxTouCap2 += 25;
					maxSpeCap2 += 40;
					maxIntCap2 += 55;
				}
			}//+(15)30/(10-20)30-40
			if (unicornkinScore() >= 12) {
				maxTouCap2 += 55;
				maxSpeCap2 += 70;
				maxIntCap2 += 75;
			}//+(15)30/(10-20)30-40
			if (alicornScore() >= 8) {
				if (alicornScore() >= 27) {
					maxStrCap2 += 60;
					maxTouCap2 += 70;
					maxSpeCap2 += 150;
					maxIntCap2 += 125;
				} else if (alicornScore() >= 18) {
					maxTouCap2 += 55;
					maxSpeCap2 += 120;
					maxIntCap2 += 95;
				} else {
					maxTouCap2 += 15;
					maxSpeCap2 += 50;
					maxIntCap2 += 55;
				}
			}//+(30)55/(30-40)50-60
			if (alicornkinScore() >= 12) {
				maxTouCap2 += 45;
				maxSpeCap2 += 60;
				maxIntCap2 += 75;
			}//+(30)55/(30-40)50-60
			if (phoenixScore() >= 10) {
				if (phoenixScore() >= 21) {
					maxStrCap2 += 40;
					maxTouCap2 += 20;
					maxSpeCap2 += 150;
					maxLibCap2 += 105;
				} else {
					maxStrCap2 += 20;
					maxTouCap2 += 20;
					maxSpeCap2 += 70;
					maxLibCap2 += 40;
				}
			}//+30/30-40
			if (scyllaScore() >= 7 && (isScylla() || isKraken())) {
				if (scyllaScore() >= 12 && isKraken()) {
					if (scyllaScore() >= 17) {
						maxStrCap2 += 135;
						maxTouCap2 += 60;
						maxIntCap2 += 60;
					} else {
						maxStrCap2 += 120;
						maxIntCap2 += 60;
					}
				} else {
					maxStrCap2 += 65;
					maxIntCap2 += 40;
				}
			}//+30/30-40
			if (plantScore() >= 4) {
				if (plantScore() >= 7) {
					maxStrCap2 += 25;
					maxTouCap2 += 100;
					maxSpeCap2 -= 50;
				} else if (plantScore() == 6) {
					maxStrCap2 += 20;
					maxTouCap2 += 80;
					maxSpeCap2 -= 40;
				} else if (plantScore() == 5) {
					maxStrCap2 += 10;
					maxTouCap2 += 50;
					maxSpeCap2 -= 20;
				} else {
					maxTouCap2 += 30;
					maxSpeCap2 -= 10;
				}
			}//+20(40)(60)(75)/10-20(30-40)(50-60)(70-80)
			if (alrauneScore() >= 13) {
				if (alrauneScore() >= 17) {
					maxTouCap2 += 115;
					maxSpeCap2 -= 60;
					maxLibCap2 += 200;
				}
				maxTouCap2 += 100;
				maxSpeCap2 -= 50;
				maxLibCap2 += 145;
			}
			if (yggdrasilScore() >= 10) {
				maxStrCap2 += 50;
				maxTouCap2 += 70;
				maxSpeCap2 -= 50;
				maxIntCap2 += 50;
				maxWisCap2 += 80;
				maxLibCap2 -= 50;
			}//+150
			if (deerScore() >= 4) {
				maxSpeCap2 += 20;
			}//+20/10-20
			if (ushionnaScore() >= 11) {
				maxStrCap2 += 80;
				maxTouCap2 += 70;
				maxIntCap2 -= 40;
				maxWisCap2 -= 40;
				maxLibCap2 += 95;
			}//+20/10-20
			if (yetiScore() >= 14) {
				if (yetiScore() >= 17) {
					maxStrCap2 += 130;
					maxTouCap2 += 100;
					maxSpeCap2 += 65;
					maxIntCap2 -= 90;
					maxLibCap2 += 50;
				} else {
					maxStrCap2 += 100;
					maxTouCap2 += 80;
					maxSpeCap2 += 50;
					maxIntCap2 -= 70;
					maxLibCap2 += 50;
				}
			}
			if (yukiOnnaScore() >= 14) {
				maxSpeCap2 += 70;
				maxIntCap2 += 140;
				maxWisCap2 += 70;
				maxLibCap2 += 50;
			}
			if (wendigoScore() >= 10) {
				if (wendigoScore() >= 22) {
					maxStrCap2 += 70;
					maxTouCap2 += 70;
					maxIntCap2 += 60;
					maxWisCap2 -= 50;
					maxLibCap2 += 50;
					currentSen += 50;
				} else {
					maxStrCap2 += 70;
					maxTouCap2 += 70;
					maxIntCap2 += 60;
					maxWisCap2 -= 50;
					maxLibCap2 += 50;
					currentSen += 50;
				}
			}
			if (melkieScore() >= 18) {
				if (melkieScore() >= 21) {
					maxSpeCap2 += 140;
					maxIntCap2 += 140;
					maxLibCap2 += 100;
					currentSen += 65;
				} else {
					maxSpeCap2 += 120;
					maxIntCap2 += 120;
					maxLibCap2 += 80;
					currentSen += 50;
				}
			}

			if (poltergeistScore() >= 6) {
				if (poltergeistScore() >= 18) {
					maxStrCap2 -= 45;
					maxTouCap2 -= 45;
					maxSpeCap2 += 150;
					maxIntCap2 += 150;
					maxWisCap2 += 60;
				} else if (poltergeistScore() >= 12) {
					maxStrCap2 -= 25;
					maxTouCap2 -= 25;
					maxSpeCap2 += 90;
					maxIntCap2 += 90;
					maxWisCap2 += 45;
				} else {
					maxStrCap2 -= 15;
					maxTouCap2 -= 15;
					maxSpeCap2 += 45;
					maxIntCap2 += 45;
					maxWisCap2 += 30;
				}
			}
			if (bansheeScore() >= 4) {

			}
			if (firesnailScore() >= 15) {
				maxStrCap2 += 70;
				maxTouCap2 += 175;
				maxSpeCap2 -= 80;
				maxLibCap2 += 110;
				currentSen += 50;
			}//+30/30-40
			if (lowerBody == 51 && hydraScore() >= 14) {
				if (hydraScore() >= 29) {
					maxStrCap2 += 160;
					maxTouCap2 += 145;
					maxSpeCap2 += 130;
				} else if (hydraScore() >= 24) {
					maxStrCap2 += 130;
					maxTouCap2 += 125;
					maxSpeCap2 += 105;
				} else if (hydraScore() >= 19) {
					maxStrCap2 += 120;
					maxTouCap2 += 105;
					maxSpeCap2 += 60;
				} else {
					maxStrCap2 += 100;
					maxTouCap2 += 50;
					maxSpeCap2 += 60;
				}
			}//+30/30-40
			if (couatlScore() >= 11) {
				if (couatlScore() >= 19) {
					maxStrCap2 += 50;
					maxTouCap2 += 45;
					maxSpeCap2 += 140;
					maxIntCap2 += 50;
				} else {
					maxStrCap2 += 30;
					maxTouCap2 += 25;
					maxSpeCap2 += 80;
					maxIntCap2 += 30;
				}
			}//+30/30-40
			if (vouivreScore() >= 11) {
				if (vouivreScore() >= 21) {
					maxStrCap2 += 130;
					maxTouCap2 += 80;
					maxSpeCap2 += 100;
					maxIntCap2 += 20;
					maxWisCap2 -= 20;
				} else if (vouivreScore() >= 16) {
					maxStrCap2 += 100;
					maxTouCap2 += 65;
					maxSpeCap2 += 70;
					maxIntCap2 += 15;
					maxWisCap2 -= 15;
				} else {
					maxStrCap2 += 70;
					maxTouCap2 += 45;
					maxSpeCap2 += 45;
					maxIntCap2 += 10;
					maxWisCap2 -= 10;
				}
			}
			if (gorgonScore() >= 11) {
				if (gorgonScore() >= 17) {
					maxStrCap2 += 80;
					maxTouCap2 += 65;
					maxSpeCap2 += 110;
				} else {
					maxStrCap2 += 50;
					maxTouCap2 += 45;
					maxSpeCap2 += 70;
				}
			}//+30/30-40
			if (nagaScore() >= 8) {
				maxStrCap2 += 40;
				maxTouCap2 += 20;
				maxSpeCap2 += 60;
			}
			if (apophisScore() >= 23) {
				if (apophisScore() >= 26) {
					maxStrCap2 += 80;
					maxTouCap2 += 80;
					maxSpeCap2 += 100;
					maxLibCap2 += 130;
				} else {
					maxStrCap2 += 70;
					maxTouCap2 += 70;
					maxSpeCap2 += 100;
					maxLibCap2 += 105;
				}
			}
			if (centaurScore() >= 8) {
				maxTouCap2 += 80;
				maxSpeCap2 += 40;
			}//+40/30-40
			if (centipedeScore() >= 8) {
				maxStrCap2 += 60;
				maxSpeCap2 += 80;
			}
			if (oomukadeScore() >= 15) {
				if (oomukadeScore() >= 18) {
					maxStrCap2 += 125;
					maxTouCap2 += 45;
					maxSpeCap2 += 60;
					maxLibCap2 += 110;
					maxWisCap2 -= 50;
				} else {
					maxStrCap2 += 75;
					maxTouCap2 += 40;
					maxSpeCap2 += 50;
					maxLibCap2 += 110;
					maxWisCap2 -= 50;
				}
			}
			if (avianScore() >= 9) {
				maxStrCap2 += 30;
				maxSpeCap2 += 75;
				maxIntCap2 += 30;
			}
			if (isNaga()) {
				if (lowerBody == LowerBody.FROSTWYRM) {
					maxStrCap2 += 20;
					maxTouCap2 += 10;
				} else {
					maxStrCap2 += 15;
					maxSpeCap2 += 15;
				}
			}
			if (isTaur()) {
				maxSpeCap2 += 20;
			}
			if (isDrider()) {
				if (lowerBody == LowerBody.CANCER) {
					maxStrCap2 += 15;
					maxSpeCap2 += 5;
					maxTouCap2 += 10;
				} else {
					maxTouCap2 += 15;
					maxSpeCap2 += 15;
				}
			}
			if (isScylla()) {
				maxStrCap2 += 30;
			}
			if (isKraken()) {
				maxStrCap2 += 60;
				currentSen += 15;
			}
			if (lowerBody == LowerBody.CENTIPEDE) {
				maxStrCap2 += 15;
				maxTouCap2 += 5;
				maxSpeCap2 += 10;
			}
			if (isAlraune()) {
				maxTouCap2 += 15;
				maxLibCap2 += 15;
			}
			if (batScore() >= 10) {
				maxStrCap2 += 35;
				maxSpeCap2 += 35;
				maxIntCap2 += 35;
				maxLibCap2 += 45;
			}
			if (vampireScore() >= 10) {
				if (vampireScore() >= 20) {
					maxStrCap2 += 70;
					maxSpeCap2 += 70;
					maxIntCap2 += 70;
					maxLibCap2 += 90;
				} else {
					maxStrCap2 += 35;
					maxSpeCap2 += 35;
					maxIntCap2 += 35;
					maxLibCap2 += 45;
				}
			}
			if (internalChimeraScore() >= 1 && !hasPerk(PerkLib.RacialParagon)) {
				maxStrCap2 += 5 * internalChimeraScore();
				maxTouCap2 += 5 * internalChimeraScore();
				maxSpeCap2 += 5 * internalChimeraScore();
				maxIntCap2 += 5 * internalChimeraScore();
				maxWisCap2 += 5 * internalChimeraScore();
				maxLibCap2 += 5 * internalChimeraScore();
				currentSen += 5 * internalChimeraScore();
			}
			if (hasPerk(PerkLib.RacialParagon)) {
				maxStrCap2 += level;
				maxTouCap2 += level;
				maxSpeCap2 += level;
				maxIntCap2 += level;
				maxWisCap2 += level;
				maxLibCap2 += level;
			}
			if (hasPerk(PerkLib.Apex)) {
				maxStrCap2 += 2 * level;
				maxTouCap2 += 2 * level;
				maxSpeCap2 += 2 * level;
				maxIntCap2 += 2 * level;
				maxWisCap2 += 2 * level;
				maxLibCap2 += 2 * level;
			}
			if (hasPerk(PerkLib.AlphaAndOmega)) {
				maxStrCap2 += 2 * level;
				maxTouCap2 += 2 * level;
				maxSpeCap2 += 2 * level;
				maxIntCap2 += 2 * level;
				maxWisCap2 += 2 * level;
				maxLibCap2 += 2 * level;
			}
			if (hasPerk(PerkLib.AscensionOneRaceToRuleThemAllX)) {
				maxStrCap2 += 2 * perkv1(PerkLib.AscensionOneRaceToRuleThemAllX) * level;
				maxTouCap2 += 2 * perkv1(PerkLib.AscensionOneRaceToRuleThemAllX) * level;
				maxSpeCap2 += 2 * perkv1(PerkLib.AscensionOneRaceToRuleThemAllX) * level;
				maxIntCap2 += 2 * perkv1(PerkLib.AscensionOneRaceToRuleThemAllX) * level;
				maxWisCap2 += 2 * perkv1(PerkLib.AscensionOneRaceToRuleThemAllX) * level;
				maxLibCap2 += 2 * perkv1(PerkLib.AscensionOneRaceToRuleThemAllX) * level;
			}
			if (jiangshiScore() >= 20) {
				maxStrCap2 += 150;
				maxSpeCap2 -= 90;
				maxIntCap2 -= 90;
				maxWisCap2 += 130;
				maxLibCap2 += 200;
			}//+110 strength +80 toughness +60 Wisdom +100 Libido +50 sensitivity
			if (gargoyleScore() >= 22) {//990
				switch (Forgefather.material){
					case "stone":
						switch(Forgefather.refinement){
							case 1:
								maxStrCap2 += 50;
								maxTouCap2 += 50;
								maxSpeCap2 += 50;
								maxIntCap2 += 50;
								maxWisCap2 += 50;
								maxLibCap2 += 50;
								break;
							case 2:
								maxStrCap2 += 75;
								maxTouCap2 += 75;
								maxSpeCap2 += 75;
								maxIntCap2 += 75;
								maxWisCap2 += 75;
								maxLibCap2 += 75;
								break;
							case 3:
								maxStrCap2 += 100;
								maxTouCap2 += 100;
								maxSpeCap2 += 100;
								maxIntCap2 += 100;
								maxWisCap2 += 100;
								maxLibCap2 += 100;
								break;
						}
						break;
					case "alabaster":
						//Alabaster - Magic (Int+100%, +20% max mana, +15% spell dmg)
						switch(Forgefather.refinement){
							case 1:
								maxIntCap2 += 100;
								maxWisCap2 += 50;
								maxStrCap2 -= 10;
								maxTouCap2 -= 10;
								break;
							case 2:
								maxIntCap2 += 150;
								maxWisCap2 += 75;
								maxStrCap2 -= 15;
								maxTouCap2 -= 15;
								break;
							case 3:
								maxIntCap2 += 200;
								maxWisCap2 += 100;
								maxStrCap2 -= 20;
								maxTouCap2 -= 20;
								break;
							case 4:
								maxIntCap2 += 200;
								maxWisCap2 += 100;
								maxStrCap2 -= 20;
								maxTouCap2 -= 20;
								break;
							case 5:
								maxIntCap2 += 500;
								maxWisCap2 += 250;
								maxStrCap2 -= 30;
								maxTouCap2 -= 30;
								break;
						}
						break;
					case "marble":
						switch(Forgefather.refinement){
							case 1:
								maxWisCap2 += 100;
								maxStrCap2 += 50;
								maxIntCap2 -= 10;
								break;
							case 2:
								maxWisCap2 += 150;
								maxStrCap2 += 75;
								maxIntCap2 -= 15;
								break;
							case 3:
								maxWisCap2 += 200;
								maxStrCap2 += 100;
								maxIntCap2 -= 20;
								break;
							case 4:
								maxWisCap2 += 200;
								maxStrCap2 += 100;
								maxIntCap2 -= 20;
								break;
							case 5:
								maxWisCap2 += 500;
								maxStrCap2 += 200;
								maxIntCap2 -= 30;
								break;
						}
						break;
					case "granite":
						switch(Forgefather.refinement){
							case 1:
								maxTouCap2 += 100;
								maxStrCap2 += 50;
								maxIntCap2 -= 10;
								maxWisCap2 -= 10;
								break;
							case 2:
								maxTouCap2 += 150;
								maxStrCap2 += 75;
								maxIntCap2 -= 15;
								maxWisCap2 -= 15;
								break;
							case 3:
								maxTouCap2 += 200;
								maxStrCap2 += 100;
								maxIntCap2 -= 20;
								maxWisCap2 -= 20;
								break;
							case 4:
								maxTouCap2 += 200;
								maxStrCap2 += 100;
								maxIntCap2 -= 20;
								maxWisCap2 -= 20;
								break;
							case 5:
								maxTouCap2 += 500;
								maxStrCap2 += 250;
								maxIntCap2 -= 30;
								maxWisCap2 -= 30;
								break;
						}
						break;
					case "ebony":
						switch(Forgefather.refinement){
							case 1:
								maxStrCap2 += 100;
								maxSpeCap2 += 50;
								maxIntCap2 -= 10;
								maxWisCap2 -= 10;
								break;
							case 2:
								maxStrCap2 += 150;
								maxSpeCap2 += 75;
								maxIntCap2 -= 15;
								maxWisCap2 -= 15;
								break;
							case 3:
								maxStrCap2 += 200;
								maxSpeCap2 += 100;
								maxIntCap2 -= 20;
								maxWisCap2 -= 20;
								break;
							case 4:
								maxStrCap2 += 200;
								maxSpeCap2 += 100;
								maxIntCap2 -= 20;
								maxWisCap2 -= 20;
								break;
							case 5:
								maxStrCap2 += 500;
								maxSpeCap2 += 250;
								maxIntCap2 -= 30;
								maxWisCap2 -= 30;
								break;
						}
						break;
					case "sandstone":
						switch(Forgefather.refinement){
							case 1:
								maxSpeCap2 += 100;
								maxStrCap2 += 25;
								maxIntCap2 += 25;
								maxWisCap2 -= 10;
								break;
							case 2:
								maxSpeCap2 += 150;
								maxStrCap2 += 35;
								maxIntCap2 += 35;
								maxWisCap2 -= 15;
								break;
							case 3:
								maxSpeCap2 += 200;
								maxStrCap2 += 50;
								maxIntCap2 += 50;
								maxWisCap2 -= 20;
								break;
							case 4:
								maxSpeCap2 += 200;
								maxStrCap2 += 50;
								maxIntCap2 += 50;
								maxWisCap2 -= 20;
								break;
							case 5:
								maxSpeCap2 += 500;
								maxStrCap2 += 125;
								maxIntCap2 += 125;
								maxWisCap2 -= 30;
								break;
						}
						break;
						
				}
				if (hasPerk(PerkLib.GargoylePure)) {
					maxWisCap2 += 130;
					maxLibCap2 -= 20;
					currentSen -= 10;
				}
				if (hasPerk(PerkLib.GargoyleCorrupted)) {
					maxWisCap2 -= 20;
					maxLibCap2 += 140;
				}
				switch (Forgefather.channelInlay){
					case "emerald":
						if (Forgefather.refinement == 5) maxSpeCap2 += 100;
						else maxSpeCap2 += 50;
						break;
				}
				switch (Forgefather.gem){
					case "emerald":
						if (Forgefather.refinement == 5) maxSpeCap2 += 50;
						else maxSpeCap2 += 25;
						break;
				}
			}
			if (fairyScore() >= 23) {
				maxStrCap2 -= 20;
				maxTouCap2 -= 10;
				if (fairyScore() >= 32) {
					maxSpeCap2 += 660;
					maxIntCap2 += 660;
					maxWisCap2 += 200;
					currentSen += 50;
				}
				else if (fairyScore() >= 29) {
					maxSpeCap2 += 600;
					maxIntCap2 += 600;
					maxWisCap2 += 175;
					currentSen += 40;
				}
				else if (fairyScore() >= 26) {
					maxSpeCap2 += 540;
					maxIntCap2 += 540;
					maxWisCap2 += 150;
					currentSen += 30;
				}
				else {
					maxSpeCap2 += 480;
					maxIntCap2 += 480;
					maxWisCap2 += 125;
					currentSen += 20;
				}
			}//+10/10-20
			score = atlachNachaScore();
			if (score >= 30) {
				//30 Greater Atlach Nacha(1350)
				maxStrCap2 += 340;
				maxTouCap2 += 400;
				maxIntCap2 += 425;
				maxLibCap2 += 425;
				maxWisCap2 -= 90;
				currentSen += 150;
			} else if (score >= 21) {
				//21 Atlach Nacha(945)
				maxStrCap2 += 230;
				maxTouCap2 += 265;
				maxIntCap2 += 300;
				maxLibCap2 += 300;
				maxWisCap2 -= 60;
				currentSen += 90;
			} else if (score >= 14) {
				//14 Incomplete Atlach Nacha(190)
				maxTouCap2 += 60;
				maxIntCap2 += 100;
				maxLibCap2 += 60;
				maxWisCap2 -= 10;
			}
			if (hasPerk(PerkLib.ElementalBody)) {
				if (perkv1(PerkLib.ElementalBody) == 1) {
					if (perkv2(PerkLib.ElementalBody) == 1) {
						maxSpeCap2 += 100;
						maxIntCap2 += 75;
						maxWisCap2 += 50;
					}
					if (perkv2(PerkLib.ElementalBody) == 2) {
						maxSpeCap2 += 125;
						maxIntCap2 += 100;
						maxWisCap2 += 75;
					}
					if (perkv2(PerkLib.ElementalBody) == 3) {
						maxSpeCap2 += 150;
						maxIntCap2 += 125;
						maxWisCap2 += 100;
					}
					if (perkv2(PerkLib.ElementalBody) == 4) {
						maxSpeCap2 += 175;
						maxIntCap2 += 150;
						maxWisCap2 += 125;
					}
				}
				if (perkv1(PerkLib.ElementalBody) == 2) {
					if (perkv2(PerkLib.ElementalBody) == 1) {
						maxStrCap2 += 50;
						maxTouCap2 += 100;
						maxWisCap2 += 75;
					}
					if (perkv2(PerkLib.ElementalBody) == 2) {
						maxStrCap2 += 75;
						maxTouCap2 += 125;
						maxWisCap2 += 100;
					}
					if (perkv2(PerkLib.ElementalBody) == 3) {
						maxStrCap2 += 100;
						maxTouCap2 += 150;
						maxWisCap2 += 125;
					}
					if (perkv2(PerkLib.ElementalBody) == 4) {
						maxStrCap2 += 125;
						maxTouCap2 += 175;
						maxWisCap2 += 150;
					}
				}
				if (perkv1(PerkLib.ElementalBody) == 3) {
					if (perkv2(PerkLib.ElementalBody) == 1) {
						maxStrCap2 += 75;
						maxSpeCap2 += 100;
						maxWisCap2 += 25;
					}
					if (perkv2(PerkLib.ElementalBody) == 2) {
						maxStrCap2 += 100;
						maxSpeCap2 += 125;
						maxWisCap2 += 50;
					}
					if (perkv2(PerkLib.ElementalBody) == 3) {
						maxStrCap2 += 125;
						maxSpeCap2 += 150;
						maxWisCap2 += 75;
					}
					if (perkv2(PerkLib.ElementalBody) == 4) {
						maxStrCap2 += 150;
						maxSpeCap2 += 175;
						maxWisCap2 += 100;
					}
				}
				if (perkv1(PerkLib.ElementalBody) == 4) {
					if (perkv2(PerkLib.ElementalBody) == 1) {
						maxStrCap2 += 75;
						maxTouCap2 += 50;
						maxWisCap2 += 100;
					}
					if (perkv2(PerkLib.ElementalBody) == 2) {
						maxStrCap2 += 100;
						maxTouCap2 += 75;
						maxWisCap2 += 125;
					}
					if (perkv2(PerkLib.ElementalBody) == 3) {
						maxStrCap2 += 125;
						maxTouCap2 += 100;
						maxWisCap2 += 150;
					}
					if (perkv2(PerkLib.ElementalBody) == 4) {
						maxStrCap2 += 150;
						maxTouCap2 += 125;
						maxWisCap2 += 175;
					}
				}
			}
			addStatusValue(StatusEffects.StrTouSpeCounter2, 1, maxStrCap2);
			addStatusValue(StatusEffects.StrTouSpeCounter2, 2, maxTouCap2);
			addStatusValue(StatusEffects.StrTouSpeCounter2, 3, maxSpeCap2);
			addStatusValue(StatusEffects.IntWisCounter2, 1, maxIntCap2);
			addStatusValue(StatusEffects.IntWisCounter2, 2, maxWisCap2);
			addStatusValue(StatusEffects.LibSensCounter2, 1, maxLibCap2);
			addStatusValue(StatusEffects.LibSensCounter2, 2, currentSen);
		}

		public function sleepUpdateStat():void{
			strtouspeintwislibsenCalculation2();
			if (hasPerk(PerkLib.TitanicStrength)) statStore.replaceBuffObject({'str.mult':(0.01 * Math.round(tallness*4))}, 'Titanic Strength', { text: 'Titanic Strength' });
			if (!hasPerk(PerkLib.TitanicStrength) && statStore.hasBuff('Titanic Strength')) statStore.removeBuffs('Titanic Strength');
			if (hasPerk(PerkLib.Enigma)) statStore.replaceBuffObject({'str.mult':Math.round(((intStat.mult.value/2)+(wisStat.mult.value/2))),'tou.mult':Math.round(((intStat.mult.value/2)+(wisStat.mult.value/2)))}, 'Enigma', { text: 'Enigma' });
			if (!hasPerk(PerkLib.Enigma) && statStore.hasBuff('Enigma')) statStore.removeBuffs('Enigma');
			if (hasPerk(PerkLib.AvatorOfCorruption) && unicornScore() >= 18) statStore.replaceBuffObject({'lib.mult':Math.round(intStat.mult.value/2)}, 'Avatar Of Corruption', { text: 'Avatar Of Corruption' });
			if ((!hasPerk(PerkLib.AvatorOfCorruption) || unicornScore() < 18) && statStore.hasBuff('Avatar Of Corruption')) statStore.removeBuffs('Avatar Of Corruption');
			if (hasPerk(PerkLib.AvatorOfPurity) && unicornScore() >= 18) statStore.replaceBuffObject({'wis.mult':Math.round(intStat.mult.value/2)}, 'Avatar Of Purity', { text: 'Avatar Of Purity' });
			if ((!hasPerk(PerkLib.AvatorOfPurity) || unicornScore() < 18) && statStore.hasBuff('Avatar Of Purity')) statStore.removeBuffs('Avatar Of Purity');
			if (hasPerk(PerkLib.StrengthOfStone)) statStore.replaceBuffObject({'str.mult':(0.01 * Math.round(tou/2))}, 'Strength of stone', { text: 'Strength of stone' });
			if (!hasPerk(PerkLib.StrengthOfStone) && statStore.hasBuff('Strength of stone')) statStore.removeBuffs('Strength of stone');
			if (hasPerk(PerkLib.PsionicEmpowerment)) statStore.replaceBuffObject({'int.mult':(0.01 * Mindbreaker.MindBreakerFullConvert)}, 'Psionic Empowerment', { text: 'Psionic Empowerment' });
			var power:Number = 0;
			if (hasPerk(PerkLib.BullStrength)){
				if (cowScore() >= 15) power = lactationQ()*0.001;
				if (minotaurScore() >= 15) power = cumCapacity()*0.001;
				if (power > 0.5) power = 0.5;
				statStore.replaceBuffObject({'str.mult':(Math.round(power))}, 'Bull Strength', { text: 'Bull Strength' });
			}
			if (!hasPerk(PerkLib.BullStrength) && statStore.hasBuff('Bull Strength')) statStore.removeBuffs('Bull Strength');
			if (hasPerk(PerkLib.UnnaturalStrength)){
				if (flags[kFLAGS.HUNGER_ENABLED] > 0) power = (hunger/maxHunger())*0.01;
				else power = (lust/maxLust())*0.01;
				statStore.replaceBuffObject({'str.mult':(Math.round(power))}, 'Unnatural Strength', { text: 'Unnatural Strength' });
			}
			if (!hasPerk(PerkLib.UnnaturalStrength) && statStore.hasBuff('Unnatural Strength')) statStore.removeBuffs('Unnatural Strength');
			if (hasPerk(PerkLib.AbsoluteStrength) && (wrath > wrath100 * 0.5)){
				power = 0.25;
				if (wrath > wrath100 * 0.6) power += 0.05;
				if (wrath > wrath100 * 0.7) power += 0.05;
				if (wrath > wrath100 * 0.8) power += 0.05;
				if (wrath > wrath100 * 0.9) power += 0.05;
				if (wrath > wrath100) power += 0.05;
				if (wrath > wrath100 * 1.1) power += 0.05;
				if (wrath > wrath100 * 1.2) power += 0.05;
				if (wrath > wrath100 * 1.3) power += 0.05;
				if (wrath > wrath100 * 1.4) power += 0.05;
				//if (hasPerk(PerkLib.)) power *= 2;
				statStore.replaceBuffObject({'str.mult':(Math.round(power))}, 'Absolute Strength', { text: 'Absolute Strength' });
			}
			if (!hasPerk(PerkLib.AbsoluteStrength) && statStore.hasBuff('Absolute Strength')) statStore.removeBuffs('Absolute Strength');
			statStore.replaceBuffObject({
				"str.mult":statusEffectv1(StatusEffects.StrTouSpeCounter2)/100,
				"tou.mult":statusEffectv2(StatusEffects.StrTouSpeCounter2)/100,
				"spe.mult":statusEffectv3(StatusEffects.StrTouSpeCounter2)/100,
				"int.mult":statusEffectv1(StatusEffects.IntWisCounter2)/100,
				"wis.mult":statusEffectv2(StatusEffects.IntWisCounter2)/100,
				"lib.mult":statusEffectv1(StatusEffects.LibSensCounter2)/100,
				"sens":statusEffectv2(StatusEffects.LibSensCounter2)
			}, "Racials", {text:"Racials"});
		}

		public function removeAllRacialMutation():void {
			for each (var pPerks:PerkType in MutationsLib.mutationsArray("", true)){
				if (hasPerk(pPerks)){
					removePerk(pPerks);
					//perkPoints += 1;
				}
			}
			if (hasPerk(PerkLib.ChimericalBodyInitialStage)){
				removePerk(PerkLib.ChimericalBodyInitialStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySemiBasicStage)){
				removePerk(PerkLib.ChimericalBodySemiBasicStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodyBasicStage)){
				removePerk(PerkLib.ChimericalBodyBasicStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySemiImprovedStage)){
				removePerk(PerkLib.ChimericalBodySemiImprovedStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodyImprovedStage)){
				removePerk(PerkLib.ChimericalBodyImprovedStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySemiAdvancedStage)){
				removePerk(PerkLib.ChimericalBodySemiAdvancedStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodyAdvancedStage)){
				removePerk(PerkLib.ChimericalBodyAdvancedStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySemiSuperiorStage)){
				removePerk(PerkLib.ChimericalBodySemiSuperiorStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySuperiorStage)){
				removePerk(PerkLib.ChimericalBodySuperiorStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySemiPeerlessStage)){
				removePerk(PerkLib.ChimericalBodySemiPeerlessStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodyPeerlessStage)) {
				removePerk(PerkLib.ChimericalBodyPeerlessStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySemiEpicStage)) {
				removePerk(PerkLib.ChimericalBodySemiEpicStage);
				perkPoints += 1;
			}
		}

		public function requiredXP():int {
			var xpm:Number = 100;
			if (level >= 42) xpm += 100;
			if (level >= 102) xpm += 100;
			if (level >= 180) xpm += 100;
			//if (level >= 274)
			var temp:int = (level + 1) * xpm;
			if (temp > 74000) temp = 74000;//(max lvl)185 * 400(exp multi)
			return temp;
		}

		public function minotaurAddicted():Boolean {
			return !hasPerk(PerkLib.MinotaurCumResistance) && !hasPerk(PerkLib.ManticoreCumAddict) && (hasPerk(PerkLib.MinotaurCumAddict) || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1);
		}
		public function minotaurNeed():Boolean {
			return !hasPerk(PerkLib.MinotaurCumResistance) && !hasPerk(PerkLib.ManticoreCumAddict) && flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1;
		}

		public function clearStatuses(visibility:Boolean):void
		{
			var HPPercent:Number;
			HPPercent = HP/maxHP();
			resetCooldowns();
			if (hasStatusEffect(StatusEffects.DriderIncubusVenom))
			{
				removeStatusEffect(StatusEffects.DriderIncubusVenom);
				CoC.instance.mainView.statsView.showStatUp('str');
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.Sandstorm)) CoC.instance.monster.removeStatusEffect(StatusEffects.Sandstorm);
			if(hasStatusEffect(StatusEffects.Berzerking)) {
				removeStatusEffect(StatusEffects.Berzerking);
			}
			if(hasStatusEffect(StatusEffects.Lustzerking)) {
				removeStatusEffect(StatusEffects.Lustzerking);
			}
			if(hasStatusEffect(StatusEffects.TooAngryTooDie)) {
				removeStatusEffect(StatusEffects.TooAngryTooDie);
			}
			if(hasStatusEffect(StatusEffects.EverywhereAndNowhere)) {
				removeStatusEffect(StatusEffects.EverywhereAndNowhere);
			}
			if(hasStatusEffect(StatusEffects.Displacement)) {
				removeStatusEffect(StatusEffects.Displacement);
			}
			if(hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
				removeStatusEffect(StatusEffects.BlazingBattleSpirit);
			}
			if(hasStatusEffect(StatusEffects.Cauterize)) {
				removeStatusEffect(StatusEffects.Cauterize);
			}
			if(hasStatusEffect(StatusEffects.WinterClaw)) {
				removeStatusEffect(StatusEffects.WinterClaw);
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				CoC.instance.monster.removeStatusEffect(StatusEffects.TailWhip);
			}
			if(hasStatusEffect(StatusEffects.Flying)) {
				removeStatusEffect(StatusEffects.Flying);
				if(hasStatusEffect(StatusEffects.FlyingNoStun)) {
					removeStatusEffect(StatusEffects.FlyingNoStun);
					removePerk(PerkLib.Resolute);
				}
			}
			if(statStore.hasBuff("Might")){
				statStore.removeBuffs("Might");
				removeStatusEffect(StatusEffects.Minimise);
			}
			if(hasStatusEffect(StatusEffects.Minimise)) {
				statStore.removeBuffs("Minimise");
				removeStatusEffect(StatusEffects.Minimise);
			}
			if(hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
				dynStats("spe", -statusEffectv2(StatusEffects.UnderwaterCombatBoost), "scale", false);
				removeStatusEffect(StatusEffects.UnderwaterCombatBoost);
			}
			if(hasStatusEffect(StatusEffects.UnderwaterAndIgnis)) {
				removeStatusEffect(StatusEffects.UnderwaterAndIgnis);
			}
			if(hasStatusEffect(StatusEffects.EzekielCurse) && EvangelineFollower.EvangelineAffectionMeter >= 3 && hasPerk(PerkLib.EzekielBlessing)) {
				removeStatusEffect(StatusEffects.EzekielCurse);
			}
			if(hasStatusEffect(StatusEffects.DragonBreathCooldown) && hasPerk(MutationsLib.DraconicLungsEvolved)) {
				removeStatusEffect(StatusEffects.DragonBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) && (hasPerk(MutationsLib.DraconicLungs) || hasPerk(MutationsLib.DrakeLungsEvolved))) {
				removeStatusEffect(StatusEffects.DragonDarknessBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonFireBreathCooldown) && (hasPerk(MutationsLib.DraconicLungs) || hasPerk(MutationsLib.DrakeLungsEvolved))) {
				removeStatusEffect(StatusEffects.DragonFireBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonIceBreathCooldown) && (hasPerk(MutationsLib.DraconicLungs) || hasPerk(MutationsLib.DrakeLungsEvolved))) {
				removeStatusEffect(StatusEffects.DragonIceBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonLightningBreathCooldown) && (hasPerk(MutationsLib.DraconicLungs) || hasPerk(MutationsLib.DrakeLungsEvolved))) {
				removeStatusEffect(StatusEffects.DragonLightningBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonWaterBreathCooldown) && (hasPerk(MutationsLib.DraconicLungs) || hasPerk(MutationsLib.DrakeLungsEvolved))) {
				removeStatusEffect(StatusEffects.DragonWaterBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.HeroBane)) {
				removeStatusEffect(StatusEffects.HeroBane);
			}
			if(hasStatusEffect(StatusEffects.PlayerRegenerate)) {
				removeStatusEffect(StatusEffects.PlayerRegenerate);
			}
			if(hasStatusEffect(StatusEffects.Disarmed)) {
				removeStatusEffect(StatusEffects.Disarmed);
				if (weapon == WeaponLib.FISTS) {
//					weapon = ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon;
//					(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon).doEffect(this, false);
					setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
				}
				else {
					flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID];
				}
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = 0;
			}
			if (hasStatusEffect(StatusEffects.DriderIncubusVenom))
			{
				removeStatusEffect(StatusEffects.DriderIncubusVenom);
			}
			if(statusEffectv4(StatusEffects.CombatFollowerAlvina) > 0) addStatusValue(StatusEffects.CombatFollowerAlvina, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerAmily) > 0) addStatusValue(StatusEffects.CombatFollowerAmily, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerAurora) > 0) addStatusValue(StatusEffects.CombatFollowerAurora, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerAyane) > 0) addStatusValue(StatusEffects.CombatFollowerAyane, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerEtna) > 0) addStatusValue(StatusEffects.CombatFollowerEtna, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerExcellia) > 0) addStatusValue(StatusEffects.CombatFollowerExcellia, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerDiana) > 0) addStatusValue(StatusEffects.CombatFollowerDiana, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerDiva) > 0) addStatusValue(StatusEffects.CombatFollowerDiva, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerMitzi) > 0) addStatusValue(StatusEffects.CombatFollowerMitzi, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerNeisa) > 0) addStatusValue(StatusEffects.CombatFollowerNeisa, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerSiegweird) > 0) addStatusValue(StatusEffects.CombatFollowerSiegweird, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerZenji) > 0) addStatusValue(StatusEffects.CombatFollowerZenji, 4, -1);
			// All CombatStatusEffects are removed here
			for (var a:/*StatusEffectClass*/Array=statusEffects.slice(),n:int=a.length,i:int=0;i<n;i++) {
				// Using a copy of array in case effects are removed/added in handler
				if (statusEffects.indexOf(a[i])>=0) a[i].onCombatEnd();
			}
			statStore.removeCombatRoundTrackingBuffs();
			HP = HPPercent*maxHP();
		}

		public function consumeItem(itype:ItemType, amount:int = 1):Boolean {
			if (!hasItem(itype, amount)) {
				CoC_Settings.error("ERROR: consumeItem attempting to find " + amount + " item" + (amount > 1 ? "s" : "") + " to remove when the player has " + itemCount(itype) + ".");
				return false;
			}
			//From here we can be sure the player has enough of the item in inventory
			var slot:ItemSlotClass;
			while (amount > 0) {
				slot = getLowestSlot(itype); //Always draw from the least filled slots first
				if (slot.quantity > amount) {
					slot.quantity -= amount;
					amount = 0;
				}
				else { //If the slot holds the amount needed then amount will be zero after this
					amount -= slot.quantity;
					slot.emptySlot();
				}
			}
			return true;
/*
			var consumed:Boolean = false;
			var slot:ItemSlotClass;
			while (amount > 0)
			{
				if(!hasItem(itype,1))
				{
					CoC_Settings.error("ERROR: consumeItem in items.as attempting to find an item to remove when the has none.");
					break;
				}
				trace("FINDING A NEW SLOT! (ITEMS LEFT: " + amount + ")");
				slot = getLowestSlot(itype);
				while (slot != null && amount > 0 && slot.quantity > 0)
				{
					amount--;
					slot.quantity--;
					if(slot.quantity == 0) slot.emptySlot();
					trace("EATIN' AN ITEM");
				}
				//If on slot 5 and it doesn't have any more to take, break out!
				if(slot == undefined) amount = -1

			}
			if(amount == 0) consumed = true;
			return consumed;
*/
		}

		public function getLowestSlot(itype:ItemType):ItemSlotClass
		{
			var minslot:ItemSlotClass = null;
			for each (var slot:ItemSlotClass in itemSlots) {
				if (slot.itype == itype) {
					if (minslot == null || slot.quantity < minslot.quantity) {
						minslot = slot;
					}
				}
			}
			return minslot;
		}

		public function hasItem(itype:ItemType, minQuantity:int = 1):Boolean {
			return itemCount(itype) >= minQuantity;
		}

		public function itemCount(itype:ItemType):int {
			var count:int = 0;
			for each (var itemSlot:ItemSlotClass in itemSlots){
				if (itemSlot.itype == itype) count += itemSlot.quantity;
			}
			return count;
		}

		// 0..5 or -1 if no
		public function roomInExistingStack(itype:ItemType):Number {
			for (var i:int = 0; i<itemSlots.length; i++){
				if(itemSlot(i).itype == itype && itemSlot(i).quantity != 0 && itemSlot(i).quantity < 5)
					return i;
			}
			return -1;
		}

		public function itemSlot(idx:int):ItemSlotClass
		{
			return itemSlots[idx];
		}

		// 0..5 or -1 if no
		public function emptySlot():Number {
		    for (var i:int = 0; i<itemSlots.length;i++){
				if (itemSlot(i).isEmpty() && itemSlot(i).unlocked) return i;
			}
			return -1;
		}


		public function destroyItems(itype:ItemType, numOfItemToRemove:Number):Boolean
		{
			for (var slotNum:int = 0; slotNum < itemSlots.length; slotNum += 1)
			{
				if(itemSlot(slotNum).itype == itype)
				{
					while(itemSlot(slotNum).quantity > 0 && numOfItemToRemove > 0)
					{
						itemSlot(slotNum).removeOneItem();
						numOfItemToRemove--;
					}
				}
			}
			return numOfItemToRemove <= 0;
		}

		public function lengthChange(temp2:Number, ncocks:Number):void {

			if (temp2 < 0 && flags[kFLAGS.HYPER_HAPPY])  // Early return for hyper-happy cheat if the call was *supposed* to shrink a cock.
			{
				return;
			}
			//DIsplay the degree of length change.
			if(temp2 <= 1 && temp2 > 0) {
				if(cocks.length == 1) outputText("Your [cock] has grown slightly longer.");
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("One of your [cocks] grows slightly longer.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("Some of your [cocks] grow slightly longer.");
					if(ncocks == cocks.length) outputText("Your [cocks] seem to fill up... growing a little bit larger.");
				}
			}
			if(temp2 > 1 && temp2 < 3) {
				if(cocks.length == 1) outputText("A very pleasurable feeling spreads from your groin as your [cock] grows permanently longer - at least an inch - and leaks pre-cum from the pleasure of the change.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A very pleasurable feeling spreads from your groin as your [cocks] grow permanently longer - at least an inch - and leak plenty of pre-cum from the pleasure of the change.");
					if(ncocks == 1) outputText("A very pleasurable feeling spreads from your groin as one of your [cocks] grows permanently longer, by at least an inch, and leaks plenty of pre-cum from the pleasure of the change.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("A very pleasurable feeling spreads from your groin as " + num2Text(ncocks) + " of your [cocks] grow permanently longer, by at least an inch, and leak plenty of pre-cum from the pleasure of the change.");
				}
			}
			if(temp2 >=3){
				if(cocks.length == 1) outputText("Your [cock] feels incredibly tight as a few more inches of length seem to pour out from your crotch.");
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("Your [cocks] feel incredibly tight as one of their number begins to grow inch after inch of length.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("Your [cocks] feel incredibly number as " + num2Text(ncocks) + " of them begin to grow inch after inch of added length.");
					if(ncocks == cocks.length) outputText("Your [cocks] feel incredibly tight as inch after inch of length pour out from your groin.");
				}
			}
			//Display LengthChange
			if(temp2 > 0) {
				if(cocks[0].cockLength >= 8 && cocks[0].cockLength-temp2 < 8){
					if(cocks.length == 1) outputText("  <b>Most men would be overly proud to have a tool as long as yours.</b>");
					if(cocks.length > 1) outputText("  <b>Most men would be overly proud to have one cock as long as yours, let alone " + multiCockDescript() + ".</b>");
				}
				if(cocks[0].cockLength >= 12 && cocks[0].cockLength-temp2 < 12) {
					if(cocks.length == 1) outputText("  <b>Your [cock] is so long it nearly swings to your knee at its full length.</b>");
					if(cocks.length > 1) outputText("  <b>Your [cocks] are so long they nearly reach your knees when at full length.</b>");
				}
				if(cocks[0].cockLength >= 16 && cocks[0].cockLength-temp2 < 16) {
					if(cocks.length == 1) outputText("  <b>Your [cock] would look more at home on a large horse than you.</b>");
					if(cocks.length > 1) outputText("  <b>Your [cocks] would look more at home on a large horse than on your body.</b>");
					if (biggestTitSize() >= BreastCup.C) {
						if (cocks.length == 1) outputText("  You could easily stuff your [cock] between your breasts and give yourself the titty-fuck of a lifetime.");
						if (cocks.length > 1) outputText("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the titty-fuck of a lifetime.");
					}
					else {
						if(cocks.length == 1) outputText("  Your [cock] is so long it easily reaches your chest.  The possibility of autofellatio is now a foregone conclusion.");
						if(cocks.length > 1) outputText("  Your [cocks] are so long they easily reach your chest.  Autofellatio would be about as hard as looking down.");
					}
				}
				if(cocks[0].cockLength >= 20 && cocks[0].cockLength-temp2 < 20) {
					if(cocks.length == 1) outputText("  <b>As if the pulsing heat of your [cock] wasn't enough, the tip of your [cock] keeps poking its way into your view every time you get hard.</b>");
					if(cocks.length > 1) outputText("  <b>As if the pulsing heat of your [cocks] wasn't bad enough, every time you get hard, the tips of your [cocks] wave before you, obscuring the lower portions of your vision.</b>");
					if(cor > 40 && cor <= 60) {
						if(cocks.length > 1) outputText("  You wonder if there is a demon or beast out there that could take the full length of one of your [cocks]?");
						if(cocks.length ==1) outputText("  You wonder if there is a demon or beast out there that could handle your full length.");
					}
					if(cor > 60 && cor <= 80) {
						if(cocks.length > 1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [cocks] to their hilts, milking you dry.\n\nYou smile at the pleasant thought.");
						if(cocks.length ==1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [cock] to the hilt, milking it of all your cum.\n\nYou smile at the pleasant thought.");
					}
					if(cor > 80) {
						if(cocks.length > 1) outputText("  You find yourself fantasizing about impaling nubile young champions on your [cocks] in a year's time.");
					}
				}
			}
			//Display the degree of length loss.
			if(temp2 < 0 && temp2 >= -1) {
				if(cocks.length == 1) outputText("Your [cocks] has shrunk to a slightly shorter length.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your [cocks] have shrunk to a slightly shorter length.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your [cocks] have shrunk to a slightly shorter length.");
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your [cocks] has shrunk to a slightly shorter length.");
				}
			}
			if(temp2 < -1 && temp2 > -3) {
				if(cocks.length == 1) outputText("Your [cocks] shrinks smaller, flesh vanishing into your groin.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your [cocks] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your [cocks] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your [cocks] shrink smaller, the flesh vanishing into your groin.");
				}
			}
			if(temp2 <= -3) {
				if(cocks.length == 1) outputText("A large portion of your [cocks]'s length shrinks and vanishes.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A large portion of your [cocks] recedes towards your groin, receding rapidly in length.");
					if(ncocks == 1) outputText("A single member of your [cocks] vanishes into your groin, receding rapidly in length.");
					if(ncocks > 1 && cocks.length > ncocks) outputText("Your [cocks] tingles as " + num2Text(ncocks) + " of your members vanish into your groin, receding rapidly in length.");
				}
			}
		}

		public function killCocks(deadCock:Number):void
		{
			//Count removal for text bits
			var removed:Number = 0;
			var temp:Number;
			//Holds cock index
			var storedCock:Number = 0;
			//Less than 0 = PURGE ALL
			if (deadCock < 0) {
				deadCock = cocks.length;
			}
			//Double loop - outermost counts down cocks to remove, innermost counts down
			while (deadCock > 0) {
				//Find shortest cock and prune it
				temp = cocks.length;
				while (temp > 0) {
					temp--;
					//If anything is out of bounds set to 0.
					if (storedCock > cocks.length - 1) storedCock = 0;
					//If temp index is shorter than stored index, store temp to stored index.
					if (cocks[temp].cockLength <= cocks[storedCock].cockLength) storedCock = temp;
				}
				//Smallest cock should be selected, now remove it!
				removeCock(storedCock, 1);
				removed++;
				deadCock--;
				if (cocks.length == 0) deadCock = 0;
			}
			//Texts
			if (removed == 1) {
				if (cocks.length == 0) {
					outputText("<b>Your manhood shrinks into your body, disappearing completely.</b>");
					if (hasStatusEffect(StatusEffects.Infested)) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.");
				}
				if (cocks.length == 1) {
					outputText("<b>Your smallest penis disappears, shrinking into your body and leaving you with just one [cock].</b>");
				}
				if (cocks.length > 1) {
					outputText("<b>Your smallest penis disappears forever, leaving you with just your [cocks].</b>");
				}
			}
			if (removed > 1) {
				if (cocks.length == 0) {
					outputText("<b>All your male endowments shrink smaller and smaller, disappearing one at a time.</b>");
					if (hasStatusEffect(StatusEffects.Infested)) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.");
				}
				if (cocks.length == 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with just your [cock].</b>");
				}
				if (cocks.length > 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with [cocks].</b>");
				}
			}
			//remove infestation if cockless
			if (cocks.length == 0) removeStatusEffect(StatusEffects.Infested);
			if (cocks.length == 0 && balls > 0) {
				outputText(" <b>Your " + sackDescript() + " and [balls] shrink and disappear, vanishing into your groin.</b>");
				balls = 0;
				ballSize = 1;
			}
		}
		public function modCumMultiplier(delta:Number):Number
		{
			trace("modCumMultiplier called with: " + delta);

			if (delta == 0) {
				trace( "Whoops! modCumMuliplier called with 0... aborting..." );
				return delta;
			}
			else if (delta > 0) {
				trace("and increasing");
				if (hasPerk(PerkLib.MessyOrgasms)) {
					trace("and MessyOrgasms found");
					delta *= 2
				}
			}
			else if (delta < 0) {
				trace("and decreasing");
				if (hasPerk(PerkLib.MessyOrgasms)) {
					trace("and MessyOrgasms found");
					delta *= 1
				}
			}

			trace("and modifying by " + delta);
			cumMultiplier += delta;
			return delta;
		}

		public function increaseCock(cockNum:Number, lengthDelta:Number):Number
		{
			var bigCock:Boolean = false;
			if (hasPerk(PerkLib.BigCock)) bigCock = true;
			return cocks[cockNum].growCock(lengthDelta, bigCock);
		}

		public function increaseEachCock(lengthDelta:Number):Number
		{
			var totalGrowth:Number = 0;
			for (var i:Number = 0; i < cocks.length; i++) {
				trace( "increaseEachCock at: " + i);
				totalGrowth += increaseCock(i as Number, lengthDelta);
			}

			return totalGrowth;
		}

		// Attempts to put the player in heat (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if she is already pregnant or is a he.
		//
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the
		// duration and intensity. Defaults to 1.
		public function goIntoHeat(output:Boolean, intensity:int = 1):Boolean {
			if(!hasVagina() || pregnancyIncubation != 0) {
				// No vagina or already pregnant, can't go into heat.
				return false;
			}

			//Already in heat, intensify further.
			if (inHeat) {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Despite already being in heat, the desire to copulate constantly grows even larger.");
				}
				var sac:HeatEffect = statusEffectByType(StatusEffects.Heat) as HeatEffect;
				sac.value1 += 5 * intensity;
				sac.value2 += (0.25 * intensity);
				sac.value3 += 48 * intensity;
				sac.ApplyEffect();
			}
			//Go into heat.  Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
			else {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Your hands begin stroking your body from top to bottom, your sensitive skin burning with desire.  Fantasies about bending over and presenting your needy pussy to a male overwhelm you as <b>you realize you have gone into heat!</b>");
				}
				createStatusEffect(StatusEffects.Heat, 10 * intensity, (50 * intensity)/100, 48 * intensity, 0);
			}
			return true;
		}

		// Attempts to put the player in rut (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if he is a she.
		//
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the
		// duration and intensity. Defaults to 1.
		public function goIntoRut(output:Boolean, intensity:int = 1):Boolean {
			if (!hasCock()) {
				// No cocks, can't go into rut.
				return false;
			}
			//Has rut, intensify it!
			if (inRut) {
				if(output) {
					outputText("\n\nYour [cock] throbs and dribbles as your desire to mate intensifies.  You know that <b>you've sunken deeper into rut</b>, but all that really matters is unloading into a cum-hungry cunt.");
				}
				var sac:RutEffect = statusEffectByType(StatusEffects.Rut) as RutEffect;
				sac.value1 += 100 * intensity;
				sac.value2 += 0.25 * intensity;
				sac.value3 += 48 * intensity;
				sac.ApplyEffect();
			}
			else {
				if(output) {
					outputText("\n\nYou stand up a bit straighter and look around, sniffing the air and searching for a mate.  Wait, what!?  It's hard to shake the thought from your head - you really could use a nice fertile hole to impregnate.  You slap your forehead and realize <b>you've gone into rut</b>!");
				}
				//v1 - bonus cum production
				//v2 - bonus libido
				//v3 - time remaining!
				createStatusEffect(StatusEffects.Rut, 150 * intensity, (50 * intensity)/100, 100 * intensity, 0);
			}
			return true;
		}

		public function maxFeralCombatLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function FeralCombatExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryFeralCombatLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryFeralCombatLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function feralCombatXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryFeralCombatXP++;
					XP--;
				}
				else {
					masteryFeralCombatXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryFeralCombatLevel < maxFeralCombatLevel() && masteryFeralCombatXP >= FeralCombatExpToLevelUp()) {
					outputText("\n<b>Dao of Feral Beast leveled up to " + (masteryFeralCombatLevel + 1) + "!</b>\n");
					masteryFeralCombatLevel++;
					masteryFeralCombatXP = 0;
				}
			}
		}

		public function maxGauntletLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function GauntletExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryGauntletLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryGauntletLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function gauntletXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryGauntletXP++;
					XP--;
				}
				else {
					masteryGauntletXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryGauntletLevel < maxGauntletLevel() && masteryGauntletXP >= GauntletExpToLevelUp()) {
					outputText("\n<b>Dao of Gauntlet leveled up to " + (masteryGauntletLevel + 1) + "!</b>\n");
					masteryGauntletLevel++;
					masteryGauntletXP = 0;
				}
			}
		}

		public function maxSwordLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function SwordExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masterySwordLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masterySwordLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function swordXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masterySwordXP++;
					XP--;
				}
				else {
					masterySwordXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masterySwordLevel < maxSwordLevel() && masterySwordXP >= SwordExpToLevelUp()) {
					outputText("\n<b>Dao of Sword leveled up to " + (masterySwordLevel + 1) + "!</b>\n");
					masterySwordLevel++;
					masterySwordXP = 0;
				}
			}
		}

		public function maxAxeLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function AxeExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryAxeLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryAxeLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function axeXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryAxeXP++;
					XP--;
				}
				else {
					masteryAxeXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryAxeLevel < maxAxeLevel() && masteryAxeXP >= AxeExpToLevelUp()) {
					outputText("\n<b>Dao of Axe leveled up to " + (masteryAxeLevel + 1) + "!</b>\n");
					masteryAxeLevel++;
					masteryAxeXP = 0;
				}
			}
		}

		public function maxMaceHammerLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function MaceHammerExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryMaceHammerLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryMaceHammerLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function macehammerXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryMaceHammerXP++;
					XP--;
				}
				else {
					masteryMaceHammerXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryMaceHammerLevel < maxMaceHammerLevel() && masteryMaceHammerXP >= MaceHammerExpToLevelUp()) {
					outputText("\n<b>Dao of Mace/Hammer leveled up to " + (masteryMaceHammerLevel + 1) + "!</b>\n");
					masteryMaceHammerLevel++;
					masteryMaceHammerXP = 0;
				}
			}
		}

		public function maxDuelingSwordLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function DuelingSwordExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryDuelingSwordLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryDuelingSwordLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function duelingswordXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryDuelingSwordXP++;
					XP--;
				}
				else {
					masteryDuelingSwordXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryDuelingSwordLevel < maxDuelingSwordLevel() && masteryDuelingSwordXP >= DuelingSwordExpToLevelUp()) {
					outputText("\n<b>Dao of Dueling Sword leveled up to " + (masteryDuelingSwordLevel + 1) + "!</b>\n");
					masteryDuelingSwordLevel++;
					masteryDuelingSwordXP = 0;
				}
			}
		}

		public function maxPolearmLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function PolearmExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryPolearmLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryPolearmLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function polearmXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryPolearmXP++;
					XP--;
				}
				else {
					masteryPolearmXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryPolearmLevel < maxPolearmLevel() && masteryPolearmXP >= PolearmExpToLevelUp()) {
					outputText("\n<b>Dao of Polearm leveled up to " + (masteryPolearmLevel + 1) + "!</b>\n");
					masteryPolearmLevel++;
					masteryPolearmXP = 0;
				}
			}
		}

		public function maxSpearLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function SpearExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masterySpearLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masterySpearLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function spearXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masterySpearXP++;
					XP--;
				}
				else {
					masterySpearXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masterySpearLevel < maxSpearLevel() && masterySpearXP >= SpearExpToLevelUp()) {
					outputText("\n<b>Dao of Spear leveled up to " + (masterySpearLevel + 1) + "!</b>\n");
					masterySpearLevel++;
					masterySpearXP = 0;
				}
			}
		}

		public function maxDaggerLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function DaggerExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryDaggerLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryDaggerLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function daggerXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryDaggerXP++;
					XP--;
				}
				else {
					masteryDaggerXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryDaggerLevel < maxDaggerLevel() && masteryDaggerXP >= DaggerExpToLevelUp()) {
					outputText("\n<b>Dao of Dagger leveled up to " + (masteryDaggerLevel + 1) + "!</b>\n");
					masteryDaggerLevel++;
					masteryDaggerXP = 0;
				}
			}
		}

		public function maxWhipLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function WhipExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryWhipLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryWhipLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function whipXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryWhipXP++;
					XP--;
				}
				else {
					masteryWhipXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryWhipLevel < maxWhipLevel() && masteryWhipXP >= WhipExpToLevelUp()) {
					outputText("\n<b>Dao of Whip leveled up to " + (masteryWhipLevel + 1) + "!</b>\n");
					masteryWhipLevel++;
					masteryWhipXP = 0;
				}
			}
		}

		public function maxExoticLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function ExoticExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryExoticLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryExoticLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function exoticXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryExoticXP++;
					XP--;
				}
				else {
					masteryExoticXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryExoticLevel < maxExoticLevel() && masteryExoticXP >= ExoticExpToLevelUp()) {
					outputText("\n<b>Dao of Exotic Weapons leveled up to " + (masteryExoticLevel + 1) + "!</b>\n");
					masteryExoticLevel++;
					masteryExoticXP = 0;
				}
			}
		}

		public function maxArcheryLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function ArcheryExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryArcheryLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryArcheryLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function archeryXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryArcheryXP++;
					XP--;
				}
				else {
					masteryArcheryXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryArcheryLevel < maxArcheryLevel() && masteryArcheryXP >= ArcheryExpToLevelUp()) {
					outputText("\n<b>Dao of Archery leveled up to " + (masteryArcheryLevel + 1) + "!</b>\n");
					masteryArcheryLevel++;
					masteryArcheryXP = 0;
				}
			}
		}

		public function maxThrowingLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function ThrowingExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryThrowingLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryThrowingLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function throwingXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryThrowingXP++;
					XP--;
				}
				else {
					masteryThrowingXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryThrowingLevel < maxThrowingLevel() && masteryThrowingXP >= ThrowingExpToLevelUp()) {
					outputText("\n<b>Dao of Throwing Weapons leveled up to " + (masteryThrowingLevel + 1) + "!</b>\n");
					masteryThrowingLevel++;
					masteryThrowingXP = 0;
				}
			}
		}

		public function maxFirearmsLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function FirearmsExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryFirearmsLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryFirearmsLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function firearmsXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryFirearmsXP++;
					XP--;
				}
				else {
					masteryFirearmsXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryFirearmsLevel < maxFirearmsLevel() && masteryFirearmsXP >= FirearmsExpToLevelUp()) {
					outputText("\n<b>Dao of Firearms Weapons leveled up to " + (masteryFirearmsLevel + 1) + "!</b>\n");
					masteryFirearmsLevel++;
					masteryFirearmsXP = 0;
				}
			}
		}

		public function maxDualWieldSmallLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function DualWieldSmallExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = dualWSLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = dualWSLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function dualWieldSmallXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					dualWSXP++;
					XP--;
				}
				else {
					dualWSXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (dualWSLevel < maxDualWieldSmallLevel() && dualWSXP >= DualWieldSmallExpToLevelUp()) {
					outputText("\n<b>Dual Wield (Small) skill leveled up to " + (dualWSLevel + 1) + "!</b>\n");
					dualWSLevel++;
					dualWSXP = 0;
				}
			}
		}

		public function maxDualWieldNormalLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function DualWieldNormalExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = dualWNLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = dualWNLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function dualWieldNormalXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					dualWNXP++;
					XP--;
				}
				else {
					dualWNXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (dualWNLevel < maxDualWieldNormalLevel() && dualWNXP >= DualWieldNormalExpToLevelUp()) {
					outputText("\n<b>Dual Wield (Normal) skill leveled up to " + (dualWNLevel + 1) + "!</b>\n");
					dualWNLevel++;
					dualWNXP = 0;
				}
			}
		}

		public function maxDualWieldLargeLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function DualWieldLargeExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = dualWLLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = dualWLLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function dualWieldLargeXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					dualWLXP++;
					XP--;
				}
				else {
					dualWLXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (dualWLLevel < maxDualWieldLargeLevel() && dualWLXP >= DualWieldLargeExpToLevelUp()) {
					outputText("\n<b>Dual Wield (Large) skill leveled up to " + (dualWLLevel + 1) + "!</b>\n");
					dualWLLevel++;
					dualWLXP = 0;
				}
			}
		}

		public function maxDualWieldFirearmsLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			return maxLevel;
		}
		public function DualWieldFirearmsExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = dualWFLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = dualWFLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function dualWieldFirearmsXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					dualWFXP++;
					XP--;
				}
				else {
					dualWFXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (dualWFLevel < maxDualWieldFirearmsLevel() && dualWFXP >= DualWieldFirearmsExpToLevelUp()) {
					outputText("\n<b>Dual Wield (Firearms) skill leveled up to " + (dualWFLevel + 1) + "!</b>\n");
					dualWFLevel++;
					dualWFXP = 0;
				}
			}
		}

		public function maxMiningLevel():Number {
			var maxLevel:Number = 2;
			//if (hasPerk(PerkLib.SuperSensual)) {
				//if (level < 48) maxLevel += level;
				//else maxLevel += 48;
			//}
			//else {
				if (level < 18) maxLevel += level;
				else maxLevel += 18;
			//}
			return maxLevel;
		}
		public function MiningExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = miningLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = miningLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function mineXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					miningXP++;
					XP--;
				}
				else {
					miningXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (miningLevel < maxMiningLevel() && miningXP >= MiningExpToLevelUp()) {
					outputText("\n\n<b>Mining skill leveled up to " + (miningLevel + 1) + "!</b>");
					miningLevel++;
					miningXP = 0;
				}
			}
		}

		public function maxHerbalismLevel():Number {
			var maxLevel:Number = 2;
			//if (hasPerk(PerkLib.SuperSensual)) {
				//if (level < 48) maxLevel += level;
				//else maxLevel += 48;
			//}
			//else {
				if (level < 18) maxLevel += level;
				else maxLevel += 18;
			//}
			return maxLevel;
		}
		public function HerbExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = herbalismLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = herbalismLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function herbXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					herbalismXP++;
					XP--;
				}
				else {
					herbalismXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (herbalismLevel < maxHerbalismLevel() && herbalismXP >= HerbExpToLevelUp()) {
					outputText("\n\n<b>Herbalism skill leveled up to " + (herbalismLevel + 1) + "!</b>");
					herbalismLevel++;
					herbalismXP = 0;
				}
			}
		}

		public function usePotion(pt:PotionType):void {
			pt.effect();
			changeNumberOfPotions(pt, -1);
			EngineCore.doNext(EventParser.playerMenu);
		}

		public function maxTeaseLevel():Number {
			var maxLevel:Number = 16;
			if (hasPerk(PerkLib.SuperSensual)) {
				if (level < 54) maxLevel += level;
				else maxLevel += 54;
			}
			else {
				if (level < 24) maxLevel += level;
				else maxLevel += 24;
			}
			return maxLevel;
		}
		public function teaseExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = teaseLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = teaseLevel + 1;
			if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}

		public function SexXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					teaseXP++;
					XP--;
				}
				else {
					teaseXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (teaseLevel < maxTeaseLevel() && teaseXP >= teaseExpToLevelUp()) {
					outputText("\n<b>Tease skill leveled up to " + (teaseLevel + 1) + "!</b>");
					teaseLevel++;
					teaseXP = 0;
				}
			}
		}

		public function cumOmeter(changes:Number = 0):Number {
			flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] += changes;
			if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 100) flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] = 100;
			return flags[kFLAGS.SEXUAL_FLUIDS_LEVEL];
		}

		public function blockingBodyTransformations():Boolean {
			return hasPerk(PerkLib.TransformationImmunity) || hasPerk(PerkLib.TransformationImmunityFairy) || hasPerk(PerkLib.TransformationImmunityAtlach)
					|| hasPerk(PerkLib.Undeath) || hasPerk(PerkLib.WendigoCurse) || hasPerk(PerkLib.BlessingOfTheAncestorTree);
		}

		public function manticoreFeed():void {
			if (hasPerk(MutationsLib.ManticoreMetabolism)) {
				if (hasPerk(MutationsLib.ManticoreMetabolismPrimitive)) {
					var PowerMultiplier:Number = 1;
					if (hasPerk(MutationsLib.ManticoreMetabolismEvolved)) PowerMultiplier *= 2;
					if (buff("Feeding Euphoria").getValueOfStatBuff("spe.mult") < (0.50*PowerMultiplier) + (0.5 * (1 + newGamePlusMod()))) {
						buff("Feeding Euphoria").addStats({"spe.mult": 0.5}).withText("Feeding Euphoria!").forHours(15);
					}
					else if (buff("Feeding Euphoria").getValueOfStatBuff("spe.mult") >= (1.50*PowerMultiplier) + (1.5 * (1 + newGamePlusMod()))) {
						buff("Feeding Euphoria").addDuration(3);
					}
				} else {
					if (buff("Feeding Euphoria").getValueOfStatBuff("spe.mult") < 0.50) {
						buff("Feeding Euphoria").addStats({"spe.mult": 0.5}).withText("Feeding Euphoria!").forHours(10);
					}
					else if (buff("Feeding Euphoria").getValueOfStatBuff("spe.mult") >= 1.50) {
						buff("Feeding Euphoria").addDuration(2);
					}
				}
			}
			EngineCore.HPChange(Math.round(maxHP() * .2), true);
			cumOmeter(40);
			cor += 2;
			var Ammount:Number = 100;
			if ((hunger+Ammount)>maxHunger()) Ammount = (maxHunger()-hunger-1);
			refillHunger(Ammount);
			var Amm2:Number = 50;
			if (hasPerk(MutationsLib.ManticoreMetabolismPrimitive)) Amm2 *= 2;
			tailVenom += Amm2;
			if (tailVenom > maxVenom()) tailVenom = maxVenom();
		}

		public function displacerFeed():void {
			if (hasPerk(MutationsLib.DisplacerMetabolism)) {
				if (hasPerk(MutationsLib.DisplacerMetabolismPrimitive)) {
					if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") < 0.25 + (0.25 * (1 + newGamePlusMod()))) {
						buff("Milking Euphoria").addStats({"str.mult": 0.25, "spe.mult": 0.25, "int.mult": -0.25}).withText("Milking Euphoria!").forHours(15);
					}
					else if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") >= 0.75 + (0.75 * (1 + newGamePlusMod()))) {
						buff("Milking Euphoria").addDuration(3);
					}
				} else {
					if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") < 0.25) {
						buff("Milking Euphoria").addStats({"str.mult": 0.25, "spe.mult": 0.25, "int.mult": -0.25}).withText("Milking Euphoria!").forHours(10);
					}
					else if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") >= 0.75) {
						buff("Milking Euphoria").addDuration(2);
					}
				}
			}
			EngineCore.HPChange(Math.round(maxHP() * .2), true);
			cumOmeter(40);
			cor += 2;
			var Ammount:Number = 100;
			if ((hunger+Ammount)>maxHunger()) Ammount = (maxHunger()-hunger-1);
			refillHunger(Ammount);
		}

		public function slimeGrowth():void {
			if (hasStatusEffect(StatusEffects.SlimeCraving)) {
				if (hasPerk(MutationsLib.SlimeMetabolismEvolved)) {
					buff("Fluid Growth").addStats({"tou.mult": 0.02}).withText("Fluid Growth!");
					if (hasPerk(PerkLib.DarkSlimeCore)){
						buff("Fluid Growth").addStats({"int.mult": 0.02}).withText("Fluid Growth!");
					}
				} else {
					buff("Fluid Growth").addStats({"tou.mult": 0.01}).withText("Fluid Growth!");
					if (hasPerk(PerkLib.DarkSlimeCore)){
						buff("Fluid Growth").addStats({"int.mult": 0.01}).withText("Fluid Growth!");
					}
				}
			}
			EngineCore.HPChange(Math.round(maxHP() * .2), true);
			cumOmeter(40);
			cor += 2;
			var Ammount:Number = 100;
			if ((hunger+Ammount)>maxHunger()) Ammount = (maxHunger()-hunger-1);
			refillHunger(Ammount);
		}

        /**
		 * fluidtype: "cum", "vaginalFluids", "saliva", "milk", "Default".
         *
		 * type: 'n', 'Vaginal', 'Anal', 'Dick', 'Lips', 'Tits', 'Nipples', 'Ovi', 'VaginalAnal', 'DickAnal', 'Default', 'Generic'
		 */
		public function sexReward(fluidtype:String = 'Default', type:String = 'Default', real:Boolean = true, Wasfluidinvolved:Boolean = true):void
		{
			if (Wasfluidinvolved) {
				slimeFeed();
				if (isGargoyle() && hasPerk(PerkLib.GargoyleCorrupted)) refillGargoyleHunger(30);
				if (jiangshiScore() >= 20 && hasPerk(PerkLib.EnergyDependent)) EnergyDependentRestore();
				if (hasPerk(PerkLib.DemonEnergyThirst)) createStatusEffect(StatusEffects.DemonEnergyThirstFeed, 0, 0, 0, 0);
				if (hasPerk(PerkLib.KitsuneEnergyThirst)) createStatusEffect(StatusEffects.KitsuneEnergyThirstFeed, 0, 0, 0, 0);
				switch (fluidtype)
				{
					// Start with that, whats easy
					case 'cum':
						if (hasStatusEffect(StatusEffects.Overheat) && inHeat) {
							if (statusEffectv3(StatusEffects.Overheat) != 1) addStatusValue(StatusEffects.Overheat, 3, 1);
						}
						if (hasPerk(PerkLib.ManticoreCumAddict)) manticoreFeed();
						if (hasPerk(PerkLib.EndlessHunger)) refillHunger(30, false);
						break;
					case 'vaginalFluids':
						if (hasStatusEffect(StatusEffects.Overheat) && inRut) {
							if (statusEffectv3(StatusEffects.Overheat) != 1) addStatusValue(StatusEffects.Overheat, 3, 1);
						}
						if (hasPerk(PerkLib.EndlessHunger)) refillHunger(30, false);
						break;
					case 'saliva':
						break;
					case 'milk':
						if (hasPerk(PerkLib.DisplacerMilkAddict)) displacerFeed();
						refillHunger(10, false);
						break;
				}
			}
			SexXP(5+level);
			if (armor == game.armors.SCANSC)SexXP(5+level);
			orgasm(type,real);
			if (type == "Dick") {
				if (hasPerk(PerkLib.EasterBunnyBalls)) {
					if (ballSize > 3) createStatusEffect(StatusEffects.EasterBunnyCame, 0, 0, 0, 0);
				}
				if (hasPerk(MutationsLib.NukiNutsPrimitive)) {
					var cumAmmount:Number = cumQ();
					var payout:Number = 0;
					//Get rid of extra digits
					cumAmmount = int(cumAmmount);
					//Calculate payout
					if (cumAmmount > 10) payout = 2 + int(cumAmmount/100)*2;
					//Reduce payout if it would push past
					if (hasPerk(MutationsLib.NukiNutsEvolved)) payout *= 2;
					if (payout > 0) {
						gems += payout;
						EngineCore.outputText("\n\nBefore moving on you grab the " + payout + " gems you came from from your " + cockDescript(0) + ".</b>\n\n");
					}
				}
			}
		}

		public function orgasmReal():void
		{
			dynStats("lus=", 0, "sca", false);
			hoursSinceCum = 0;
			flags[kFLAGS.TIMES_ORGASMED]++;
			if (countCockSocks("gilded") > 0) {
				var randomCock:int = rand( cocks.length );
				var bonusGems:int = rand( cocks[randomCock].cockThickness ) + countCockSocks("gilded"); // int so AS rounds to whole numbers
				EngineCore.outputText("\n\nFeeling some minor discomfort in your " + cockDescript(randomCock) + " you slip it out of your [armor] and examine it. <b>With a little exploratory rubbing and massaging, you manage to squeeze out " + bonusGems + " gems from its cum slit.</b>\n\n");
				gems += bonusGems;
			}
		}

		public function orgasm(type:String = 'Default', real:Boolean = true):void
		{
			switch (type) {
					// Start with that, whats easy
				case 'Vaginal': //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_VAGINAL] < 10) flags[kFLAGS.TIMES_ORGASM_VAGINAL]++;
					break;
				case 'Anal':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_ANAL]    < 10) flags[kFLAGS.TIMES_ORGASM_ANAL]++;
					break;
				case 'Dick':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_DICK]    < 10) flags[kFLAGS.TIMES_ORGASM_DICK]++;
					break;
				case 'Lips':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_LIPS]    < 10) flags[kFLAGS.TIMES_ORGASM_LIPS]++;
					break;
				case 'Tits':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_TITS]    < 10) flags[kFLAGS.TIMES_ORGASM_TITS]++;
					break;
				case 'Nipples': //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_NIPPLES] < 10) flags[kFLAGS.TIMES_ORGASM_NIPPLES]++;
					break;
				case 'Ovi':
					break;
					// Now to the more complex types
				case 'VaginalAnal':
					orgasm((hasVagina() ? 'Vaginal' : 'Anal'), real);
					return; // Prevent calling orgasmReal() twice
				case 'DickAnal':
					orgasm((rand(2) == 0 ? 'Dick' : 'Anal'), real);
					return;
				case 'Default':
				case 'Generic':
				default:
					if (!hasVagina() && !hasCock()) {
						orgasm('Anal'); // Failsafe for genderless PCs
						return;
					}
					if (hasVagina() && hasCock()) {
						orgasm((rand(2) == 0 ? 'Vaginal' : 'Dick'), real);
						return;
					}
					orgasm((hasVagina() ? 'Vaginal' : 'Dick'), real);
					return;
			}

			if (real) orgasmReal();
		}
		public function orgasmRaijuStyle():void
		{
			if (game.player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
				EngineCore.outputText("\n\nAs you finish masturbating you feel a jolt in your genitals, as if for a small moment the raiju discharge was brought back, increasing the intensity of the pleasure and your desire to touch yourself. Electricity starts coursing through your body again by intermittence as something in you begins to change.");
				game.player.addStatusValue(StatusEffects.RaijuLightningStatus,1,6);
				dynStats("lus", (60 + rand(20)), "sca", false);
				game.mutations.voltageTopaz(false,CoC.instance.player);
			}
			else {
				EngineCore.outputText("\n\nAfter this electrifying orgasm your lust only raises higher than the sky above. You will need a partner to fuck with in order to discharge your ramping up desire and electricity.");
				dynStats("lus", (maxLust() * 0.1), "sca", false);
			}
			hoursSinceCum = 0;
			flags[kFLAGS.TIMES_ORGASMED]++;
		}
		public function penetrated(where:ISexyPart, tool:ISexyPart, options:Object = null):void {
			options = Utils.extend({
				display:true,
				orgasm:false
			},options||{});
			if (where.host != null && where.host != this) {
				trace("Penetration confusion! Host is "+where.host);
				return;
			}
			var size:Number = 8;
			if ('size' in options) size = options.size;
			else if (tool is Cock) size = (tool as Cock).cArea();
			var otype:String = 'Default';
			if (where is AssClass) {
				buttChange(size, options.display);
				otype = 'Anal';
			} else if (where is VaginaClass) {
				cuntChange(size, options.display);
				otype = 'Vaginal';
			}
			if (options.orgasm) {
				orgasm(otype);
			}
		}

		public function EnergyDependentRestore():void {
			var intBuff:Number = buff("Energy Vampire").getValueOfStatBuff("int.mult");
			var speBuff:Number = buff("Energy Vampire").getValueOfStatBuff("spe.mult");
			if (hasStatusEffect(StatusEffects.AlterBindScroll2)) {
				if (intBuff < +1.8) buff("Energy Vampire").addStats({ "int.mult": +0.20 }).withText("Energy Vampire");
				if (speBuff < +0.9) buff("Energy Vampire").addStats({ "spe.mult": +0.10 }).withText("Energy Vampire");
			}
			else {
				if (intBuff < +0.9) buff("Energy Vampire").addStats({ "int.mult": +0.10 }).withText("Energy Vampire");
				if (speBuff < +0.45) buff("Energy Vampire").addStats({ "spe.mult": +0.05 }).withText("Energy Vampire");
			}
			if (!CoC.instance.monster.hasPerk(PerkLib.EnemyTrueDemon)) {
				if (hasStatusEffect(StatusEffects.AlterBindScroll2)) soulforce += maxSoulforce() * 0.08;
				else soulforce += maxSoulforce() * 0.04;
				if (soulforce > maxSoulforce()) soulforce = maxSoulforce();
				outputText(" You feel slightly more alive from the soulforce you vampirised from your sexual partner orgasm.");
			}
			if (HP < maxHP()) EngineCore.HPChange(25 + (lib/2), true);
			if (mana < maxMana()) EngineCore.ManaChange(25 + (inte/2), true);
			EngineCore.changeFatigue(-(25 + (spe/2)));
			removeCurse("lib", 5, 1);
			removeCurse("lib", 5, 2);
		}

		public function displacerFeedFromBottle():void {
			if (hasPerk(MutationsLib.DisplacerMetabolism)) {
				if (hasPerk(MutationsLib.DisplacerMetabolismPrimitive)) {
					if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") < 0.25 + (0.25 * (1 + newGamePlusMod()))) {
						buff("Milking Euphoria").addStats({"str.mult": 0.05, "spe.mult": 0.05, "int.mult": -0.05}).withText("Milking Euphoria!").forHours(10);
					}
					else if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") >= 0.75 + (0.75 * (1 + newGamePlusMod()))) {
						buff("Milking Euphoria").addDuration(2);
					}
				} else {
					if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") < 0.05) {
						buff("Milking Euphoria").addStats({"str.mult": 0.05, "spe.mult": 0.05, "int.mult": -0.05}).withText("Milking Euphoria!").forHours(6);
					}
					else if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") >= 0.75) {
						buff("Milking Euphoria").addDuration(1);
					}
				}
			}
			EngineCore.HPChange(Math.round(maxHP() * .05), true);
		}

		public function hasUniquePregnancy():Boolean{
			if (isSlime() || isHarpy() || isGoblinoid() || isAlraune()) return true;
			else return false;
		}

		public function impregnationRacialCheck():void
		{
		    if (isGoblinoid()) knockUp(PregnancyStore.PREGNANCY_GOBLIN, PregnancyStore.INCUBATION_GOBLIN);
			else if (isSlime()) knockUp(PregnancyStore.PREGNANCY_GOO_GIRL, PregnancyStore.INCUBATION_GOO_GIRL);
			else if (isHarpy()){
				knockUp(PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, PregnancyStore.INCUBATION_OVIELIXIR_EGGS, 1, 1);
				createStatusEffect(StatusEffects.Eggs, Utils.rand(6), 0, Utils.rand(3) + 5, 0);
			}
			//until we get a real harpy knock up
			else if (isAlraune()) knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
		}

		protected override function maxHP_base():Number {
			var max:Number = super.maxHP_base();
			if (alicornScore() >= 12) max += (250 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (centaurScore() >= 8) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (isGargoyle() && Forgefather.material == "granite")
			{
				if (Forgefather.refinement == 1) max *= (1.15);
				if (Forgefather.refinement == 2) max *= (1.25);
				if (Forgefather.refinement == 3 || Forgefather.refinement == 4) max *= (1.35);
				if (Forgefather.refinement == 5) max *= (1.5);
			}
			if (gorgonScore() >= 11) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (gorgonScore() >= 17) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (horseScore() >= 7) max += (70 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (manticoreScore() >= 15) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (manticoreScore() >= 22) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (rhinoScore() >= 4) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (scyllaScore() >= 7) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (scyllaScore() >= 12) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (unicornScore() >= 12) max += (250 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.ElementalBondFlesh) && statusEffectv1(StatusEffects.SummonedElementals) >= 2) max += maxHP_ElementalBondFleshMulti() * statusEffectv1(StatusEffects.SummonedElementals);
			return max;
		}
		protected override function maxLust_base():Number {
			var max:Number = super.maxLust_base();
			if (cowScore() >= 10) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (devilkinScore() >= 11) max += (150 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (devilkinScore() >= 16) max += (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (devilkinScore() >= 21) max += (90 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 24) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 32) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (minotaurScore() >= 10) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (phoenixScore() >= 5) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (salamanderScore() >= 7) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (sharkScore() >= 9 && vaginas.length > 0 && cocks.length > 0) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.ElementalBondUrges) && statusEffectv1(StatusEffects.SummonedElementals) >= 2) max += maxLust_ElementalBondUrgesMulti() * statusEffectv1(StatusEffects.SummonedElementals);
			if (hasPerk(MutationsLib.LactaBovinaOvaries)) max += (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(MutationsLib.LactaBovinaOvariesEvolved)) max += (90 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(MutationsLib.MinotaurTesticles)) max += (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(MutationsLib.MinotaurTesticlesEvolved)) max += (90 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			return max;
		}

		public function sadomasochismBoost():Number {
			var sadomasochismBoost:Number = 1;
			if (HP < maxHP() * 0.25) sadomasochismBoost += 0.2;
			if (lust > maxLust() * 75) sadomasochismBoost += 0.2;
			return sadomasochismBoost;
		}

		public function get additionalTransformationChances():Number {
			var additionalTransformationChancesCounter:Number = 0;
			if (hasPerk(PerkLib.HistoryAlchemist) || hasPerk(PerkLib.PastLifeAlchemist)) additionalTransformationChancesCounter++;
			if (hasPerk(PerkLib.EzekielBlessing)) additionalTransformationChancesCounter++;
			if (hasPerk(PerkLib.TransformationResistance)) additionalTransformationChancesCounter--;
			return additionalTransformationChancesCounter;
		}

		public function MutagenBonus(statName: String, bonus: Number):Boolean
		{
			var cap:Number = 0.2;
			if (hasPerk(PerkLib.Enhancement)) cap += 0.02;
			if (hasPerk(PerkLib.Fusion)) cap += 0.02;
			if (hasPerk(PerkLib.Enchantment)) cap += 0.02;
			if (hasPerk(PerkLib.Refinement)) cap += 0.02;
			if (hasPerk(PerkLib.Saturation)) cap += 0.02;
			if (hasPerk(PerkLib.Perfection)) cap += 0.02;
			if (hasPerk(PerkLib.Creationism)) cap += 0.02;
			if (hasPerk(PerkLib.MunchkinAtGym)) cap += 0.05;
            if (bonus == 0)
                return false; //no bonus - no effect
            if (removeCurse(statName, bonus))
                return false; //remove existing curses
            var current:Number = buff("Mutagen").getValueOfStatBuff(statName + ".mult");
            var bonus_sign:Number = (bonus > 0) ? 1 : -1;
            var current_sign:Number = (current > 0) ? 1 : -1;
            if ((bonus_sign == current_sign) && Math.abs(current) >= cap) //already max and matching signs
                return false;

            var addBonus:Number = bonus_sign * Math.min(Math.abs(bonus_sign * cap - current), Math.abs(bonus * 0.01)); 
            buff("Mutagen").addStat(statName + ".mult", addBonus);
            CoC.instance.mainView.statsView.refreshStats(CoC.instance);
            CoC.instance.mainView.statsView.showStatUp(statName);
            return true;
		}

		public function AlchemyBonus(statName: String, bonus: Number):void
		{
			var ABCap:Number = 0.2;
			if (hasPerk(PerkLib.Enhancement)) ABCap += 0.02;
			if (hasPerk(PerkLib.Fusion)) ABCap += 0.02;
			if (hasPerk(PerkLib.Enchantment)) ABCap += 0.02;
			if (hasPerk(PerkLib.Refinement)) ABCap += 0.02;
			if (hasPerk(PerkLib.Saturation)) ABCap += 0.02;
			if (hasPerk(PerkLib.Perfection)) ABCap += 0.02;
			if (hasPerk(PerkLib.Creationism)) ABCap += 0.02;
			if (hasPerk(PerkLib.MunchkinAtGym)) ABCap += 0.05;
			removeCurse(statName, bonus);
			if (buff("Alchemical").getValueOfStatBuff(""+statName+".mult") < ABCap){
				buff("Alchemical").addStat(""+statName+".mult",0.01);
				CoC.instance.mainView.statsView.refreshStats(CoC.instance);
				CoC.instance.mainView.statsView.showStatUp(statName);
			}
		}

		public function KnowledgeBonus(statName: String, bonus: Number):void
		{
			var KBCap:Number = 0.2;
			if (hasPerk(PerkLib.MunchkinAtGym)) KBCap += 0.05;
			removeCurse(statName, bonus);
			if (buff("Knowledge").getValueOfStatBuff(""+statName+".mult") < KBCap){
				buff("Knowledge").addStat(""+statName+".mult",0.01);
				CoC.instance.mainView.statsView.refreshStats(CoC.instance);
				CoC.instance.mainView.statsView.showStatUp(statName);
			}
		}

		public function BrainMeltBonus():void
		{
			var MBCap:Number = 1;
			if (hasPerk(PerkLib.MindbreakerBrain1toX)) MBCap += 0.50*perkv1(PerkLib.MindbreakerBrain1toX);
			removeCurse("inte", 5);
			removeCurse("wis", 5);
			removeCurse("lib", 5);
			if (buff("Devoured Mind").getValueOfStatBuff("int.mult") < MBCap){
				buff("Devoured Mind").addStat("int.mult",0.05);
				buff("Devoured Mind").addStat("wis.mult",0.05);
				buff("Devoured Mind").addStat("lib.mult",0.05);
				CoC.instance.mainView.statsView.refreshStats(CoC.instance);
				CoC.instance.mainView.statsView.showStatUp("inte");
				CoC.instance.mainView.statsView.showStatUp("wis");
				CoC.instance.mainView.statsView.showStatUp("lib");
				outputText("Your mind surges with newfound knowledge, your brain expanding slightly from the stolen information. You orgasm in sympathy with this new added knowledge.");
			}
			else{
				outputText("Sadly as much as you try to extract new knowledge from your victims brain there's only so few to be had… " +
						"that Mareth is filled with idiots doesn't help that." +
						" Despite draining your victim into something about as smart as a mineral you fail to extract anything noteworthy.");
			}
		}

		public function VenomWebCost():Number
		{
			var VWC:Number = 5;
			if (hasPerk(PerkLib.ImprovedVenomGlandEx)) VWC -= 1;
			if (hasPerk(PerkLib.ImprovedVenomGlandSu)) VWC += 2;
			return VWC;
		}

		public override function mf(male:String, female:String):String {
			var old:String = super.mf(male, female);
			switch (flags[kFLAGS.MALE_OR_FEMALE]) {
				case 1: return male;
				case 2: return female;
				default: return old;
			}
		}

		override public function modStats(dstr:Number, dtou:Number, dspe:Number, dinte:Number, dwis:Number, dlib:Number, dsens:Number, dlust:Number, dcor:Number, scale:Boolean, max:Boolean):void {
			//Easy mode cuts lust gains!
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1 && dlust > 0 && scale) dlust /= 10;
			//Set original values to begin tracking for up/down values if
			//they aren't set yet.
			//These are reset when up/down arrows are hidden with
			//hideUpDown();
			//Just check str because they are either all 0 or real values
			if(game.oldStats.oldStr == 0) {
				game.oldStats.oldStr = str;
				game.oldStats.oldTou = tou;
				game.oldStats.oldSpe = spe;
				game.oldStats.oldInte = inte;
				game.oldStats.oldWis = wis;
				game.oldStats.oldLib = lib;
				game.oldStats.oldSens = sens;
				game.oldStats.oldCor = cor;
				game.oldStats.oldHP = HP;
				game.oldStats.oldLust = lust;
				game.oldStats.oldFatigue = fatigue;
				game.oldStats.oldSoulforce = soulforce;
				game.oldStats.oldHunger = hunger;
			}
			if (scale) {
				//MOD CHANGES FOR PERKS
				//Bimbos learn slower
				if (hasPerk(PerkLib.FutaFaculties) || hasPerk(PerkLib.BimboBrains) || hasPerk(PerkLib.BroBrains)) {
					if (dinte > 0) dinte /= 2;
					if (dinte < 0) dinte *= 2;
				}
				if (hasPerk(PerkLib.FutaForm) || hasPerk(PerkLib.BimboBody) || hasPerk(PerkLib.BroBody)) {
					if (dlib > 0) dlib *= 2;
					if (dlib < 0) dlib /= 2;
				}
				// Uma's Perkshit
				if (hasPerk(PerkLib.ChiReflowLust) && dlib > 0) dlib *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
				if (hasPerk(PerkLib.ChiReflowLust) && dsens > 0) dsens *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
				//Apply lust changes in NG+.
				dlust *= 1 + (newGamePlusMod() * 0.2);
				//lust resistance
				if (dlust > 0 && scale) dlust *= EngineCore.lustPercent() / 100;
				if (dlib > 0 && hasPerk(PerkLib.PurityBlessing)) dlib *= 0.75;
				if (dcor > 0 && hasPerk(PerkLib.PurityBlessing)) dcor *= 0.5;
				if (dcor > 0 && hasPerk(PerkLib.PureAndLoving)) dcor *= 0.75;
				if (dcor > 0 && weapon == game.weapons.HNTCANE) dcor *= 0.5;
				if (hasPerk(PerkLib.AscensionMoralShifter)) dcor *= 1 + (perkv1(PerkLib.AscensionMoralShifter) * 0.2);
				if (hasPerk(PerkLib.Lycanthropy)) dcor *= 1.2;
				if (hasStatusEffect(StatusEffects.BlessingOfDivineFera)) dcor *= 2;
				if (sens > 50 && dsens > 0) dsens /= 2;
				if (sens > 75 && dsens > 0) dsens /= 2;
				if (sens > 90 && dsens > 0) dsens /= 2;
				if (sens > 50 && dsens < 0) dsens *= 2;
				if (sens > 75 && dsens < 0) dsens *= 2;
				if (sens > 90 && dsens < 0) dsens *= 2;
				//Bonus gain for perks!
				if(hasPerk(PerkLib.Strong)) dstr += dstr * perkv1(PerkLib.Strong);
				if(hasPerk(PerkLib.Tough)) dtou += dtou * perkv1(PerkLib.Tough);
				if(hasPerk(PerkLib.Fast)) dspe += dspe * perkv1(PerkLib.Fast);
				if(hasPerk(PerkLib.Smart)) dinte += dinte * perkv1(PerkLib.Smart);
				if(hasPerk(PerkLib.Wise)) dwis += dwis * perkv1(PerkLib.Wise);
				if(hasPerk(PerkLib.Lusty)) dlib += dlib * perkv1(PerkLib.Lusty);
				if(hasPerk(PerkLib.Sensitive)) dsens += dsens * perkv1(PerkLib.Sensitive);
				// Uma's Str Cap from Perks (Moved to max stats)
				/*if (hasPerk(PerkLib.ChiReflowSpeed))
				{
					if (str > UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP)
					{
						str = UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP;
					}
				}
				if (hasPerk(PerkLib.ChiReflowDefense))
				{
					if (spe > UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP)
					{
						spe = UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP;
					}
				}*/
			}
			//Change original stats
			super.modStats(dstr,dtou,dspe,dinte,dwis,dlib,dsens,dlust,dcor,false,max);
			//Refresh the stat pane with updated values
			//mainView.statsView.showUpDown();
			if (dlust != 0){
				raijuSuperchargedCheck();
			}
			if (raijuScore() < 10 && statStore.hasBuff('Supercharged')) statStore.removeBuffs('Supercharged');
			EngineCore.showUpDown();
			EngineCore.statScreenRefresh();
		}

		public function raijuSuperchargedCheck():void{
			if (raijuScore() >= 10 && lust100>=75){
				if (!statStore.hasBuff("Supercharged")){
					var buff:Number = 1;
					if (hasPerk(MutationsLib.RaijuCathodeEvolved)) buff *= 2
					statStore.replaceBuffObject({'spe.mult':Math.round(speStat.mult.value)*buff}, 'Supercharged', { text: 'Supercharged!' });
					CoC.instance.mainView.statsView.refreshStats(CoC.instance);
					CoC.instance.mainView.statsView.showStatUp('spe');
					outputText("\n\nAs your bottled up voltage ramps up you begin to lose yourself to lust turning increasingly feral as your overwhelming need to discharge override any rational thinking. FUCK… you need someone to fuck that voltage out of you!");
					if(game.inCombat) outputText(" [monster] gulp as [he] see's your lust crazed expression. Should you win [he] won't get off the hook so easily!");
					outputText("\n\n<b>You entered the supercharged state!</b>\n\n");
				}
				if(lust100 >= 100){
					lust = maxLust()*99/100
				}
			}
		}

		public override function takeLustDamage(lustDmg:Number, display:Boolean = true, applyRes:Boolean = true):Number{
			var x:Number = super.takeLustDamage(lustDmg, display, applyRes);
			raijuSuperchargedCheck();
			return x;
		}

		public function knownAbilities():/*CombatAbility*/Array {
			return CombatAbilities.ALL.filter(
					function(ability:CombatAbility,index:int,array:Array):Boolean {
						return ability.isKnown
					}
			)
		}
		public function knownAbilitiesOfClass(klass:Class):/*CombatAbility*/Array {
			return CombatAbilities.ALL.filter(
					function(ability:CombatAbility,index:int,array:Array):Boolean {
						return ability is klass && ability.isKnown
					}
			)
		}
		public function resetCooldowns():void {
			for (var i:int = 0; i<cooldowns.length; i++) {
				cooldowns[i] = 0;
			}
		}
	}
}