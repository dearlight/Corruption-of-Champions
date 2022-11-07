﻿package classes.Scenes.Places.Boat{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Ocean.UnderwaterSharkGirl;
import classes.Scenes.Areas.Ocean.UnderwaterTigersharkGirl;
import classes.Scenes.Areas.Ocean.UnderwaterSharkGirlsPack;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

public class SharkGirlScene extends AbstractBoatContent{

		public function SharkGirlScene()
	{
	}

	/*Codex: Shark girls and tiger shark girls

Gender: Mostly female, though there are males and herms. Due to the nature of their conception, the vast majority of tiger sharks are herms.

Height: 5-6 feet tall. Tiger sharks are primarily in the 6 foot region.
Build: Well-toned and athletic.
Skin tone: Grey. Light orange with stripes for tiger sharks.
Hair color: Silver and in rare cases, Black.
Eye color: Red for both species.

Typical dress: Ridiculously skimpy swimwear, which they use to entice victims. Some tiger shark girls will wear grass hula skirts when on land to hide their endowments.

Weaponry: Fangs, tail and their bare hands.
Notable features: Retractable shark teeth, a large fin between their shoulders and a shark tail dangling off of their backsides.

Sexual characteristics: Despite their slutty nature, shark girls have rather modest endowments in comparison to other such creatures; the majority of them are C-cups, D-cups at most. Though, their hips and buttocks are nice and curvy. Tiger shark girls possess wildly varying bustlines that are larger than their 'sisters', and usually are hyper-endowed with male genitalia.

Loot:
Shark Tooth
T.Shark Tooth (Tiger shark girls only)
Slutty Swimwear
L.Draft

History: Before the corruption truly began, the Shark people were a normal fishing community that lived by the lake. They respected and admired marine life so much that they used magic to morph their forms, allowing them to live both under the sea and on dry land. As the demons began to take control, the Shark people retreated into the lake water to avoid the taint. It was only through sheer bad luck that they wound up as they are now; when the factory was constructed, the chemical run-off was funnelled into the lake, causing a drastic change to the mindset of the Shark people and making them near-constantly horny. Those who swam too close to the pollutants found their bodies morphed in unexpected ways, becoming what are now known as tiger shark girls. Even if the factory were to be destroyed, it would take generations for the shark girls to fully lose the effects.

Social Structure: Most shark girls travel in small groups, ruled over by one tiger shark girl. However, there are larger communities that can be found in the lake. Males are generally kept chained up, being abnormally aggressive even for sharks. But as they are more virile and fertile than tiger sharks girls, every once in a while they are unchained to help with reproduction. The Shark people spend most of their time either hunting for food or hunting for sex.

Sex Life: The shark girls treat sex like a game or a sport, constantly battling for dominance against their opponents and using them as sex toys if they win. As they're horny most of the time, shark girls often look for 'playmates', regardless if their victims want to 'play' or not!
----------------------------------
*/
//[Explore Lake]
public function sharkGirlEncounter(exploreLoc:Number = 0):void {
	//Set 'PC met Sharkgirls' for Izma stuff
	if(flags[kFLAGS.IZMA_ENCOUNTER_COUNTER] == 0) flags[kFLAGS.IZMA_ENCOUNTER_COUNTER] = 1;
	if(!player.hasStatusEffect(StatusEffects.SharkGirl)) player.createStatusEffect(StatusEffects.SharkGirl,0,0,0,0);
	else if(player.statusEffectv1(StatusEffects.SharkGirl) >= 7 && player.cockTotal() > 0) {
		spriteSelect(SpriteDb.s_sharkgirl);
		sharkBadEnd();
		return;
	}
	//exploreLoc = 0 for lake, 1 for boat
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	//Rowboat
	if(exploreLoc == 1) {
		outputText("While rowing the boat across the lake you spy a shark fin heading your way.  Worried it might damage the small boat, you hastily row back to shore, jumping out of the boat.  The shark shows no signs of slowing, and the fin disappears just before coming ashore.  ");
	}
	//Lake
	else {
		outputText("You wander around the sandy shores of the lake before raising your eyebrow at a strange sight: A solitary fin, circling around in the water. You take a step back in surprise when the fin suddenly starts barrelling toward the shore at inhuman speeds.  ");
	}
	outputText("A grey blur bursts from the water and lands on the ground a few feet away from you.\n\n");
	outputText("It's a woman – a peculiarly corrupted woman, with shiny grey skin, silver hair, and a fin positioned between her shoulder blades. She's wearing some rather revealing black swimwear. The girl looks up at you and grins widely, showing rows of knife-like teeth. \"<i>Wanna play? Heads up though, I play 'rough'!</i>\"\n\n");
	if (flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] = 1;
		outputText("<b>New codex entry unlocked: Shark-girls & Tigershark-girls!</b>\n\n")
	}
	outputText("You're fighting a shark girl!");
	startCombat(new SharkGirl());
	spriteSelect(SpriteDb.s_sharkgirl);
}

public function oceanSharkGirlEncounter():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	outputText("Your boat is hit from the side and violently rocked, throwing you right into the water! As you look for your opponent you see an indistinct shape doing circle in the distance and closing in on you at high speed until its shape becomes clear, jaw wide with a toothy grin.\n\n");
	if (flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] = 1;
		outputText("<b>New codex entry unlocked: Shark-girls & Tigershark-girls!</b>\n\n")
	}
	outputText("You are under attack by a shark girl!");
	startCombat(new UnderwaterSharkGirl());
	spriteSelect(SpriteDb.s_sharkgirl);
}
public function oceanTigersharkGirlEncounter():void {
	clearOutput();
	spriteSelect(SpriteDb.s_izma);
	outputText("Your boat is grabbed from the side and violently rocked throwing you right into the water! As you look for your opponent you see an indistinct shape doing circle in the distance and closing on you at high speed until its shape becomes clear, jaw wide with a toothy grin.\n\n");
	if (flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] = 1;
		outputText("<b>New codex entry unlocked: Shark-girls & Tigershark-girls!</b>\n\n")
	}
	outputText("You are under attack by a tiger shark girl!");
	startCombat(new UnderwaterTigersharkGirl());
	spriteSelect(SpriteDb.s_izma);
}
public function oceanSharkGirlsPackEncounter():void {
	clearOutput();
	spriteSelect(SpriteDb.s_izma);
	outputText("As you row your boat through this ocean, something feels... off. You're not quite sure how to describe it"+(silly() ? " as a weird music start playing in background similar to \"<i>Dun dun, dun dun, dun dun dun dun</i>\"":"")+". You see several large fins rising out of the water ahead of you and before you can react your boat is hit by a powerful collision, sending you straight into the water. As you look around you see several shark girls as well as their alpha tiger shark circling you, grinning widely with. most likely, very bad intentions in store for you. This is gonna be a hard battle!\n\n");
	if (flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] = 1;
		outputText("<b>New codex entry unlocked: Shark-girls & Tigershark-girls!</b>\n\n")
	}
	outputText("You are under attack by a shark girls pack!");
	startCombat(new UnderwaterSharkGirlsPack());
	spriteSelect(SpriteDb.s_izma);
}

//Victory Sex. Herms should get a choice between the two scenes:
internal function sharkWinChoices():void {
	spriteSelect(SpriteDb.s_sharkgirl);
	//HP Win
	clearOutput();
	if(monster.HP <= monster.minHP()) {
		outputText("The shark-girl falls, clearly defeated.");
	}
	//Lust win
	else {
		outputText("The shark-girl begins masturbating, giving up on dominating you.  The sight is truly entrancing.");
		dynStats("lus", 15);
	}
	if(player.lust >= 33 && player.gender > 0) {
		outputText("  Do you have your way with her or leave?");
        var dildo:Function = (player.hasKeyItem("Deluxe Dildo") >= 0 ? sharkGirlGetsDildoed : null);
		var temp3:Function =null;
		if (player.gender == 1)
			simpleChoices("Use Dick", sharkgirlDickFuck, "Pussy w/69", null, "Dildo Rape", dildo, "", null, "Leave", cleanupAfterCombat);
		else if (player.gender == 2) {
			simpleChoices("Yes", sharkgirlSixtyNine, "", null, "Dildo Rape", dildo, "", null, "Leave", cleanupAfterCombat);
		}
		else if (player.gender == 3) {
			if (player.isNaga())
				simpleChoices("Use Dick", sharkgirlDickFuck, "Pussy Oral", sharkgirlSixtyNine, "Dildo Rape", dildo, "", null, "Leave", cleanupAfterCombat);
			else simpleChoices("Use Dick", sharkgirlDickFuck, "Pussy w/69", sharkgirlSixtyNine, "Dildo Rape", dildo, "", null, "Leave", cleanupAfterCombat);
		}
        SceneLib.uniqueSexScene.pcUSSPreChecksV2(sharkWinChoices2);
	}
	else cleanupAfterCombat();
}
public function sharkWinChoices2():void{
	outputText("  Do you have your way with her or leave?");
       var dildo:Function = (player.hasKeyItem("Deluxe Dildo") >= 0 ? sharkGirlGetsDildoed : null);
	var temp3:Function =null;
	if (player.gender == 1)
		simpleChoices("Use Dick", sharkgirlDickFuck, "Pussy w/69", null, "Dildo Rape", dildo, "", null, "Leave", cleanupAfterCombat);
	else if (player.gender == 2) {
		simpleChoices("Yes", sharkgirlSixtyNine, "", null, "Dildo Rape", dildo, "", null, "Leave", cleanupAfterCombat);
	}
	else if (player.gender == 3) {
		if (player.isNaga())
			simpleChoices("Use Dick", sharkgirlDickFuck, "Pussy Oral", sharkgirlSixtyNine, "Dildo Rape", dildo, "", null, "Leave", cleanupAfterCombat);
		else simpleChoices("Use Dick", sharkgirlDickFuck, "Pussy w/69", sharkgirlSixtyNine, "Dildo Rape", dildo, "", null, "Leave", cleanupAfterCombat);
	}
        SceneLib.uniqueSexScene.pcUSSPreChecksV2(sharkWinChoices2);
}
public function oceanSharkWinChoices():void {
	spriteSelect(SpriteDb.s_sharkgirl);
	clearOutput();
	outputText("The shark girl unable to fight further as she slowly lets the currents carry her. Well, you could have fun with her but are you in the mood to begin with?");
	menu();
	addButton(0, "Leave", cleanupAfterCombat);
	if (player.lust >= 33 && player.gender > 0) {
		if (player.hasCock()) addButton(1, "Fuck Her", sharkgirlOceanDickFuck1);
		if (player.hasVagina()) addButton(2, "Sixty nine", sharkgirlOceanSixtyNine1);
		SceneLib.uniqueSexScene.pcUSSPreChecksV2(oceanSharkWinChoices);
			}
}
public function oceanTigerSharkWinChoices():void {
	spriteSelect(SpriteDb.s_izma);
	clearOutput();
	outputText("The tiger shark girl unable to fight further as she slowly lets the currents carry her. Well, you could have fun with her but are you in the mood to begin with?");
	menu();
	addButton(0, "Leave", cleanupAfterCombat);
	if (player.lust >= 33 && player.gender > 0) {
		if (player.hasCock()) addButton(1, "Fuck Her", sharkgirlOceanDickFuck2);
		if (player.hasVagina()) addButton(2, "Sixty nine", sharkgirlOceanSixtyNine2);
		SceneLib.uniqueSexScene.pcUSSPreChecksV2(oceanTigerSharkWinChoices);
			}
}
public function oceanSharkspackWinChoices():void {
	spriteSelect(SpriteDb.s_izma);
	clearOutput();
	outputText("The shark girl frenzy breaks formation before your might, leaving their weakest member behind. Well, you could have fun with her but are you in the mood to begin with?");
	menu();
	addButton(0, "Leave", cleanupAfterCombat);
	if (player.lust >= 33 && player.gender > 0) {
		if (player.hasCock()) addButton(1, "Fuck Her", sharkgirlOceanDickFuck2);
		if (player.hasVagina()) addButton(2, "Sixty nine", sharkgirlOceanSixtyNine2);
		SceneLib.uniqueSexScene.pcUSSPreChecksV2(oceanSharkspackWinChoices);
			}
}

//Male and Herm:
private function sharkgirlDickFuck():void {
	player.addStatusValue(StatusEffects.SharkGirl,1,1);
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	//Naga get a different version of this scene.
	if(player.isNaga()) {
		var x:Number = player.cockThatFits(monster.analCapacity());
		if(x < 0) x = player.smallestCockIndex();
		//[if(monster.lust >= monster.eMaxLust())
		if(monster.lust >= monster.maxLust()) outputText("You slither towards the furiously masturbating shark-girl. She lies on her back, desperately trying to relieve herself of her lust. She eyes you for a second, but her focus quickly returns to your own sex, moaning and sighing loudly. You admire the scene for a moment, but decide that she must be punished for her attempt to rape you.\n\n");
		else outputText("You slither towards the defeated shark-girl. She lies on her back, clearly weakend and in pain from the fight. You pity the poor girl for a moment, but you quickly remember that she just tried to rape you. Overcome by the need for revenge and the need to sate your lusts, you decide to punish her for her painful advances on you.\n\n");
		outputText("You grab the shark-girl by her hips and lift them up.  Before she can reach out to steady herself, you twist her around and thrust her front side into the ground.  She groans and makes a weak attempt to push herself back up, but her arms quickly give out under her weight and she falls back into the sand.  Your tail deftly snaps out and snatches the bikini she is wearing, and rips it off.  She looks back at you and gives an indignant \"<i>hmph</i>\" before laying her head back down, resigning herself to whatever fate you have planned for her.  Looking down at her pussy, you can see that it's grown moist with anticipation.  You have other plans for her, however, and you coil your tail around hers tightly and grab her hips in your hands.  She yelps in surprise as you lift her lower half up a bit, easily supporting her weight with your tail's considerable strength.  Her feet are still touching the ground, but her legs are not supporting her.  You lift her tail up a bit more, exposing her tight anus.  Your intentions dawn on her quickly, and you see her eyes begin to water.  \"<i>No,</i>\" she begs, \"<i>not like that...</i>\"  The tiniest of sobs escapes her, and you roll your eyes at the pitiful display.  You don't really want to see her cry, so you decide on something of a compromise.\n\n");
		outputText("Her soft crying ceases suspiciously quickly when you push her tail off to the side and uncoil your own, holding her in the same position with your arms. A bit annoyed that you let her manipulate you even after you defeated her, you are determined to take complete charge.  With a grunt you heft her up a bit, and bring the tip of your tail under her and up to her slick pussy.  You slide your scales up and down along her lips, coating your tail in her lubricant. You hear her voice her appreciation loudly, and see a wide smile come to her face.  Too wide, you think.  You continue your stroking as you pull her up, positioning her ass directly in front of your erect member. You quickly work your " + cockDescript(x) + " into her tight anus, and she turns back towards you, yelling in anger and surprise. Your tail quickly pulls away from her dripping pussy, and ignoring her protests, you turn it and thrust deep into her wide cunt.  Her shouting begins to lose coherency and devolves back into loud grunts and moans as pleasure starts to overtake her; her face contorts as she adjusts to the new feelings.  You slam into her ass again and again, thrusting your hips against her and pulling her back into you in a quickening rhythm, all the while pumping her widening pussy with your tail, pushing deeper into it each time, probing the sides with the thin tip.  Her ass is amazingly tight; clearly you are introducing her to something new.  By the look on her face, you can tell she's enjoying it much more than she thought she would.\n\n");
		outputText("You keep up the motion, pushing deeper into her with each thrust of your " + cockDescript(x) + " and tail.  The widening circumference of your tapered tail spreads her already loose vagina until you're sure it will gape when you pull out. You're amazed at how deep she is able to take you, but never more so than when your tail begins to bump against the ground through her belly.  Her moans grow louder beneath you, and you find that the pleasure building in your own " + cockDescript(x) + " is rapidly bringing you towards your own climax.  You thrust into her one final time and hold her ass against you, pushing your tail in as far as it will go.  As you fill her ass with your load of hot cum, you see her eyes roll back and her mouth open wide as she reaches orgasm.  She pushes back against you now, using her arms for leverage, before finally going limp beneath you.  When your member begins to soften, you pull it and your tail out of her, and leave her in a tired heap in the sand.  You think you notice a sly smile creep to her face as she looks back at you just before she blacks out.  You slither off, shaking your head at the thought of the slutty creature.");
	}
	//Non-nagaz
	else {
		outputText("You sneer at the fallen shark girl, making up your mind to have your way with her. You tear her bikini off as you whip out your [cock] and start to order, \"<i>Get to i--!</i>\" But you're cut short by the shark girl suddenly taking the entirety of your cock into her mouth, forcing it as deep into her mouth as possible. Quite a slutty creature, that's for sure. What surprises you more is that those sharp fangs of hers appear to be retractable, and she has a more human-like set hidden behind them.\n\n");
		//[if herm]
		if(player.gender == 3) outputText("While sucking you off, her hand steadily snakes its way between your legs. Without warning, she shoves three fingers into your " + vaginaDescript(0) + ", pushing in and stretching the moist passage out.\n\n");
		outputText("You abruptly pull your cock from her mouth, causing the shark girl to gasp in surprise. She looks up at you, tears welling up in her eyes, \"<i>Please let me finish! I need this!</i>\" You smirk and order the shark girl onto her hands and knees. Her expression brightens and she obediently complies, getting down and raising her ass towards you. Taking a firm grip on her well-toned buttocks, you quickly shove your [cock] into her damp pussy and the shark girl squeals in excitement. You find yourself surprised by its texture; while it looks human enough on the outside, the inside is actually filled with strange feeler-like structures that wriggle and massage your cock as it pushes through.");
		//[if herm]
		if(player.gender == 3) outputText("  The sensation is incredible, and you find yourself massaging your " + biggestBreastSizeDescript() + " and tweaking your " + nippleDescript(0) + "s in an attempt to bring your pleasure to even greater heights.");
		outputText("\n\nThe shark girl cries out in orgasm, her pussy tightening as the feelers wrap around your cock. The pleasure drives you over the edge, and you pump your load of cum into her needy pussy, the feelers milking you for every drop you have. You pull out, satisfied, and as you turn to leave you see the shark girl rubbing cum into her cunt and winking at you.");
	}
	cleanupAfterCombat();
	player.sexReward("Default","Dick",true,false);
	dynStats("sen", -1);
	if(player.cor < 33) dynStats("cor", 1);
}
private function sharkgirlOceanDickFuck1():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	sharkgirlOceanDickFuck();
}
private function sharkgirlOceanDickFuck2():void {
	clearOutput();
	spriteSelect(SpriteDb.s_izma);
	sharkgirlOceanDickFuck();
}
private function sharkgirlOceanDickFuck():void {
	outputText("You sneer at the defeated ");
	if (flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] == 2) outputText("tiger ");
	outputText("shark girl, making up your mind to have your way with her. You grab her by the tail, swim back to your boat and forcefully pull her out of the water dropping her flat on the wood floor.\n\n");
	outputText("\"<i>Ow that hurt.</i>\"");
	outputText("You tear her bikini off as you whip out your [cock] and start to order, \"<i>Get to i—!</i>\" But you’re cut short by the ");
	if (flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] == 2) outputText("tiger ");
	outputText("shark girl suddenly taking the entirety of your cock into her mouth, forcing it as deep into her mouth as possible. Quite a slutty creature, that’s for sure. What surprises you more is that those sharp fangs of hers appear to be retractable, and she has a more human-like set hidden behind them.\n\n");
	if (player.hasVagina()) outputText("While sucking you off, her hand steadily snakes its way between your legs. Without warning, she shoves three fingers into your loose cunt, pushing in and stretching the moist passage out.\n\n");
	outputText("You abruptly pull your cock from her mouth, causing the ");
	if (flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] == 2) outputText("tiger ");
	outputText("shark girl to gasp in surprise. She looks up at you, tears welling up in her eyes, \"<i>Please let me finish! I need this!</i>\" You smirk and order the ");
	if (flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] == 2) outputText("tiger ");
	outputText("shark girl onto her hands and knees. Her expression brightens and she obediently complies, getting down and raising her ass towards you. Taking a firm grip on her well-toned buttocks, you quickly shove your [cock] into her damp pussy and the ");
	if (flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] == 2) outputText("tiger ");
	outputText("shark girl squeals in excitement. You find yourself surprised by its texture; while it looks human enough on the outside, the inside is actually filled with strange feeler-like structures that wriggle and massage your cock as it pushes through.");
	if (player.hasBreasts()) outputText(" The sensation is incredible, and you find yourself massaging your " + biggestBreastSizeDescript() + " and tweaking your " + nippleDescript(0) + "s in an attempt to bring your pleasure to even greater heights.");
	outputText("\n\nThe ");
	if (flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] == 2) outputText("tiger ");
	outputText("shark girl cries out in orgasm, her pussy tightening as the feelers wrap around your cock. The pleasure drives you over the edge, and you pump your load of cum into her needy pussy, the feelers milking you for every drop you have. You pull out, satisfied, then grab the shark slut and dump her back in the water as you ready to leave.\n\n");
	cleanupAfterCombat();
	player.sexReward("Default","Dick",true,false);
	dynStats("sen", -1);
}

private function sharkgirlSixtyNine():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	//Nagas don't actually get to 69!
	if(player.isNaga()) {
		outputText("The shark-girl reels and trips, falling onto her back.  You slide quickly towards her as she sits up, bringing a look of sheer terror to her face.  Clearly she is not accustomed to being 'prey' in any sense of the word.  You decide to change that.  Grabbing her by the shoulders, you push her back down a bit.  Clearly weakened by the fight, she goes limp in your hands, still scared and shaking ever so slightly with fear, but unable to resist.  You take a moment to admire the smooth curves of her body and meditate on how fine a catch you have before you.\n\n");
		outputText("The shark-girl begins to stir slightly under you, and you hear a slight annoyance with the delay beneath the obvious fear as she stammers out, \"<i>W-what are you waiting for?</i>\"  A smile nearly creeps to your face as you muse over her demanding attitude toward someone who just defeated her. Instead, you snap your head up and lock your gaze to her eyes, maintaining a fearsomely expressionless look.  She quickly winces back, clearly expecting something painful to come from you.  After a moment of being frozen in terror, she slowly turns her head back to you.  Her anger is more palpable this time as she says, \"<i>Well, get on with whatever it is you're doing!</i>\"  She opens her eyes, and looks to yours expectantly.  You enjoy the show of her face turning strangely from an expression of anger and fear to one of total confusion as her thoughts begin to cloud, draining as your hypnotizing gaze affects her mind.  She weakly begins, \"<i>Why... what are you...</i>\" but she's unable to complete her sentence or break your spell over her.  Her questions trail off quietly, and her face loses expression, but maintains a blank, slack-jawed stare back at you.  Her muscles relax and you see her limbs slowly go limp as her body seems to forget the situation it's in.\n\n");
		outputText("You lower her gently back down to the ground, keeping up your expressionless, insistent stare.  You slowly move your hand towards her breasts along her rough skin, and trace one of her nipples lightly with your outstretched finger.  Every bit of her face save for her empty eyes betray the lust building within her body, though she makes no move to relieve herself of it.  You lean down and grab her arm by the wrist, and are glad to see her eyes following yours on their own.  Placing her hand beneath her bikini on her own quickly slickening sex, you slip a few of her fingers inside and guide her hand into a slow rocking motion.  As you begin to speed up the pace, her body seems to take note and moves on its own.  You remove your hand, and she is very soon sighing and moaning with uninhibited pleasure.  You watch her as her masturbation grows less and less mechanical and her hand grows swifter.  Pleased to be the one to cause her vocalizations, you find your own hands parting the folds of your " + vaginaDescript(0) + ". You slowly slide up her side, your [allbreasts] rubbing against her body, stimulated by her rough skin.  Eventually your head is over and slightly behind hers, forcing her to tilt her own head back to maintain your mutual stare.  All the while, she has been pumping more and more of her hand into her loose cunt and moaning rather loudly.  This, along with her blank stare, makes for an odd but arousing sight.\n\n");
		outputText("You raise up from her and move your " + vaginaDescript(0) + " close to her face.  She doesn't appear to notice this or take the hint.  At first you are angered by her thoughtless insolence, but you then remember that you are the one bringing that about.  You point towards your vagina with one hand and reach close to her ear with the other.  As you snap your fingers, she immediately acts as you wish, pushing her face roughly into your crotch and rolling her eyes up in their sockets to maintain eye contact.  Her long tongue slips inside your " + vaginaDescript(0) + ", the sensation of it pushing far into your depths arousing you and making the pleasurable heat in your sex grow almost unbearable.  You reach behind her head and grind her face into you hard, muffling her moans, though they are soon replaced by your own.  You push her into you, thinking only of how deeply she is able to stimulate you and the pleasure the mindless shark-girl is bringing you.  You feel almost as though you are floating, and you want to stay like this forever, wishing the heat inside you would never stop building.  As you approach your climax, her moans into you grow louder, signaling hers.  The thought is too much and it pushes you over the edge; clenching the shark-girl's face into your " + vaginaDescript(0) + " you are drawn to orgasm as she is beneath you.  You cry out loudly and she gives a final grunt into your scaly tail.\n\n");
		outputText("Pleasure robbing you of thought, you look up, breaking your spell over the shark-girl.  Quickly realizing your mistake, you glance back down to see her paralyzed with confusion, apparently having been dropped back into her own body during her orgasm.  She doesn't dare to move a muscle, her hand still inside her bikini and her mouth still pressed to your " + vaginaDescript(0) + ".  You smile down at her, and she smiles a shier, more confused smile back at you for a moment before shaking her head and pulling her hand out.  You giggle as she struggles awkwardly to get out from beneath your coils.  She finally does, and begins to stagger back towards the water.  You head back to camp, feeling satisfied with the encounter.");
	}
	else {
		outputText("Making up your mind to rape the shark girl, you remove your [armor] and approach the slut before taking a firm grip on her silver hair. \"<i>You know what to do, bitch,</i>\" you sneer, pulling her head into your damp cunt. The shark girl needs no encouragement, eagerly probing your pussy with her long tongue");
		//[if female]
		if(player.gender == 2) outputText(", pulling out every few minutes to lick your " + clitDescript() + ".");
		//[if herm]
		if(player.gender == 3) outputText(". You remind her not to neglect your [cock], and the shark girl responds by thoroughly licking your hard erection and sucking at your [balls].");
		outputText("\n\n");
		outputText("You shove the shark girl down onto the ground and quickly plant your crotch on her face, ordering the shark girl to continue. She complies enthusiastically, licking with a greater intensity and clearly loving the sensation of being dominated. You have to admit, you are enjoying your role as master.\n\n");
		outputText("To reward your little slut for her efforts, your hand reaches back between her legs and slips under her skimpy black thong. You get to work fingering her moist cunt and you soon hear a series of muffled moans coming from beneath your legs. But she's smart enough to know not to stop licking, and you smirk at the effect you're having on the shark girl.  A cute little cry escapes from your little slave's mouth, and you pull your hand from her cunt before licking her sweet juices from your fingers. Shortly after, you cry out in orgasm");
		if(player.gender == 2) outputText(", juices spraying from your sex and coating the girl's face.");
		//[if herm]
		else outputText(" and stand up, gripping your [cock] and splattering thick jets of cum onto her face.");
		outputText("  The shark slut licks up your fluids hungrily.\n\n");
		outputText("Thoroughly satisfied, you leave the shark girl on the ground covered in your fluids and depart for your camp.");
	}
	cleanupAfterCombat();
	player.sexReward("saliva");
	dynStats("sen", -1);
	if(player.cor < 33) dynStats("cor", 1);
}
private function sharkgirlOceanSixtyNine1():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	sharkgirlOceanSixtyNine();
}
private function sharkgirlOceanSixtyNine2():void {
	clearOutput();
	spriteSelect(SpriteDb.s_izma);
	sharkgirlOceanSixtyNine();
}
private function sharkgirlOceanSixtyNine():void {
	outputText("Making up your mind to rape the ");
	if (flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] == 2) outputText("tiger ");
	outputText("shark girl, you remove your [armor] and approach the slut before taking a firm grip on her silver hair. \"<i>You know what to do, bitch,</i>\" you sneer, pulling her head into your damp cunt. The ");
	if (flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] == 2) outputText("tiger ");
	outputText("shark girl needs no encouragement, eagerly probing your pussy with her long tongue");
	if (player.gender == 3) {
		outputText(". You remind her not to neglect your [cock], and the ");
		if (flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] == 2) outputText("tiger ");
		outputText("shark girl responds by thoroughly licking your hard erection and sucking at your [balls].");
	}
	if (player.gender == 2) outputText(", pulling out every few minutes to lick your " + clitDescript() + ".");
	outputText("\n\nTo reward your little slut for her efforts, your hand reaches back between her legs and slips under her skimpy black thong. You get to work fingering her moist cunt and you soon hear a series of muffled moans coming from beneath your legs. But she’s smart enough to know not to stop licking, and you smirk at the effect you’re having on the ");
	if (flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] == 2) outputText("tiger ");
	outputText("shark girl. A cute little cry escapes from your little slave’s mouth, and you pull your hand from her cunt before licking her sweet juices from your fingers. Shortly after, you cry out in orgasm");
	if (player.gender == 3) outputText(" and stand up, gripping your [cock] and splattering thick jets of cum onto her face. The shark slut licks up your fluids hungrily.");
	if (player.gender == 2) outputText(", juices spraying from your sex and coating the girl’s face. The shark slut licks up your fluids hungrily.");
	outputText("\n\nThoroughly satisfied, you pick up and dump the ");
	if (flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] == 2) outputText("tiger ");
	outputText("shark girl back in the water before departing for your camp.\n\n");
	cleanupAfterCombat();
	player.sexReward("saliva");
	dynStats("sen", -1);
}

//Shark girl Bad End.
//Requirements: Have vaginal sex with 7 Shark girls in one day (Loss rape for males also counts toward this)
//Scene triggers automatically after the seventh Shark girl
private function sharkBadEnd():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	outputText("Several weeks pass by and you once again find yourself at the lake, your loins aching for another shark girl to swim by. Just thinking of their incredible sexual organs and the sense of domination you get from them makes you feel aroused. Sadly though, there's no sign of one, so you instead decide to take a nap.\n\n");
	outputText("You're awoken a short time later by something warm wriggling around inside your mouth. Your eyes pop open, worried that you might've swallowed a bug or something. However, when your vision swims back into focus, you become quite aware that it is actually someone's tongue probing around your mouth. It seems to be a young shark girl in her early teens, judging by her modest measurements and short stature. She pulls her head back and grins at you before exclaiming, \"<i>Hi, daddy!</i>\" You raise an eyebrow at that. Then you turn and you see several more teenage shark girls, each pinning your arms and legs down.\n\n");
	outputText("They are surprisingly strong given their stature, and even a Minotaur would have trouble prying them all off. Combined with a strong wave of arousal flooding your body, you find it rather hard to focus on anything. They must've funnelled a few Lust Drafts down your throat while you were sleeping.\n\n");
	outputText("\"<i>Wh-what's going on?</i>\" you ask, your voice shifting between arousal and fear. The young girl straddling your chest giggles while drawing circles on your skin with her finger, \"<i>Aw daddy, don't be scared. You're gonna play with your kids! Doesn't that sound fun?</i>\" Another adds, \"<i>Since you seem to love knocking up us shark girls, we figured you'd like to make a living out of it...</i>\" Your eyes widen slightly and you ask her, \"<i>What do you mean by that?</i>\"\n\n");
	outputText("The girls look at each other and grin before the one straddling you pulls out an odd-looking Shark's Tooth. \"<i>Oh you'll see. Open wide...!</i>\"");
	doNext(sharkBadEnd2);
}

//[Next]
private function sharkBadEnd2():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	outputText("Several months and mutations later...\n\n");
	outputText("You plunge your cock into yet another shark girl, the third one in the past hour, and finger two others at the same time. You've been fucking without stop for weeks now. Ever since you were morphed into a shark man, sex is almost the only thing you can think about. At one point you recalled that you had a name, and you vaguely remember having to do something important... Not as important as this, though. Not as important as breeding your harem.\n\n");
	outputText("\"<i>My, he's... certainly a virile creature, isn't he?</i>\" a tiger shark asks, taking a seat on a nearby rock. Another shark girl chuckles in response, \"<i>Oh I know. Our numbers have practically doubled because of him.</i>\" She gestures to several heavily pregnant shark girls lazing on the sands, caressing their bumps happily.\n\n");
	outputText("\"<i>Wow. When I heard rumors of your pack getting a new male, I had to check it out for myself. But I didn't think he'd be anything like this...</i>\" the tiger shark says, rubbing her own genitalia. You blow your load inside the shark girl before pausing a moment to catch your breath, your quad of cantaloupe-sized balls churning with more cum. You look up, ready to start on another girl, and catch sight of a human moving across the shoreline. A grin spreads across your face at the sight and you direct the girls' attention to the lone human.\n\n");
	outputText("\"<i>Fresh meat!</i>\"");
	EventParser.gameOver();
}

/*-------------------------
Shark's Tooth

Item description: A glinting white tooth, very sharp and intimidating.

You have no idea why, but you decide to eat the pointed tooth. To your surprise, it's actually quite brittle, turning into a fishy-tasting dust. You figure it must just be a tablet made to look like a shark's tooth.

Transformations:

You firmly grasp your mouth, an intense pain racking your mouth. Your gums shift around and the bones in your jaw reset. You blink a few times wondering what just happened. You move over to a puddle to catch sight of your reflection, and you are thoroughly surprised by what you see. A set of retractable shark fangs have grown in front of your normal teeth. They even scare you a little. (Adds the 'Bite' special attack)

Attack descript: You open your mouth wide, your shark teeth extending out. Snarling with hunger, you lunge at your opponent, set to bite into right them! (Similar to the bow attack, high damage but it raises your fatigue).
+

Jets of pain shoot down your spine, causing you to gasp in surprise and fall to your hands and knees. Feeling a bulging at the end of your back, you lower your \" + armorName + \"  down just in time for a fully formed shark tail to burst through. You swish it around a few times, surprised by how flexible it is. After some modifications to your clothing, you're ready to go with your brand new shark tail.
+

You feel a tingling in your scalp and reach up to your head to investigate. To your surprise, your hair color has changed into a silvery color, just like that of a shark girl!
+

You abruptly stop moving and gasp sharply as a shudder goes up your entire frame. Your skin begins to shift and morph, growing slightly thicker and changing into a shiny grey color. Your skin now feels oddly rough too, comparable to that of a marine mammal. You smile and run your hands across your new shark skin.
+

You groan and slump down in pain, almost instantly regretting eating the tooth. You start sweating profusely and panting loudly, feeling the space between your shoulder blades shifting about. You hastily remove your \" + armorName +   just in time before a strange fin-like structure bursts from in-between your shoulders. You examine it carefully and make a few modifications to your \" + armorName +   to accommodate your new fin.
--------------------------

Stat effects:

Increase strength 1-2 points (Up to 50)
Increase toughness 2-4 points (Up to 100)
Increase Speed 1-3 points (Up to 100)
Reduce sensitivity 1-3 Points (Down to 25 points)
Increase Libido 2-4 points (Up to 75 points)
Decrease intellect 1-3 points (Down to 40 points)
---------------------------
Slutty Swimwear

Item description: An impossibly skimpy black bikini. You feel dirty just looking at it... and a little aroused, actually.

armorDef: 0
armorPerk: Greatly increases effectiveness of 'Tease' ability.
armorValue: 25 gems

Putting it on: (Lust increases)

[flat-chested]  You feel rather stupid putting the top part on like this, but you're willing to bear with it. It could certainly be good for distracting. [/]

[breasts]  The bikini top clings tightly to your bustline, sending a shiver of pleasure through your body. It serves to turn you on quite nicely. [/]

[no dick]  The thong moves over your smooth groin, clinging onto your buttocks nicely. [If player has balls] However, your testicles do serve as an area of discomfort, stretching the material despite their normal size. [/] [/]

[dick]  You grunt in discomfort, your cock flopping free from the thong's confines. The tight material rubbing against your dick does manage to turn you on slightly. [/]

[If dick is 7+ inches OR balls are apple-sized] You do your best to put the thong on, and while the material is very stretchy, it's simply far too uncomfortable to even try. Maybe if you shrunk your male parts down a little... [/]
-------------------------------*/
//Loss Rape scenes:
internal function sharkLossRape():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	//Genderless:
	if(player.gender == 0) {
		outputText("You slump down in defeat, too ");
		if(player.HP < 1) outputText("hurt ");
		else outputText("horny ");
		outputText("to fight on.\n\n");
		outputText("The shark girl does a little victory dance, swaying her hips to and fro before moving over to you. She quickly removes your [armor], but her smile fades to a blank expression when she notices you lack any genitalia. \"<i>What the...</i>\" she mumbles, poking you in the groin. Finding you completely useless, she growls in frustration and stomps on your face in anger. The sudden pain makes you pass out.");
		cleanupAfterCombat();
		dynStats("tou", -2);
		return;
	}
	//Female:
	if(player.hasVagina() && (player.cockTotal() == 0 || rand(2) == 0)) {
		outputText("You slump down in defeat, too ");
		//[defeat via HP]
		if(player.HP < 1) outputText("hurt ");
		else outputText("horny ");
		outputText("to fight on.\n\n");

		outputText("The shark girl giggles and moves over to you, tugging at your [armor]  impatiently. Her tail swishes around and smacks your [ass]. \"<i>You're gonna make me very happy, you hear? Otherwise...</i>\" she opens her mouth wide and you see her fangs glinting menacingly in the light. You gulp hard and nod, bringing a smile from the shark girl.\n\n");
		outputText("Wasting no time, she removes her skimpy swimwear and your own gear.  ");
		//[if herm]
		if(player.gender == 3) outputText("Seeing your [cock] puts a smile on the shark girl's face as she takes a firm grip on your erection. \"<i>Well, you're just full of surprises, aren't you? Maybe I'll give this bad boy a whirl sometime. For now though...</i>\"  ");
		outputText("Her gaze drifts over to your " + vaginaDescript(0) + " and she licks her lips in delight. \"<i>Now that's what I'm looking for! Tell you what dear, you get me wet and I might just give you some pleasure too.</i>\"\n\n");

		outputText("She roughly grabs you by the hair and pulls your face into her drooling cunt, your tongue instinctively probing into her. \"<i>Mmm... don't you dare stop licking you dumb bitch, if you know what's good for you,</i>\" she orders. You reply by speeding up your tongue work. You're a little ashamed to admit it, but her dominant command makes you feel rather hot and bothered.\n\n");
		outputText("The shark girl eventually sighs happily and relaxes her grip on your hair, pulling your head away a few inches. \"<i>Not bad bitch, not bad. Now get on your back.</i>\" You obey your mistress's command and flop onto your back. A sense of joy fills you as she positions her crotch in front of your face and moves her own head between your legs. You quickly resume eating her out, and this time she joins in the feast. It's not too long before the two of you orgasm, spraying girl-cum onto each other's faces.\n\n");
		outputText("The shark girl stands to leave and winks at you before diving back into the water. You eventually pass out from the exertion.");
		//(Corruption +2, Intelligence -4)
		player.sexReward("saliva");
		if(player.cor < 30) dynStats("cor", 1);
		cleanupAfterCombat();
		return;
	}
	//Male:
	else {
		outputText("You slump down in defeat, too ");
		//[defeat via HP]
		if(player.HP < 1) outputText("hurt ");
		else outputText("horny ");
		outputText("to fight on.\n\n");

		outputText("You feel the shark girl's bare foot press against your chest and she roughly pushes you onto your back. \"<i>Oh man, I can't even remember the last time I had an actual man...</i>\" the shark girl says, pulling your pants down to your ankles. Seeing your stiff erection, your opponent smirks and wets her lips before taking your entire [cock] into her mouth. The feeling is heavenly, her long tongue slithering around your shaft.\n\n");
		outputText("But before you can begin to really enjoy it, she pulls her head away, visible strands of saliva still linking her mouth and your [cock]. The shark girl quickly maneuvers herself so that she's straddling your cock and presses herself down, the two of you gasping sharply from the sensation. \"<i>Hmm, good boy... You make me cum first, and I won't bite you. Deal?</i>\" You nod, though given that peculiar feelers inside her cunt are massaging your cock, you don't know how long you can really hold out.\n\n");

		outputText("The shark girl has no such qualms and rides you like a mechanical bull, hammering up and down your [cock] with incredible speed. It certainly feels nice, but the rough nature of the ride also certainly hurts. You'll be walking funny for a while after this, that's for sure.\n\n");

		outputText("Eventually, her vagina clamps down on your cock and she cries out in orgasm. You grunt loudly and cum a few seconds after, pumping your seed into her womb. The shark girl leans over and plants a tiny kiss on your lips. \"<i>Good boy. I'll be sure to see you again</i>\". She gets up again and you watch her re-enter the water before you pass out.");
		player.sexReward("Default","Dick",true,false);
		dynStats("sen", 1);
		if(player.cor < 30) dynStats("cor", 1);
		cleanupAfterCombat();
		return;
	}
}
public function sharkLossOceanRape():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	sharkLossOceanRape2();
}
public function tigersharkLossOceanRape():void {
	clearOutput();
	spriteSelect(SpriteDb.s_izma);
	sharkLossOceanRape2();
}
public function sharkspackLossOceanRape():void {
	clearOutput();
	spriteSelect(SpriteDb.s_izma);
	sharkLossOceanRape3();
}
public function sharkLossOceanRape2():void {
	outputText("Defeated, you pathetically try to swim back to the boat but the ");
	if (flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] == 2) outputText("tiger ");
	if (!player.canSwimUnderwater()) outputText(", forcefully feeding you a strange kelp in the process. Somehow thanks to the aquatic plant you manage to breath underwater");
	outputText(".\n\n\"<i>I will be loud and clear with you ");
	if (player.hasCock()) outputText("boy");
	else outputText("lass");
	outputText(".\n\nYou’re going to satisfy my needs, because if you don’t I will rip a huge chunk out of you!</i>\"\n\n");
	outputText("She flashes her teeth to make her statement and you nod right away in understanding, she ain’t bloody kidding!\n\n");
	outputText("shark girl is faster than you. She grabs your leg and pulls you into the depths");
	if (flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] == 2) {
		outputText("You see her dong harden before you as she grabs your head and forcefully pulls it down to the level of her crotch.\n\n");
		outputText("\"<i>Suck it!!!</i>\"\n\n");
		outputText("You hurry and get to the task shoving the entire monster in. The shark girl seems to enjoy your eager effort but the moment you relent she swiftly grabs hold of your head and jam it back on her cock.\n\n");
		outputText("\"<i>I didn't give you permission to stop! Keep at it or I’m going to tear you a new hole to shove my big boy in!</i>\"\n\n");
		outputText("Somehow her dominance turns you on and while at first you were reluctant to do this you now eagerly suck her cock off for all it’s worth. The tiger shark girl skull fucks you until she finally achieves satisfaction. Without warning, your throat is flooded with a torrent of salty tigershark cum and bulges from the sheer size of the load.\n\n");
		outputText("The tiger shark girl, satisfied, pulls your head off of her dick and carries you back to your boat.\n\n");
		outputText("\"<i>Come back anytime you want to get raped again, bitch. I need more cumbuckets like you to empty my load.</i>\"\n\n");
		player.sexReward("cum");
	}
	else {
		outputText("She swiftly grabs hold of your hairs and pull you down to her nethers.\n\n\"<i>");
		if (player.hasCock()) outputText("You’re way too pathetic to get any decent fertilisation from. ");
		outputText("Lick my cunt and fast!</i>\"\n\n");
		outputText("You hurry and get to the task, shoving your tongue into her slit. The shark girl seems to enjoy your eager effort but the moment you relent she swiftly grabs hold of your head and jams it back on her pussy.\n\n");
		outputText("\"<i>Who said you had right to stop?! I don’t care if you're tired, you're going to fully get me off or it'll go bad for you.</i>\"\n\n");
		outputText("Somehow her dominance turns you on and while at first you were reluctant to do this, you now eagerly use your mouth to create a seal around her cunt. The shark girl moans in delight as you give it your all to properly get her off. She screams in extasy as the taste of salty girlcum floods your mouth. Knowing better than to disappoint her you drink it all in.\n\n");
		outputText("The shark girl, satisfied, pulls your head off her cunt and carries you back to your boat.\n\n");
		outputText("\"<i>Come back anytime you want to get raped again, bitch. I need more sluts like you to lick my cunt.</i>\"\n\n");
		player.sexReward("vaginalFluids");
	}
	outputText("She swims back into the depths, leaving you dazed to rest in your boat.\n\n");
	cleanupAfterCombat();
}
public function sharkLossOceanRape3():void {
	outputText("Unable to fight further, you watch in horror as the shark girls circling you close in, grabbing you from all sides.\n\n");
	outputText("\"<i>Get that fresh meat, girls!</i>\"\n\n");
	outputText("Before you know it, you have one using your head as a seat while the others are using your hands and feet as makeshift dildos, your crotch being used by the tiger shark alpha as a tribute. "+(player.canSwimUnderwater() ? "":"One of them force feeds you some kind of algae and for some reason you manage to breathe. Well, at least you won’t drown while being raped. ")+"You feel the orgasm of the shark girls come way before yours as their cunts squeeze and drench your limbs in somewhat slimy waters.\n\n");
	outputText("\"<i>Mark that piece of meat with cum, girls!</i>\"\n\nThe other girls join in and squirt all over you, covering you in shark girl cum. Finally, you feel the tigershark cuming along with you, filling ");
	if (player.hasVagina()) {
		if (player.hasCock()) outputText("your pussy and hers with");
		else outputText("your needy pussy full of her");
	}
	else outputText("her pussy with your");
	outputText(" cum. You doze off in a content sleep while being carried away by the waves.\n\nYou wake up in your boat with your equipment piled next to you. Thankfully, the sharks didn't feel like keeping you as their plaything.\n\n");
	player.sexReward("Default", "Default", true, false);
	cleanupAfterCombat();
}

    //RAEP SOME FUKKIN SHARKGIRLZ NIGGA
    private function sharkGirlGetsDildoed():void {
        EngineCore.clearOutput();
        EngineCore.outputText("You grin from ear to ear, revealing enough teeth to make even the defeated shark-girl shiver.  Advancing upon the prone monster-woman, you ");
        if(player.weaponName != "fists") EngineCore.outputText("put away your [weapon] and ");
        EngineCore.outputText("draw out a glistening pink dildo from your pouches, as if it were a weapon.   She looks up at you, at once knowing your intent.  ");
        if(monster.lust >= monster.maxLust()) EngineCore.outputText("Her legs spread invitingly wide and she tears off her bikini bottom in a lusty frenzy.  You hold the dildo over her and give it a tiny squeeze, wringing out a few drops of pink fluid from the special dildo.  They land on her exposed cunt and in seconds she's writhing underneath you, humping the air.");
        else EngineCore.outputText("She holds her legs together defiantly, but you pry them open, tear off her bikini bottom and expose her bald nether-lips.   You hold the dildo over her and squeeze, squirting a gush of pink fluid onto her exposed cunt.  The effect is immediate, and in moments she's humping the air and wet with her own fluids.");
        EngineCore.outputText("\n\n");

        EngineCore.outputText("'<i>What a wonderful toy</i>,' you muse as you kneel between your ");
        if(player.cor > 50) EngineCore.outputText("latest ");
        EngineCore.outputText("victim's legs, inhaling her scent.  It smells surprisingly salty, reminding you of the sea.   Sand-papery skin brushes against your ankle.  You don't even have to look down to recognize the feeling of her tail curling around your leg and thigh.  Before she can use it to her advantage, you gently part her outer folds with one hand and insert the artificial member with the other.  The shark-girl's tail immediately drops away as her body shivers and relaxes, barely managing a few twitches.\n\n");

        EngineCore.outputText("The sea-smell from her groin intensifies and you feel the dildo bloat up in your hand.  She's orgasmed already!\n\n");

        EngineCore.outputText("You slap her left ass-cheek hard, the rough texture of her skin giving the perfect *crack* of skin on skin as you scold her, \"<i>You're not supposed to cum so hard!  Now you're really going to get stretched, skank!</i>\"\n\n");

        EngineCore.outputText("The aquatic monster-woman whimpers, feeling herself getting stretched wider and wider by the growing toy.   Intent on punishing her for trying to rape you AND for cumming too soon, you grab the dildo in a double-handed grip and force it in to the hilt.   Her tail flops and thrashes as the dildo sinks in until you bottom out.  She flops about like a dying fish, though perhaps the only thing about her 'dying' is a few brain cells from the bliss her cunny's feeling.  Satisfied with the degree of penetration, you grab it around the base and yank back on it, struggling with how tightly it's lodged in her cunt.\n\n");

        EngineCore.outputText("You wiggle it back and forth, working it partway out before ramming it back in.  Moaning and rocking underneath you, the shark-girl's eyes cross as she tries to fuck your hands.  Both her hands climb up under the thin black fabric of her top and wrap around her modest breasts, squeezing and caressing them.  She gasps when her fingers find her nipples, and starts drooling down her chin.\n\n");
        EngineCore.outputText("Her salty pussy clamps down hard, but the slick juices pouring from her hole makes it easier and easier to work the bloated sex-toy in and out of her love-hole.   Tired of the slut's moans and gasps of pleasure, you decide to finish her off.   You pull the dildo out, and let out a gasp of surprise when her twitching cunt gapes open obscenely, allowing you to see the entire depth of her love-tunnel, all the way to her cervix.   She groans at the sudden loss of sensation, but before she has a chance to jam a finger into her needy hole, you squeeze the perverted toy HARD, wringing a thick gush of pinkish fluid directly into her baby-maker.\n\n");

        EngineCore.outputText("You plunge the jiggling sex-toy back into her stretched cunt, pistoning the fluid directly into her womb and setting off an orgiastic cry with enough volume to make you cringe.  She trembles madly and you have to sit down on her tail to keep the tip of it from cracking you upside your head.  The dildo in your hands puffs up wider and wider until it pops itself out, exposing the pink-coated inner flesh of the shark-woman's cunt.  You can watch the muscles rippling and squeezing, though thanks to her stretching, you don't think she'll be able to squeeze anything smaller than a minotaur.  After a few more seconds her body goes still, save for the occasional twitch, and you realize she's passed out.\n\n");

        EngineCore.outputText("Damn that was hot!  You'll need to sate yourself once you get back to camp for sure.  Maybe you should give this dildo a whirl?  It still smells of your victim.");

        player.dynStats("lus", (20+player.lib/5+player.cor/10));
        cleanupAfterCombat();
    }
}
}
