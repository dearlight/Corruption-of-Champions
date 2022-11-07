/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class DualDaggers extends Weapon {
		
		public function DualDaggers() 
		{
			super("DDagger","D.Daggers","dual daggers","a dual daggers","stab",3,240,"A pair of small blades.  Preferred weapons for the rogues.", "Dual Small", "Dagger");
		}
		
		override public function canUse():Boolean {
			if (game.player.hasPerk(PerkLib.DualWield)) return super.canUse();
			outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}