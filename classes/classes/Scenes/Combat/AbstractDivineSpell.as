package classes.Scenes.Combat {
public class AbstractDivineSpell extends AbstractSpell {
	
	function AbstractDivineSpell(
			name:String,
			desc:String,
			targetType:int,
			timingType:int,
			tags:/*int*/Array
	) {
		super(name, desc, targetType, timingType, Combat.USEMANA_WHITE, tags);
	}
	
	override public function get category():int {
		return CAT_SPELL_DIVINE;
	}
	
	override public function manaCost():Number {
		return spellCostWhite(baseManaCost);
	}
	
	override protected function usabilityCheck():String {
		var uc:String =  super.usabilityCheck();
		if (uc) return uc;
		
		if(player.cor > 20) {
			return "Your corruption is too high to cast this spell.";
		}
		if (player.lust >= combat.magic.getWhiteMagicLustCap()) {
			return "You are far too aroused to focus on divine magic.";
		}
		
		return "";
	}
	
	
}
}
