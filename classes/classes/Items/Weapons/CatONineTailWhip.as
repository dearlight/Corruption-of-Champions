/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.PerkLib;
	import classes.Player;
	import classes.Items.Weapon;

	public class CatONineTailWhip extends Weapon
	{
		
		public function CatONineTailWhip() 
		{
			super("CNTWhip", "CatONineTailWhip", "Bastet Whip", "a Bastet Whip", "whipping", 27, 1080, "A rope made from unknown magic beast fur that unravelled into three small ropes, each of which is unravelled again designed to whip and cut your foes into submission.", "Large, Whipping, Bleed25", "Whip");
		}
		//przerobić na high grade wrath weapon?
		override public function get attack():Number {
			var boost:int = 0;
			if ((game.player.str + game.player.spe) >= 225) {
				if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 27;
				else boost += 18;
			}
			if ((game.player.str + game.player.spe) >= 100) {
				if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 21;
				else boost += 12;
			}
			if ((game.player.str + game.player.spe) >= 75) {
				if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 15;
				else boost += 6;
			}
            if (((game.player.str + game.player.spe) < 75) && game.player.hasPerk(PerkLib.ArcaneLash)) boost += 9;
			return (9 + boost);
        }
		
		override public function canUse():Boolean {
			if (game.player.hasPerk(PerkLib.GigantGrip)) return super.canUse();
			outputText("You aren't skilled in handling large weapons with one hand yet to effectively use this whip. Unless you want to hurt yourself instead enemies when trying to use it...  ");
			return false;
		}
	}
}