/**
 * Created by Kitteh6660 on 01.29.15.
 */
package classes.Items 
{
	/**
	 * ...
	 * @author Kitteh6660
	 */
	import classes.ItemType;
	import classes.PerkLib;
	import classes.Player;
	import classes.Scenes.SceneLib;
	import classes.GlobalFlags.kFLAGS
	
public class Shield extends Useable //Equipable
	{
		private var _block:Number;
		private var _perk:String;
		private var _name:String;
		
		public function Shield(id:String, shortName:String, name:String, longName:String, block:Number, value:Number = 0, description:String = null, perk:String = "") {
			super(id, shortName, longName, value, description);
			this._name = name;
			this._block = block;
			this._perk = perk;
		}
		
		public function get block():Number { return _block; }
		
		public function get perk():String { return _perk; }
		
		public function get name():String { return _name; }
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Shield";
            if (perk != "") desc += " (" + perk + ")";
			//Block Rating
			desc += "\nBlock: " + String(block);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
		}
		
		override public function canUse():Boolean {
			if (game.player.weaponRangePerk == "Dual Firearms") {
				outputText("Your current range weapons requires two hands. Unequip your current range weapons or switch to one-handed before equipping this shield. ");
				return false;
			}
			else if (game.player.weaponRangePerk == "2H Firearm") {
				outputText("Your current range weapon requires two hands. Unequip your current range weapon or switch to one-handed before equipping this shield. ");
				return false;
			}
			else if ((game.player.weaponSpecials("Large") && !game.player.hasPerk(PerkLib.GigantGrip)) || game.player.weaponSpecials("Massive") || game.player.weaponSpecials("Dual Small") || game.player.weaponSpecials("Dual") || game.player.weaponSpecials("Dual Large") || game.player.weaponName == "Daisho") {
				outputText("Your current melee weapon requires two hands. Unequip your current melee weapon or switch to one-handed before equipping this shield. ");
				return false;
			}
			else if (game.player.hasPerk(PerkLib.Rigidity)) {
				outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
				return false;
			}
			else if (game.player.shieldPerk == "Massive" && !game.player.hasPerk(PerkLib.GigantGrip)) {
				outputText("This shield requires use of both hands. Unequip your current melee weapon before equipping it. ");
				return false;
			}
			return true;
		}
		
		public function playerEquip():Shield { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			if ((perk == "Massive" && game.player.weapon != WeaponLib.FISTS && !game.player.hasPerk(PerkLib.GigantGrip))
				|| (game.player.weaponSpecials("Large") && !game.player.hasPerk(PerkLib.GigantGrip))
				|| game.player.weaponSpecials("Massive")
				|| game.player.weaponSpecials("Dual Small")
				|| game.player.weaponSpecials("Dual")
				|| game.player.weaponSpecials("Dual Large")) {
				SceneLib.inventory.unequipWeapon();
			}
			if (game.player.weaponRangePerk == "Dual Firearms" || game.player.weaponRangePerk == "2H Firearm") SceneLib.inventory.unequipWeaponRange();
			return this;
		}
		
		public function playerRemove():Shield { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally
		
	}
}