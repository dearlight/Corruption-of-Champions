/**
 * ...
 * @author Zevos
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class Wardensblade extends WeaponWithPerk
	{
		
		public function Wardensblade() 
		{
			super("WDBlade", "WardensBlade", "Warden’s blade", "a Warden’s blade", "slash", 15, 1200, "Wrought from alchemy, not the forge, this sword is made from sacred wood and resonates with Yggdrasil’s song.", "Daoist's Focus (+40% Magical Soulskill Power), Body Cultivator's Focus (+40% Physical Soulskill Power),  Blade-Warden (enables Blade Dance soul skill)", PerkLib.DaoistsFocus, 0.4, 0, 0, 0, "", "Sword");
		}

		override public function playerEquip():Weapon {
			while (game.player.hasPerk(PerkLib.BodyCultivatorsFocus)) game.player.removePerk(PerkLib.BodyCultivatorsFocus);
			game.player.createPerk(PerkLib.BodyCultivatorsFocus,0.4,0,0,0);
			while (game.player.hasPerk(PerkLib.BladeWarden)) game.player.removePerk(PerkLib.BladeWarden);
			game.player.createPerk(PerkLib.BladeWarden,0,0,0,0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Weapon {
			while (game.player.hasPerk(PerkLib.BladeWarden)) game.player.removePerk(PerkLib.BladeWarden);
			while (game.player.hasPerk(PerkLib.BodyCultivatorsFocus)) game.player.removePerk(PerkLib.BodyCultivatorsFocus);
			return super.playerRemove();
		}
	}
}