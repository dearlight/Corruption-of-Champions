/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionTranshumanismSpePerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_SPE_LEVEL + ") Increases maximum base/core Spe by " + params.value1 * 16 + ".";
		}
		
		public function AscensionTranshumanismSpePerk() 
		{
			super("Ascension: Transhumanism (Spe)", "Ascension: Transhumanism (Spe)", "", "Increases maximum base/core Spe by 16.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}

}