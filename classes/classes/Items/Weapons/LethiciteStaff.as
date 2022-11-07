/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class LethiciteStaff extends WeaponWithPerk {
		
		public function LethiciteStaff() {
			super("L.Staff", "Lthc. Staff", "lethicite staff", "a lethicite staff", "smack", 14, 1337, "This staff is made of a dark material and seems to tingle to the touch.  The top consists of a glowing lethicite orb.  It once belonged to Lethice who was defeated in your hands.", "Staff", PerkLib.WizardsFocus, 0.8, 0, 0, 0, "", "Staff");
		}
		
		override public function get verb():String { 
			return game.player.hasPerk(PerkLib.StaffChanneling) ? "shot" : "smack";
		}
		
		override public function playerEquip():Weapon {
			while (game.player.hasPerk(PerkLib.WizardsFocus)) game.player.removePerk(PerkLib.WizardsFocus);
			game.player.createPerk(PerkLib.WizardsFocus, 0.8, 0, 0, 0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Weapon {
			while (game.player.hasPerk(PerkLib.WizardsFocus)) game.player.removePerk(PerkLib.WizardsFocus);
			return super.playerRemove();
		}
	}
}