package classes.Items 
{
	/**
	 * ...
	 * @author Ormael
	 */
	import classes.Items.HeadJewelries.*;
	import classes.PerkLib;
	import classes.PerkType;
	
	public final class HeadJewelryLib 
	{
		public static const MODIFIER_SF:int = 				1;
		public static const MODIFIER_MP:int = 				2;
		public static const MODIFIER_HP:int = 				3;
		public static const MODIFIER_ATTACK_POWER:int = 	4;
		public static const MODIFIER_SPELL_POWER:int = 		5;
		public static const MODIFIER_R_ATTACK_POWER:int = 	6;
		//public static const :int = 				7;
		public static const MODIFIER_WR:int = 				8;
		public static const MODIFIER_FIRE_R:int = 			9;
		public static const MODIFIER_ICE_R:int = 			10;
		public static const MODIFIER_LIGH_R:int = 			11;
		public static const MODIFIER_DARK_R:int = 			12;
		public static const MODIFIER_POIS_R:int = 			13;
		public static const MODIFIER_MAGIC_R:int = 			14;
		public static const MODIFIER_LUST_R:int = 			15;
		public static const MODIFIER_PHYS_R:int = 			16;
		
		public static const DEFAULT_VALUE:Number = 6;//base cost 200 gems, each effect increase up to 2x cost
		
		public static const NOTHING:Nothing = new Nothing();
		
		public const AQBREATH:HeadJewelry = new HeadJewelry("AqBreath", "Aqua breather", "Aqua breather", "an Aqua breather", 0, 0, 200, "This unfashionable, yet very practical, goblin device allows to breathe underwater. A must have for any underwater expedition. \n\nType: Helm \nBase value: 200","Helmet");
		public const DMONSKUL:SkullOrnament = new SkullOrnament();
		public const FOXHAIR:HeadJewelry = new HeadJewelry("FoxHair", "Fox Hairpin", "fox hairpin", "a fox hairpin", 0, 0, 800, "This hairpin, adorned with the design of a fox and blessed by Taoth, grants a kitsune increased magical power. (-20% spell and soulskills costs, +20% mag/lust dmg to fox fire specials) \n\nType: Jewelry (Hairpin) \nBase value: 800","Hairpin");
		public const GNHAIR:HeadJewelry = new HeadJewelry("GNHair", "Golden Naga Hairpins", "pair of Golden Naga Hairpins", "a pair of Golden Naga Hairpins", 0, 0, 400, "This pair of lovely half moon-shaped golden hairpins are commonly used by the nagas to enhance their bodily charms. (+10% lust dmg from naga specials and +1 duration of Hypnosis) \n\nType: Jewelry (Hairpin) \nBase value: 400","Hairpin");
		public const HBHELM :HBHelmet = new HBHelmet();
		public const KABUMEMP:HeadJewelry = new HeadJewelry("KabuMemp", "KabutoMempo", "Kabuto & Mempo", "a Kabuto & Mempo", 0, 0, 100, "This fashionable and practical set of Kabuto (helmet) and Mempo (face mask) allow to protect whole head. Usualy worn alongside Samurai armor. \n\nType: Helm \nBase value: 200","Helmet");
		public const MACHGOG:MachinistGoggles = new MachinistGoggles();
		public const SATGOG :SATechGoggle = new SATechGoggle();
		public const SCANGOG:ScannerGoggle = new ScannerGoggle();
		public const SEERPIN:SeersHairpin = new SeersHairpin();
		public const SKIGOGG:HeadJewelry = new HeadJewelry("SkiGogg", "Ski goggles", "Ski goggles", "a Ski goggles", 0, 0, 400, "These goggles help shield your eyes against the snowstorms of the glacial rift, allowing you to see correctly in a blizzard like the denizens of the rift. \n\nType: Helm \nBase value: 400","Helmet");
		public const SNOWFH:SnowflakeHairpin = new SnowflakeHairpin();
		public const SPHINXAS:SphinxAccessorySet = new SphinxAccessorySet();
		public const TSHAIR :HeadJewelry = new HeadJewelry("TSHair", "T.S.Hairpin", "training soul hairpin", "training soul hairpin", 0, 0, 200, "This hairpin, made from soulmetal helps to train soulforce to the uttermost limit for novice soul cultivator. \n\nType: Jewelry (Hairpin) \nBase value: 200","Hairpin");
		public const FIRECRO:HeadJewelry = new HeadJewelry("FireCro", "Fire Crown", "crown of fire protection", "an enchanted crown of fire protection", MODIFIER_FIRE_R, 20, 3200, "This crown is topped with ruby gemstones. It is said that this will make you protected from fire. \n\nType: Jewelry (Crown) \nBase value: 3,200 \nSpecial: Increases fire resistance by 20%.","Crown");
		public const ICECROW:HeadJewelry = new HeadJewelry("IceCrow", "Ice Crown", "crown of ice protection", "an enchanted crown of ice protection", MODIFIER_ICE_R, 20, 3200, "This crown is topped with sapphire gemstones. It is said that this will make you protected from ice. \n\nType: Jewelry (Crown) \nBase value: 3,200 \nSpecial: Increases ice resistance by 20%.","Crown");
		public const LIGHCRO:HeadJewelry = new HeadJewelry("LighCro", "Ligh Crown", "crown of lightning protection", "an enchanted crown of lightning protection", MODIFIER_LIGH_R, 20, 3200, "This crown is topped with lapis lazuli gemstones. It is said that this will make you protected from lightning. \n\nType: Jewelry (Crown) \nBase value: 3,200 \nSpecial: Increases lightning resistance by 20%.","Crown");
		public const DARKCRO:HeadJewelry = new HeadJewelry("DarkCro", "Dark Crown", "crown of darkness protection", "an enchanted crown of darkness protection", MODIFIER_DARK_R, 20, 3200, "This crown is topped with onyx gemstones. It is said that this will make you protected from darkness. \n\nType: Jewelry (Crown) \nBase value: 3,200 \nSpecial: Increases darkness resistance by 20%.","Crown");
		public const POISCRO:HeadJewelry = new HeadJewelry("PoisCro", "Pois Crown", "crown of poison protection", "an enchanted crown of poison protection", MODIFIER_POIS_R, 20, 3200, "This crown is topped with pearls. It is said that this will make you protected from poison. \n\nType: Jewelry (Crown) \nBase value: 3,200 \nSpecial: Increases poison resistance by 20%.","Crown");
		public const LUSTCRO:HeadJewelry = new HeadJewelry("LustCro", "Lust Crown", "crown of lust protection", "an enchanted crown of lust protection", MODIFIER_LUST_R, 20, 4800, "This crown is topped with amethyst gemstones. It is said that this will make you protected from lust. \n\nType: Jewelry (Crown) \nBase value: 4,800 \nSpecial: Increases lust resistance by 20%.","Crown");
		public const MAGICRO:HeadJewelry = new HeadJewelry("MagiCro", "Magic Crown", "crown of magic protection", "an enchanted crown of magical protection", MODIFIER_MAGIC_R, 8, 6400, "This crown is topped with pyrite gemstones. It is said that this will make you protected from magic. \n\nType: Jewelry (Crown) \nBase value: 6,400 \nSpecial: Increases magic resistance by 8%.","Crown");
		public const PHYSCRO:HeadJewelry = new HeadJewelry("PhysCro", "Phys Crown", "crown of physical protection", "an enchanted crown of physical protection", MODIFIER_PHYS_R, 12, 6400, "This crown is topped with hematite gemstones. It is said that this will make you protected from physical harm. \n\nType: Jewelry (Crown) \nBase value: 6,400 \nSpecial: Increases physical resistance by 12%.","Crown");
		public const CUNDKIN:HeadJewelry = new HeadJewelry("CUndKing", "CroUndefKing", "Crown of the Undefeated King", "a Crown of the Undefeated King", 0, 0, 6000, "This splendid crown topped with many kinds of gems belonged in the past to the king, which claimed to be undefeated. But then how it get into your hands? \n\nType: Jewelry (Crown) \nBase value: 3,000","Crown");
		//helmet(s) that giving armor and/or mres
		public const CROWINT:CrownOfIntelligence = new CrownOfIntelligence();
		public const CROWLIB:CrownOfLibido = new CrownOfLibido();
		public const CROWSEN:CrownOfSensitivity = new CrownOfSensitivity();
		public const CROWSPE:CrownOfSpeed = new CrownOfSpeed();
		public const CROWSTR:CrownOfStrength = new CrownOfStrength();
		public const CROWTOU:CrownOfToughness = new CrownOfToughness();
		public const CROWWIS:CrownOfWisdom = new CrownOfWisdom();
		public const EZEKIELC:HeadJewelry = new HeadJewelry("EzekielC", "EzekielCrown", "Ezekiel's Crown", "an Ezekiel's Crown", 0, 0, 400, "A crown rumored to be blessed by the Ezekiel himself. Is that real one or just another fake crown merchant sold you? \n\nType: Jewelry (Crown) \nBase value: 400","Crown");
		public const JIANGCT:HeadJewelry = new HeadJewelry("JiangCT", "JiangshiCurseTag", "Jiangshi Curse Tag", "a Jiangshi Curse Tag", 0, 0, 400, "This item controls and alter your bodily function. \n\nType: Helm \nBase value: 200","Helmet");
		
		public function HeadJewelryLib() 
		{
		}
	}
}