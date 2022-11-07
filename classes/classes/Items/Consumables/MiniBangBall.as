/**
 * ...
 * @author Ormael
 */
package classes.Items.Consumables
{
	import classes.Items.Consumable;
	import classes.PerkLib;
	//import classes.Monster;
	import classes.internals.Utils;

	public final class MiniBangBall extends Consumable {
		
		public function MiniBangBall() {
			super("BangB.", "MiniBangB", "a mini bang ball", 10, "A mini ball-shaped throwing weapon.  Though good for only a single use, it's guaranteed to do super low to very low damage to solo or weak group of enemies if it hits.  Inflicts 120 to 160 base damage.");
		}
		
		override public function canUse():Boolean {
			if (game.inCombat) return true;
			outputText("There's no one to throw it at!");
			return false;
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You toss a mini bangball at your foe");
			if (game.monster.hasPerk(PerkLib.EnemyGroupType) || game.monster.hasPerk(PerkLib.EnemyLargeGroupType)) outputText("s");
			outputText("!  It flies straight and true, almost as if it has a mind of its own as it arcs towards " + game.monster.a + game.monster.short + "!\n");
			if (game.monster.spe - 80 > Utils.rand(100) + 1) { //1% dodge for each point of speed over 80
				outputText("Somehow " + game.monster.a + game.monster.short + "'");
				if (!game.monster.plural) outputText("s");
				outputText(" incredible speed allows " + game.monster.pronoun2 + " to avoid the ball!  The deadly sphere shatters when it impacts something in the distance.");
			}
			else { //Not dodged
				var damage:Number = 120 + Utils.rand(41);
				if (game.monster.hasPerk(PerkLib.EnemyGroupType) || game.monster.hasPerk(PerkLib.EnemyLargeGroupType)) damage *= 5;
				outputText(game.monster.capitalA + game.monster.short + " is hit with the mini bangball!  It breaks apart as it lacerates " + game.monster.pronoun2 + ". <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
				game.monster.HP -= damage;
				if (game.monster.HP < game.monster.minHP()) game.monster.HP = game.monster.minHP() - 1;
			}
			return(false);
		}
	}
}