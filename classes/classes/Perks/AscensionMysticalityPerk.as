package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionMysticalityPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_MYSTICALITY_LEVEL + ") Increases spell effect multiplier by " + params.value1 * 10 + "% multiplicatively.";
		}

		public function AscensionMysticalityPerk() 
		{
			super("Ascension: Mysticality", "Ascension: Mysticality", "", "Increases spell effect multiplier by 10% per level, multiplicatively.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}		
	}

}