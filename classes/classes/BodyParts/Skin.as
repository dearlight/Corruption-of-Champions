package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;

/**
 * Container class for the players skin
 *
 * * character has two layer of skin: base and ~~cover~~ coat
 * each layer has: `type`, `tone`, `adj` (optional adjective), and `desc` (overrides default noun for type)
 * a **coverage** parameter with the rance:
 * `(0) COVERAGE_NONE` : coat layer is non-existant
 * `(1) COVERAGE_LOW` : coat layer exists, but its descriptions appear only when explicitly called
 * `(2) COVERAGE_MEDIUM` : coat layer exists, descriptions use mixed "[base] and [skin coat]", can explicitly check either
 * `(3) COVERAGE_HIGH` : coat layer exists and is used as a default layer when describing skin; base description appear only when explicitly called
 * `(4) COVERAGE_COMPLETE` : same as COVERAGE_HIGH; intended to be used when even face is fully coverred
 * tattoos should be moved to body part-level as patterns
 *
 * @since December 27, 2016
 * @author Stadler76, aimozg
 */
public class Skin extends SaveableBodyPart {

  public static const COVERAGE_NONE:int     = 0;
	public static const COVERAGE_LOW:int      = 1;
	public static const COVERAGE_MEDIUM:int   = 2;
	public static const COVERAGE_HIGH:int     = 3;
	public static const COVERAGE_COMPLETE:int = 4;


	/**
	 * Entry properties:
	 * - value: numerical id (0, 1, 2)
	 * - id: name of the constant ("PLAIN", "FUR", "SCALES")
	 * - name: human-readable default name, ("skin", "fur", "scales")
	 * - plural: is name a plural noun phrase (false, false, true)
	 * - base: is valid base layer type (true, false, false)
	 * - coat: is valid coat layer type (false, true, true)
	 */
	public static var SkinTypes:/*EnumValue*/Array = [];

	public static const PLAIN: int = 0;
	EnumValue.add(SkinTypes, PLAIN, "PLAIN", {
		name:"skin",
		appearanceDesc: "Your [skin base] has a completely normal texture, at least for your original world.",
		plural: false,
		base:true
	});
	public static const FUR: int = 1;
	EnumValue.add(SkinTypes, FUR, "FUR", {
		name:"fur",
		appearanceDesc: "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
		plural: false,
		coat:true
	});
	public static const SCALES: int = 2;
	EnumValue.add(SkinTypes, SCALES, "SCALES", {
		name:"scales",
		appearanceDesc: "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
		plural: true
	});
	public static const GOO: int = 3;
	EnumValue.add(SkinTypes, GOO, "GOO", {
		name:"skin",
		appearanceDesc: "Your [skin base] is {partiallyOrCompletely} made of [skin coat].",
		plural: false,
		base:true
	});
	public static const UNDEFINED: int = 4;//[Deprecated] Silently discarded upon loading save
	public static const CHITIN: int = 5;
	EnumValue.add(SkinTypes, CHITIN, "CHITIN", {
		name:"chitin",
		appearanceDesc: "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
		plural: false,
		coat:true
	});
	public static const BARK: int = 6;
	EnumValue.add(SkinTypes, BARK, "BARK", {
		name:"bark",
		appearanceDesc: "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
		plural: false,
		coat:true
	});
	public static const STONE: int = 7;
	EnumValue.add(SkinTypes, STONE, "STONE", {
		name:"stone",
		appearanceDesc: "Your [skin base] is completely made of [gargoylematerial].",
		plural: false,
		base:true
	});
	public static const TATTOED: int = 8; // [Deprecated] Replaced on load with PLAIN + pattern
	public static const AQUA_SCALES: int = 9;
	EnumValue.add(SkinTypes, AQUA_SCALES, "AQUA_SCALES", {
		name:"scales",
		appearanceDesc: "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
		plural: true,
		coat:true
	});
	public static const PARTIAL_FUR: int = 10; // [Deprecated] Replaced on load with PLAIN + FUR
	public static const PARTIAL_SCALES: int = 11; // [Deprecated] Replaced on load with PLAIN + SCALES
	public static const PARTIAL_CHITIN: int = 12; // [Deprecated] Replaced on load with PLAIN + CHITIN
	public static const PARTIAL_BARK: int = 13; // [Deprecated] Replaced on load with PLAIN + BARK
	public static const DRAGON_SCALES: int = 14;
	EnumValue.add(SkinTypes, DRAGON_SCALES, "DRAGON_SCALES", {
		name:"dragon scales",
		appearanceDesc: "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
		plural: false,
		coat:true
	});
	public static const MOSS: int = 15;
	EnumValue.add(SkinTypes, MOSS, "MOSS", {
		name:"moss",
		appearanceDesc: "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
		plural: false,
		coat:true
	});
	public static const PARTIAL_DRAGON_SCALES: int = 16; // [Deprecated] Replaced on load with PLAIN + DRAGON_SCALES
	public static const PARTIAL_STONE: int = 17; // [Deprecated] Replaced on load with PLAIN + STONE
	public static const PARTIAL_AQUA_SCALES: int = 18; // [Deprecated] Replaced on load with PLAIN + AQUA_SCALES
	public static const AQUA_RUBBER_LIKE: int = 19;
	EnumValue.add(SkinTypes, AQUA_RUBBER_LIKE, "AQUA_RUBBER_LIKE", {
		name:"slippery rubber-like skin",
		appearanceDesc: "Your [skin base] has a rubber-like texture.",
		plural: false,
		base:true
	});
	public static const TATTOED_ONI: int = 20; // [Deprecated] Replaced on load with PLAIN + pattern
	public static const FEATHER: int = 21;
	EnumValue.add(SkinTypes, FEATHER, "FEATHER", {
		name:"feather",
		appearanceDesc: "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
		plural: false,
		base:true
	});
	public static const TRANSPARENT: int = 22;
	EnumValue.add(SkinTypes, TRANSPARENT, "TRANSPARENT", {
		name:"transparent",
		appearanceDesc: "Your [skin base] is completely transparent, like a ghost's.",
		plural: false,
		base:true
	});

	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "MAGICAL_TATTOO")
	 * - name: human-readable default name, ("none", "magical tattoo")
	 * - base: valid pattern for base layer
	 * - coat: valid pattern for coat layer
	 */
	public static var PatternTypes:/*EnumValue*/Array = [];

	public static const PATTERN_NONE: int = 0;
	EnumValue.add(PatternTypes, PATTERN_NONE, "NONE", {
		name:"none",
		appearanceDesc: "",
		base:true,
		coat:true
	});
	public static const PATTERN_MAGICAL_TATTOO: int = 1;
	EnumValue.add(PatternTypes, PATTERN_MAGICAL_TATTOO, "MAGICAL_TATTOO", {
		name:"magical tattoo",
		appearanceDesc: "Your body is covered with runic tattoos.",
		base:true
	});
	public static const PATTERN_ORCA_UNDERBODY: int = 2;
	EnumValue.add(PatternTypes, PATTERN_ORCA_UNDERBODY, "ORCA_UNDERBODY", {
		name:"orca underbody",
		appearanceDesc: "A [skin color2] underbelly runs on the underside of your limbs bearing a glossy shine, similar to that of an orca.",
		base:true
	});
	public static const PATTERN_BEE_STRIPES: int = 3;
	EnumValue.add(PatternTypes, PATTERN_BEE_STRIPES, "BEE_STRIPES", {
		name:"bee stripes",
		appearanceDesc: "You have [skin color] [skin base] covered by a bee-like [skin color2] stripe pattern.",
		coat:true
	});
	public static const PATTERN_TIGER_STRIPES: int = 4;
	EnumValue.add(PatternTypes, PATTERN_TIGER_STRIPES, "TIGER_STRIPES", {
		name:"tiger stripes",
		appearanceDesc: "You have [skin color] [skin base] covered by a tiger-like [skin color2] stripe pattern.",
		coat:true
	});
	public static const PATTERN_BATTLE_TATTOO: int = 5;
	EnumValue.add(PatternTypes, PATTERN_BATTLE_TATTOO, "BATTLE_TATTOO", {
		name:"battle tattoo",
		appearanceDesc: "Your body is covered with battle tattoos.",
		base:true
	});
	public static const PATTERN_SPOTTED: int = 6;
	EnumValue.add(PatternTypes, PATTERN_SPOTTED, "SPOTTED", {
		name:"spotted",
		appearanceDesc: "You have many [skin color2] spots around your [skin color] fur.",
		coat:true
	});
	public static const PATTERN_LIGHTNING_SHAPED_TATTOO: int = 7;
	EnumValue.add(PatternTypes, PATTERN_LIGHTNING_SHAPED_TATTOO, "LIGHTNING_SHAPED_TATTOO", {
		name:"lightning shaped tattoo",
		appearanceDesc: "Your body is covered with glowing lightning tattoos.",
		base:true
	});
	public static const PATTERN_RED_PANDA_UNDERBODY: int = 8;
	EnumValue.add(PatternTypes, PATTERN_RED_PANDA_UNDERBODY, "RED_PANDA_UNDERBODY", {
		name:"red panda underbody",
		appearanceDesc: "You have an underbelly colored [skin color2].",
		coat:true
	});
	public static const PATTERN_SCAR_SHAPED_TATTOO: int = 9;
	EnumValue.add(PatternTypes, PATTERN_SCAR_SHAPED_TATTOO, "SCAR_SHAPED_TATTOO", {
		name:"scar shaped tattoo",
		appearanceDesc: "Your body is covered with scar-shaped tattoos.",
		base:true
	});
	public static const PATTERN_WHITE_BLACK_VEINS: int = 10;
	EnumValue.add(PatternTypes, PATTERN_WHITE_BLACK_VEINS, "WHITE_BLACK_VEINS", {
		name:"white and black veins",
		appearanceDesc: "Many [skin color2] veins are clearly visible on your [skin base] body.",
		base:true
	});
	public static const PATTERN_VENOMOUS_MARKINGS: int = 11;
	EnumValue.add(PatternTypes, PATTERN_VENOMOUS_MARKINGS, "VENOMOUS_MARKINGS", {
		name:"venomous markings",
		appearanceDesc: "Your skin is covered in intricate purple designs which pump venom alongside their paths.",
		base:true
	});
	public static const PATTERN_USHI_ONI_TATTOO: int = 12;
	EnumValue.add(PatternTypes, PATTERN_USHI_ONI_TATTOO, "USHI_ONI_TATTOO", {
		name:"ushi-oni tattoo",
		appearanceDesc: "You have strange ushi-oni tattoos on your belly, chest, breasts, shoulders and even face; some are like a black sheen plate, while others are just fur.",
		base:true
	});
	public static const PATTERN_SCAR_WINDSWEPT: int = 13;
	EnumValue.add(PatternTypes, PATTERN_SCAR_WINDSWEPT, "SCAR_WINDSWEPT", {
		name:"windswept scars",
		appearanceDesc: "Your body is covered with scars as if your skin was cut in various place by a windstorm",
		base:true
	});
	public static const PATTERN_OIL: int = 14;
	EnumValue.add(PatternTypes, PATTERN_OIL, "OIL", {
		name:"oily skin",
		appearanceDesc: "Your body is dripping with oily black fluids.",
		base:true
	});
	public static const PATTERN_SEA_DRAGON_UNDERBODY: int = 15;
	EnumValue.add(PatternTypes, PATTERN_SEA_DRAGON_UNDERBODY, "SEA_DRAGON_UNDERBODY", {
		name:"sea dragon underbody",
		appearanceDesc: "An underbelly colored [skin color2] runs on the underside of your limbs bearing a glossy shine, on top of being lined up with bioluminescent dots like those of a deep sea fish.",
		base:true
	});
	// Don't forget to add new types in DebugMenu.as lists SKIN_BASE_TYPES or SKIN_COAT_TYPES

	public var base:SkinLayer;
	public var coat:SkinLayer;
	private var _coverage:int = COVERAGE_NONE;

	public function Skin(creature:Creature) {
		super(creature, "skin", ["coverage"]);
		base = new SkinLayer(this);
		coat = new SkinLayer(this);
		addPublicJsonables(["base", "coat"]);
	}

	[Deprecated(replacement="describe('coat')")]
	public function skinFurScales():String {
		return describe('coat');
	}
	public function get coverage():int {
		return _coverage;
	}
	public function set coverage(value:int):void {
		_coverage = boundInt(COVERAGE_NONE, value, COVERAGE_COMPLETE);
	}
	public function get tone():String {
		return color;
	}
	public function get color():String {
		return skinValue(base.color, coat.color);
	}
	public function get color2():String {
		return skinValue(base.color2, coat.color2);
	}
	public function get desc():String {
		return skinValue(base.desc, coat.desc);
	}
	public function get adj():String {
		return skinValue(base.adj, coat.adj);
	}
	public function get pattern():int {
		if (coverage >= COVERAGE_NONE && coat.pattern != PATTERN_NONE) return coat.pattern;
		return base.pattern;
	}
	/**
	 * Returns `s` (default "is") if the skin main layer noun is singular (skin,fur,chitin)
	 * and `p` (default "are") if plural (scales)
	 */
	public function isAre(s:String = "is", p:String = "are"):String {
		return skinValue(base.isAre(s, p), coat.isAre(s, p));
	}
	override public function get type():int {
		if (coverage > COVERAGE_NONE) return coat.type;
		return base.type;
	}

    //used to determine default coat color - 
    public function isHairy():Boolean {
        return (type == FUR || type == MOSS || type == FEATHER);
    }

	/**
	 * Checks both layers against property set
	 * @param p {color, type, adj, desc}
	 * @return this.base, this.coat, or null
	 */
	public function findLayer(p:Object):SkinLayer {
		if (coverage < COVERAGE_COMPLETE && base.checkProps(p)) return base;
		if (coverage > COVERAGE_NONE && coat.checkProps(p)) return coat;
		return null;
	}
    
	public function growCoat(type:int,options:Object=null,coverage:int=COVERAGE_HIGH):SkinLayer {
		this.coverage = coverage;
		this.coat.type = type;
        if (!this.coat.color) {
            if (isHairy()) //select default color
		        this.coat.color = creature.hairColor;
            else
                this.coat.color = this.base.color;
        }
		if (options) this.coat.setProps(options);
		return this.coat;
	}
	/**
	 * @param options = {color,adj,desc}
	 */
	public function growFur(options:Object=null,coverage:int=COVERAGE_HIGH):SkinLayer {
		this.coverage = coverage;
		this.coat.setProps({color: creature.hairColor, type: FUR});
		if (options) this.coat.setProps(options);
		return this.coat;
	}
	/**
	 * @param baseOptions = {color,adj,desc,type}
	 */
	public function setBaseOnly(baseOptions:Object =null):void {
        //mainly workaround to fix *something* setting the skin desc forever. Fuck.
        //clear coverage. Nobody needs its type, color
		this.coverage = Skin.COVERAGE_NONE;
        coat.restore(true); //restore, keep color for parts
		if (baseOptions) this.base.setAllProps(baseOptions);
	}
	/**
	 * @param layer 'base','coat','skin' (both layer if MEDIUM, else major),'full' (both layers if present)
	 * @return
	 */
	public function describe(layer:String = 'skin', noAdj:Boolean = false, noTone:Boolean = false):String {
		var s_base:String = base.describe(noAdj, noTone);
		var s_coat:String = coat.describe(noAdj, noTone);
		switch (coverage) {
			case COVERAGE_NONE:
				return s_base;
			case COVERAGE_LOW:
				switch (layer) {
					case 'coat':
						return s_coat;
					case 'full':
						return s_base + " with patches of " + s_coat;
					case 'skin':
					case 'base':
					default:
						return s_base;
				}
				break;
			case COVERAGE_MEDIUM:
				switch (layer) {
					case 'coat':
						return s_coat;
					case 'full':
					case 'skin':
						return s_base + " and " + s_coat;
					case 'base':
					default:
						return s_base;
				}
				break;
			case COVERAGE_HIGH:
				switch (layer) {
					case 'base':
						return s_base;
					case 'full':
						return s_base + " under " + s_coat;
					case 'skin':
					case 'coat':
					default:
						return s_coat;
				}
				break;
			case COVERAGE_COMPLETE:
				switch (layer) {
					case 'base':
						return s_base;
					case 'full':
						return s_base + " under " + s_coat;
					case 'skin':
					case 'coat':
					default:
						return s_coat;
				}
				break;
			default:
				return s_coat;
		}
	}
	override public function descriptionFull():String {
		return describe("full");
	}
	public function hasAny(...types:Array):Boolean {
		if (types.length === 1 && types[0] is Array) types = types[0];
		return (coverage < COVERAGE_COMPLETE && base.isAny(types)) ||
			   (coverage > COVERAGE_NONE && coat.isAny(types));
	}
	public function isCoverLowMid():Boolean {
		return coverage > COVERAGE_NONE && coverage < COVERAGE_HIGH;
	}
	public function coatType():int {
		return hasCoat() ? coat.type : -1;
	}
	public function baseType():int {
		return base.type;
	}
	public function hasCoat():Boolean {
		return coverage > COVERAGE_NONE && coverage <= COVERAGE_COMPLETE;
	}
	public function hasFullCoat():Boolean {
		return coverage >= COVERAGE_HIGH && coverage <= COVERAGE_COMPLETE;
	}
	public function hasFullCoatOfType(...types:Array):Boolean {
		return hasFullCoat() && coat.isAny(types);
	}
	public function hasCoatOfType(...types:Array):Boolean {
		return hasCoat() && coat.isAny(types);
	}
	public function hasPartialCoat():Boolean {
		return coverage == COVERAGE_LOW;
	}
	public function hasPartialCoatOfType(coat_type:int):Boolean {
		return coverage == COVERAGE_LOW && coat.type == coat_type;
	}
	public function hasFur():Boolean {
		return hasCoatOfType(FUR);
	}
	public function get fur():SkinLayer {
		return hasFur() ? coat : null;
	}
	public function hasChitin():Boolean {
		return hasCoatOfType(CHITIN);
	}
	public function hasScales():Boolean {
		return hasCoatOfType(SCALES, AQUA_SCALES, DRAGON_SCALES);
	}
	public function hasReptileScales():Boolean {
		return hasCoatOfType(SCALES, DRAGON_SCALES);
	}
	public function hasDragonScales():Boolean {
		return hasCoatOfType(DRAGON_SCALES);
	}
	public function hasLizardScales():Boolean {
		return hasCoatOfType(SCALES);
	}
	public function hasNonLizardScales():Boolean {
		return hasScales() && !hasLizardScales();
	}
	public function hasBark():Boolean {
		return coat.isAny(BARK);
	}
	public function hasGooSkin():Boolean {
		return base.isAny(GOO);
	}
	public function hasRubberSkin():Boolean {
		return base.isAny(AQUA_RUBBER_LIKE);
	}
	public function hasGhostSkin():Boolean {
		return base.isAny(TRANSPARENT);
	}
	public function hasFeather():Boolean {
		return coat.isAny(FEATHER);
	}
	public function hasMostlyPlainSkin():Boolean {
		return coverage <= COVERAGE_LOW && base.type == PLAIN;
	}
	public function hasPlainSkinOnly():Boolean {
		return coverage == COVERAGE_NONE && base.type == PLAIN;
	}
	public function hasBaseOnly(baseType:int):Boolean {
		return coverage == COVERAGE_NONE && base.type == baseType;
	}
	public function hasPlainSkin():Boolean {
		return coverage < COVERAGE_COMPLETE && base.type == PLAIN;
	}
	public function hasNoPattern():Boolean {
		return base.pattern == PATTERN_NONE;
	}
	public function hasMagicalTattoo():Boolean {
		return base.pattern == PATTERN_MAGICAL_TATTOO;
	}
	public function hasBattleTattoo():Boolean {
		return base.pattern == PATTERN_BATTLE_TATTOO;
	}
	public function hasLightningShapedTattoo():Boolean {
		return base.pattern == PATTERN_LIGHTNING_SHAPED_TATTOO;
	}
	public function hasWindSweptScars():Boolean {
		return base.pattern == PATTERN_SCAR_WINDSWEPT;
	}
	public function hasOilySkin():Boolean {
		return base.pattern == PATTERN_OIL;
	}
	public function hasScarShapedTattoo():Boolean {
		return base.pattern == PATTERN_SCAR_SHAPED_TATTOO;
	}
	public function hasVenomousMarking():Boolean {
		return base.pattern == PATTERN_VENOMOUS_MARKINGS;
	}
	public function hasWhiteBlackVeins():Boolean {
		return base.pattern == PATTERN_WHITE_BLACK_VEINS;
	}
	public function hasUshiOniTattoo():Boolean {
		return base.pattern == PATTERN_USHI_ONI_TATTOO;
	}
	override public function restore(keepTone:Boolean = true):void {
		coverage = COVERAGE_NONE;
		base.restore(keepTone);
		coat.restore(keepTone);
	}
	override public function setProps(p:Object):void {
		super.setProps(p);
		if ("base" in p) base.setProps(p.base);
		if ("coat" in p) base.setProps(p.coat);
	}
	private function skinValue(inBase:String, inCoat:String):String {
		switch (coverage) {
			case COVERAGE_NONE:
			case COVERAGE_LOW:
				return inBase;
			case COVERAGE_MEDIUM:
			case COVERAGE_HIGH:
			case COVERAGE_COMPLETE:
			default:
				return inCoat;
		}
	}
	//noinspection JSDeprecatedSymbols
	private static const PARTIAL_TO_FULL:Object            = createMapFromPairs([
		[PARTIAL_CHITIN, CHITIN],
		[PARTIAL_SCALES, SCALES],
		[PARTIAL_FUR, FUR],
		[PARTIAL_BARK, BARK],
		[PARTIAL_AQUA_SCALES, AQUA_SCALES],
		[PARTIAL_DRAGON_SCALES, DRAGON_SCALES],
		[PARTIAL_STONE, PARTIAL_STONE]
	]);
	private static const TYPE_TO_BASE_COVERAGE_COAT:Object = multipleMapsFromPairs([
		[PLAIN,
		 PLAIN, COVERAGE_NONE, 0],
		[FUR,
		 PLAIN, COVERAGE_HIGH, FUR],
		[SCALES,
		 PLAIN, COVERAGE_HIGH, SCALES],
		[GOO,
		 GOO, COVERAGE_NONE, 0],
		[UNDEFINED,
		 PLAIN, COVERAGE_NONE, 0],
		[CHITIN,
		 PLAIN, COVERAGE_HIGH, CHITIN],
		[BARK,
		 PLAIN, COVERAGE_HIGH, BARK],
		[STONE,
		 STONE, COVERAGE_NONE, 0],
		[TATTOED,
		 PLAIN, COVERAGE_NONE, 0],
		[AQUA_SCALES,
		 PLAIN, COVERAGE_HIGH, AQUA_SCALES],
		[PARTIAL_FUR,
		 PLAIN, COVERAGE_LOW, FUR],
		[PARTIAL_SCALES,
		 PLAIN, COVERAGE_LOW, SCALES],
		[PARTIAL_CHITIN,
		 PLAIN, COVERAGE_LOW, CHITIN],
		[PARTIAL_BARK,
		 PLAIN, COVERAGE_LOW, BARK],
		[DRAGON_SCALES,
		 PLAIN, COVERAGE_HIGH, DRAGON_SCALES],
		[MOSS,
		 PLAIN, COVERAGE_HIGH, MOSS],
		[PARTIAL_DRAGON_SCALES,
		 PLAIN, COVERAGE_LOW, DRAGON_SCALES],
		[PARTIAL_STONE,
		 PLAIN, COVERAGE_LOW, STONE],
		[PARTIAL_AQUA_SCALES,
		 PLAIN, COVERAGE_LOW, AQUA_SCALES],
		[AQUA_RUBBER_LIKE,
		 PLAIN, COVERAGE_NONE, 0],
		[TATTOED_ONI,
		 PLAIN, COVERAGE_NONE, 0],
		[FEATHER,
		 PLAIN, COVERAGE_HIGH, FEATHER],
		[TRANSPARENT,
		 TRANSPARENT, COVERAGE_NONE, 0],
	]);
	private static const TYPE_TO_BASE:Object               = TYPE_TO_BASE_COVERAGE_COAT[0];
	private static const TYPE_TO_COVERAGE:Object           = TYPE_TO_BASE_COVERAGE_COAT[1];
	private static const TYPE_TO_COAT:Object               = TYPE_TO_BASE_COVERAGE_COAT[2];
	[Deprecated]
	public override function set type(value:int):void {
		coverage  = TYPE_TO_COVERAGE[value];
		base.type = TYPE_TO_BASE[value];
		coat.type = TYPE_TO_COAT[value];
		if (value == TATTOED) {
			base.pattern = PATTERN_MAGICAL_TATTOO;
			base.adj = "tattooed";
		} else if (value == AQUA_RUBBER_LIKE) {
			base.adj = "slippery rubber-like";
		} else if (value == TATTOED_ONI) {
			base.pattern = PATTERN_BATTLE_TATTOO;
			base.adj = "battle tattooed";
		}
	}
	override protected function loadFromOldSave(savedata:Object):void {
		//Convert from old skinDesc to new skinAdj + skinDesc!
		var type:int = intOr(savedata.skinType, PLAIN);
		//noinspection JSDeprecatedSymbols
		if (type === UNDEFINED) type = PLAIN;
		var desc:String = stringOr(savedata.skinDesc, "");
		var adj:String  = stringOr(savedata.skinAdj, "");
		for each (var legacyAdj:String in ["smooth", "thick", "rubber", "latex", "slimey"]) {
			if (desc.indexOf(legacyAdj) != -1) {
				adj = legacyAdj;
				if (type == FUR) {
					desc = "fur";
				} else if (type == GOO) {
					desc = "goo";
				} else if ([
							SCALES,
							AQUA_SCALES,
							DRAGON_SCALES
						   ].indexOf(type) >= 0) {
					desc = "scales";
				} else {
					desc = "skin";
				}
			}
		}
		var tone:String        = stringOr(savedata.skinTone, "albino");
		var furColor:String    = stringOr(savedata.furColor, stringOr(savedata.hairColor, ""));
		var chitinColor:String = stringOr(savedata.chitinColor, "");
		var scalesColor:String = stringOr(savedata.scalesColor, "");
		if (furColor === "no") furColor = "";
		if (chitinColor === "no") chitinColor = "";
		if (scalesColor === "no") scalesColor = "";
		//noinspection JSDeprecatedSymbols
		if (InCollection(type, PLAIN, GOO, TATTOED, STONE, SCALES, AQUA_SCALES, PARTIAL_DRAGON_SCALES, AQUA_RUBBER_LIKE, TATTOED_ONI)) {
			coverage   = COVERAGE_NONE;
			base.type  = type;
			base.color = (type == SCALES && scalesColor) ? scalesColor : tone;
			base.adj   = adj;
			base.desc  = desc;
			coat.type  = FUR;
			if (coat.color == "no") coat.color = savedata.hairColor;
		} else {
			coverage = COVERAGE_HIGH;
			if (type in PARTIAL_TO_FULL) {
				coverage = COVERAGE_LOW;
				type     = PARTIAL_TO_FULL[type];
			}
			coat.type  = type;
			coat.adj   = adj;
			coat.desc  = desc;
			base.color = tone;
			if (type === FUR) {
				coat.color = furColor;
			} else if (type === SCALES) {
				coat.color = scalesColor;
			} else if (type === CHITIN) {
				coat.color = chitinColor;
			}
			if (!coat.color) coat.color = furColor || scalesColor || chitinColor || "white";
		}
	}
	override protected function saveToOldSave(savedata:Object):void {
		savedata.skinType    = type;
		savedata.skinDesc    = desc;
		savedata.skinAdj     = adj;
		savedata.skinTone    = tone;
		savedata.furColor    = coat.color;
		savedata.scalesColor = coat.color;
		savedata.chitinColor = coat.color;
	}

	public function get shortName():String {
		return SkinTypes[type].name;
	}

	public static function getSkinAppearanceDescription(creature: *):String {
		const id: int = creature.skin.type;
		return formatDescription((SkinTypes[id].appearanceDescFunc ? SkinTypes[id].appearanceDescFunc(creature) : SkinTypes[id].appearanceDesc) || "", creature);
	}

	public static function getSkinPatternAppearanceDescription(creature: *):String {
		const id: int = creature.skin.base.pattern;

		return formatDescription((PatternTypes[id].appearanceDescFunc ? PatternTypes[id].appearanceDescFunc(creature) : PatternTypes[id].appearanceDesc) || "", creature);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;
		const coveragePattern:RegExp = /{partiallyOrCompletely}/g;

		return desc
			.replace(coveragePattern, creature.skin.coverage > Skin.COVERAGE_MEDIUM ? "completely" : "partially")
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
