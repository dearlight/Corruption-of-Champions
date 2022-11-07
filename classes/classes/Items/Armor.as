/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.PerkLib;

	public class Armor extends Useable //Equipable
	{
		private var _def:Number;
		private var _mdef:Number;
		private var _perk:String;
		private var _name:String;
		private var _supportsBulge:Boolean;
		private var _supportsUndergarment:Boolean;
		
		public function Armor(id:String, shortName:String, name:String, longName:String, def:Number, mdef:Number, value:Number = 0, description:String = null, perk:String = "", supportsBulge:Boolean = false, supportsUndergarment:Boolean = true) {
			super(id, shortName, longName, value, description);
			this._name = name;
			this._def = def;
			this._mdef = mdef;
			this._perk = perk;
			_supportsBulge = supportsBulge;
			_supportsUndergarment = supportsUndergarment;
		}
		
		public function get def():Number { return _def; }
		
		public function get mdef():Number { return _mdef; }
		
		public function get perk():String { return _perk; }
		
		public function get name():String { return _name; }
		
		public function get supportsBulge():Boolean { return _supportsBulge && game.player.modArmorName == ""; }
			//For most clothes if the modArmorName is set then it's Exgartuan's doing. The comfortable clothes are the exception, they override this function.
		
		public function get supportsUndergarment():Boolean { return _supportsUndergarment; }
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: ";
			if (name.indexOf("armor") >= 0 || name.indexOf("armour") >= 0 || name.indexOf("chain") >= 0 || name.indexOf("mail") >= 0 || name.indexOf("plates") >= 0) {
				desc += "Armor ";
				if (perk == "Light" || perk == "Medium") {
					desc += "(Light)";
				}
				else if (perk == "Medium") desc += "(Medium)";
				else if (perk == "Heavy") desc += "(Heavy)";
				else if (perk == "Light Ayo") desc += "(Light Ayo)";
				else if (perk == "Heavy Ayo") desc += "(Heavy Ayo)";
				else if (perk == "Ultra Heavy Ayo") desc += "(Ultra Heavy Ayo)";
			}
			else desc += "Clothing ";
			//Defense
			if (def > 0) desc += "\nDefense (P): " + String(def);
			if (mdef > 0) desc += "\nDefense (M): " + String(mdef);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		override public function canUse():Boolean {
			if (!this.supportsUndergarment && (game.player.upperGarment != UndergarmentLib.NOTHING || game.player.lowerGarment != UndergarmentLib.NOTHING)) {
				var output:String = "";
				var wornUpper:Boolean = false;
				output += "It would be awkward to put on " + longName + " when you're currently wearing ";
				if (game.player.upperGarment != UndergarmentLib.NOTHING) {
					output += game.player.upperGarment.longName;
					wornUpper = true;
				}
				if (game.player.lowerGarment != UndergarmentLib.NOTHING) {
					if (wornUpper) {
						output += " and ";
					}
					output += game.player.lowerGarment.longName;
				}
				output += ". You should consider removing them. You put it back into your inventory.";
				outputText(output);
				return false;
			}
			else if (game.player.hasPerk(PerkLib.Rigidity)) {
				outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
				return false;
			}
			return super.canUse();
		}

		override public function useText():void {
			outputText("You equip " + longName + ".  ");
		}
		
		public function playerEquip():Armor { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			game.player.addToWornClothesArray(this);
			return this;
		}
		
		public function playerRemove():Armor { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			game.player.removePerk(PerkLib.BulgeArmor); //Exgartuan check
			if (game.player.modArmorName.length > 0) game.player.modArmorName = "";
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally
	}
}