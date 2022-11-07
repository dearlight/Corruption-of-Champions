/**
 * Created by aimozg on 03.01.14.
 */
package classes.Scenes.Areas.Swamp
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armors.LustyMaidensArmor;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

public class MaleSpiderMorphScene extends BaseContent
	{
		public function MaleSpiderMorphScene()
		{
		}

		//Greeting
		public function greetMaleSpiderMorph():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_spiderguy);
			outputText("A spider-morph drops out of a tree in front of you, hanging by a single thread of sparkling webbing.  His purple eyes gaze deeply into your own while he looks you up and down.  ");
			//DANGER MODE:
			if (rand(2) == 0) {
				outputText("A moment later, he flips down onto his feet and advances, touching his half-hard, foreskin-shrouded cock.  Judging from the glint in his eyes, he plans to force himself upon you!");
				//- auto fight
				startCombat(new MaleSpiderMorph());
			}
			//NICE GUY MODE:
			else {
				outputText("He breaks into a smile and says, \"<i>Hi there!  I haven't seen anyone else with a shred of sanity in FOREVER.  Would you mind just, talking with me?</i>\"");
				//[Fight] [Talk] [Leave]
				simpleChoices("Fight", fightSpiderBoy, "Talk", talkToSpiderBoy, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
			}
			if (flags[kFLAGS.CODEX_ENTRY_ARACHNES] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_ARACHNES] = 1;
				outputText("\n\n<b>New codex entry unlocked: Arachnes, Spider-Morphs, and Driders!</b>")
			}
		}

		private function fightSpiderBoy():void {
			startCombat(new MaleSpiderMorph());
			spriteSelect(SpriteDb.s_spiderguy);
			playerMenu();
		}

//Talk
		private function talkToSpiderBoy():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_spiderguy);
			outputText("The male spider-morph grins even wider, displaying the partially retracted tips of his two fangs.  You smile back nervously while he rotates about and drops lightly onto his feet, gleefully approaching you in spite of his nudity.  Sensing your discomfort, he stops a few yards away and pulls some food from a pouch on his hip, offering you some dried meats and fruits.  You take one of the more harmless looking ones and sit down with him.  ");
			player.refillHunger(20, false);
			outputText("He starts talking first, telling of how his people were a young race of transformed off-worlders.  The demons put a quick end to that, and recruited a large amount of the more aggressive driders and arachnes from his tribe.  He quickly explains that arachne are like him, but with chitinous exoskeletons covering their whole body, except for the face.  Driders on the other hand, have the body of a human from the hips up, but a giant spider body below.\n\n");
			outputText("You talk of your own people, and the good times you had in Ingnam growing up, but you keep coming back to the sadness of losing so many young adults to becoming champions.  Eventually you go over your own selection, training, and eventual journey.  The spider-morph listens with rapt attention the whole way through.\n\n");
			outputText("\"<i>Wow,</i>\" comments the arachnid male, \"<i>that's quite the story.  Thank you so much for talking to me today.  Here, take this.  If you ever want to have your own venom or webbing, eat as much of it as you can.  Who knows, maybe it'll help you take down the demons somehow?</i>\"\n\n");
			outputText("He stands and gives you a bundle of pink fibers with a nervous bow.  You look down at the gossamer strands in your hands, and when you glance back up, he's gone.  ");
			inventory.takeItem(consumables.S_GOSSR, camp.returnToCampUseOneHour);
		}

//*Victory Pretext:rr
		public function defeatSpiderBoy():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_spiderguy);
			outputText("The male spider-morph collapses onto his hands and knees, ");
			if (monster.lust >= monster.maxLust()) outputText("masturbating with furious abandon, working his ebon dick with such vigor that the spider's pre-cum-slicked dick-skin noisily slides itself back and forth over his fattened glans; it becomes apparent just how much foreskin he truly has at this point, as even with his frenzied rubbing his glans remains shrouded in the thick excess skin while his fist slaps lewdly against his groin.  Dribbles of pre-cum leak from between his fingers to spill on the ground.");
			else outputText("wobbling back and forth as he tries to stay up and fight.  There's no way he can oppose you, as beaten as he is now.");
			if (player.gender > 0 && player.lust >= 33) {
				outputText("\n\nYou're not aroused enough to rape him.");
				cleanupAfterCombat();
				return;
			}
			outputText("\n\nWhat do you do?");
			menu();
			addButtonIfTrue(0, "Mount", victoryCowgirlRidingOnSpiderBoi,
				"Req. a vagina.", player.hasVagina());
			addButtonIfTrue(1, "FuckHisButt", victoryButtFuck,
				"Req. dick with area smaller than " + monster.analCapacity(),
				player.findCock(1, -1, monster.analCapacity()) >= 0);
			addButtonIfTrue(2, "Frot", victoryFrotTheSpoidah,
				"Req. dick with area smaller than " + monster.analCapacity(),
				player.findCock(1, monster.analCapacity(), -1) >= 0);
			LustyMaidensArmor.addTitfuckButton(3);
			SceneLib.uniqueSexScene.pcUSSPreChecksV2(defeatSpiderBoy);
			addButton(14, "Leave", cleanupAfterCombat);
		}

//Loss selector
		public function loseToMaleSpiderMorph():void
		{
			if (player.gender == 0) {
				clearOutput();
				outputText("The raven-haired spider-guy tears off your [armor], and disgusted by what he finds, he kicks you in the head, knocking you out.");
				player.HP = 1;
				cleanupAfterCombat();
				return;
			}
			sceneHunter.selectLossMenu([
					[0, "Anal", spiderBoyLossMaleButtfuck],
					[1, "Vaginal", loseToSpiderBoyVagFucked, "Req. a vagina.", player.hasVagina()]
				],
				"The spider-morph starts stroking his cock, preparing to fuck you. But even though his mind is dominated by lust, he can be reasoned with. Maybe you could ask him to select the way you'd like more?\n\n"
			);
		}

//*Victory Buttfucko
		private function victoryButtFuck():void
		{
			var x:int = player.cockThatFits(monster.analCapacity());
			clearOutput();
			spriteSelect(SpriteDb.s_spiderguy);
			//*Summary:  Reaming some anus.
			outputText("You approach and turn the spider-boy around, pushing the spider's bulbous abdomen aside to give yourself a better view of his tight, heart-shaped ass.  ");
			if (monster.lust >= monster.maxLust()) outputText("He's too distracted by his foreskin fondling to pay much attention to your anal-focused attentions.");
			else outputText("He's too busy trying to stay upright to fight off your anal-focused attentions.");
			outputText("  With a wide smile on your face, you grab a handful of his pale butt-cheek and squeeze your fingers into the soft flesh.  It spreads his dainty derrière just wide enough for you to see the puckered star of his rectum.  " + SMultiCockDesc() + " ");
			if (player.lust < (player.maxLust() * 0.7)) outputText("hardens to full size");
			else outputText("bobs happily");
			outputText(" against your [armor], eager to take the dark hole.\n\n");

			outputText("The arachnid finally realizes what you intend to do, and he whimpers plaintively, \"<i>P-please... don't put it there.  ");
			if (rand(3) == 0) outputText("I-I've never had anything in there...");
			else outputText("I-I don't want anything in there...");
			outputText("</i>\"\n\n");

			outputText("You grab his balls and caress them in one hand while you take off your equipment with the other.  The hapless victim starts to relax from the attentions, and pre-cum begins to leak from inside his foreskin ");
			if (monster.lust < monster.maxLust()) outputText("after he starts touching himself.");
			else outputText("while he fondles and caresses the sensitive flesh.");
			outputText("  Meanwhile, you grab " + oMultiCockDesc() + " and line it up with the spider-boy's twitching rectum, rubbing the " + player.cockHead(x) + " over the tight little hole while you wait for it to slowly loosen.  A fresh dollop of pre-cream bubbles out of his cum-frothing foreskin in response, letting you know that in spite of his protests, your reluctant lover's body loves the anal stimulation.\n\n");

			outputText("After a little more gentle pressure and a few more gentle caresses of his testicles, the defeated male finally relaxes enough for you to put the first inch inside him.  His tunnel is so hot that it feels like your " + cockDescript(x) + " is going to melt inside his sweltering embrace, and much worse, his sphincter clamps down hard enough to trap your " + player.cockHead(x) + " inside his toasty tail-hole.  Holding tightly to his ass and balls, you yank your clenching, anal slut down hard, forcing him to stretch while the rest of your " + cockDescript(x) + " burrows deep inside him");
			if (player.cockTotal() > 1) {
				outputText(", your other penis");
				if (player.cockTotal() == 2) outputText(" resting atop the small of his back");
				else outputText("es splaying out over his butt");
			}
			outputText(".\n\n");

			outputText("The spider-morph cries out, \"<i>Oww... it's stretching me so much!  B-b-but why does it feel good?</i>\"\n\n");
			outputText("Chuckling at his admission of enjoyment, you let go of the spider's twitching ball-sack and take advantage of your free hand to slap his pale white ass.  It leaves a red, hand-shaped mark on his perfect little hiney, a temporary reminder of your authority.  His abdomen rubs against your belly as you start to fuck him, the heavy organ swaying with the gentle sawing motions of two bodies locked in anal coitus.  You gradually increase the tempo and quickly reach a point where your hips are slapping against his butt with loud, echoing smacks.\n\n");
			outputText("The arachnid male squirms under you, whimpering, \"<i>W-Why is it feeling so good?  It's-ooohh-making my dick so hot.  It feels like it's gonna explode!</i>\"\n\n");
			outputText("You whisper back that it feels good because he's a spider-slut, and you give him another hard slap to emphasize your point.  He whimpers and dribbles white cream into the dirt, his balls churning against you");
			if (player.balls > 0) outputText("r own");
			outputText(" during the brief instant you've got him hilted.  Inspired by his submissive, orgasm-induced dribbling, you reach down to catch some of his cream in your hand.  He isn't squirting enough to fully fill your hand, so you lean back and hilt him again, roughly milking his spooge into your palm.  You take the handful of cum and hold it to his mouth.  He licks up his wasted seed like a good little bitch, shuddering in between swallows while you continue to dominate his asshole.\n\n");
			outputText("Once he's had most of it, you wipe the rest off in his raven-black hair, marking him as your spooge-slurping semen-slut.  He looks back with tearful eyes, but his beet-red cheeks and pursed, white-glazed lips tell a different story.  The spider-boy keeps mewling and moaning, strangling off his own sounds of pleasure as if he could deny the steady flow of seed that drips from his droopy, foreskin-shrouded shaft.\n\n");

			outputText("You go wild on him, fucking his ass hard.  His limp dick swings back and forth, slapping down at his balls while it continues to spew white globs into the ground.  Watching the little slut cream out his load in response to your anal 'massage' sends a sexual thrill through your body, and when his tight little ass-ring clamps down on your " + cockDescript(x) + ", you're pushed to ejaculation as well.  Your spunk glazes his intestines with cum, coating them in the thick white goo of your liquid love.");
			if (player.cockTotal() == 2) outputText("  The leftover dick spurts out its half of your load over his ass, making it look more pearly-white than ever before.");
			else if (player.cockTotal() > 2) outputText("  The leftover dicks spurt out their portion of your load across his ass-cheeks, making them look more pearl-white than ever before.");
			if (player.cumQ() >= 500) {
				outputText("  His belly is ");
				if (player.cumQ() >= 1500)outputText("heavy and ");
				if (player.cumQ() < 1000) outputText("slightly ");
				outputText("distended by the time you finish.");
			}
			outputText("\n\n");

			outputText("Pushing the spider-boy off you, you smile and watch the slut's gaped asshole slowly close, ");
			if (player.cumQ() < 50) outputText("trickles");
			else if (player.cumQ() < 1000) outputText("streams");
			else outputText("rivers");
			outputText(" of semen sliding out of the abused opening.  He rolls onto his side and pants, still leaking his thick goo from the limp, weak little cock between his legs.  You bend down and wipe your dick off on his face, letting him lick at it like a trained puppy.  Once cleaned, you get dressed and wander back to camp, leaving the spider to recover from the ordeal.");
			player.sexReward("Default","Dick",true,false);
			cleanupAfterCombat();
		}

//*Victory Frotting? (too biggo)
		private function victoryFrotTheSpoidah():void
		{
			var x1:int = player.biggestCockIndex() + 1;
			clearOutput();
			spriteSelect(SpriteDb.s_spiderguy);
			outputText("You push the ");
			if (monster.lust >= monster.maxLust()) outputText("masturbating");
			else outputText("injured");
			outputText(" spider-morph over onto his back and laugh at his relatively tiny dick.  It's no wonder he jumped you wanting sex - the girls probably took one look at the unimpressive member and took off running.  You take off your [armor] and let " + sMultiCockDesc() + " flop free.  ");
			if (player.cockTotal() == 1) outputText("Dropping it squarely ");
			else outputText("Dropping the largest ");
			outputText("atop his miniature cock, you virtually bury it in a superior male's heavy penile flesh.  ");
			if (monster.lust >= monster.maxLust()) outputText("He pants in surprise and pleasure, clearly enjoying the weighty shaft rubbing against his drooping dick-skin");
			else outputText("He gasps in surprise and slowly growing pleasure, clearly enjoying the weighty shaft rubbing against his drooping dick-skin");
			outputText(".  You sway your " + hipDescript() + " to drag your [cock "+x1+"] all over his body, and the defeated boy's pale white skin slowly colors pink with a full-body blush.\n\n");

			outputText("Trapped below your sizable weight, the turgid spider-shaft slowly leaks pre-cum from its tiny cum-slit.  The added moisture proves to be just the lubrication you needed, and you begin to sway your body back and forth, letting your incredible endowment rub over the spider's balls, flat chest, and fat little pecker.  Each time you let it get a little closer to his face, but as his pre-cum lubricates more and more of your mighty member, you stop measuring your strokes so modestly.\n\n");

			outputText("You hump forward and smash your [cockhead "+x1+"] against the spider-boy's face, popping a bubble of pre-cum on his lips before you pull back far enough to reveal the soaked foreskin that hides his cock-tip.  He's probably filled the entirety of that little flesh-balloon with his leavings, and as you slide back up you feel more of his pre-cum bursting out, confirming your suspicions.  A pair of hard, chitinous arms encircle your [cock "+x1+"] in a tight hug, squeezing into a slippery pleasure-vice for your penis.\n\n");

			outputText("The enthusiastic spider-bitch looks up at you with a twinkle in his purple eyes, and the next time you push forward, he bites your cock-tip.  You scream in surprise and pain, throwing your head back and howling from the abuse of your most tender part.  Before you can finish your scream, the pain vanishes, replaced by a heat and... need - a warm command that rolls through your body to your brain and balls, ordering them to cum over and over until every drop of spooge has been spilled.  With newfound desire coursing through you, you glare down at the bitch.  He rapidly retracts his fangs and gives you a long, apologetic lick that somehow feels almost as good as fucking a tight pussy.\n\n");

			outputText("Driven by the unquenchable desire coursing through your cock, you unleash a series of rapid-fire thrusts through the sneaky spider's arms, smashing his cock so hard into his belly that you wonder if he can even keep it up under all that pressure.  His whole body is little more than your personal onahole, and you fuck it like a disposable object, not caring in the slightest if you damage him.  Every time you smear another bubble of pre-cum on the spider's face he gives a gentle kiss, lick, or even a cruel, cum-slurping suckle.\n\n");

			outputText("Without the slightest shred of decency, you keep humping the spider-boy's body like an animal.  No matter how hard you grind your [cock "+x1+"] against him or how forcefully you slide your girthy penis through the ring he's made from his arms, it isn't enough for you.  You let go of him completely and wrap both your hands around your own swollen mass, completely giving in to the artificial desire.  Immediately, your hands start to pump up and down, providing a cacophony of pleasure that makes your eyes cross and your tongue hang out.\n\n");

			outputText("A spasm of pleasure sparks in your loins, slowly building into a knot of warm, liquid heat, and you know it's finally time to claim the release you so desperately crave.  You push as far forward as you can, grinding the slippery tip of your cock's cum-slit into the spider-boy's face while your urethra bulges wide at the base, distended by the building cum-bubble slowly pushing through your huge prick.  Climax arrives, and as your body expels the gush of creamy goo directly into the spider-boy's face, another two deliveries of spunk push their way up, squeezing the boy-slut's tiny dick even tighter between the two of you.  He loses it and squirts, adding his own lubricants to the mess while you paint his face a whorish, glistening white.  You shake from stem to stern, body clenching while you pump out the last of your spooge onto his well-bukkake'd face.");
			if (player.cumQ() >= 750) {
				outputText("  Only after you finish do you realize how much you came - there's a ");
				if (player.cumQ() >= 2000) outputText("huge ");
				outputText("puddle under his head!");
			}
			outputText("\n\n");

			outputText("You stretch and sigh with contentment, looking over your cum-covered conquest while he tries to clean himself off.  Absolutely perfect.");
			player.sexReward("Default","Dick",true,false);
			cleanupAfterCombat();
		}

//*Victory Cowgirl
		private function victoryCowgirlRidingOnSpiderBoi():void
		{
			//*Summary: Throw him on his back and mount up on that throbbing, ebon piece of uncut spidercock as he looks to you meekly, panting, needing something to tend to his foreskinned dick so badly...
			clearOutput();
			spriteSelect(SpriteDb.s_spiderguy);
			outputText("You hastily remove your [armor] to bare yourself in preparation for the coming pleasure.  Throughout it all, the spider-boy doesn't react.  He's too busy ");
			if (monster.HP < 1) outputText("trying to stay upright");
			else outputText("trying to drown himself in pleasure");
			outputText(" to summon a response.  How irritating.  You push him over with your [foot] to roll him onto his back, giving you the access you need to get at his ");
			if (monster.HP < 1) outputText("dripping dick");
			else outputText("gradually stiffening dick");
			outputText(".  Gently exploring his body, you run your hands over his chest, circle his tight, stiff nipples, and slide all ten fingers down his smooth skin toward his loins.  The effect of your touches soon becomes apparent, ");
			if (monster.HP < 1) outputText("resulting in a stiff, pre-cum-dripping spider-cock.");
			else outputText("resulting in the spider-cock's hood of excess, sensitive flesh overfilling with sticky, musky pre-cum.");
			outputText("\n\n");

			outputText("The arachnid male looks up at you with wide, open eyes and a lusty expression, begging with his eyes for you to take his slippery black cock inside you.  Lucky for him, that's exactly what you have planned.  You mount the male spider's lithe body with a smooth, sensuous motion, ");
			if (player.balls > 0) outputText("lifting your balls and ");
			outputText("placing your " + vaginaDescript() + " atop the floppy, folded skin that obscures his cockhead.  The drippy arachnid-cock easily slides inside you while your labia push the skin back, exposing his pre-cum-drooling cum-slit to your hot, inner walls.  You can feel him swelling further from the stimulation, his twitching cock trying to stuff you as effectively as possible.");
			//(virgin check)
			player.cuntChange(monster.cockArea(0), true, true, false);
			outputText("\n\n");

			outputText("You pinch the arachnid male's nipple as you begin to bounce up and down upon him.  Each lewd slap of your [butt] on his groin is accompanied by a rippling spasm of pleasure in your " + vaginaDescript() + ", inadvertantly milking the thick-skinned member with the muscular spasms.  He moans and begins trying to lift his hips to meet you.  You deny him, slamming your body down harder with every downward motion to crush him back into the moist swamp-earth.\n\n");

			outputText("\"<i>Ungh... uh... c-c-coming!</i>\" whines the spider-morph, trembling underneath you.  His cock squirts and dumps its inhuman seed into your innermost depths.  Squishing wetly, you can feel pump after pump of the thick spooge being forced past your cervix to burrow in your womb.  The male finishes his climax and sags down into the loam, panting.  Reaching down, you give him an irritated slap.  Your victim's dick actually starts wilting inside you while you ride him, spooge slopping past your lips with each thrust.  The nerve of some men!\n\n");

			outputText("An idea comes to you while you try to get off on the limp-dicked man, and you decide to act on it immediately.  Grabbing his head in both hands, you push the spider-boy's head against his shoulder and command, \"<i>Bite.</i>\"  He fights against you, but he's too weak from the recent combat, not to mention orgasm, to put up much of a fight.  All too soon he's letting his fangs slip into his shoulder and wincing slightly from the pain.  His cock immediately stiffens inside your cum-packed cunt, fueled by the aphrodisiacs he's pouring into himself.  You firmly hold the pathetic male in place and rub his cheek while softly murmuring, \"<i>Good boy,</i>\" over and over again into his ear, all while milking his venom into his body.\n\n");

			outputText("Without even waiting for him to finish, you go back to your cock-riding, the sensation of his trembling, drug-fueled erection tickling at all the right places.  Inside your " + vaginaDescript(0) + ", that wonderful, foreskin-clad member bastes in its own spooge, soaking up the sloppy spunk while you use it as your personal, living dildo.  You ");
			if (!player.hasFuckableNipples()) outputText("pinch");
			else outputText("finger");
			outputText(" your " + nippleDescript(0) + "s, struggling to get off while the spider-boy cums again, this time without any warning at all.\n\n");

			outputText("You finally let him loose, and he immediately slumps back, totally unconscious while his rock-hard cock continues to unload into you.  Riding the wet, drugged up fuck-stick, you get closer and closer to your own climax, the spider's dick continuing to pump every ounce of his seed from his body in a toxin-fueled, continuous orgasm.  Even after his jism is pooling on his waist, his cock keeps spasming wildly in your " + vaginaDescript() + ".  The warm blooms of his seed fade away, but he keeps coming, rocking weakly underneath you.\n\n");

			outputText("At last, your orgasm arrives in a thunderous wave, crashing over you to make you shake and tremble, violently squeezing on his slippery foreskin and forcing out thick dollops of man-cream from between your lips.  Shuddering wildly, you bump and grind unthinkingly, until your strength completely vanishes and you slump down atop the unconscious spider.\n\n");

			outputText("It takes some time to regain your strength with all the orgasmic aftershocks rolling through your " + vaginaDescript() + ".  Once you've mastered yourself, you climb off your conquest and get dressed, ");
			if (player.cor < 33) outputText("taking the time to clean the dripping spunk from your body.");
			else if (player.cor < 66) outputText("casually wiping away the worst of the dripping spunk.");
			else outputText("paying no heed to the thick flows of spunk that drip down your [legs].");
			player.slimeFeed();
			//Pregnancy Goes Here
			if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
            else player.knockUp(PregnancyStore.PREGNANCY_SPIDER, PregnancyStore.INCUBATION_SPIDER, 151);
			player.sexReward("cum","Vaginal");
			cleanupAfterCombat();
		}

		private function spiderBoyLossMaleButtfuck():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_spiderguy);
			outputText("You collapse");
			if (player.HP < 1) {
				outputText(" in a semi-conscious heap, unable to stand, barely able to flop onto your back and look up ");
				if (player.cor < 33) outputText("in fear");
				else if (player.cor < 66) outputText("with worry");
				else outputText("in anticipation");
				outputText(" at the male spider.");
			}
			else outputText(", utterly overwhelmed by your desire for sex until the only thing that matters is letting the sexy spider have his way with you.");
			outputText("  He looks down at you with a cocky grin plastered across his face and a twinkle of light in his violet eyes, almost like a kid at Christmas.  His hand wraps around his girthy shaft and starts to pump at the drooping foreskin, masturbating himself to a full, erect stiffness.  The floppy flesh is so copious that even at his full six inches, you can't see the glans peek out - just a tiny dribble of pre-cum.\n\n");

			outputText("Finished with his foreplay, the spider-boy grabs your " + hipDescript() + " and raises your ");
			if (player.isTaur()) outputText("hindquarters slightly");
			else outputText(player.legs() + " up and out of the way");
			outputText(", displaying surprising strength as he holds your " + assholeDescript() + " at waist height.  You look up at the gloating arachnid ");
			if (player.HP < 1) outputText("and silently mouth, \"<i>Please, no.</i>\"");
			else outputText("and give a little nod, too intoxicated by arousal to decline any form of sex.");
			outputText("  His only response is to squeeze tight on your [butt] and press forward until his pre-cum-soaked foreskin is glazing your rim in preparation for the coming penetration.  ");
			if (player.lust >= player.maxOverLust()) outputText(SMultiCockDesc() + " bounces atop your belly, reacting strongly to the tingling sensation radiating from your " + assholeDescript() + ".");
			else {
				outputText(SMultiCockDesc() + " ");
				if (player.lust < 50) outputText("slowly fills with blood");
				else outputText("fills completely with blood");
				outputText(", reacting strongly to the tingles radiating up from your " + assholeDescript() + ".");
			}
			outputText("\n\n");

			outputText("The penetration is ");
			if (player.analCapacity() < 40) outputText("mercifully easy due to the mess of pre-cum and the forgiving foreskin that clings to his shaft.  It rolls further and further back as he pushes in until his glans is exposed to your clenching guts.");
			else outputText("quite easy due to how well-stretched your " + assholeDescript() + " is.  Watching his fat little cock disappear into your roomy backside actually brings a smile to your lips.");
			player.buttChange(monster.cockArea(0), true, true, false);
			outputText("  A firm, unforgiving hand grabs hold of " + oMultiCockDesc() + " and starts pumping it with short, fast strokes.  The slippery carapace gliding along your length feels absolutely marvelous, and in no time you're utterly relaxed against his invading member, dripping rivulets of sticky pre-cream onto your belly.  A round, hard digits circles your frenulum with a soft, repetitive motion, and you nearly blow your load on the spot.\n\n");

			outputText("Cruelly, the purple-eyed man stops touching you and puts his hands back on your hips and [butt].  He admires you, his conquest, for a few moments while you leak onto yourself.  Time seems to drag on for an age, until you look up at him, still impaled on his thick tool, and ply him with questioning eyes.  The spider-morph gives you a reassuring squeeze and pulls back, his foreskin stretching inside of you while the hard cylindrical shape of his member vanishes from your rectum.  Your [ass] clenches repeatedly, feeling cold and empty after holding on to his hot, black-skinned cock for so long.\n\n");

			outputText("You aren't left empty for long.  The hard-shelled aggressor propels his heavy cock forward.  It disappears into your hungry anus with a 'schliiooorp' and returns the feeling of blessed fullness to you.  This time, you can feel his crown bumping against something inside you, and the reaction is intense and immediate.  Pleasure hits you upside the head with a hammer-blow of sexual gratification.  It's almost like there's a button inside you, right behind your cock and labelled 'push here for bliss', and the spider is poking it hard.  ");
			if (player.cockTotal() == 1) outputText("A ribbon ");
			else outputText("Ribbons ");
			outputText(" of thick cum drizzle");
			if (player.cockTotal() == 1) outputText("s");
			outputText(" out from " + sMultiCockDesc() + " over your belly, weakly leaking out in a slow, steady flow.\n\n");

			outputText("\"<i>My my, what a little butt-slut you are,</i>\" he comments.  \"<i>Did you just get off from feeling my cock sliding into your hungry little asshole?</i>\"\n\n");

			if (player.cor < 33) outputText("You blush shamefully and nod, utterly humiliated by the quick little orgasm.");
			else if (player.cor < 66) outputText("You blush shamefully and nod, humiliated and aroused by how quickly you just came.");
			else outputText("You blush with arousal and humiliation, shaking your head up and down and hoping he'll hit that spot again.");
			outputText("  Pumping his hips slowly, the spider-morph watches a few more weak trickles of seed squirt out.  He gives your ass a hearty smack and muses out loud, \"<i>That's a good " + player.mf("boy", "girl") + ".  You make a");
			if (player.analCapacity() >= 40) outputText("n okay");
			else outputText(" great");
			outputText(" cock-sleeve.  ");
			if (player.analCapacity() >= 40) outputText("I just wish you were less loose, but I guess you must let anyone with a nice fat cock plug your ass every chance you get, huh?  ");
			outputText("Just lie there and take it, bitch, I'm not going to cum until you've painted your belly white.</i>\"\n\n");

			outputText("You sigh when he hits a particularly good spot and squirt a fresh strand of goop onto yourself.  There's nothing to do but lie there, while your " + assholeDescript() + " is used and hope that he keeps hitting your prostate.  It feels sooo good when he does.  The hard butt-fucking hits it more and more as time passes, the spider slowly adjusting his strokes to make you leak as much as possible.  Eventually you stop spurting, " + sMultiCockDesc() + " continually spewing seed while you're raped by the arachnid boy's girthy penis.  Dollops of your submission roll off your belly to pool in the dirt.\n\n");

			outputText("Crossing your eyes, you grab the ground with both hands and struggle to hold on.  There's... too much... too much pleasure for you to think.  Muscles randomly seize and twitch throughout your body, and though the ");
			if (player.cumQ() >= 500) outputText("semen continues to leak out at the same pace");
			else outputText("semen trails off as you empty");
			outputText(", you're absolutely drowning in a sea of bliss.  The waves of sexual indulgence threaten to drag you under their frothing crests.  Slowly, your self-control washes away, eroded by the all-encompasing pleasure " + sMultiCockDesc() + " is experiencing.\n\n");

			outputText("You begin to mumble, \"<i>fuckmefuckmefuckmefuckme,</i>\" like some kind of religious mantra.\n\n");

			outputText("The spider smiles and groans, \"<i>Oh fuck yeah, you little bitch, I'm gonna... gonna... hnnnggg.</i>\"  Hot blooms of spunk splatter through your rectum, soaking your guts and washing over your prostate.  The explosion of perfect enjoyment locks every muscle in your body at once, forcing your sphincter to squeeze down on the still-pulsing penis.  ");
			if (player.cumQ() < 500) outputText(SMultiCockDesc() + " bounces on your belly, leaking one last drop from its tip, utterly draining every drop from your [balls].");
			else outputText(SMultiCockDesc() + " explodes again, dumping every remaining drop from your [balls] directly onto your " + chestDesc() + " and belly.");
			outputText("  Your eyelids flutter and droop, your tongue lolls out of your mouth, and you start drooling all over yourself.  Zombie-like, your body keeps shaking, locked in orgasm, even after the spider dumps you in the dirt and walks away.");
			player.sexReward("cum","Anal");
			cleanupAfterCombat();
		}

//*Loss: Impregnation?
//*Summary: Vagoozles only!
		private function loseToSpiderBoyVagFucked():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_spiderguy);
			outputText("As your ");
			if (player.HP < 1) outputText("wounds overwhelm");
			else outputText("lust overwhelms");
			outputText(" you, your [legs] grow shaky, then give out entirely.  You flop down on your back");
			if (player.lust >= player.maxOverLust()) outputText(", caressing yourself with reckless abandon while praying the sexy spider-boy will come violate you with his thick-skinned prick.");
			else outputText(", clearly too injured and fatigued by the battle to make more than a few token movements.");
			outputText("  He pounces you, lightning fast, quick enough that you don't even react until he's on top of you.  Chitin-clad legs brush your " + hipDescript() + ", the hard knees sinking deep into the swampy loam.  Grinning happily, the spider-boy leans over you and sucks a " + nippleDescript(0) + " ");
			if (player.hasFuckableNipples()) outputText("into his mouth before plunging his tongue into the tit-pussy's passage");
			else outputText("into his mouth before circling his tongue around it");
			outputText(".\n\n");

			outputText("You arch your back from the sensation, lifting your " + chestDesc() + " to provide him better access.  ");
			if (player.HP < 1) outputText("Even though you're injured, his oral attentions make the nub get so hard and sensitive that you quickly forget your own pain.");
			else outputText("Even though you tried to fight him, his oral attentions make your nub so hard and your horny body so eager that you quickly forget.");
			outputText("  The monstrous man handles your body with ease, playing your " + nippleDescript(0) + " like a finely tuned instrument, and you pant out little");
			if (player.cor < 33) outputText(", half-stifled");
			outputText(" moans of pleasure to his ministrations.  Helpless to do anything but grow more and more aroused, you give up entirely on resisting and let yourself be putty in his hands.\n\n");

			outputText("The spider-morph's eyes seem to grow purple in the dim swamp light as he lifts himself away from your " + chestDesc() + ", looking you in the eye.  \"<i>I knew you wanted this,</i>\" he says, rubbing his floppy foreskin against your entrance hard enough for you to feel the stiffness of the member hidden within the loose sheath.  His solid-black shaft feels wonderful against your ");
			if (player.wetness() >= 4) outputText("soaked");
			else if (player.wetness() >= 2) outputText("wet");
			else outputText("moist");
			outputText(" mons, teasing against your vulva until your " + clitDescript() + " emerges from its hood, ");
			if (player.clitLength >= 3) outputText("frotting against him");
			else outputText("grinding along the underside of his dick");
			outputText(".  You start rocking your " + hipDescript() + " encouragingly, trying to snare his marvelous maleness, but every time you catch his tip within your lips, he changes the angle and swivels away, teasing you.\n\n");

			outputText("The arachnid man kisses at your neck, slobbering a messy, unpracticed kiss against your throat.  For one so talented with his hands, he sure is a mess when it comes to kissing - maybe spider-people don't kiss each other much?  The spider-morph pops off, leaving a small hickey behind before revealing his true intent.  Fangs slide into the tender, bruised spot above your collarbone with a small burst of pain, making you gasp.  You hold absolutely still, not wanting to make it any worse.  Numbing, boiling warmth explodes inside you, making you gasp out in shock. A split-second later, the pain vanishes under a growing tide of arousal.  Your " + vaginaDescript() + " ");
			if (player.wetness() >= 5) outputText("pours out a river of lube");
			else if (player.wetness() >= 3) outputText("drools out a steady stream of lube");
			else if (player.wetness() >= 2) outputText("dribbles lube");
			else outputText("gets soaked");
			outputText(", your " + nippleDescript(0) + "s ");
			if (player.hasFuckableNipples()) outputText("drip their own slippery juices");
			else if (player.biggestLactation() >= 1) outputText("bead drops of milk");
			else outputText("fully engorge");
			outputText(", ");
			if (player.hasCock()) outputText(sMultiCockDesc() + " becomes so full and hard it feels like it could burst, ");
			outputText("and your " + clitDescript() + " ");
			if (player.clitLength >= 4) outputText("bounces up and down on your belly with each beat of your heart");
			else outputText("seems to pulsate with every beat of your heart");
			outputText(".\n\n");

			outputText("You gurgle happily and wrap your arms around the man-spider's back, clutching your new mate tightly, lest he leave before he takes the time to fuck your sloppy, wanton little hole.  Meanwhile, his aphrodisiac toxins continue to slide unimpeded through his fangs into your body, taking your need higher and higher.  You claw at his back and hump against him, pressing your slobbering slit tightly against the underside of his manhood, rubbing back and forth over the slight bulge his urethra makes on the bottom of his shaft.  Tiny pulses ripple through the cock, letting you know just how much he's loving having your sloppy-wet lips rubbing on him.\n\n");

			outputText("The horny boy keeps his lips and fangs locked onto you, but he seems nearly as aroused as you at this point.  He raises his hips, removing the source of your pussy's pleasure and drawing a mewl of disappointment from your lips.  His cock doesn't disappoint you, and it returns a mere moment later, burying the entire shaft into your nethers with a smooth, confident stroke.  ");
			player.cuntChange(monster.cockArea(0), true, false, true);
			outputText("The rippling, fat cock rubs your " + vaginaDescript() + " perfectly, the foreskin dragging along your walls as soon as you start reciprocating and humping your wonderful mate's dripping dick.\n\n");

			outputText("You fuck him like an animal, a wanton beast lost in the throes of artificial heat.  The spider-boy hangs onto you for dear life, clutching tightly to your torso while your frenzied motions bounce him into the air on top of you, sliding his cock in and out of the quivering vice that is your " + vaginaDescript() + ".  Loud, wet slaps echo through the sex-musk-filled air while you put all of your body's strength and endurance into milking the spider-boy's cock.  Your thoughts vanished some time ago, replaced with hunger for orgasm and fantasies of getting an injection of hot spider-spunk.\n\n");

			outputText("At long last, the twin needles withdraw from your neck, dripping out the last of the spider's venom while he throws his head back, closes his eyes, and mewls quietly.  You throw your hips into him desperately, eager to catch every drop of his seed with your womb.  His cum squirts out, and blossoms of slippery warmth squirt through your cunt.  Your " + vaginaDescript() + " squeezes and begins to ripple, sending spasms of pleasure up your spine until you're screaming out loud, moaning and grunting in complete, utter bliss.  Absolute happiness washes through you, the pleasure that can only come from giving into your body's demands and letting this male fill you with his spunk.\n\n");

			outputText("You sigh and close your eyes, slowly slumping down while your hips keep twitching.  You've been sated, and though your body keeps hungering for more, you slip into unconsciousness.");
			player.sexReward("cum","Vaginal");
			if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
            else player.knockUp(PregnancyStore.PREGNANCY_SPIDER, PregnancyStore.INCUBATION_SPIDER);
			cleanupAfterCombat();
		}

		public function spiderPregVagBirth():void
		{
			outputText("\n");
			spriteSelect(SpriteDb.s_spiderguy);
			if (player.vaginas.length == 0) {
				outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a vagina.  ");
				player.createVagina();
			}
			outputText("You shudder violently, your stomach growling fiercely at you. It feels as if something is moving around in your womb, and you bend over on all fours, raising your ass into the air as if it is the most natural thing in the world. A slimy green fluid starts leaking out of your " + vaginaDescript(0) + ", making a small puddle on the ground. The sensation is extremely pleasurable as you feel it running down your thighs. Groaning, you start to push out a small, smooth green ball, and the action makes your " + vaginaDescript(0) + " so much wetter.  You push out another, and another, each ball rubbing against your inner walls before dropping into the slimy pool of goo. After the sixth, you orgasm, ");
			//[if male/herm]
			if (player.gender != 2) outputText("spraying your cum all over the ground underneath you, each egg squeezing out and prolonging the intense feeling.\n\n");
			//[if female/genderless]
			else outputText("spraying your juices all over the ground and mixing in with the green slime, soaking your legs, each egg you squeeze out only prolonging the intense feeling.\n\n");

			outputText("After what seems like hours, you have lost count of the eggs pushed out, and you collapse from sexual exhaustion.\n\n");
			CoC.instance.timeQ += 2;
			outputText("You awaken later on, a sticky feeling between your legs to go with your wet pussy");
			if (player.hasCock()) outputText(" and raging hard on");
			outputText(". Looking around, you notice the slimy pool appears to have dried up, but the broken eggshells show that you weren't just dreaming. Tiny dots in the dirt form a trail leading to the swamp, and you can only guess where your offspring went.\n");
			player.sexReward("Default","Vaginal",true,false);
		}
	}
}
