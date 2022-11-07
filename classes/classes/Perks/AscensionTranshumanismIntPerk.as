/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionTranshumanismIntPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_INT_LEVEL + ") Increases maximum base/core Int by " + params.value1 * 16 + ".";
		}
		
		public function AscensionTranshumanismIntPerk() 
		{
			super("Ascension: Transhumanism (Int)", "Ascension: Transhumanism (Int)", "", "Increases maximum base/core Int by 16.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}

}