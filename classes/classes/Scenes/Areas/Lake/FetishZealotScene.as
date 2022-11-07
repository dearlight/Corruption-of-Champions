/**
 * Created by aimozg on 04.01.14.
 */
package classes.Scenes.Areas.Lake
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Places.Mindbreaker;
import classes.Scenes.SceneLib;
import classes.Items.Armors.LustyMaidensArmor;
import classes.display.SpriteDb;

public class FetishZealotScene extends AbstractLakeContent
	{
				
		public function FetishZealotScene()
		{
		}

//Fetish Zealot
//The Fetish zealot is the guard, escort, and de-facto
//warrior for the Followers of the Fetish.  They are tasked
//with guarding their assets, protecting their members, and
//as the primary warriors when fighting becomes necessary.
//They wield daggers coated in aphrodisiacs, and like the
//cultist are able to change their clothing at will and cast
//a spell that transfers their lust to their opponent.
//Combat Stats
//Stats similar to the cultist (we can adjust for balance
		//later) +5 STR, god bless DnD
//Begins combat with 10 lust (so that he can transfer
		//something with the lust transfer spell), gains 5
		//lust on each turn of combat
//Standard attack enabled: does a little bit of lust damage
		//in addition to regular damage (lib/20 + rand(4)+1)


		/*
		 Appearance:
		 Male
		 (average) Height is 5'10\"
		 One dick, 6.5 inches (can vary in sex scenes)
		 One ass, loose
		 Loot
		 Lust Draft (same as Cultist drop)
		 Lust dagger (+3 attack, slight lust effect added to regular attacks)
		 \"A dagger with a short blade in a zigzag pattern(lightning bolt?).  Its edge seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.  \"
		 \"L. Dagger\"
		 Comfortable clothes (same as Cultist drop, and the starting armour of the player)
		 */

//Scenes
//Boat encounter
//After the cultists arrive at the Lake, a zealot will be found guarding the player's boat.  Once defeated, there is a 50% chance he will be guarding it the next time the PC goes to the boat, until the swamp is added.  When that happens, repeat encounters will not occur anymore.
		public function zealotBoat():void
		{
			if (player.statusEffectv1(StatusEffects.FetishOn) == 1) {
				zealotRepeat();
				return;
			}
			player.changeStatusValue(StatusEffects.FetishOn, 1, 1);
			clearOutput();
			outputText("As you get close to your boat, you are surprised to find someone standing at the end of the dock.  As you get closer, you see that it's a man wearing some kind of bizarre religious outfit.  He turns to face you as you approach and says \"<i>This has been claimed by the Followers of the Fetish for security reasons, leave at once.</i>\"\n\n\"<i>What?  This is my boat!</i>\" you cry out in surprise.  The zealot seems to take this as an aggressive action on your part and moves to attack you.");
			if (flags[kFLAGS.CODEX_ENTRY_FETISHFOLLOWERS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_FETISHFOLLOWERS] = 1;
				outputText("\n\n<b>New codex entry unlocked: Followers of the Fetish!</b>")
			}
			//next button, go to zealot fight
			startCombat(new FetishZealot());
			spriteSelect(SpriteDb.s_fetish_zealot);
		}

//Regular encounter
//This is the regular pre combat text for wandering zealots (they'll be a regular mob at the swamp)
		private function zealotRepeat():void
		{
			clearOutput();
			outputText("While exploring, you hear someone cry out behind you \"<i>This is sacred land!  You WILL be punished for trespassing!</i>\"  It seems you've managed to stumble upon whatever land this zealot has been tasked to guard, and now you must fight him.");
			startCombat(new FetishZealot());
			spriteSelect(SpriteDb.s_fetish_zealot);
		}

//Raping the player
		public function zealotLossRape():void {
			clearOutput();
			//Pre Rape Scene - lose by hp
			if (player.HP < 1)
				outputText("You collapse from the pain of the zealot's attacks.  You feel your head swimming from the aphrodisiac; it seems to be having a stronger and stronger effect on you.  Soon your head is swimming with images of fetish scenes of all kinds.  The zealot walks up to you and puts his hand on your forehead.  Suddenly, all the images cascade into one.\n\n");
			//Pre Rape Scene – lose by lust
			else
				outputText("The constant images of fetishes overwhelm you, and you fall to your knees, unable to resist the temptation. The zealot walks up to you and puts his hand on your forehead.  Suddenly all the images cascade into one.\n\n");

			//Student rape
			//Zealot in a student costume, the player is in a teacher costume.  The zealot asks for a sex aid lesson in a very nervous way.  The player is afraid of what his parents may do to them if they refuse, so they agree to help him.
			outputText("You stand up facing the chalkboard in your classroom.  For some reason you think you should be bothered by this, but you're in your classroom just after class.  Nothing seems to be out of place or missing.  You turn back to the rest of the classroom and notice that everyone but one boy seems to have left already.  You recognize that he is the cute nervous boy with the rich parents.  You shudder at the thought of his parents; last week they got a teacher fired for yelling at him to speak up.  ");
			if (sceneHunter.uniHerms) {
				outputText("\n\nYou look at yourself in the mirror and notice that your clothes are blurry. Trying to focus your thoughts, you see... Who do you see in the mirror?\n\n");
				menu();
				addButton(0, "Man", scene, true);
				addButton(1, "Woman", scene, false);
			}
			else scene(player.mf("m","f") == "m");

			//============================================
			function scene(male:Boolean):void {
				//is that a guy?  Or does he just look like one?
				//Set asside a varaible for this, its used a few times
				if (male && player.hasCock()) {
					//set the player's armor to their new male teacher outfit, see lower down for a full description.
					if (player.armor == armors.C_CLOTH) {
						player.modArmorName = "formal vest, tie, and crotchless pants";  //can you think of a better way of putting this?
					}
					outputText("You smooth down your detached pants, and look at your exposed dick for a few moments, wondering if there was anything you said that may have upset him.  ");
				}
				//no its a girl, or it looks like one
				else if (!male) {
					//Set armour to female teacher outfit with no back side.
					if (player.armor == armors.C_CLOTH) {
						player.modArmorName = "backless female teacher's clothes";  // again, change this if you've got a better name
					}
					outputText("You smooth out your half-skirt, trying to busy yourself as you try to remember if there was anything you said to upset him.  ");
				}
				outputText("\"<i>Professor?</i>\"  You hear him call out to you.  You look up and see him standing in front of your desk looking at the ground nervously.  \"<i>Yes, what is it?</i>\" you reply.  ");
				//same as before
				if (male) {
					outputText("He starts to look up, but then his gazes fixes directly on your ");
					if (player.cockTotal() > 0) {
						outputText(multiCockDescriptLight() + ".  You feel yourself grow hard ");
						if (player.hasVagina()) {
							outputText("and wet ");
						}
						outputText("under his gaze, ");
					}
					else outputText("bare crotch, ");
					outputText("and you silently wish that the dress code allowed for a small flap for covering your ");
					if (player.gender == 0) {
						outputText("lack of ");
					}
					else outputText("genitals.  ");
				}
				else {
					outputText("He starts to look up, but his gazes fixes on your skirt, just barely covering your ");
					if (player.hasVagina()) {
						outputText(vaginaDescript(0) + " ");
						if (player.cockTotal() > 0) {
							outputText("and your [cocks] ");
						}
					}
					else {
						outputText("bare crotch ");
					}
					outputText("from this angle.  You feel hot under his gaze ");
					if (player.cockTotal() > 0) {
						outputText(", and your [cocks] start");
						if (player.cockTotal() == 1) {
							outputText("s");
						}
						outputText(" to get hard, as your ");
					}
					outputText("cleft starts to moisten.  ");
				}
				outputText("You clear your throat nervously, and he starts, finally raising his eyes to your face.\n\n");
				outputText("\"<i>Ah, professor,</i>\" he says again, \"<i>I just got a " + player.mf("boyfriend", "girlfriend") + " and I have no idea how to have sex.  Could you please give me a lesson?</i>\"  You stare at him in disbelief.  This boy still hadn't had a " + player.mf("man", "woman") + " at this school?  It would almost be laughable, if the threat of his parents didn't loom in the back of your mind.\n\n");
				outputText("\"<i>Ok,</i>\"  you say nervously, \"<i>I can give you a lesson on pleasing " + player.mf("men", "women") + ".</i>\"  He jumps up excitedly and runs around to the other side of the desk saying \"<i>Ok, what do I have to do?</i>\"  Feeling a bit put on the spot, you stop for a moment to take in the situation.  ");
				//again, is that a guy?  Or just look like one?
				if (male) {
					outputText("You're standing in front of your student behind your desk in your empty classroom.  You are in regular teacher's attire: an open vest and tie over your otherwise bare [allbreasts], with formal dress pant legs attached to your vest with suspenders, plus your black dress shoes for dancing.  Your student is wearing the standard male student uniform, a collection of pieces of material held together with straps, that will all fall away easily when one gets pulled; but otherwise gives full coverage.\n\n");
					//How to please a man (in this zealot boy's fantasy)
					outputText("You take a deep breath and start to explain how to please a man.  You explain how important it is for men to have friendly competitions with each other.  Of special note is who can give the best blowjob, and who can jerk themselves off the best.  He nods to you and explains that he knew about the dick sucking part, but not the rest.  Usually one of them issues a challenge to the other, the one being challenged has the first go at the other's cock.  Then the challenger has their turn.  After that the two have to do their best to orgasm before the other by pumping their cocks with their hands.\n\n");
					//now if the player can have sex...
					if (player.gender != 0) {
						//Give the zealot a blowjob
						outputText("You take a hold of his nicely sized balls in one hand and the base of his cock in the other.  You give the tip a few licks before running your tongue down its length, making sure to coat every bit of it in your saliva along the way.  His aroused groans let you know that you are giving a good demonstration.  You give his balls a soft rub as you stick the end inside your mouth and run your tongue around it; the taste of his pre is almost like candy to you.\n\n");
						//now the favor is returned
						outputText("You stand up and indicate to him that it is now his turn, and while he is disappointed that the blowjob ended before he came, he still eagerly kneels down in front of your exposed [cocks] and licks his lips eagerly.  He tries to imitate your performance on his manhood onto your [cock], but he sometimes messes up the order, or does something too fast or slow.  Fortunately, he is a good student, and under your guidance he is soon sucking cock like a pro.  He tickles you with his tongue in just the right way, and gives just the right amount of attention to each part of your length.  ");
						if (player.hasVagina()) outputText("You slip one of your fingers inside your " + vaginaDescript(0) + ", wishing that it could get some attention, but this lesson is about pleasing <i>men</i>.  ");
						outputText("You feel yourself getting close to the edge and tell him to stop.  He looks up at you uncertain for a moment, and you tell him \"<i>It's time for the main event.</i>\"\n\n");
						//jerking off contest
						outputText("He eagerly stands up and wraps his hands around his fine cock, you quickly try to do the same with your " + multiCockDescript() + ".  \"<i>I won't lose to you so easily, professor!</i>\" he declares to you, \"<i>Don't act so confidently on your first time.</i>\" you reply.  Then the two of you are madly jerking yourselves off in a mad effort to get off before the other, your respective cocks already moist from the blowjobs they just received.  ");
						//just one cock
						if (player.cockTotal() == 1) {
							outputText("You piston your hands on your [cock], ");
						}
						//nope two
						else if (player.cockTotal() == 2) {
							outputText("With one hand on each of your [cocks], you piston them like mad, ");
						}
						//oh no, is more than that
						else {
							outputText("Rapidly moving your hands between each rod in your [cocks], you manage to piston each of them at an incredible rate, ");
						}
						outputText("pushing your pleasure to incredible levels at an impressive rate.  Though, to your amazement, you hear your student give a gasp of pleasure just before you yourself are pushed over the edge.  The student had surpassed the teacher.\n\n");
					}
					player.sexReward("cum");
				}
				else {
					outputText("You're standing in front of your student behind your desk in your empty classroom.  You are in your regular dress clothes; a formal backless blouse and short semi skirt that only blocks the front from view, plus your two-inch tall high heels.  Your student is wearing the standard male student uniform, a collection of pieces of material held together with straps, that will all fall away easily when one gets pulled; but otherwise gives full coverage.\n\n");
					//How to please a woman (in this zealot boy's fantasy...)
					outputText("You take a deep breath and start to explain how to please a woman.  You explain that one of the most important things is to show the woman that you want her, you want her body, and you want her to suck your dick.  He nods to you and explains that he knew about the dick sucking part, but not the rest.  Then you explain the proper way to thank a woman for the blowjob, by licking and sucking on her vagina.  After that, the man penetrates the pussy with his cock.\n\n");
					if (player.gender != 0) {
						//he wants to do that to you, doesn't he?
						outputText("Throughout the whole conversation, your student gets more and more excited before finally saying \"<i>Can we do it now?!</i>\" and pulling his waist strings, causing his crotch piece to fall open.  At the site of his impressive erection, you eagerly kneel down in front of him as he says \"<i>I want you, I want you to suck my cock <b>so</b> much!</i>\"  You waste no time in obliging him.\n\n");
						//blowjob
						outputText("You take a hold of his nicely sized balls in one hand and the base of his cock in the other.  You give the tip a few licks before running your tongue down its length,  making sure to coat every bit of it in your saliva along the way.  His aroused groans let you know that you are giving a good demonstration.  You give his balls a soft rub as you stick the end inside your mouth and run your tongue around it; the taste of his pre is almost like candy to you.\n\n");
						//cunalinguss
						outputText("You stand up and indicate that it is now his turn, and while he is disappointed that the blowjob ended before he came, he still eagerly kneels down in front of your " + vaginaDescript(0) + ".  You gingerly lift up your skirt ");
						if (player.balls > 0) {
							outputText("and move your [balls] out of the way ");
						}
						outputText("so he has access to your " + vaginaDescript(0) + ".  He sets to work, and you give him careful instructions on where to lick, how hard, and such.  He easily catches on, and soon he is probing all the right places, and giving the right amount of attention to every part of you.  ");
						if (player.cockTotal() > 0) {
							outputText("You give your [cocks] a few gentle strokes, wishing he would give that a little attention too, but this is a lesson on how to please a <i>woman</i>.  ");
						}
						outputText("You feel yourself getting close to the edge and tell him to stop.  He looks up at you uncertain for a moment, and you tell him \"<i>It's time for the main event.</i>\"\n\n");
						//prick in the twat
						outputText("He eagerly stands up and starts to push you back against your desk, his fine cock already inside your " + vaginaDescript(0) + ".  He pushes you onto your back and grabs ahold of your legs, starting to make strong thrusts deep inside you, his cock seeming to fit your " + vaginaDescript(0) + " perfectly.  Any pretense of professionalism is lost in the moment, as all you can care about is the feeling of his exquisite cock perfectly filling you, pushing in and out.  All too soon, you hear him gasp, and the wonderful feeling of sweet release fills you.  ");
						if (player.cockTotal() > 0) {
							outputText("Your [cocks] spasms and covers you with a liberal amount of your own fluids.  ");
						}
						outputText("After a moment, your student pulls out of you and helps you back up.\n\n");
						player.sexReward("cum", "Vaginal");
					}
				}
				//Wrapping things up
				if (player.gender != 0) {
					outputText("The two of you stand looking at each other again for a moment.  Then you help your student get his clothes back together.  Once you have him fixed up, you notice that he is looking at the ground again.  \"<i>Professor?  I have a confession to make.</i>\" he says very quietly.  \"<i>What is it?</i>\" you ask him.  \"<i>I lied to you about getting a " + player.mf("boyfriend", "girlfriend") + ", I actually just wanted you.</i>\"  Before you have a chance to respond, he quickly gives you a kiss on the mouth, before rushing out the door, blushing furiously.  You can't help but smile at how he is growing up.\n\n");
				}
				if (player.gender == 0) {
					outputText("Throughout the whole conversation, your student gets more and more excited.  Half way, though, he starts masturbating, and by the end he is ready to go over the edge.  \"<i>Thank you so much for the lesson professor, gaahh.</i>\" he tells you as he begins to cum. The sight of him cumming in front of you is enough to drive you to your own orgasm.  Breathing a sigh of relief, you let your student out of the room and go back to cleaning up.\n\n");
				}
				//After any zealot rape
				//Reduce intelligence, set lust to zero, then add some lust based on libido and corruption
				player.sexReward("Default", "Default", true, false);
				dynStats("int", -1, "cor", 2);
				//Trigger bad end if player's intelligence is less than 10 after being drained.
				if (player.inte < 10 && rand(2) == 0) {
					outputText("You find that your mind is unable to return to reality, and it moves on to another, then another.  Later you feel a female body come and pick you up, but you are too messed up to react to it...");
					doNext(lake.fetishCultistScene.cultistBadEnd2);
					return;
				}
					//Otherwise, continue on here
				//continue on to Cultist bad end.  I'll expand these later when where doing the cathedral.
				else {
					outputText("A few hours later your mind finally returns to reality.  You look around and realize that you are no longer in the same place you were before, and the zealot is nowhere to be seen.");
				}
				//If there were changes to the player's genitals
				//same as cultist
				//If there were changes to the player's chest
				//same as cultist
				//If armour is replaced
				if (player.armor == armors.C_CLOTH) {
					outputText("\n\nYou notice that you still have the [armor] from the fantasy that your mind was trapped in, with no sign of your original clothes.");
				}
				//If armour is not replaced
				else {
					outputText("\n\nYou find that your [armor] are back to normal, and there is no sign of the strange clothes you were wearing before.");
				}
				outputText("  The ordeal has also left you with a slightly dulled mind, and some of the desire you felt still lingers.");
				dynStats("lus", player.cor / 20 + player.lib / 10);
				cleanupAfterCombat();
			}
		}

		public function zealotDefeated():void
		{
			//Defeated by health
			if (monster.HP < 1) outputText("The zealot collapses from his wounds, too hurt to continue controlling his powers.");
			//Defeated by lust
			else outputText("The zealot quivers for a moment before collapsing, his desires becoming too great for even him to control.");
			if (player.lust >= 33 && player.gender > 0) {
				outputText("\n\nDo you want to take advantage of his vulnerable state to sate your lusts?");
				menu();
				addButton(0, "Yes", zealotWinRape);
				LustyMaidensArmor.addTitfuckButton(1);
				addButtonIfTrue(2, "Mindbreak", mindbreakMaleCultist, "You don't know how and why... yet?", Mindbreaker.MindBreakerQuest == Mindbreaker.QUEST_STAGE_ISMB, "Toy with the cultist's brain.");
				addButton(14, "Leave", cleanupAfterCombat);
				SceneLib.uniqueSexScene.pcUSSPreChecksV2(zealotDefeated);
			}
			else {
				outputText("\n\nYou can't think of anything to do with him.");
				cleanupAfterCombat();
			}
		}


	//Raped by the player
		private function zealotWinRape():void
		{
			clearOutput();
			//Religious Costume Rape
			outputText("The zealot's attire seems to have settled on an outfit similar to those commonly worn by members of religious orders, though you aren't too surprised to see that it has a slit running down the front and back of the outfit that gives you full access to his sizable cock and asshole.\n\n");
			sceneHunter.selectGender(dickF, vagF, null, null, 0);

			function dickF():void {
				outputText("As you move towards him, he drops onto all fours with his head down and ass in the air.  He seems to have started making a prayer: \"<i>Forgive me my lord, for I have failed to protect your holdings and will now accept your punishment by being violated by the one who defeated me.</i>\" ");
				if (player.cor < 50) outputText("You stop and stare at him for a moment, in complete disbelief at this bizarre 'prayer'.  You consider just leaving him alone, but sensing your hesitation, the zealot looks up to you with a horrified expression.  \"<i>You must violate me!</i>\"  He cries out to you, \"<i>Please, let me finish my prayer, put your [cock] in my ass.</i>\"  Well, he did ask you...\n\n");
				else outputText("You chuckle at him, he <i>accepts</i> his punishment?  Oh, you are going to enjoy this so much.\n\n");
				outputText("You remove your [armor] and stride up behind him, and grab his rear end to line up your [cock] with his loose hole as he continues his prayer: \"<i>Soon a man will violate my ass, like so many others have done in your holy worship.  Woe is me, to be treated like this by someone who doesn't follow us.</i>\" You shake your head at this absurdity and plunge your [cock] inside his waiting hole.  Amazingly, his hole somehow manages to fit you perfectly.  Since he seems to have no problem taking you, you waste no time in getting the anal rape on.\n\n");
				outputText("\"<i>My shame brings the one within me their pleasure; such a tragedy has befallen me.</i>\" he continues.  \"<i>Shut up and take it like a man!</i>\" you tell him, and start fucking him more and more roughly.  You reach around him and grab his balls, and start to grip them painfully.    He isn't perturbed, and continues his prayers between his gasps: \"<i>Agh, The horror, I'm being tortur- ah, while being raped ungh, and I'm loving every moment.  Oug!</i>\"  Having had enough, you squeeze his sack hard, at the same time as you cum inside his ass.\n\n");
				outputText("Your lusts sated for now, you rise up off of him and put your [armor] back on.  You decide to leave him lying there, still doubled over in pain from the damage you did to his balls.\n\n");
				player.sexReward("Default", "Default", true, false);
				cleanupAfterCombat();
			}
			function vagF():void {
				outputText("As you move towards him, he lays back onto the ground, his cock almost pointing straight up in the air.  He clasps his hands in front of his face and starts praying: \"<i>Forgive me my lord, for I have failed to protect your holdings and will now accept your punishment by being violated by the one who defeated me.</i>\" ");
				if (player.cor < 50) outputText("You stop and stare at him for a moment, in complete disbelief at this bizarre 'prayer'.  You consider just leaving him alone, but sensing your hesitation, the zealot looks up to you with a horrified expression.  \"<i>You must violate me!</i>\"  He cries out at you, \"<i>Please, let me finish my prayer, take me within your " + vaginaDescript(0) + " for your own pleasure.</i>\"  Well, he did ask you...\n\n");
				else outputText("You chuckle at him, he <i>accepts</i> his punishment?  Oh, you are going to enjoy this so much.\n\n");
				outputText("You remove your [armor] and stride over top of him, looking down at the defeated zealot as he continues his prayer.  \"<i>I am a wretched man to have allowed a woman like you to have defeated me.  Woe is me, lying at your feet.</i>\"  You shake your head at this absurdity and lower yourself down to get to the fun part.  You eagerly grab his cock and guide it towards your " + vaginaDescript(0) + ", awaiting the pleasure you are sure it will bring you.  \"<i>Look at me, so eager to be violated despite why it is happening to me, and yet she teases me and draws it out, making it so much more painful.</i>\"\n\n");
				outputText("With a laugh, you impale yourself on his cock and despite how ");
				if (player.vaginas[0].vaginalLooseness < VaginaClass.LOOSENESS_LOOSE) outputText("tight");
				else outputText("loose");
				outputText(" you are, he still seems to fit you like a glove.  With no need to adjust to his presence inside you, you immediately start to roughly fuck him.  To make sure he doesn't enjoy himself too much, you start to twist and pull at his nipples.  Between his gasps of pleasure and pain, he continues his prayer: \"<i>Gah, oh woe is me, ah-gha, my punishment is my pleas- agh!  My eternal torment will be –ugha, never being able to –hah, enjoy this forever.  Ugha!</i>\"  Finally tired of his antics, you punch him in the stomach, as his amazing rod pumping within your " + vaginaDescript(0) + " pushes you over the edge of an orgasm.\n\n");
				outputText("Your lusts sated for now, you rise up off of him and put your [armor] back on.  You decide to leave him lying there, still coughing from the blow to his stomach.  ");
				player.cuntChange(monster.cockArea(0), true);
				player.sexReward("cum","Vaginal");
				cleanupAfterCombat();
			}
		}

		private function mindbreakMaleCultist():void{
			clearOutput();
			outputText("As the fetish cultist drops to the ground, it occurs to you that Kaerb-Dnim wants you to invite more people to the ‘game’." +
					" This guy doesn’t even need you in his brain to blabber insanity." +
					" He's likely already insane, but perhaps you can fix him still." +
					" You approach the man and insert your tentacles inside of his ears, squelching your way in as you look for the damaged part of his brain." +
					"\n\n\"<i>Woohoo! Why am I riding a flying mud tart you need to blue my smelly!</i>\"" +
					"\n\nYou ignore his blabber as you proceed to mess with his memory, erasing all this stupid fetish stuff of his and altering his perception of reality so that he believes the only way he can cum is through you messing with his head." +
					" You give a few small shocks to his pleasure center in order to test the results." +
					" Green light dances behind his eyes as they roll up, and he spontaneously starts cumming like a fountain." +
					" When you stop playing with his pleasure switch he whines pitifully and begs for more as his balls keep churning, waiting for the chance to let go." +
					"\n\n\"<i>Big </i>");
			if (player.hasCock())outputText("<i>brother</i>");
			else if (player.hasVagina())outputText("<i>sister</i>");
			outputText("<i>, [name] please, I beg you. Make me cum more!</i>\"" +
					"\n\nYou promise him the chance to cum and leak like a hose with the condition he heads to Kaerb-Dnim and, of course, take tons of transformative to increase the size of his balls.");
			Mindbreaker.MindBreakerFetishMaleConvert ++;
			Mindbreaker.MindBreakerConvert ++;
			if (Mindbreaker.MindBreakerConvert >= Mindbreaker.MindBreakerConvertGoal) SceneLib.mindbreaker.MindbreakerBrainEvolution();
			else outputText(" This is all it takes to get your newest plaything running to the lair. You smile, knowing you have made yet another convert as you head back to camp still giggling.");
			player.sexReward("Default", "Default",true,false);
			cleanupAfterCombat();
		}
	}
}