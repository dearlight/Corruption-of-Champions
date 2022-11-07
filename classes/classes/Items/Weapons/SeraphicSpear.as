package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class SeraphicSpear extends Weapon
	{
		
		public function SeraphicSpear() 
		{
			super("SeSpear", "Seraph Spear", "seraph spear", "a seraph spear", "piercing stab", 20, 1600,
				"A silvery spear imbued with holy power and decorated with blue sapphire gemstones. Engraved in the handle is an ancient runic spell made to ward evil. This blessed equipment seems to slowly heal its wielder’s wounds.",
				"", "Spear"
			);
		}
		override public function get attack():Number {
			var base:int = 0;
			if (game.player.spe >= 75) base += 3;
			base += (100 - game.player.cor) / 10;
			return (7 + base);
		}
		override public function canUse():Boolean {
			if (game.player.level >= 40) return super.canUse();
			outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
	}

}