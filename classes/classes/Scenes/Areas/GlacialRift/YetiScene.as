//Courtesy of
package classes.Scenes.Areas.GlacialRift
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armors.LustyMaidensArmor;
import classes.Scenes.SceneLib;

public class YetiScene extends BaseContent
	{
		public function YetiScene()
		{
		}

		public function FemalePCMeetYeti():void {
			outputText(". A massive hulking creature barrels around the corner and sets its gaze on you, its clawed hands and feet launching its body over the iced caverns with ease as you stare the beast down. The white blur of an ice yeti heads for you but stops his charge midway, curious.");
			if (flags[kFLAGS.MET_YETI_FIRST_TIME] == 1) outputText(" Looks like this tought male mistook you for something else and aware of his mistake has already started softening his stance.\n\n");
			else{
				outputText(" To your surprise the thing you at first identified as a stupid beast speaks up.\n\n");
				flags[kFLAGS.MET_YETI_FIRST_TIME] = 1;
			}
			outputText("\"<i>Thought some other dumb intruder got in home but me lucky today, female must've come here by accident so will patch roof later. Female alone, no male scent on her so may forgive intrusion and let out if snu-snu. No fun in days and gal look like could use warmth.</i>\"\n\n" +
					"He makes you what you imagine and know instinctively is a seductive yet fanged smile, offering his massive hand forward in invitation. This here is yeti courtship if you've seen one before. You have to admit that by yeti standards this guy is quite handsome. How are you going to handle him? ");
			menu();
			addButton(0, "Snu-Snu", SnuSnu);
			addButton(1, "No", NoSnuSnu);
		}

		public function NoSnuSnu():void {
			clearOutput();
			outputText("Ain't no damn male making you his mate of the day so easily. How dare he! Totally not interested in his offer you roar in indignation and charge at him.");
			SceneLib.glacialRift.GlacialRiftConditions();
			startCombat(new Yeti());
		}

		public function SnuSnu():void {
			clearOutput();
			outputText("Well he fits your tastes as far as yeti standards goes and besides, he's right, you could use some relief." +
					" You put your equally large hand into his as he guides you deeper into the cave to his bedroom. As far as yeti culture goes he's quite the gentleman, already set the whole place for a mate even by lining the icy bed with warm furs and readying a fireplace." +
					" Guess he just wasn't lucky in finding one. Not that you can judge him since the blizzard would make anyone blind in this frozen landscape." +
					" Your instincts kicking in full swing you take a whiff of his musky scent, smiling in contentment, that's the smell of a strong man, one worthy of fathering your offsprings." +
					" You lay down in bed, spreading your two furry legs apart, your arms open for a hug, in invitation for the courting male to proceed." +
					" His impressive twelve-inch rod stands proudly, warm cum bubbling from the tip, and you just almost beg him with your eyes to put it in." +
					" He starts by teasing your entrance, aligning his glan for a powerful first strike, you make a frustrated groan annoyed by the delay, urging him to get down to business." +
					" You want to be bred and won't take any delay or further teasing.\n\n" +
					"On cue the male thrust his yeti rod in your pussy, making you coo in delight as you put your massive hands on his shoulder and wrap your legs around his torso, the male beginning to mate you in earnest, and you respond positively by impaling yourself back on his cock at every opportunity." +
					" His thrusts are powerful and accurate, hitting the spot on every strike and confirming to you that he's a good mate.\n\n" +
					"\"<i>Girl be eager, me like that. Give you strong offspring.</i>\"\n\n" +
					"His cock reacts favorably to your ministrations, twitching in your pussy. Reaching for the climax your mate roars as he fills you with a mighty jet of yeti cum, warming up your womb with his seeds." +
					" The strength of his ejaculation is all you need to reach over the edge, achieving your own orgasm as the male bottoms up in you filling you to the brim with his virile seed, giving a solid shot at his paternity.\n\n" +
					"A few seconds later he escorts you to the exit. You are positively beaming, pondering whether the seed of your mate took as you leave the cave." +
					" Probably not since most yeti intercourse would fail to conceive a child but who knows, you could get lucky eventually. Thoroughly satisfied you head back to camp.");
			player.sexReward("cum","Vaginal");
			doNext(camp.returnToCampUseOneHour);
		}

		public function loseToYeti():void {
			clearOutput();
			if (player.HP <= 0) outputText("You feel your strength give way as your fighting stance wavers; the yeti beast senses your exhaustion and tackles you to the ground. With a groan, you stare up at the yeti as he pins you beneath him. There is a brief comfort from having such a warm, furred creature pressed against you in the frozen cave, though you feel the heat and pressure of his monstrous prick sliding out of its sheath and grinding against your body. His intentions are clear: he’s going to enjoy your warmth forcefully.");
			else outputText("You reach your limit; your loins are distracting you too much as you give up on fighting entirely. Your hands instead take to touching yourself through your armor lewdly: the only thing convincing you to keep anything on is the chill of the ice caverns surrounding you, but as you look at the ice yeti moving closer to loom over you, his monstrous red prick unsheathed fully and streaming the frigid air with its heat, you doubt you’ll be cold much longer.");
			outputText("\n\n");
			getFuckedByYetiDoggyStyle();
		}

		private function getFuckedByYetiDoggyStyle():void {
			outputText("Your body is pinned completely under the large beast, his hand roughly feeling you up through your armor as his monstrous prick slides from the furred sheath to grind over you. All the forceful touching and groping sends shivers down your spine, but despite all that, the warmth of his body pressed against yours is oddly soothing, and you find yourself relaxing into it to avoid the cold. WIth a grunt, his large hands cup over your [butt] and fondle your ass through your [armor]. His forceful touch combined with the heat of his monstrous slick cock grinding over you excites your body, and the scent of the beasts rutting musk edges you even further, ");
			//Genderless PCs
			if (!player.hasCock() && !player.hasVagina()) outputText("tingling your body with arousal.");
			//Gendered PCs
			if (player.hasCock()) outputText("sending blood swelling to your [cocks]");
			if (player.hasCock() && player.hasVagina()) outputText(" as well as ");
			if (player.hasVagina()) outputText("making the lips of your " + vaginaDescript(0) + " begin to drool and grow moist");
			outputText(". With a sudden jerk you are spun around and shoved onto your hands and knees, his limbs pinning down yours to the ice cavern floor. With a gasp, you feel frost collecting on your limbs, ice crawling up them as they are frozen in place, trapping you as the yeti has his way with you. With a strong yank of his hands, the yeti exposes your [butt], you shiver as it’s briefly left in the cold air.\n\n");
			outputText("A hot slick throbbing length is quickly nestled between your asscheeks, humping between your firm mounds as you feel the welcome warmth of the yeti’s cock. You gasp as the naturally slick monster prick drools over your " + assholeDescript() + ", smearing the warm preparation fluids all along your taint. The yeti continues to hump you earnestly as his warm furred body lays over yours, and you can’t help, but the soft warmth oddly pleasurable despite your limbs being trapped in ice.  ");
			if (player.hasCock()) outputText("Your [cocks] is now fully erect, despite being in the cold air.  ");
			outputText("With a needy grunt the yeti ceases his humping, and when you turn your head, you can see him lining up, one of his hands gripping the hilt of his monstrous length. He presses the pulsing cockhead to your pucker, pushing in against your resistance and coaxing a low moan from your lips. With a persistent shove he slides in past the stiff flesh of your rim, nestling in your warmth. The beast gives a guttural moan from his maw, bucking his hips as he gets more of his massive cock inside you. You can only whimper and strain against the ice binding your limbs in place as the beast takes your hole.\n\n");
			outputText("The sound of flesh smacking flesh bounces off the ice walls of the cavern as the yeti beats your ass into oblivion, his giant huge member impaling you fully over and over, each savage thrust making your limbs ache from the strain of your bindings. Moans slip past your lips despite your discomforts, the furred beast wrapped around you like a heated fur sweater, the brutal thrusts against your ass making it burn up in all the right ways. You can feel his prespunk dripping out of your pucker and leaving warm trails down your taint and legs.  ");
			if (player.hasCock()) {
				outputText("Some gets onto your fully erect [cocks], making ");
				if (player.cockTotal() == 1) outputText("it");
				else outputText("them");
				outputText(" ache all the more.");
			}
			if (player.balls > 0) outputText("Your ballsack is slimy with the stuff. ");
			if (player.hasVagina()) outputText("You can feel it pooling along the lips of your mound. ");
			outputText("The yeti’s furred balls slap against you, bludgeoning you with their large size, your cheeks reddening under its abuse. ");
			if (player.mf("m", "f") == "m") outputText("The tip of the beast’s length rams into your prostate, making you cry out in pleasure.") ;
			outputText("Your moans grow louder and, as the monstrous length pounds away at your hole, you soon reach your limits.");
			if (player.hasCock()) outputText("Ropes of cum shoot from your [cocks], splashing all over the cavern flooring and steaming against the cold ice. ");
			if (player.hasVagina()) outputText("Your  " + vaginaDescript(0) + " is drenched in your sex, leaving your legs slick in your pleasure and dripping down to steam on the icy flooring under you. ");
			player.buttChange(18, true);
			outputText("With a low snarl the yeti rams into you hard enough to make your ice bindings crack: hilted in you as much as he can manage, he begins to pump you full of his cold resistant spunk. It warms your gut and lower body in ways that make you groan, his baseball sized balls filling you well past your limits as it flood your inner confines, spilling out to drenching your taint and groin. Soon there is a large heated pool on the floor under you. With a wet pop the yeti pulls his spent cock from your over stuffed hole, more spunk spilling out to splash onto the floor. Without any further ceremony the beast’s prick returns to its sheath, and the yeti leaves out the way he came in, leaving you a trapped, helpless fuckhole to be used later.\n\n");
			outputText("You struggle against the ice binding your limbs, one of them cracked from the earlier rutting, and with some effort you manage to break free. ");
			outputText("Collecting your things, you notice you lost some gems during the struggle, but you ignore them since you are eager to leave the cavern. Taking the exit the yeti had used to wander back out into the rift, you begin your long walk to camp... but as you trek through the frigid fields of the glacial rift, you notice your ass stays hot despite the cold. Perhaps it’s a special quality of the yeti’s cum?");
			player.sexReward("cum","Anal");
			cleanupAfterCombat();
		}

		public function winAgainstYeti():void {
			clearOutput();
			if (monster.HP <= 0) outputText("The yeti's bruised and battered body stares you down, though it’s obvious his muscles are giving out. With a loud thump he falls on his back, and lays there, vulnerable. A bellowed groan of defeat echoes the cavern walls, and the threat passes. What do you do now?");
			else outputText("The beast looks at you with a hungry gaze, his hot thick member sliding from the sheath between his legs. Unable to fight it any longer, the yeti wraps his hands around his long hot prick, protecting it from the cold as he pleasures the slick, stiff flesh. You lower your guard as you realize the monster is no longer willing to fight, content to just touch himself while looking warily at you. So, what do you do now?");
			//Options
			menu();
			if (player.lust >= 33) {
				addButtonIfTrue(0, "Buttfuck", fuckYetiInTheAss, "Req. a cock", player.hasCock());
				addButtonIfTrue(1, "RideHisCock", rideYetisCock, "Req. a vagina", player.hasVagina());
				LustyMaidensArmor.addTitfuckButton(2);
				SceneLib.uniqueSexScene.pcUSSPreChecksV2(winAgainstYeti);
			}
			else outputText("You're not aroused enough to rape him.")
			addButton(14, "Leave", cleanupAfterCombat);
		}

		private function fuckYetiInTheAss():void {
			clearOutput();
			outputText("You walk closer to the vulnerable form of the yeti beast, his body laid out on his back before you. A desire wells up in your gut as your gaze lowers down to the beast’s genitals and beyond, at his legs slightly parted, his muscled asscheeks on display. You kneel down to push the large legs aside, and when the beast offers no resistance to your touch, you expose his large rump fully. Your hands feel up the beast’s furred cheeks, the fur surprisingly soft and warm to your touch, and kneading with your fingers you coax the firm mounds apart to expose his tight puckered entrance. \n\n");
			clearOutput();
			outputText("With a spark of curiosity, you slide a finger over the soft flesh: it resists your prodding, stiff and tight. You hear a strained grunt from the beast’s maw, though he continues to lay still as you coax his hole loose. By the time you slide a finger in, the beast seems to be panting hot wisps of steam from its mouth. Your finger is wrapped tight in the yeti’s pucker: it feels so hot compared to your frigid surroundings, and your loins ache under your armor just thinking of how wonderful it would feel to be wrapped in such blissful heat. You decide to keep your armor on as you fish your [cocks] out into the air, rubbing over the warm rear before you as the beast begins to stroke along his monstrous length. \n\n");
			outputText("Once you are fully hard, you begin to prod against the yeti’s resistance, working " + oMultiCockDesc() + " inside.\n\n");
			if (player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("Your flared head makes things difficult, but your drooling precum eases your attempts as you work the resistant pucker loose enough to fit the wide flare past the rim. The yeti gives low groans as a spurt of precum leaks from his red member and, feeling your flared head grid over his walls, you begin to thrust deeper into the hot hole. \n\n");
			if (player.cocks[0].cockType == CockTypesEnum.CAT) outputText("With a grunt you manage to slip past the resistant rim, your feline prick plunging in deep as the stiff barbs rubbing over the yeti’s inner walls coax moans of pleasure from the beast's maw. You begin to thrust and smack your hips against the furred rear as your barbs vibrate over the beasts blissfully warm hole. \n\n");
			if (player.cocks[0].cockType == CockTypesEnum.DOG) outputText("Your members tip slips in easily, and with a few slow thrusts you work more of your canine dong into the beasts wonderful warmth. The sound of your hips slapping his firm rear echoes in the cave as you begin to pound away at the tight yeti hole, your knot slowly swelling as you moan out in pleasure. The beast under you groans softly as he strokes along his own massive red prick. Eventually your knot swells to a size too big for the yeti’s rim, smacking against the stiff flesh as you feel your climax approaching. \n\n");
			else outputText("You groan out loud at the beast’s warmth wrapped around your prick, slapping your hips against the beast’s furred rump as you begin to thrust and dig deeper into the yeti’s depths. More of your length sliding in each time, slipping past the tight ring stroking your shaft, milking you of your seed as it tugs on your stiff flesh. \n\n");
			outputText("The yeti strokes his giant red sprick as you fuck him, gutteral moans escaping his maw as he lays still and lets you dominate his rear. Your hands grip his furred hips, clenching down tight as you pick up the pace. \n\n");
			if (player.biggestCockArea() >= 20) outputText("You shove as much into the beast as you can, taking what warmth you can get and moving one hand from the yeti’s hips to stroke along the inches of your length that simply won’t fit. \n\n");
			if (player.biggestCockArea() <= 20 && player.cocks[player.biggestCockIndex()].cockType == CockTypesEnum.DOG) outputText("With a final thrust, you pop your knot past the beast’s rim, joining you two together with you as the alpha and him your bitch as you ready to breed him with your seed. You lean forward, hitting your limit as you give out a low groan.\n\n");
			if (player.balls > 0) outputText("Your [balls] clench as your body readies to fire. You pump the yeti’s ass full of your spunk, firing out countless ropes of your seed, coating the beasts wall in your musky cum. \n\n");
			if (player.cocks.length > 1) outputText("Your other cocks unload and coat his furred rear, drenching his rump in your spunk and messing his white fur with your sticky cream. With a satisfied huff you pull out, trails of your seed following your cock and leaking out across his abused rear. The beast groans as he unloads over his chest, his giant globs of thick spunk matting his fur. \n\n");
			outputText("Without any delay you tuck your [cocks] into your [armor] and make your way out of the cavern through the passageway the yeti came in through, leaving the fearsome yeti looking like a well-used whore and collecting a few spoils along the way.");
			player.sexReward("Default","Dick",true,false);
			cleanupAfterCombat();
		}

		private function rideYetisCock():void {
			clearOutput();
			outputText("More than a little wet yourself, you decide to give the fallen beast a nice, warm sheath for his vulnerable rod. You pull open your [armor] just enough to expose your [vagina] as you straddle the downed yeti. He looks up at you with wary, yet hopeful eyes. Grinning, you take his big, furry hands in yours and push them back from his stiff red prick. The yeti gives a little yelp as the cold air assaults him, but you’re quick to line yourself up with him and drop down, burying his length inside you in one powerful motion. \n\n");
			if (player.looseness(true) <= 1) outputText("You whimper slightly as his thick cock stretches your walls painfully.  ");
			player.cuntChange(18, true);
			outputText("\n\n");
			outputText("You settle atop the burly yeti, sliding down on his prick until his hefty baseball-sized nuts press into your [butt]. You give a few short bounces on the beast’s cock, but quickly find yourself shivering as a cold wind barrels through the cave, chilling you to your core. Seeing your discomfort, the Yeti reaches up and wraps his thick, powerful arms around you before pulling you down on top of him. Your face nestles into ");
			if (player.tallness < 60) outputText("his furry belly");
			if (player.tallness >= 60 && player.tallness < 72) outputText("the thick, soft fur of his chest");
			if (player.tallness >= 72) outputText("the nape of his neck");
			outputText(", the yeti’s thick musk surrounding you. \n\n");
			outputText("Now wrapped in thick, warm fur and benefitting from the yeti’s comforting body heat, your shivers soon subside. With surprising gentleness, the yeti shifts so that his back is pressed against the cave wall, putting the two of you into a sitting position with you cuddled up in his lap. You give the big softie a little wink and, burying your hands in his pelt, start to rock your hips slightly, gently taking a tiny portion of his cock in and out of your " + vaginaDescript(0) + ", careful to keep the remained locked in the warmth between your bodies. \n\n");
			outputText("You continue to bounce on the yeti’s cock, grinding your hips against him and squeezing your vaginal muscles to milk him. Holding you tight against him, the yeti shifts one of his big hands from your back to your [chest], giving you gentle squeezes and pinches through your [armor] and forcing a little gasp from you. Letting out a deep, throaty laugh at your reaction, the yeti starts to move his own hips in tandem with yours, stuffing you with even more of his cock than ever before. You grit your teeth and moan as the narrow head of his prick slides through your cervix, poking at the entrance to your womb. \n\n");
			outputText("You give out a final, whimpered moan as you climax, humping on the yeti’s prick as fast as you can while his arms restrain you. Shocks of pleasure shoot through you, making your whole body spasm in the beasts embrace. As your [vagina] squeezes down on him, the yeti throws his head back and, with a final mighty thrust into your depths, cums as well, hilting in you as much as he can manage as you pumps you full of his thick, hot spunk. Pouring into you, the yeti’s cum warms your gut and lower body in ways that make you groan and gasp with pleasure. His baseball-sized balls fill you well past your limits as spunk floods your innermost depths, spilling out to drench your thighs and groin, squelching wetly between your entwined bodies. \n\n");
			outputText("With a wet pop, the yeti’s cock slides from your over-stuffed hole and back into its sheathe, letting more spunk spill out to stain his fur. Still gasping from your recent orgasm, you spend the next few minutes snuggled up to the warm, damp yeti, clinging to his soft fur until you feel it’s time to go. You look up to the yeti to say goodbye, but find him snoring quietly, his chest hefting your entire body with every breath. With a little smirk, you give him a kiss on the cheek and, securing your equipment, head back to camp.");
			player.sexReward("cum","Vaginal");
			cleanupAfterCombat();
		}

	}

}