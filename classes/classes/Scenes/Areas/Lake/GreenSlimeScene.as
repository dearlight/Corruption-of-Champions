﻿package classes.Scenes.Areas.Lake{
	import classes.*;
	import classes.Scenes.SceneLib;

	public class GreenSlimeScene extends AbstractLakeContent{
//serviceLowCorruption();
//servuceLowCorruptionHighLust();
//maleRapesOoze();
//femaleRapesOoze();
//oozeButtRapesYou();
//oozeRapesYouOrally();
//oozeRapesYouVaginally();
public function defeatGS():void {
	clearOutput();
	outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.");
	if (player.lust < 33 || player.gender == 0) {
		if (player.hasStatusEffect(StatusEffects.Feeder)) {
			outputText("\n\nYour nipples ache with the desire to forcibly breastfeed the gelatinous beast.  Do you?");
			doYesNo(rapeOozeWithMilk, cleanupAfterCombat);
		}
		else {
			if (player.lust < 33) outputText("\n\nYou're not horny enough to rape it.");
			else outputText("You can't think of anything to do with it.");
			cleanupAfterCombat();
		}
	}
	else {
		menu();
		if (player.hasStatusEffect(StatusEffects.Feeder)) {
			outputText("\n\nYou're horny enough to try and rape it, though you'd rather see how much milk you can squirt into it.  What do you do?");
			addButton(1,"B.Feed",rapeOozeWithMilk);
		}
		else {
			addButtonDisabled(1, "B.Feed", "Req. Feeder perk.");
			outputText("  Sadly you realize your own needs have not been met.  Of course, you could always play with the poor thing... Do you rape it?");
		}
		// "Pure" options
		if (player.cor <= 33 + player.corruptionTolerance || sceneHunter.other) {
			addButton(0, "Handjob", serviceLowCorruption).hint("Make the slime feel good with your hands.");
			addButtonIfTrue(1, "ServiceHim", serviceLowCorruptionHighLust,
				"You're not horny enough to do that!", player.lust >= 60 || player.lib >= 60,
				"Deliver it the pleasure it craves so badly.");
		}
		else {
			addButtonDisabled(0, "Handjob", "You're too corrupted do care about its pleasure!\n\n<b>Enable 'Other' in SceneHunter settings to override.</b>");
			addButtonDisabled(1, "ServiceHim", "You're too corrupted do care about its pleasure!\n\n<b>Enable 'Other' in SceneHunter settings to override.</b>");
		}
		// "Corrupt" options
		if (player.cor > 33 - player.corruptionTolerance || sceneHunter.other) {
			addButton(2, "M.Rape (O)", maleRapesOoze).hint("Fuck its ass with your dick.");
			addButton(3, "M.Rape (A)", oralRape).hint("Stick your cock in its mouth.");
			addButton(4, "F.Rape", femaleRapesOoze).hint("Take its slimy member to your vagina.");
		}
		else {
			addButtonDisabled(2, "M.Rape (O)", "You're too pure to stick your dick in this goo!\n<b>Enable 'Other' in SceneHunter settings to override.</b>");
			addButtonDisabled(3, "M.Rape (A)", "You're too pure to stick your dick in this goo!\n<b>Enable 'Other' in SceneHunter settings to override.</b>");
			addButtonDisabled(4, "F.Rape", "You're too pure to take this filth in your pussy!\n<b>Enable 'Other' in SceneHunter settings to override.</b>");
		}
		SceneLib.uniqueSexScene.pcUSSPreChecksV2(defeatGS);
		addButton(14, "Leave", cleanupAfterCombat);
	}
}

private function serviceLowCorruption():void {
	clearOutput();
	outputText("You seem unable to pull your eyes away from the creature, clearly helpless and distressed in its current state.  Carefully, you step forward, the slime barely registering your presence any longer.  It momentarily grimaces as if in agony, and you decide that you can't simply leave it like this.");
	outputText("You sit next to the blob and gently touch its throbbing member.  The surface membrane is moist and almost velvety in texture, not entirely smooth but not truly rough either.  You slowly run a hand along its length, glancing at the creature's face as you do so.  It seems calmer somehow, more in control of its breathing.\n\n");
	//Big peoples!
	if(player.tallness >= 82)
	{
		outputText("You try gently wrapping one of your massive hands around its erection, and squeezing.");
	}
	//Not so big peoples
	else
	{
		outputText("You try to wrap one of your hands around the erection, but end up having to use both to get a firm grip.");
	}
	outputText("  In spite of its appearance the thing is very soft and spongy, although a strong pulse periodically makes it surge in your hand, pushing itself into the cracks between your fingers.  Looking back at the thing's face you slowly begin to pump up and down the massive erection, which grows moist and then a little slick as some of the creature's thin green fluid seeps out onto your hands.  You feel slightly flush and start moving faster, the slime reacting positively to your ministrations.  The rest of its body seems to pulse as well, the definition in its body returning as you continue.  It even begins moving its hips in time with you, its facial features slowly becoming less and less pronounced as its erection gains more definition, clearly forming into a " + monster.cockDescriptShort(0) + ".\n\n");
	//Big peoples!
	if(player.tallness >= 82)
	{
		outputText("The throbbing of the slime's " + monster.cockDescriptShort(0) + " continues to grow stronger until the creature surprises you by reforming its arms and reaching up to grab you, holding your hand at the tip of its cock.  A fraction of a moment later the thing visibly arches its back off the ground and erupts into your palm, a thick jet of its green fluid splashing fiercely against your hand and spilling down the length of its penis, soaking both of your hands and even splashing onto your nearby lap.  You watch the creature's face with a mixture of shock and a sudden surge of excitement, its erection and face both turning smooth and featureless, before its cock slowly recedes back into its body.  The slime slowly begins to retreat as you return to your senses, looking down at your hands covered in the creature's green fluids.  When you look up again the creature is gone.\n");
	}
	//Not so big peoples!
	else
	{
		outputText("The throbbing of the slime's " + monster.cockDescriptShort(0) + " continues to grow stronger until the creature surprises you by reforming its arms and reaching up to grab you as you grasp him, holding your hands at the tip of its cock.  A fraction of a moment later the thing visibly arches its back off the ground and erupts into your palm, a thick jet of its green fluid splashing fiercely against your hands and spilling down the length of its penis, soaking both of your hands and even splashing onto your nearby lap.  You watch the creature's face with a mixture of shock and a sudden surge of excitement, its erection and face both turning smooth and featureless, before its cock slowly recedes back into its body.  The slime slowly begins to retreat as you return to your senses, looking down at your hands covered in the creature's green fluids.  When you look up again the creature is gone.\n");
	}
	player.slimeFeed();
	dynStats("sen", 2);
	cleanupAfterCombat();
}
private function serviceLowCorruptionHighLust():void {
	clearOutput();
	outputText("You find yourself unable to tear your eyes away from the creature as it undulates almost hypnotically in front of you, the heat in your crotch rising.  The rigid protrusion at its middle visibly pulses and throbs, and with a small grin you step closer to the ooze and strip off your clothing.\n\n");
	outputText("You straddle the creature's chest and playfully run a hand over the tip of its featureless member, which is moist and soft to the touch.");
	//Tall peeps
	if(player.tallness >=82) outputText("  You grip the head of the member firmly with one of your large hands and tease the tip with your thumb for a moment before squeezing and sliding your hand to its base.");
	//Short peeps
	else outputText("  You run a finger up and down the creature's member a few times before tightly wrapping your hands around the tip and running them to its base.");
	outputText("  The erection is spongy and pliable to the touch, and with every pulse it seems to fill the cracks between your fingers.\n\n");
	//If player has a cunny
	if(player.vaginas.length > 0)
	{
		outputText("As you rub the creature's shaft you toy with the idea of inserting the thing into your " + vaginaDescript(0) + ", biting your lip slightly and sliding forward a bit to rub yourself against the slime's " + monster.cockDescriptShort(0) + ".  You moan a bit and lose yourself for a moment, caught between desire ");
		//Non virgin's are sluts!
		if(!player.vaginas[0].virgin) outputText("for that familiar full feeling ");
		outputText("and paranoid about allowing this creature inside of you.");
		//If you be hella tight
		if(player.vaginalCapacity() <= 18) outputText("  On top of that, you are unsure if the thick, foot and a half long appendage would even fit inside of you.");
		outputText("\n\n"); //this line present to ensure proper paragraph structure
	}
	//Penises foreplay
	if(player.cockTotal() > 0) {
		//Multicock folk get in their own way
		if (player.cockTotal() > 1) outputText("Your own erect [cocks] rub against the creature's as you work, getting in the way somewhat.  ");
		//Big single cocked folk get in their own way too!
		else if(player.cocks[0].cockThickness >= 36) outputText("Your own erect [cock] rubs against the creature's as you work, getting in the way somewhat.  ");
		//Single dick contemplation
		if(player.cockTotal() == 1) outputText("You feel your [cock] begin to throb and entertain the idea of trying to penetrate it somehow.  You turn a bit and look around the creature for an orifice, but find nothing.  After a few frustrated moments of searching you give up and decide to handle things yourself.");
		//Multidick contemplation
		else outputText("You feel your [cocks] begin to throb and entertain the idea of trying to penetrate it somehow.  You turn a bit and look around the creature for an orifice, but find nothing.  After a few frustrated moments of searching you give up and decide to handle things yourself.");
		outputText("\n\n");
	}
	//Next PG
	//Get it hard
	outputText("As you continue to work the creature's mass its erection gains more and more definition, slowly but surely turning into an unmistakable human penis.  ");
	//And here begins the giant goddamn height split.  Hoo boy.
	sceneHunter.print("Tallness fork (82 inch)");
	//Smaller characters!
	if(player.tallness < 82) short();
	else tall();

	//===================================================================
	function short():void {
		//Hand gets coated in sensitive slime\n
		outputText("A light green fluid begins to coat your hand as you stroke the slime's cock, making your fingers feel warm and sending shivers of arousal through your entire body.\n\n");
		//Male or sometimes herm...
		sceneHunter.selectGender(dickF, vagF, null, null, 0);

		//===================================================================
		function dickF():void {
			sceneHunter.selectBigSmall(bigF, 30, smallF, -1, null, "length");

			//=====================================================
			function smallF():void {
				var x1:int = player.findCock(-1, -1, 30, "length");
				outputText("Eventually your own arousal becomes unbearable, and you reach down to work your own [cock "+x1+"] as well, massaging the monster's swollen, throbbing head with your other hand.  You gasp slightly as soon as you wrap your hand around your [cock "+x1+"], the creature's fluid making you exceptionally sensitive.  You moan in spite of yourself and start to thrust your hips a bit against your fist, feeling both yourself and the creature begin to throb harder and harder.  Before long you can hold out no longer, and feel your body racked by an orgasmic spasm, squeezing tightly with both hands as you blow your load onto the creature.  ");
				//Herm orgasm text
				if (player.vaginas.length > 0) {
					outputText("Your " + vaginaDescript(0) + " quivers and shares in the sensation as you grind yourself against the slime.  ");
				}
				outputText("The creature reaches its peak as well, and a thick, powerful gout of more green fluid shoots from the slime's cock and into your waiting palm.  You shudder as your orgasm seems to drag on for longer than usual, and notice that the slime's body regains some of its definition for a moment before its cock quickly recedes back into its body.");
				sharedEnd();
			}
			function bigF():void {
				var x1:int = player.findCock(1, 30, -1, "length");
				outputText("Eventually your own arousal becomes unbearable, and you reach down to grope at yourself as well, working the monster's swollen, throbbing head with one of your hands.  Unable to grip it properly you moan a little and hold yourself down against the creature's skin, moving your hips back and forth to get off.  You begin to moan louder as the same greenish secretion that coats your hands begins to cover your [cock "+x1+"] as well, making it throb even harder than before.  Before long you gasp and double over as you orgasm, hips shaking as you come all over the creature.  ");
				//Herm orgasm text
				if (player.vaginas.length > 0) {
					outputText("Your " + vaginaDescript(0) + " quivers and shares in the sensation as you grind yourself against the slime.  ");
				}
				outputText("Instinctively you hold onto the creature's own shaft for support as you do and with a final mighty pulse it also comes, spraying its thin green fluid in a tall gout into the air.  You feel it splash onto your back and " + hairDescript() + " as you gasp for breath, before almost falling over as the beast's erection rapidly recedes into its own body.");
				sharedEnd();
			}
		}

		function vagF():void {
			//Foreplay and smearing goo about
			outputText("Eventually your own arousal becomes unbearable, and you let one of your hands slide down the creature's erection and body and up your leg, purring softly as a slight warm sensation spreads everywhere you get the green fluid the creature has been so readily leaking.  You let your hand crawl between your legs and gasp slightly as you run a hand over the lips of your " + vaginaDescript(0) + ", savoring the sensation before going to work on yourself.  ");
			//Big clitties
			if (player.clitLength >= 2) outputText("You moan and lean back slightly as you grip your " + clitDescript() + " between your thumb and forefinger, biting your lip at the intense sensations as you rub your thumb over your " + clitDescript() + " and shuddering in anticipation and delight.  ");
			//Small clitties
			else outputText("You moan and lean back slightly as you start to flick your " + clitDescript() + ", the slime's fluid providing excellent lubrication and a luxurious warming feeling as you make small circles around your nub.  ");
			//Jack off slime and make it human shapes
			outputText("At the same time you continue to work the head of the slime beneath you, slowly twisting your hand around the top of its large erection.  Before long the mass starts to slim and bulge, becoming more defined before taking on the distinct image of a human penis.  The sight of it further excites you and you begin to work it harder, feeling it start to throb in earnest beneath your touch.  ");
			//Tit stuff
			if (player.breastRows.length > 0 && player.biggestTitSize() > 0) {
				outputText("You gasp a little as the slime's massive arms reach up from behind you to cup your [allbreasts], and the soft material ");
				//Tig ol' bitties
				if (player.biggestTitSize() > 8) outputText("barely contains them.");
				//Middling Boobiliciousness
				else if (player.biggestTitSize() > 3) outputText("gently covers them.");
				//Tiny ta-tas.
				else outputText("easily smothers them.");
				//Get nips played with and nearly cum
				outputText("  You feel the thing tweak your nipples, and you moan a little as the ooze begins a gentle, rhythmic massage, teasing your " + nippleDescript(0) + " and rubbing you in all the right ways.  With a bit of surprise you notice that its hands actually appear to be completely still, and that all of the motion comes from the creature altering its shape around you.  Your arousal surges as you imagine what this beast would feel like inside you, and quickly start to peak.  ");
			}
			//No titties or too small to bother with
			else outputText("You gasp a little as the slime's massive arms suddenly grab your " + hipDescript() + " and press you down against its body, and another bulge pushes out between your legs to force your hand away.  Instead of sprouting a second penis, however, the creature starts to gently rock you back and forth along it, eliciting a moan escaping your mouth as the soft material slides delightfully against your nethers.  This, and the aphrodisiac effects of its natural secretions, quickly bring you to your peak.  ");
			//Herms rock out with their cocks out
			if (player.cockTotal() > 0) {
				//Multicock
				if (player.cockTotal() > 1) {
					outputText("You feel your [cocks] surge to their full size as the slime works you over.  They quickly begin to throb and ache for release, a need made only more pressing by your desire to have it fondled.  ");
					//of course, if the creature is working the player's crotch because they don't have breasts, they -can- jerk off!
					if (player.biggestTitSize() == 0) outputText("You delicately grasp the head of one of your cocks, your hand slick with the fluids of yourself and of the creature.  The combination of the creature's movements and your own quickly overwhelms you.");
				}
				//Single prick
				else {
					outputText("You feel your [cock] surge to full size as the slime works you over.  It begins to throb and ache for release, a need made only more pressing by your desire to have it fondled.  ");
					//Play with it if your boobs aren't being manhandled
					if (player.biggestTitSize() == 0) outputText("You delicately grasp the head of your [cock], your hand slick with the fluids of yourself and of the creature.  The combination of the creature's movements and your own quickly overwhelms you.");
				}
			}
			//New paragraph for orgazms.
			outputText("\n\n");
			//Female cum!
			outputText("Finally, you feel a tsunami of pleasure begin to wash over you as you orgasm, and as your entire body shakes you unconsciously try to squeeze the creature between your legs.  It pulls back slightly and with a final mighty pulse, a green fluid explodes from the tip of its " + monster.cockDescriptShort(0) + ", splashing over your entire body.  Everywhere it touches seems to catch fire with pleasure and your already reeling mind almost collapses, and you let yourself fall back against the slime's body as wave after wave of pleasure flows through you.  ");
			//Herm bonus cum!
			if (player.cockTotal() > 0) {
				//Multidicked herms
				if (player.cockTotal() > 1) outputText("You let out a strangled gasp as your body, already straining from exertion, shudders again as your " + multiCockDescript() + " explodes into orgasm, showering both you and the creature in jizz.  ");
				//Single cocked herms
				else outputText("You let out a strangled gasp as your body, already straining from exertion, shudders again as your [cock] explodes into orgasm, sending a jet of your warm jizz into the air.  ");
			}
			outputText("When you open your eyes you notice that the creature's erection has disappeared, and the almost predatory calm it possessed when you first encountered it has returned, though different somehow.");
			sharedEnd();
		}

		function sharedEnd():void {
			outputText("\n\nAfter a few moments the creature slides out from under you, slinking back into the waters of the lake as you recover from the ordeal.  When your wits return, there is nothing to do but stop back by camp.\n");
			player.sexReward("vaginalFluids");
			dynStats("sen", 3);
			cleanupAfterCombat();
		}
	}

	function tall():void {
		outputText("A light green fluid begins to coat your hand as you stroke the slime's cock, making your fingers feel warm and sending shivers of arousal through your entire body.  Eventually your own arousal becomes unbearable, and you feel the dire need to please yourself too.\n\n");
		menu();
		addButtonIfTrue(0, "Dick", dickF, "", player.hasCock());
		addButtonIfTrue(1, "Vagina", vagF, "", player.hasVagina());
		addButtonIfTrue(2, "Tits", titsF, "Req. a vagina and bigger tits.",
			player.hasVagina() && player.biggestTitSize() > 0);

		//=======================================================================================
		function dickF():void {
			//Multicock foreplay
			if(player.cockTotal() > 1)
				outputText("You reach down to work one of the shafts in your [cocks], as well, continuing to run your other hand up and down the creature's length.  You gasp slightly as soon as you wrap your hand around your " + cockDescript(1) + ", the creature's fluid making you exceptionally sensitive.  You moan in spite of yourself and start to thrust your hips a bit against your fist, stroking yourself and the creature from crest to root.  The creature's erection gains definition as it starts pulsing harder and faster, turning into a distinctly human penis.  ");
			//SingleCock
			else {
				outputText("You reach down to work your own [cock] as well, continuing to run your other hand up and down the creature's length.  You gasp slightly as soon as you wrap your hand around your [cock], the creature's fluid making you exceptionally sensitive.  You moan softly in spite of yourself and begin to thrust your hips a bit against your fist, stroking yourself and the creature from crest to root.  The creature's erection gains definition as it starts pulsing harder and faster, turning into ");
				if(player.cocks[0].cockType == CockTypesEnum.HUMAN) outputText("a near exact replica of your own [cock]!  ");
				else outputText("a distinctly human penis.  ");
			}
			//vaginal arousal & cum text for herms
			if(player.vaginas.length > 0)
			{
				outputText("The intense sensations ripple through your entire body, and your " + vaginaDescript(0) + "grows wet with arousal.  You push against the creature and rhythmically slide back and forth, its soft, moist body conforming to your folds and creating a wonderfully arousing sensation.");
				outputText("\n\nIt isn't long before you can no longer hold yourself back and with a groan, you explode, showering the creature with your seed as your " + multiCockDescript() + " and " + vaginaDescript(0) + " simultaneously explode into orgasm.  The ooze's penis also seems to swell, and a torrent of the green fluid gushes from the tip, creating a large, slippery pool that coats your bottom half and forms a small pool on the ground around you before soaking into the earth.  As you catch your breath the creature's cock begins to lose definition and then recedes as the thing pulls itself back into a blob and slides out from under you, quietly escaping into the nearby water as you watch.  As you get up, you notice a still partly solid blob of green gel on the ground, and pick it up.");
			}
			//Pure male orgasm
			else outputText("\n\nIt isn't long before you can no longer hold yourself back and with a groan, you explode, showering the creature with your seed.  The ooze's penis also seems to swell, and a torrent of the green fluid gushes from the tip, creating a large, slippery pool that coats your bottom half and forms a small pool on the ground around you before soaking into the earth.  As you catch your breath the creature's cock begins to lose definition and then recedes as the thing pulls itself back into a blob and slides out from under you, quietly escaping into the nearby water as you watch.");
			sharedEnd();
		}
		function titsF():void {
			outputText("Your other hand finds its way to your " + allBreastsDescript() + ", and you begin to grope yourself as you grip the creature's shaft and stroke it from crown to root.  As the pulsing of the beast's mass becomes more pronounced so does its appearance, and it takes on the distinct look of a human penis.  Grinning you pull it towards you a bit and rapidly stroke the shaft with one hand while working the cock's head with the other, making the slime buck slightly, pulsing within your hands.  Without warning, its wide arms reach up, one reaching across your breasts while the other drapes across your thighs, the hand going for your " + vaginaDescript(0) + ".  ");
			//Cant cover all of tig ol' bitties
			if (player.biggestTitSize() > 8) outputText("Its hand expands, struggling to cover all of your [allbreasts], ");
			//Middling ta-tas get covered
			else if (player.biggestTitSize() > 3) outputText("Its hand expands and gently covers your [allbreasts], ");
			//Small tits?  Pwned.
			else outputText("Its hand easily smothers your [allbreasts], ");
			outputText("and you stop for a moment until the slime tweaks one of your " + nippleDescript(0) + ", prompting you to begin rubbing it again.  The hand on your breasts expertly massages them with what feels like dozens of fingers as the other gently runs a finger over your gash.  Looking down, you realize that the slime doesn't appear to be moving at all - it is shifting its own mass to massage you, creating a feeling like nothing you've ever experienced!  ");
			outputText("A bead of realization dawns on you just before you feel it hit, the surprise making you squeeze and twist at the head of the slime's cock.  ");
			vagF_part2();
		}
		//Non titty foreplay
		function vagF():void {
			outputText("Your other hand finds its way to your " + "rapidly moistening " + vaginaDescript(0) + ", and you begin to slide a finger along your gash as you grip the creature's shaft and stroke it from crown to root.  As the pulsing of the beast's mass becomes more pronounced so does its appearance, and it takes on the distinct look of a human penis.  Grinning you pull it towards you a bit and rapidly stroke the shaft with one hand while working the cock's head with the other, making the slime buck slightly, pulsing within your hands.  Without warning, one of its wide arms reaches up, draping across your thighs, the hand going straight for your " + vaginaDescript(0) + ".\n");
			if (player.cockTotal() > 0)
				outputText("You begin to moan as the creature rubs the " + vaginaDescript(0) + " beneath your " + multiCockDescript() + ", working you with incredible skill, but sadly ignoring your needy penis" + (player.cockTotal() > 1 ? "es" : "") + " as it does.  What comes next is an utter surprise, making you unconsciously wring the head of the slime's cock.  ");
			else
				outputText("You begin to moan as the creature rubs your " + vaginaDescript(0) + ", working you with incredible skill, but what comes next is an utter surprise, making you unconsciously wring the head of the slime's cock.  ");
			vagF_part2();
		}
		function vagF_part2():void {
			//Clit engulfed!
			outputText("The creature's smooth, gel-like body envelopes your " + clitDescript() + " and slowly pulsates, stroking it from multiple angles at once and making you gasp with pleasure.  You're torn with the urges to both thrust your hips towards it to seek more pleasure and to draw away from the sheer intensity of the sensations, and settle for helplessly moaning as your hands unthinkingly tighten and squeeze around the head of the creature's cock, causing it to release a massive stream of green fluid across your chest and body.\n\n");
			//slime has orgasmed, time for the player.  again, split for cock-appropriateness.
			outputText("Even as it does, so it continues to masterfully work your body, putting you on edge with its ministrations and keeping you there for several torturous, glorious minutes as you practically lose control over your body.  Eventually the creature seems to pull on everything at once, finally causing you to orgasm as you all but scream in pleasure.  ");
			if(player.cockTotal() > 0) outputText("  Your " + multiCockDescript() + " explodes as well, sending thick ropes of your steaming ejaculate into the air as the monster finishes with you.  ");
			//Creature exits stage left!
			outputText("You barely notice as the creature's erection recedes, and it slides out from under you, leaving you utterly satisfied.  When you do finally recover, your senses you find no other traces of its presence.");
			sharedEnd();
		}
	}
	function sharedEnd():void {
		player.sexReward("vaginalFluids");
		dynStats("sen", 3);
		cleanupAfterCombat();
	}
}

private function oralRape():void {
	clearOutput();
	outputText("Noting your own erectness, you decide that the unusual nature of the thing in front of you is of, at best, minor concern, and resolve to fuck it to satisfy your own desires.\n\n");
	outputText("You approach the creature and examine it, finding no real orifices to speak of.  ");

	if(player.cockTotal() > 1) outputText("Shrugging, you decide to go with the closest thing available and walk towards its head.  You spend a moment deciding which of your organs to ravage the creature with, eventually settling on the largest,  ");
	else outputText("Shrugging, you decide to go with the closest thing available and walk towards its head, pulling out your [cock] as you do so.  You kneel over the thing's head and stroke your penis lightly to ensure it is fully ready,  ");
	//Balls ftw
	if(player.balls > 1) outputText("anointing the slime's face with your " + sackDescript() + " as you do.  ");
	//Ball-less bitches
	else outputText("probing at the 'mouth' of the creature with your free hand.  ");
	//Continue the setup...
	outputText("You pull back for a moment and aim your penis downward, resting the [cockhead] on the inside of its mouth and pushing.  You feel the material give and push harder, the membrane material that covers the slime's exterior stubbornly refusing to give.  Finally, after some frustration, you grab the creature by what would be its neck and try to pull it back to your pelvis, thrusting forward at the same time.  It finally gives, and you see your [cock] surge into its mouth");
	//This series deliberately not else-if statements.
	if(player.cocks[0].cockLength >= 12) outputText(", down its throat,");
	if(player.cocks[0].cockLength >= 24) outputText(" into its torso,");
	if(player.cocks[0].cockLength >= 48) outputText(" and all the way through to its hips,");
	outputText(" and grunt approvingly.  You begin to slowly pull yourself out and then thrust yourself back in, feeling a moistness as some fluid surrounds your cock.  ");
	//player doesn't care about monster's wellbeing
	if(player.cor >= 60) outputText("You wonder for a moment if you've broken the creature's membranous skin, then shrug and decide you don't care.");
	//player shows concern for monster
	else outputText("You wonder for a moment if you've broken the creature's membranous skin, but the continuing presence of the creature's throbbing erection implies that it's in relatively little distress.");
	//New PG
	outputText("\n\n");
	//Start fucking in earnest
	outputText("You start to thrust with more vigor, thrusting until your hips mash against the ooze's skin, feeling yourself build to orgasm even faster than usual as your [cock] begins to feel warm and incredibly sensitive.  Oddly, as you pump the creature's mouth it seems to regain some of the definition it lost when it collapsed earlier, the protrusion between its legs shaping into a fully defined human dick");
	//Balls ftw
	if(player.balls > 1) outputText(" as your [balls] slap against its face");
	outputText(".  One of its arms reaches up to meekly rub at its own erection.  You grin as this fuels your own lust, and you start to thrust even harder.");
	//vaginal arousal text
	if(player.vaginas.length > 0) outputText("  Your " + vaginaDescript(0) + " begins to grow wet as you repeatedly force yourself into the creature's throat.  You take a single deep stroke and bottom out into the creature, grinding your moist femininity against the soft, sensual material of the creature's face.");
	//New PG for cumming!
	outputText("\n\n");
	outputText("Before long you find yourself shouting as you pump your seed into the creature, watching as the semen is caught by unseen currents and dispersed into its body.");
	//vaginal orgasm text
	if(player.vaginas.length > 0) outputText("  This is quickly followed by a quivering between your nether-lips as your " + vaginaDescript(0) + " quivers in orgasm shortly afterwards.");
	outputText("  You pull your [cock] out of the thing's face slowly, relishing the sensation, producing an audible *pop* when your tip finally exits the creature.  A satisfied smirk crosses your face as the defeated beast's erection shrinks back into itself before sliding off, back into the nearby water.");
	player.sexReward("vaginalFluids","Dick");
	dynStats("sen", 3);
	cleanupAfterCombat();
}

private function maleRapesOoze():void {
	clearOutput();
	outputText("Noting your own erectness, you decide that the unusual nature of the thing in front of you is of, at best, minor concern, and resolve to fuck it to satisfy your own desires.\n\n");
	outputText("You approach the creature and examine it, finding no real orifices to speak of.  ");

	if(player.cockTotal() > 1)
	{
		outputText("You shrug at the lack of obvious orifices and decide to go for the most common one, choosing the ");
		if(player.cockTotal() == 2) outputText("larger");
		else outputText("largest");
		outputText(" of your[cocks] as you grab the slime and roughly try to turn it over.  Surprisingly it maintains its cohesion and flops onto its side, its erection flopping wetly onto the ground.  ");
	}
	//Single dicks
	else outputText("You shrug at the lack of obvious orifices and decide to go for the most common one, pulling out your [cock] as you grab the slime and roughly try to turn it over.  Surprisingly it maintains its cohesion and flops onto its side, its erection flopping wetly onto the ground.  ");
	outputText("  You position your member around where you think the asshole would be and push, smiling as the membrane moves aside and you penetrate into a tight, deep hole.  ");
	if(player.cocks[0].cockLength >= 24) outputText("By the time you finally bottom out, your [cock] is nearly halfway through its torso.");
	else if(player.cocks[0].cockLength >= 48) outputText("By the time you finally bottom out, your [cock] reaches nearly into the slime's neck.");
	else if(player.cocks[0].cockLength >= 60) outputText("Your penis keeps going deeper and deeper, through the chest, neck, and head, before finally stretching the slime as far as it needs to go to accommodate the full length of your [cock].");
	outputText("  With a satisfied smile you begin pumping, slowly at first before picking up speed.  The slime's anus feels better than anything you've ever had before, apparently coming with its own lubrication but still being tight, hugging your cock like a custom-fit fuck toy.  ");
	//vaginal arousal text
	if(player.vaginas.length > 0) outputText("Your " + vaginaDescript(0) + " grows wet as you work the thing's hole, every slap of your hips against the thing's ass sending a pang of pleasure through your nethers.  ");
	outputText("After only a few minutes you realize that you can't hold out for much longer, as whatever is inside the creature seems to be making you extra sensitive.  Deciding to make the most of it, you double your speed and grit your teeth, enjoying the slime for all it's worth before ");
	if(player.cockTotal() > 1) outputText("your [cocks] explodes into orgasm, your load filling the space inside the creature and spraying in thick streams across its back.");
	else outputText("exploding inside it, your load filling the space around your cock with a white, milky fluid.");
	//vaginal orgasm text
	if(player.vaginas.length > 0) outputText("  As you pump your jizz into the creature an almost electrical shock runs through your body, starting from your " + vaginaDescript(0) + " and radiating outwards.");

	outputText("  The thing seems to clamp down on you even tighter as you pull out, and you relish the sensation.  Its tight ass leaves your [cock] almost perfectly clean afterward, a glob of white still stuck inside the creature as it changes back into its original, amorphous state.  The cloud disperses as the slime slinks off.");
	player.sexReward("vaginalFluids","Dick");
	dynStats("sen", 3);
	cleanupAfterCombat();
}

private function femaleRapesOoze():void {
	player.slimeFeed();
	outputText("You feel a stirring inside your feminine side as you eye the slime's throbbing erection, and decide to take advantage of its current state to satisfy your own urges.  You strip off your clothes and walk forward, straddling the creature's thighs and running a hand over its member.  You pull it in against your body and stroke the soft, velvety, and just slightly moist shaft,");
	if(player.cocks.length > 0)
		outputText(" your " + vaginaDescript(0) + " growing wet and your [cock] growing firm as you imagine it inside you.  ");
	else
		outputText(" growing wet as you imagine it inside of you.  ");
	if (player.biggestTitSize() > 8)
		outputText("You grin and lean forward slightly, letting your [allbreasts] rest against its member.  You pull it forward and wedge it between them, wrapping yourself around it and slowly massaging the cock with your chest.  You feel the creature begin to pulse and throb as your chest begins to feel slick, and so you sit up to prevent the slime from finishing early.  As you pull yourself off of it you notice with a bit of delight that its formerly indistinct shaft is now a perfectly sculpted human cock, a full foot and a half long, and your breasts are now covered with a strange green fluid.\n\n");
	else if(player.biggestTitSize() > 3)
		outputText("You smile mischievously and lean down, pressing your chest down around the creature's member.  You slowly start to move back and forth and the slime responds positively by slowly moving its hips in time with your bod, all the while throbbing and pulsing magnificently.  You watch with wide eyes as the shaft shifts, changing into a perfectly sculpted human cock, a full foot and a half long.  Sensing the thing getting close you ease yourself off and sit back up, your chest now covered with a green fluid.\n\n");
	else if(player.biggestTitSize() >= 0)
		outputText("You pull the member tight against your body and run your hands along its length, rubbing it over your belly as the shaft throbs and pulses beneath your touch.  You lean forward a little and rub the tip of it against your [allbreasts], smiling as it leaves a little bit of greenish fluid behind.  After enduring your ministrations for a short time the creature begins moving its hips in time with you.  You hold in a slight gasp as the ooze's shaft shifts, changing into a perfectly sculpted human cock, a full foot and a half long.\n\n");
	outputText("Before long you cannot take the temptation anymore and lift your hind end into the air, moaning softly as you rub the tip of its cock against your " + vaginaDescript(0) + ".");
	//defloration text
	if(player.vaginas[0].virgin) {
		//low corruption reveres this loss
		if(player.cor <= 20)
			outputText("  You hesitate for a moment as you hover over the creature, a sudden surge of nervousness comes over you.  This is a moment that only comes once.  You let your weight push the creature into you, slowly at first, then forcing yourself down as far you can go.  You gasp at the initial pain, but it quickly dissipates as the creature's fluids coat your interior with a cool, soothing fluid.  ");
		//higher corruption tosses it aside
		else
			outputText("  You smile as you ram yourself onto the creature, finally removing your virginity.  You quickly start moving and give a pleased gasp as the creature's fluids coat your interior with a cool, soothing fluid.  ");
	}
	else if (player.vaginalCapacity() >= 18)
		outputText("  You enthusiastically lower yourself onto the slime's cock, letting out a small gasp of surprise as it slides inside of you.  The creature quickly understands your intentions and reaches up with its hands, beginning to pump you furiously.  ");
	else
		outputText("  You hesitate at the sheer size of the slime's cock and the creature, sensing your hesitation, reaches up with its strong arms and grips your ass, forcefully pushing you onto itself.  ");
	outputText("The thing's cock, though rigid, somehow manages to squish and expand wherever needed to conform perfectly to your insides, adapting to your " + vaginaDescript(0) + " with ease as you ride it.");
	//penis arousal text
	if (player.cockTotal() == 1)
		outputText("  Your [cock] grows hard as you are penetrated, and with the creature handling the movement you reach down to jack yourself off.");
	else if (player.cockTotal() > 1)
		//might be kind of interesting to include text that identifies the cocks you use, but is possibly pointless.
		outputText("  Your cock grows hard as you are penetrated, and with the creature handling the movement you reach down, jerking off a different cock with each hand.");
	outputText("\n\n");
	outputText("The slime pumps you hard, eliciting moans of arousal as you lean forward, finally giving in to instinct.  You find that it can easily support your weight as you lean on the thing's chest, using it as leverage as you buck your hips against it.  After a while the slime begins to react almost perfectly to your moaning and panting, changing its pace and size to incredible effect.  You feel exceptionally wet through the entire process, the creature's lubricant mixing with your own.  It has an aphrodisiac effect, intensifying your sensation and making your " + vaginaDescript(0) + " feel hot as you fuck it.  ");
	outputText("Before long you collapse entirely, resting your entire weight on the creature as it pulls your " + hipDescript() + " tightly against its own.  You let out a loud gasp as the thing begins to stir itself around inside of you, vigorously massaging your insides with its cock.  Before long this pushes you over the edge, and you clutch at the slime, pressing yourself against it as hard as you can.  ");
	//penis orgasm text
	if (player.cockTotal() > 1) {
		outputText("Your [cocks] explode into simultaneous orgasm, releasing ");
		outputText(num2Text(player.cocks.length));
		outputText(" thick streams of semen onto you and the creature, your mind blanking at the massive relief.  You vaguely notice your ejaculate sinking into the creature's body and getting absorbed as you give yourself to pleasure.  ");
	}
	else if (player.cockTotal() == 1)
		outputText("Your [cock] explodes into orgasm and releases thick streams of semen onto both you and the creature, your mind blanking at the release.  You vaguely notice your ejaculate sinking into the creature's body and getting absorbed as you give yourself to pleasure.  ");
	outputText("You feel a rush of liquid flood your insides, ");
	// !! NOTE
	// since this line is centered around previous sexual knowledge, change virginity status at the end of the event rather than beginning so this can fire properly.
	if(!player.vaginas[0].virgin)
		outputText("not as thick as semen, ");
	outputText("filling you past full and flowing out along the creature's cock, leaving you with a slight bulge at your belly and a pool of green fluids on the ground beneath you.  You gasp and hold your breath as you lay on the creature, its grip slowly loosening.  Its cock slides out of you, and a flood of liquid pours out of your " + vaginaDescript(0) + " as it begins to leak out from under you, gently letting you onto the ground.  You tremble on the ground for a few moments as you recover your wits, and once you do you realize that the creature has left.  You find no trace of the creature's presence afterward except a thin trail of green fluid leading to the nearby waters.");
	player.sexReward("vaginalFluids","Vaginal");
	dynStats("sen", 3);
	cleanupAfterCombat();
}

private function oozeButtRapesYou():void
{
	player.slimeFeed();
	outputText("You collapse under the beating from the slime's soft but heavy fists, dazed and disoriented.  You weakly try to resist as the slime rolls you onto your stomach and lifts your [butt] into the air as it takes up a position behind you.  It holds your head against the ground with one hand and strips off your clothes with the other, pressing its trunk up against you.  Its skin is soft, velvety, and firm, but it is also easily pliable.  You feel something grow out of its body and almost instantly realize what's going on.  The slime rubs its moist cock between your cheeks for a moment, before pulling back.  You realize with a tiny bit of fear that the creature's tool must be massive – over a foot, at least, and several inches wide!  It runs its tip over your ");
	//Girls get fondled.
	if(player.vaginas.length > 0) outputText(vaginaDescript(0)+ " and " + assholeDescript());
	//No coochie
	else {
		//Ballsy
		if(player.balls >= 2) outputText(assholeDescript()+ " and " + ballsDescript());
		//No balls, no pussy, just butt
		else outputText(assholeDescript());
	}
	outputText(" before settling over your rear entrance.  ");
	// virgins just assume it wont fit
	if(player.analCapacity() < 18 || player.ass.analLooseness == 0)
	{
		//...but this wont necessarily be a turnoff.  id put in some sort of formula that determines the corruption rating needed for this
		//based on player's current anus size, but that seems excessive and uneccesary.
		if(player.cor <= 33) outputText("You feel a bit of fear as you tremble under the creature's weight, worried about the damage that its massive size might do to your ass.  ");
		else if(player.cor < 66) outputText("In spite of your worries about the creature's size, you can't help but feel a little bit excited at the idea of having this beast take you from behind.  ");
		//and something special for the total whorebags that have somehow not already wrecked their asses.
		else outputText("You almost lick your lips in anticipation and push your hips back greedily, eager to feel the monster's cock stretch your asshole wide.  ");
  	}
	outputText("You grimace slightly, and it pushes at your sphincter, then penetrates.  You let out a slight gasp in spite of yourself as its cock warps, deforming to stretch your ass without pushing you beyond your limits.  It pushes itself several inches inside you and stops, pausing as you catch your breath and collect yourself.");
	//De-virgin
	player.buttChange(monster.cockArea(0), true);
	outputText("\n\n");
	outputText("With a deliberate slowness the slime pulls out of you and then thrusts back inside, this time going deeper than before.  It continues like this, and you realize that the penetration is entirely painless, the creature's pliability and moistness allowing it to easily glide inside you.  Before long you feel it bottom out inside you, its soft member curving perfectly through your insides as its trunk presses against your behind.  The slime begins fucking you with short, shallow strokes, and you feel a moistness build inside your ass as the creature's fluid begins to accumulate.  It begins to quicken and deepen its strokes as you feel a heat build inside of you, the creature's fluid apparently having an aphrodisiac effect.\n\n");
	outputText("Before long you find yourself moaning under the beast's attack, pleasure washing through your nethers in spite of yourself as it pumps your ass.  ");
	//cock arousal
	if(player.cockTotal() > 0) outputText("You feel pangs of pleasure run through your body as its member repeatedly strokes your prostate from the inside, stimulating it.  ");
	outputText("Its dick shifts slightly, continually growing and shrinking in tiny amounts in a continual, heavy throb.  ");
	//masturbation begin
	//Cawkz!
	if(player.cockTotal() > 0)
	{
		//Single
		if(player.cockTotal() == 1) outputText("You quickly grow erect under the creature's embrace as it pistons into your ass, and before long you stand at full attention.  You weakly rub yourself with one hand as it pumps you, and quickly approach orgasm.  ");
		//Multi!
		else outputText("Your " + multiCockDescript() + " quickly grows erect under the creature's embrace as it pistons into your ass, and before long you stand at full attention.  You weakly rub at a different cock with each hand as it pumps you, and quickly approach an orgasm.  ");
	}
	//Vaginas!
 	if(player.vaginas.length > 0) outputText("Your " + vaginaDescript(0) + " grows wet as the creature continues to assault you, and your cleft begins to ache for a soft touch.  As if sensing your thoughts the creature obligingly wraps a hand around and under you and begins alternating between sliding along your gash and stroking your " + clitDescript() + ".");
 	//New PG
	outputText("\n\n");
	outputText("The creature begins to throb more powerfully as its arousal builds, your own arousal growing with it, equally from sexual and fearful excitement.  With a final powerful thrust the creature rams its entire length inside you and you feel a surge of fluid run through its entire member before exploding from the tip.  You open your mouth in a silent shout as you lose your voice for a moment, unable to make a sound as liquid pours into you in an almost endless stream as its cock swells.  ");
	//Vaginal Orgasmzzzzzz
	if(player.vaginas.length > 0)
	{
		//hermaphrodite orgasm
		if(player.cockTotal() > 0) outputText("The creature finally plunges a pair of fingers into your " + vaginaDescript(0) + ", and between this and the additional pressure against your prostate you finally come, harder than you ever have before.  Thick ropes of jizm spray onto the ground as the feeling wracks your body.  ");
		//vaginal-only orgasm
		else outputText("The creature finally plunges a pair of fingers into your " + vaginaDescript(0) + ", the sudden shock finally pushing you to orgasm.  ");
	}
	//mangasm
	else if(player.cockTotal() > 0) outputText("The additional pressure against your prostate finally pushes you over the edge, and you cum hard, spraying your load against the ground.  Thick ropes of jizm spray onto the ground as the feeling wracks your body.  ");
 	outputText("You shudder beneath the creature as it slowly begins to pull out of you, which brings another moan to your lips.  When it finally pops free of your body you feel a deluge of fluid rush from your ass and onto the ground.  You recover yourself as the creature retreats back into the waters, leaving nothing but a trail of slime leading to the water's edge.");
	player.sexReward("vaginalFluids");
	dynStats("sen", 4);
	cleanupAfterCombat();
}

private function oozeRapesYouOrally():void
{
	player.slimeFeed();
	outputText("You collapse under the beating from the slime's soft but heavy fists, dazed and disoriented.  The creature surges forward, covering you and forcing you to the ground as it rests on your gut, putting just enough of its apparently enormous weight onto you to keep you pinned.  It leans forward, its massive upper body easily shadowing you, and ");
	//Low corrupppppption blush!
	if(player.cor < 20) outputText("you blush as ");
	outputText("a large erection shaped like a human's dick forms at the bottom of its torso.  The creature thrusts its hips forward, pushing this new appendage against your face and making its intent very clear.\n");
	if (sceneHunter.other) {
		outputText("Will you try to resist the creature, or eagerly suck its slimy cock?\n\n");
		menu();
		addButton(0, "Resist", resist);
		addButton(1, "Let it", let);
		addButton(2, "Suck", suck);
	}
	else {
		if (player.cor >= 66) suck();
		else if (player.cor >= 33) let();
		else resist();
	}
	//===============================================================================
	//slutty
	function suck():void {
		outputText("You lick the tip with more than a little bit of delight, noticing that the creature's skin is somewhat velvety, with a hint of a minty taste to it.  The thing obligingly runs its length along your face as you tease it with your tongue, enjoying its mild taste as it leaves traces of greenish fluids on your face.  Eventually the beast pulls back and rests its tip against your lips, nudging you several times to get you to open your mouth wide before pushing inside your mouth.\n");
		outputText("It pistons the head of its shaft back and forth in your mouth for a bit as you rock your head back and forth and suck on it.  A pleasant tingle starts in your mouth, and the thing pushes itself to the back of your throat and holds it there, making you squirm in anticipation.  It pulls back slowly, then fiercely thrusts forward.  You feel the soft material of its member squeeze into your throat and contort to perfectly fill you, going deeper and deeper until the bulk of its body is just a few inches away from your face.\n");
		if(player.cockTotal() > 0)
		{
			if(player.lust > 40) outputText("Your erect [cocks] throbs as you work the creature, a surge of even greater arousal flowing through your body.  You feel almost desperate for release and even thrust your hips impotently against the empty air, wishing for some form of release.  You try to reach for yourself to masturbate, but find yourself unable to reach around the slime's massive bulk.  ");
			else outputText("You feel your [cocks] begin to harden just slightly as you work the creature, a surge of arousal flowing through your body.");
		}
		if(player.vaginas.length > 0) {
			outputText("Your [vagina] ");
			if(player.cockTotal() > 0) outputText("also ");
			outputText("grows wet as you work the creature, a surge of arousal flowing through your body.  You rub your thighs together and moan into the creatures cock, desperate to be touched by something.");
			// this line is here because it makes no sense for the player to try to reach their genitals twice.  i think i got the logic right.
			if(player.cockTotal() < 1 || player.lust <= 40) outputText("You try to reach for yourself to masturbate, but find yourself unable to reach around the slime's massive bulk.");
		}
		outputText("The slime lets itself rest in your throat for a moment, and you relish the feeling of it pressing against the inside of your throat, and your entire body begins to tingle with arousal.  Before long you find yourself moving with the creature, and before long you're taking its cock all the way into your throat, pressing your nose up against it as you try to coax if further into you.  The slime speeds up and begins to throb inside you, each pulse of its cock making your throat feel even tighter, but never quite enough to be painful.\n");
		outputText("With a final strong thrust the thing rams your face against its hips, and you feel a surge of fluid flow down its member and explode into your stomach.  It releases several spurts of fluid into your gullet before it begins to draw out, dribbling fluid into your throat.  It pauses as it pulls its cock head into your mouth and releases a final blast of fluid, which you quickly swallow as it pulls out.  It releases a few final spurts onto your face as it begins to withdraw, and you lick your lips and begin to rub the fluid into your skin.  ");
		if(player.lust > 40) {
			outputText("The creature withdraws as you begin to masturbate, furiously working yourself to a quick, but powerful, orgasm.  By the time you recover, it is long gone.");
			player.sexReward("vaginalFluids");
		}
		else outputText("The creature withdraws while you're distracted, leaving no traces of its presence save for what it left on your body.");
		player.sexReward("vaginalFluids");
		player.refillHunger(35);
		dynStats("lib", 2, "sen", 2, "lus", 10);
		cleanupAfterCombat();
	}
	//standard
	function let():void {
		outputText("You make only minor attempts to thwart the creature as it forces its way between your lips, not exactly aroused by its decision but certainly glad that it didn't decide to kill you.  Its member squishes, deforms, and expands to conform to the shape of your mouth as it begins to pump your mouth, going deeper with each stroke.  You brace yourself as it pauses at your lips for a moment before slowly pushing deeper and deeper into your mouth, and then your throat.  You almost feel yourself gag, but find that the creature's unique material helps it to avoid this reaction.  The creature keeps pushing until your nose presses against its main body and holds there for a moment, its cock filling your mouth and throat entirely.\n");
		outputText("It pulls out just as suddenly, leaving you gasping, leaving a thin trail of green fluid across your face as it pulls away.  Shifting its weight slightly it begins to explore your mouth and lips with one of its hands, and you realize that the creature tastes just slightly of mint.  After a moment it returns its cock to your mouth, thrusting quickly and deeply to again fill your throat, and this time begins pumping your face in earnest.  It begins to throb in your throat, slowly expanding and contracting in a steady, and quickening, rhythm.  You can feel its arousal grow with every thrust, and in spite of yourself, get caught up in the creature's desires.\n");
		outputText("Without warning the creature leans forward, grabs you head, and pulls forward as it thrusts, forcing your face into its soft body as its cock goes as deep as it can possibly go.  Its cock practically shivers as you steel yourself for what's about to come, but the creature pulls you off, a powerful blast of thin, green fluid catching you in the face as soon as your mouth is empty.  You try to push your head forward to catch the thing's load more out of instinct than conscious thought, only to have it hold you back as it releases several powerful torrents of ejaculate onto your face.\n");
		outputText("The beast moves off of you, and you roll over onto your hands and knees, coughing and spitting up green fluid as you recover your senses.  When you finish you look around for the creature but find no traces of it except the fluid on the ground and a slight taste of mint in your mouth.");
		player.sexReward("vaginalFluids","Lips");
		player.refillHunger(15);
		dynStats("lib", 2, "sen", 2, "lus", 10);
		cleanupAfterCombat();
	}
	//resistant
	function resist():void {
		outputText("You close your mouth tightly as the penis rubs against your face, the soft, moist skin leaving a trace of green fluid around your mouth.  You try to turn away, and the thing forms a third arm from its chest, pressing it over your mouth.  ");
		if(player.inte > player.tou && !sceneHunter.other) outputText("You force yourself to keep your mouth shut in spite of the lack of air, holding out for as long as you can.  Eventually you become light-headed, and pass out.  When you wake up there is no trace of the creature, save for the fluid covering your mouth, chest, and the ground around you.");
		else {
			outputText("You force yourself to keep your mouth shut in spite of the lack of air, holding out for as long as you can.  Eventually you become light-headed, and instinctively open your mouth to gasp for air.  As soon as you do the creature rams its member into your mouth, thankfully releasing its grip on your face as it does.  You choke for a moment as the beast fills your mouth, thankfully pausing while you catch your breath.\n");
			outputText("As soon as you've steadied yourself you feel the thing begin to move again, its shaft slowly forcing its way down your throat.  In spite of its apparent size it easily squeezes to fit the size and contour of your mouth and then throat.  Your eyes widen slightly as it slides deeper and deeper, feeling tight in your throat.  You instinctively reach up to your face and throat, but find yourself completely unable to either push it away or keep it from forcing its way deeper.  Feeling at your throat you realize with a little bit of shock that it's bulging ever so slightly from the cock down your throat.  Eventually you take its foot, and a half long shaft nearly to the hilt before it stops, then begins to pull back  as it rapes your mouth and throat.");
			outputText("You squirm under the slime as it begins to thrust faster and faster, and soon its shaft begins to throb powerfully, pressing even further out against your throat.  Eventually the thing takes a final powerful thrust into your mouth and arches its back, releasing a powerful torrent of fluid directly into your stomach.  After several strong spurts the thing begins to pull out, pausing as the head of its cock reaches your mouth to fill it with another powerful blast.  You try to avoid swallowing, but the suddenness and sheer amount of it forces a bit down your throat.  The thing eventually pulls all the way out, and you cough as you eject the remaining juice.\n");
			outputText("The beast moves off of you, and you roll over onto your hands and knees, coughing and spitting up green fluid as you recover your senses.  When you finish you look around for the creature but find no traces of it except the fluid on the ground and a slight taste of mint in your mouth.");
		}
		player.sexReward("vaginalFluids", "Lips");
		player.refillHunger(35);
		dynStats("lib", 2, "sen", 2, "lus", 10);
		cleanupAfterCombat();
	}
}

private function oozeRapesYouVaginally():void
{
	player.slimeFeed();
	outputText("You collapse under the beating from the slime's soft but heavy fists, dazed and disoriented.  The creature lunges at you with surprising speed, grabbing you by the ankles and pulling you towards it.  You try to pull away as it pulls you up against its trunk, momentarily fearful that it's going to try and absorb you.  ");
	//shy result
	if(player.cor <= 33) {
		outputText("This fear quickly disappears as a large, human cock grows from the creature's trunk, and is replaced by an entirely different fear as you realize what it is planning.  The slime wraps its arms around your [legs] and squeezes them around its cock.  It moves back and forth several times, sliding its member over your [skin.type] and along your " + vaginaDescript(0) + ".  Its skin is soft and velvety, slightly moist, and leaves a thin trace of green fluid behind.\n\n");
		outputText("You begin to feel a tingle in your nethers as your " + vaginaDescript(0) + " grows wet.  Without warning the creature pulls your legs apart and draws its member back along your crotch, pausing a moment to rest the tip on your sex.  You watch it with equal parts excitement and anxiety and steel yourself as it holds there for a moment.");
		if(player.vaginas[0].virgin) outputText("The thing slowly presses against you to penetrate, and you grab at the grass beneath you, absolutely certain that it won't fit.  You bite your bottom lip as the cock pierces your virginity, arcing your back as a sharp pang of pain runs through you.  You let out a stuttering gasp as it penetrates deeper into your body, filling the contours of your interior perfectly.  It coats your inside with a tingling, soothing fluid that quickly turns whatever pain you may have felt into a wonderful pleasure.  When the creature finally bottoms out inside you, what remains of its length seems to slide back into the creature's body.  ");
		//Middle coochie
		else if(player.vaginalCapacity() < 18) outputText("The thing slowly presses against you to penetrate, and you grab at the grass beneath you, almost entirely certain that it won't fit.  You bite your bottom lip to hold in a moan as the cock slides into your " + vaginaDescript(0) + ", its girth squeezing down to comfortably slide into you.  You let out a pleasant sigh as it penetrates deeper into your body, filling the contours of your interior perfectly until it finally bottoms out.  What remains of its length seems to slide back into the creature's body as it pulls your hips against its trunk.  ");
		//Ginormo coochie
		else if (player.vaginalCapacity() <= 30) outputText("The thing slowly presses against you to penetrate, and you grab at the grass beneath you.  A soft moan escapes your lips as the cock slides into your " + vaginaDescript(0) + ", its girth changing slightly to fit you almost perfectly, stretching you just the right amount.  Your moan grows louder as it penetrates deeper into your body, filling the contours of your interior perfectly until your hips finally touch its trunk.  There's a short pause, and you gasp as the slime's member then grows inside you, lengthening to fill your " + vaginaDescript(0) + " perfectly.  ");
		//MEGA coochie
		else outputText("The thing slowly presses against you to penetrate, and you grab at the grass beneath you.  A soft moan escapes your lips as the cock slides into your " + vaginaDescript(0) + ", its girth changing slightly to fit you almost perfectly, stretching you just the right amount.  Your moan grows louder as it penetrates deeper into your body, filling the contours of your interior perfectly until your hips finally touch its trunk.  There's a short pause, and you gasp as the slime's member then grows inside you, lengthening until it nearly fills your " + vaginaDescript(0) + ".  ");
		player.cuntChange(monster.cockArea(0),true,false,true);
		outputText("You arch your back slightly as the slime begins moving, slowly pumping your " + vaginaDescript(0) + ".  As it picks up speed a small amount of the thing's greenish fluid builds up around your lower mouth, making your skin tingle and filling you with an unusual arousal.\n\n");
		//Cocks
		if(player.cockTotal() > 0)
		{
			//Multi biiiiitches
			if(player.cockTotal() > 1)
			{
				outputText("Your " + multiCockDescript() + " rapidly grows erect under this assault and begins to throb.  Having now released yourself to instinct you reach to jerk off, ");
				if(player.cockTotal() > 2) outputText("switching between cocks as you rapidly stroke yourself in time with the creature's movements.  ");
				else outputText("rapidly stroking one cock with each hand, working yourself in time with the creature's movements.  ");
			}
			//Single dick
			else outputText("Your [cock] rapidly grows erect under this assault and begins to throb.  Having now released yourself to instinct you reach to jerk off, rapidly stroking your [cock] in time with the creature's movements.  ");
		}
		outputText("After a short time the creature penetrates you fully again and stops, and you realize that at some point you had begun moving your hips with it.  You gasp in surprise as the slime's cock begins churning inside of you, massaging you from the inside in a uniquely pleasurable fashion.\n\n");
		outputText("It doesn't take much of this to bring you to orgasm.  Your entire body shudders, and you arch your back as shocks of pleasure run through you.  The creature pulls you tightly against it and swells just slightly as its movement inside you slows and then stops, then swells at the tip for just a second before releasing a flood of thin, cool fluid inside of you.  It forces its way around the creature's cock and spills out of you.  ");
		//Dicks again!
		if(player.cockTotal() > 0)
		{
			//Multi
			if(player.cockTotal() > 1) outputText("Your " + multiCockDescript() + " climaxes as well, sending rope after rope of hot, thick cum onto your face and chest.");
			//Single
			else outputText("Your member climaxes as well, and you pull a hand to cover your eyes and face as your jism explodes onto yourself.  Your other hand slides to the base of your [cock] and squeezes as you coat your chest in semen.");
		}
		player.sexReward("vaginalFluids","Vaginal");
		dynStats("sen", 4);
	}
	//standard result
	else
	{
		outputText("This fear quickly disappears as a large, human cock grows from the creature's trunk, and is replaced by excitement as you realize what it is planning.  The slime wraps its arms around your legs and squeezes them around its cock.  You moan softly as it moves back and forth several times, sliding its member between your thighs and along your " + vaginaDescript(0) + ".  Its skin feels wonderfully soft and velvety, slightly moist, and leaves a thin trace of green fluid behind.\n\n");
		outputText("You begin to feel a tingle in your nethers as your " + vaginaDescript(0) + " grows wet.  Without warning the creature pulls your legs apart and draws its member back along your nethers, pausing a moment to rest the tip on your sex.  You push yourself up against it impatiently, growing even wetter from the anticipation.  ");
		//VIRGIIIIIN
		if(player.vaginas[0].virgin)
		{
			outputText("The thing slowly presses against you to penetrate, and you grab at the grass beneath you, certain that it won't fit, but excited to finally have sex for the first time.  You bite your bottom lip as the cock pierces your virginity, arcing your back as a sharp pang of pain runs through you.  You let out a stuttering gasp as it penetrates deeper into your body, filling the contours of your interior perfectly.  It coats your inside with a tingling, soothing fluid that quickly turns whatever pain you may have felt into a wonderful pleasure.  When the creature finally bottoms out inside you, what remains of its length seems to slide back into the creature's body.  ");
			player.cuntChange(15, true);
		}
		//TIGHT
		else if(player.vaginalCapacity() < 18) outputText("It finally begins to penetrate you, and you grab at the grass beneath you, excited and anxious for it to try and squeeze itself into you.  You bite your bottom lip hold in a moan loudly as the cock slides into your " + vaginaDescript(0) + ", its girth squeezing down to comfortably slide into you.  You let out a pleasant sigh as it penetrates deeper into your body, filling the contours of your interior perfectly until it finally bottoms out.  What remains of its length seems to slide back into the creatures body as it pulls your hips against its trunk.  ");
		//Loose
		else
		{
			outputText("It finally begins to penetrate, and you grab at the grass beneath you, delighted that its cock seems large enough to fill you");
			//SLUT!
			if(player.vaginalCapacity() >= 30) outputText(" at least partly");
			outputText(".  A deep, throaty moan escapes your lips as the cock slides into your " + vaginaDescript(0) + ", its girth changing slightly to fit you perfectly, stretching you just the right amount.  Your moans grow even louder as it penetrates deeper into your body, filling the contours of your interior perfectly until your hips finally touch its trunk.  There's a short pause, and you let out a delighted gasp as the slime's member then grows inside you, lengthening to fill your " + vaginaDescript(0));
			if(player.vaginalCapacity() >= 30) outputText(" almost perfectly.\n");
			else outputText(" perfectly.\n");
		}
		outputText("You arch your back in pleasure as the slime begins moving, slowly pumping your wet " + vaginaDescript(0) + ".  It picks up speed, and a small amount of the thing's greenish fluid builds up around your lower mouth, making your skin tingle and filling you with an unusually strong arousal.");
		//Herm text goes here
		if(player.cockTotal() > 0)
		{
			//Multi herms
			if(player.cockTotal() > 1)
			{
				outputText("Your " + multiCockDescript() + " rapidly grows erect under this assault and begins to throb.  Having now released yourself to instinct you reach to jerk off, ");
				//Lotsa dicks
				if(player.cockTotal() > 2) outputText("switching between cocks as you rapidly stroke yourself in time with the creature's movements.  ");
				else outputText("rapidly stroking one cock with each hand, working yourself in time with the creature's movements.  ");
			}
			//Single herms
			else outputText("Your [cock] rapidly grows erect under this assault and begins to throb.  Having now released yourself to instinct you reach to jerk off, rapidly stroking your [cock] in time with the creature's movements.  ");
		}
		//CUM
		outputText("After a short time the creature penetrates you fully again and stops, and you continue to buck your hips against it for a few moments more until it grabs your thighs and holds you tightly and motionless against it.  You quiver against it and moan with desire, desperately wishing that it would continue fucking you.  You gasp in surprise as the slime's cock begins churning inside of you, massaging you from the inside in a uniquely pleasurable fashion.\n\n");
		outputText("It doesn't take much of this to bring you to orgasm, and you feel your entire body shudder.  You arch your back as shocks of pleasure run through you, your entire body tensing from the force of the orgasm.  The creature pulls you tightly against it and swells just slightly as its movement inside you slows and then stops, then swells at the tip for just a second before releasing a flood of thin, cool fluid inside of you.  This release doubles the strength of your own orgasm as the fluid forces its way around the creature's cock and spills out of you.  ");
		//Herms cum
		if(player.cockTotal() > 0)
		{
			//multi
			if(player.cockTotal() > 1) outputText("Your " + multiCockDescript() + " climaxes as well, and you open your mouth as you spray rope after rope of hot, thick jism onto your face and chest.  You relish its salty taste, continuing to stroke yourself even as you come.  ");
			//single cock
			else outputText("Your own member finally reaches its climax as well, and you open your mouth as jism explodes onto your face and chest.  Your hands slide to the base of your [cock] and squeeze as you release thick ropes of ejaculate onto yourself, coating your face and chest as you relish its salty taste.  ");
		}
		outputText("You pant as the creature holds perfectly still for a minute, then slowly lets you down as its erection slides out of you.  When the last of its dick finally pops out, a rush of its green slime flows out of you and onto the ground.  The creature leaves you to recover your strength, retreating into the nearby water.");
		player.sexReward("vaginalFluids");
		dynStats("sen", 4);
	}
	cleanupAfterCombat();
}


internal function rapeOozeWithMilk():void {
	clearOutput();
	outputText("You look over the ooze, wondering what to do about your need to nurse now that it has lost cohesion. After a while of puzzling things out, you decide to wing it, " + player.clothedOrNaked("removing the top of your [armor] and ") + "pressing the mess of a monster to your " + breastDescript(0) + " and giving it a squeeze to get the milk to it. The slime responds almost immediately, applying pressure from the base of your " + breastDescript(0) + " to the tip of your " + nippleDescript(0) + ", earning it a shot of milk to your immense satisfaction. As it tends to your " + nippleDescript(0) + ", it slowly works its way down your body, almost lovingly ");

	// [If male-
	if(player.gender == 1)
	{
		outputText("caressing your " + multiCockDescriptLight());
		if(player.balls > 0)
			outputText(", and slipping slightly further down to engulf your [balls] as well");
		outputText(". ");
	}
	// [if female-
	else if(player.gender == 2)
		outputText("manipulating your " + clitDescript() + ". ");
	//[If Herm-
	else if(player.gender == 3)
	{
		outputText("caressing your " + multiCockDescriptLight());
		if(player.balls > 0)
			outputText("and slipping slightly further down to engulf your [balls] as well. ");
		else outputText("and almost dripping down to coat your " + clitDescript() + " to add to your pleasure. ");
	}
	//[If Genderless-
	else {
		outputText("caressing the blank spot where your genitalia should be" + player.clothedOrNaked(" despite your [armor] still being in place") + ". ");
		outputText("\n\n");
		outputText("The barrage of pleasurable feelings causes you to fall over onto your [butt] and just soak in them, your hands ");
	}
	//[if male or genderless-
	if(player.gender < 1) outputText("gripping the ground as the slime has left you nothing to do; adding your hands to the mix feels like it'd be an insult to the creature's expert work.  ");
	//if duder
	else if(player.gender == 1) outputText("Your hands grip the ground as the slime has left you nothing to do; adding your fingers to the mix feels like it'd be an insult to the creature's expert work.  ");
	//[if female or Herm-
	else outputText("Your hands fly to your " + vaginaDescript(0) + " and frantically plunge your fingers in and out of it.  You wish the slime would engulf it as well.  ");

	outputText("You cum many times into the mass, but that's not what truly matters to you. It's an extremely welcome, mind-shatteringly satisfying bonus, but not the main event. What does matter is the slow, meticulous draining of milk from both of your " + breastDescript(0) + " at once that the ooze is doing for you. Feeling that it's on the last of your milk, you urge the ooze on, trying to get it to crank up its work on your now-overly sensitive ");

	//[if male-
	if(player.gender == 1) {
		outputText(multiCockDescriptLight());
		if(player.balls > 0) outputText(" and " + ballsDescript());
		outputText(" and ");
	}
	//[if female-
	else if(player.gender == 2) outputText(clitDescript() + " and ");
	//[if Herm-
	else if (player.gender==3) {
		outputText(multiCockDescriptLight());
		if(player.balls > 0) outputText(", [balls]," );
		outputText(" and " + clitDescript() + " and ");
	}
	outputText(breastDescript(0) + ".\n\n");

	outputText("Unfortunately, you seem to have done a little too much to it in your battle before. The ooze slides off, leaving you hanging on the edge of orgasm. Deciding you just won't stand for this, you scoop up most the mess left by the monster and use it as a masturbation aid, achieving sweet release by ");
	if(player.gender == 1) outputText("feverishly jacking yourself off with it.  The cool feel of it contrasts enough to send you over the edge relatively quickly, and you release your cum into it.  You drop most of its bulk ");
	//[if female-
	else if(player.gender == 2) outputText("rapidly entering it in and out of your " + vaginaDescript(0) + " by way of your fingers.  The cool feel of it contrasts enough to send you over the edge relatively quickly, and you release your juices into it.  You flick it off your fingers ");
	//[if herm-
	else if(player.gender == 3) outputText("feverishly jacking yourself off with it while rapidly entering it in and out of your " + vaginaDescript(0) + " by way of your fingers.  The cool feel of it contrasts enough to send you over the edge relatively quickly.  You release your cum into it while it absorbs the juices from your " + vaginaDescript(0) + ".  You drop some of its bulk ");
	//[if genderless-
	else outputText("rubbing it over your " + assholeDescript() + ".  The cool feel of it contrasts enough to send you over the edge relatively quickly, and you drop it as you feel your muscles spasm with the phantom orgasm ");

	outputText("while using the rest of it to coat your " + nippleDescript(0) + " in order to give it the last of your milk.\n\n");

	outputText("Now empty, you leave the ooze in the pile it's in and walk away, feeling somewhat disappointed by the lackluster ending of it all, but overall satisfied with the fact that you've nursed.\n\n");

	//set lust to 0, increase sensitivity slightly
	player.sexReward("vaginalFluids");
	dynStats("lib", .2);
	//You've now been milked, reset the timer for that
	player.addStatusValue(StatusEffects.Feeder,1,1);
	player.changeStatusValue(StatusEffects.Feeder,2,0);
	cleanupAfterCombat();
}

		public function slimeLoss():void
		{
			clearOutput();
			sceneHunter.selectLossMenu([
					[0, "Vaginal", oozeRapesYouVaginally, "Req. a vagina", player.hasVagina()],
					[1, "Anal", oozeButtRapesYou],
					[2, "Oral", oozeRapesYouOrally]
				],
				"You can't win this fight. But maybe you could tease the green blob, so it would rape you in the way that you prefer?\n\n"
			);
		}
	}
}
