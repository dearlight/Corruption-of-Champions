/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionTranshumanismTouPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_TOU_LEVEL + ") Increases maximum base/core Tou by " + params.value1 * 16 + ".";
		}
		
		public function AscensionTranshumanismTouPerk() 
		{
			super("Ascension: Transhumanism (Tou)", "Ascension: Transhumanism (Tou)", "", "Increases maximum base/core Tou by 16.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}

}