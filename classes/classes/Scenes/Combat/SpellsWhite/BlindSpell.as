package classes.Scenes.Combat.SpellsWhite {
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.NPCs.Diva;
import classes.Scenes.SceneLib;
import classes.StatusEffects;

public class BlindSpell extends AbstractWhiteSpell{
	public function BlindSpell() {
		super("Blind",
			"Blind is a fairly self-explanatory spell.  It will create a bright flash just in front of the victim's eyes, blinding them for a time.  However if they blink it will be wasted.",
			TARGET_ENEMY,
			TIMING_LASTING,
			[TAG_DEBUFF]);
		baseManaCost = 30;
	}
	
	
	override public function isActive():Boolean {
		return monster.hasStatusEffect(StatusEffects.Blind);
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsBlind);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		var successrate:int = 60;
		successrate -= (player.inte * 0.4);
		if (successrate > 20) successrate = 20;
		if (rand(100) > successrate) {
			if (monster is Lethice && (monster as Lethice).fightPhase == 2) {
				if (display) {
					outputText("You hold your [weapon] aloft and thrust your will forward, causing it to erupt in a blinding flash of light. The demons of the court scream and recoil from the radiant burst, clutching at their eyes and trampling over each other to get back.");
					
					outputText("\n\n<i>\"Damn you, fight!\"</i> Lethice screams, grabbing her whip and lashing out at the back-most demons, driving them forward -- and causing the middle bunch to be crushed between competing forces of retreating demons! <i>\"Fight, or you'll be in the submission tanks for the rest of your miserable lives!\"</i>");
				}
			} else {
				if (display) {
					outputText("You glare at [themonster] and point at [monster him].  A bright flash erupts before [monster him]!\n");
				}
			}
			if (monster is LivingStatue) {
				// noop
			} else if(rand(3) != 0) {
				if (display) {
					outputText(" <b>[Themonster] ");
					if (monster.plural && monster.short != "imp horde") outputText("are blinded!</b>");
					else outputText("is blinded!</b>");
				}
				monster.createStatusEffect(StatusEffects.Blind, 2 + player.inte / 20,0,0,0);
				if(monster is Diva){
					(monster as Diva).handlePlayerSpell("blind");
				} else if(monster.short == "Isabella") {
					if (display) {
						if (SceneLib.isabellaFollowerScene.isabellaAccent()) outputText("\n\n\"<i>Nein! I cannot see!</i>\" cries Isabella.");
						else outputText("\n\n\"<i>No! I cannot see!</i>\" cries Isabella.");
					}
				} else if(monster.short == "Kiha") {
					if (display) {
						outputText("\n\n\"<i>You think blindness will slow me down?  Attacks like that are only effective on those who don't know how to see with their other senses!</i>\" Kiha cries defiantly.");
					}
				} else if(monster.short == "plain girl") {
					if (display) {
						outputText("  Remarkably, it seems as if your spell has had no effect on her, and you nearly get clipped by a roundhouse as you stand, confused. The girl flashes a radiant smile at you, and the battle continues.");
					}
					monster.removeStatusEffect(StatusEffects.Blind);
				}
			}
		} else {
			if (display) {
				outputText(monster.capitalA + monster.short + " blinked!");
			}
		}
	}
}
}
