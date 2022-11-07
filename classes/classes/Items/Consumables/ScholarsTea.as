package classes.Items.Consumables
{
	import classes.Items.Consumable;
	
	/**
	 * Item that increases INT
	 */
	public class ScholarsTea extends Consumable
	{
		private static const ITEM_VALUE:int = 15;
		
		public function ScholarsTea()
		{
			super("Smart T", "Scholars T.", "a cup of scholar's tea", ITEM_VALUE, "This powerful brew supposedly has mind-strengthening effects.");
		}
		
		override public function useItem():Boolean
		{
			player.slimeFeed();
			clearOutput();
			outputText("Following the merchant's instructions, you steep and drink the tea. Its sharp taste fires up your palate and in moments, you find yourself more alert and insightful. As your mind wanders, a creative, if somewhat sordid, story comes to mind. It is a shame that you do not have writing implements as you feel you could make a coin or two off what you have conceived. The strange seller was not lying about the power of the tea.");
			if (rand(3) == 0) outputText(player.modTone(15, 1));
			if (player.inte < 50) player.AlchemyBonus("int",1 + rand(4));
			else if (player.inte < 100) player.AlchemyBonus("int",1 + rand(3));
			else player.AlchemyBonus("int",1 + rand(3));
			player.refillHunger(10);
			
			return false;
		}
	}
}