/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionBloodlustPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_BLOODLUST_LEVEL + ") Increases range physical attacks multiplier by " + params.value1 * 10 + "% multiplicatively.";
		}
		
		public function AscensionBloodlustPerk() 
		{
			super("Ascension: Bloodlust", "Ascension: Bloodlust", "", "Increases range physical attacks multiplier by 10% per level, multiplicatively.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}		
	}

}