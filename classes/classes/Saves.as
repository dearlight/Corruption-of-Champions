﻿package classes
{
import classes.BodyParts.Hair;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Gills;
import classes.BodyParts.Horns;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.*;
import classes.Scenes.Areas.Desert.SandWitchScene;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.NPCs.XXCNPC;
import classes.Scenes.SceneLib;
import classes.Stats.BuffableStat;
import classes.Stats.IStat;
import classes.Stats.RawStat;
import classes.internals.Jsonable;
import classes.internals.SaveableState;
import classes.lists.BreastCup;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.net.FileReference;
import flash.net.SharedObject;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.utils.getDefinitionByName;

CONFIG::AIR
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
}

public class Saves extends BaseContent {

	private static const SAVE_FILE_CURRENT_INTEGER_FORMAT_VERSION:int		= 816;
		//Didn't want to include something like this, but an integer is safer than depending on the text version number from the CoC class.
		//Also, this way the save file version doesn't need updating unless an important structural change happens in the save file.

	private var gameStateGet:Function;
	private var gameStateSet:Function;
	private var itemStorageGet:Function;
	private var pearlStorageGet:Function;
	private var gearStorageGet:Function;


    //Any classes that need to be made aware when the game is saved or loaded can add themselves to this array using saveAwareAdd.
    //	Once in the array they will be notified by Saves.as whenever the game needs them to write or read their data to the flags array.
	private static var _saveAwareClassList:Vector.<SaveAwareInterface> = new Vector.<SaveAwareInterface>();
	private static var _saveableStates:Object = {};

    public function Saves(gameStateDirectGet:Function, gameStateDirectSet:Function) {
		gameStateGet = gameStateDirectGet; //This is so that the save game functions (and nothing else) get direct access to the gameState variable
		gameStateSet = gameStateDirectSet;
	}

	public function linkToInventory(itemStorageDirectGet:Function, pearlStorageDirectGet:Function, gearStorageDirectGet:Function):void {
		itemStorageGet = itemStorageDirectGet;
		pearlStorageGet = pearlStorageDirectGet;
		gearStorageGet = gearStorageDirectGet;
	}

CONFIG::AIR {
public var airFile:File;
}
public var file:FileReference;
public var loader:URLLoader;

public var saveFileNames:Array = ["CoC_1", "CoC_2", "CoC_3", "CoC_4", "CoC_5", "CoC_6", "CoC_7", "CoC_8", "CoC_9", "CoC_10", "CoC_11", "CoC_12", "CoC_13", "CoC_14"];
public var versionProperties:Object = { "legacy" : 100, "0.8.3f7" : 124, "0.8.3f8" : 125, "0.8.4.3":119, "latest" : 119 };
public var savedGameDir:String = "data/com.fenoxo.coc";

public var notes:String = "";

public function loadSaveDisplay(saveFile:Object, slotName:String):String
{
	var holding:String = "";
	if (saveFile.data.exists/* && saveFile.data.flags[2066] == undefined*/)
	{
		if (saveFile.data.notes == undefined)
		{
			saveFile.data.notes = "No notes available.";
		}
		holding = slotName;
		holding += ":  <b>";
		holding += saveFile.data.short;
		holding += "</b> - <i>" + saveFile.data.notes + "</i>\r";
		holding += "Days - " + saveFile.data.days + " | Gender - ";
		if (saveFile.data.gender == 0)
			holding += "U";
		if (saveFile.data.gender == 1)
			holding += "M";
		if (saveFile.data.gender == 2)
			holding += "F";
		if (saveFile.data.gender == 3)
			holding += "H";
		if (saveFile.data.flags != undefined) {
			holding += " | Difficulty - ";
			if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] != undefined) { //Handles undefined
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == 0 || saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == null) {
					if (saveFile.data.flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) holding += "<font color=\"#008000\">Easy</font>";
					else holding += "<font color=\"#808000\">Normal</font>";
				}
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == 1)
					holding += "<font color=\"#800000\">Hard</font>";
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == 2)
					holding += "<font color=\"#C00000\">Nightmare</font>";
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == 3)
					holding += "<font color=\"#FF0000\">EXTREME</font>";
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] >= 4)
					holding += "<font color=\"#FF0000\">XIANXIA</font>";
			}
			else {
				if (saveFile.data.flags[kFLAGS.EASY_MODE_ENABLE_FLAG] != undefined) { //Workaround to display Easy if difficulty is set to easy.
					if (saveFile.data.flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) holding += "<font color=\"#008000\">Easy</font>";
					else holding += "<font color=\"#808000\">Normal</font>";
				}
				else holding += "<font color=\"#808000\">Normal</font>";
			}
		}
		else {
			holding += " | <b>REQUIRES UPGRADE</b>";
		}
		holding += "\r";
		return holding;
	}
	/*else if (saveFile.data.exists && saveFile.data.flags[2066] != undefined) //This check is disabled in CoC Revamp Mod. Otherwise, we would be unable to load mod save files!
	{
		return slotName + ":  <b>UNSUPPORTED</b>\rThis is a save file that has been created in a modified version of CoC.\r";
	}*/
	else
	{
		return slotName + ":  <b>EMPTY</b>\r     \r";
	}
}

CONFIG::AIR
{

	private function selectLoadButton(gameObject:Object, slot:String):void {
		//trace("Loading save with name ", fileList[fileCount].url, " at index ", i);
		clearOutput();
		loadGameObject(gameObject, slot);
		outputText("Slot " + slot + " Loaded!");
		statScreenRefresh();
		doNext(playerMenu);
	}

public function loadScreenAIR():void
{
	var airSaveDir:File = File.documentsDirectory.resolvePath(savedGameDir);
	var fileList:Array = new Array();
	var maxSlots:int = saveFileNames.length;
	var slots:Array = new Array(maxSlots);
	var gameObjects:Array = new Array(maxSlots);

	try
	{
		airSaveDir.createDirectory();
		fileList = airSaveDir.getDirectoryListing();
	}
	catch (error:Error)
	{
		clearOutput();
		outputText("Error reading save directory: " + airSaveDir.url + " (" + error.message + ")");
		return;
	}
	clearOutput();
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r");

	var i:uint = 0;
	for (var fileCount:uint = 0; fileCount < fileList.length; fileCount++)
	{
		// We can only handle maxSlots at this time
		if (i >= maxSlots)
			break;

		// Only check files expected to be save files
		var pattern:RegExp = /\.coc$/i;
		if (!pattern.test(fileList[fileCount].url))
			continue;

		gameObjects[i] = getGameObjectFromFile(fileList[fileCount]);
		outputText(loadSaveDisplay(gameObjects[i], String(i+1)));

		if (gameObjects[i].data.exists)
		{
			//trace("Creating function with indice = ", i);
			(function(i:int):void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
			{
				slots[i] = function() : void 		// Anonymous functions FTW
				{
					trace("Loading save with name ", fileList[fileCount].url, " at index ", i);
					clearOutput();
					loadGameObject(gameObjects[i]);
					outputText("Slot " + String(i+1) + " Loaded!");
					statScreenRefresh();
					doNext(playerMenu);
				}
			})(i);
		}
		else
		{
			slots[i] = null;		// You have to set the parameter to 0 to disable the button
		}
		i++;
	}
	menu();
	var s:int = 0;
	while (s < 14) {
		//if (slots[s] != null) addButton(s, "Slot " + (s + 1), slots[s]);
		if (slots[s] != null) addButton(s, "Slot " + (s + 1), selectLoadButton, gameObjects[s], "CoC_" + String(s+1));
		s++;
	}
	addButton(14, "Back", returnToSaveMenu);
}

public function getGameObjectFromFile(aFile:File):Object
{
	var stream:FileStream = new FileStream();
	var bytes:ByteArray = new ByteArray();
	try
	{
		stream.open(aFile, FileMode.READ);
		stream.readBytes(bytes);
		stream.close();
		return bytes.readObject();
	}
	catch (error:Error)
	{
		clearOutput();
		outputText("Failed to read save file, " + aFile.url + " (" + error.message + ")");
	}
	return null;
 }

}

public function loadScreen():void
{
	var slots:Array = new Array(saveFileNames.length);

	clearOutput();
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r");

	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		var test:Object = SharedObject.getLocal(saveFileNames[i], "/");
		outputText(loadSaveDisplay(test, String(i + 1)));
		if (test.data.exists/* && test.data.flags[2066] == undefined*/)
		{
			//trace("Creating function with indice = ", i);
			(function(i:int):void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
			{
				slots[i] = function() : void 		// Anonymous functions FTW
				{
					trace("Loading save with name", saveFileNames[i], "at index", i);
					if (loadGame(saveFileNames[i])) {
						doNext(playerMenu);
						showStats();
						statScreenRefresh();
						clearOutput();
						outputText("Slot " + i + " Loaded!");
					}
				}
			})(i);
		}
		else
		{
			slots[i] = null;		// You have to set the parameter to 0 to disable the button
		}
	}
	menu();
	var s:int = 0;
	while (s < 14) {
		if (slots[s] != 0) addButton(s, "Slot " + (s+1), slots[s]);
		s++;
	}
	addButton(14, "Back", returnToSaveMenu);
}

public function saveScreen():void
{
	mainView.nameBox.x = mainView.mainText.x;
	mainView.nameBox.y = 620;
	mainView.nameBox.width = 550;
	mainView.nameBox.text = "";
	mainView.nameBox.maxChars = 54;
	mainView.nameBox.visible = true;

	// var test; // Disabling this variable because it seems to be unused.
	if (flags[kFLAGS.HARDCORE_MODE] > 0)
	{
		saveGame(flags[kFLAGS.HARDCORE_SLOT]);
		clearOutput();
		outputText("You may not create copies of Hardcore save files! Your current progress has been saved.");
		doNext(playerMenu);
		return;
	}

	clearOutput();
	if (player.slotName != "VOID")
		outputText("<b>Last saved or loaded from: " + player.slotName + "</b>\r\r");
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r");

	var saveFuncs:Array = [];


	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		var test:Object = SharedObject.getLocal(saveFileNames[i], "/");
		outputText(loadSaveDisplay(test, String(i + 1)));
		trace("Creating function with indice = ", i);
		(function(i:int) : void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
		{
			saveFuncs[i] = function() : void 		// Anonymous functions FTW
			{
				trace("Saving game with name", saveFileNames[i], "at index", i);
				saveGame(saveFileNames[i], true);
			}
		})(i);

	}


	if (player.slotName == "VOID")
		outputText("\r\r");

	outputText("<b>Leave the notes box blank if you don't wish to change notes.\r<u>NOTES:</u></b>");
	menu();
	var s:int = 0;
	while (s < 14) {
		addButton(s, "Slot " + (s+1), saveFuncs[s]);
		s++;
	}
	addButton(14, "Back", returnToSaveMenu);
}

public function saveLoad(e:MouseEvent = null):void
{
	mainView.eventTestInput.x = -10207.5;
	mainView.eventTestInput.y = -1055.1;
	//Hide the name box in case of backing up from save
	//screen so it doesnt overlap everything.
	mainView.nameBox.visible = false;
	var autoSaveSuffix:String = "";
	if (player && player.autoSave) autoSaveSuffix = "ON";
	else autoSaveSuffix = "OFF";

	clearOutput();
	outputText("<b>Where are my saves located?</b>\n");
	outputText("<i>In Windows Vista/7 (IE/FireFox/Other)</i>: <pre>Users/{username}/Appdata/Roaming/Macromedia/Flash Player/#Shared Objects/{GIBBERISH}/</pre>\n\n");
	outputText("In Windows Vista/7 (Chrome): <pre>Users/{username}/AppData/Local/Google/Chrome/User Data/Default/Pepper Data/Shockwave Flash/WritableRoot/#SharedObjects/{GIBBERISH}/</pre>\n\n");
	outputText("Inside that folder it will saved in a folder corresponding to where it was played from.  If you saved the CoC.swf to your HDD, then it will be in a folder called localhost.  If you played from my website, it will be in fenoxo.com.  The save files will be labelled CoC_1.sol, CoC_2.sol, CoC_3.sol, etc.</i>\n\n");
	outputText("<b>Why do my saves disappear all the time?</b>\n<i>There are numerous things that will wipe out flash local shared files.  If your browser or player is set to delete flash cookies or data, that will do it.  CCleaner will also remove them.  CoC or its updates will never remove your savegames - if they disappear something else is wiping them out.</i>\n\n");
	outputText("<b>When I play from my HDD I have one set of saves, and when I play off your site I have a different set of saves.  Why?</b>\n<i>Flash stores saved data relative to where it was accessed from.  Playing from your HDD will store things in a different location than fenoxo.com or FurAffinity.</i>\n");
	outputText("<i>If you want to be absolutely sure you don't lose a character, copy the .sol file for that slot out and back it up! <b>For more information, google flash shared objects.</b></i>\n\n");
	outputText("<b>Why does the Save File and Load File option not work?</b>\n");
	outputText("<i>Save File and Load File are limited by the security settings imposed upon CoC by Flash. These options will only work if you have downloaded the game from the website, and are running it from your HDD. Additionally, they can only correctly save files to and load files from the directory where you have the game saved.</i>");
	//This is to clear the 'game over' block from stopping simpleChoices from working.  Loading games supercede's game over.

	menu();
	//addButton(0, "Save", saveScreen);
	addButton(1, "Load", loadScreen);
	addButton(2, "Delete", deleteScreen);
	//addButton(5, "Save to File", saveToFile);
	addButton(6, "Load File", openSave);
	//addButton(8, "AutoSave: " + autoSaveSuffix, autosaveToggle);
	addButton(14, "Back", EventParser.gameOver, true);

	if (mainView.getButtonText( 0 ) == "Game Over")
	{
		mainView.setButtonText( 0, "save/load" );
		addButton(14, "Back", EventParser.gameOver, true);
		return;
	}
	if (!player) {
		addButton(14, "Back", CoC.instance.mainMenu.mainMenu);
		return;
	}
	if (inDungeon) {
		addButton(14, "Back", playerMenu);
		return;
	}
	if (gameStateGet() == 3) {
		addButton(0, "Save", saveScreen);
		addButton(5, "Save to File", saveToFile);
		addButton(3, "AutoSave: " + autoSaveSuffix, autosaveToggle);
		addButton(14, "Back", CoC.instance.mainMenu.mainMenu);
	}
	else
	{
		addButton(0, "Save", saveScreen);
		addButton(5, "Save to File", saveToFile);
		addButton(3, "AutoSave: " + autoSaveSuffix, autosaveToggle);
		addButton(14, "Back", playerMenu);
	}
	if (flags[kFLAGS.HARDCORE_MODE] >= 1) {
		removeButton(5); //Disable "Save to File" in Hardcore Mode.
	}
}

private function saveToFile():void {
	saveGameObject(null, true);
}

private function autosaveToggle():void {
	player.autoSave = !player.autoSave;
	saveLoad();
}

public function deleteScreen():void
{
	clearOutput();
	outputText("Slot,  Race,  Sex,  Game Days Played\n");


	var delFuncs:Array = [];


	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		var test:Object = SharedObject.getLocal(saveFileNames[i], "/");
		outputText(loadSaveDisplay(test, String(i + 1)));
		if (test.data.exists)
		{
			//slots[i] = loadFuncs[i];

			trace("Creating function with indice = ", i);
			(function(i:int):void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
			{
				delFuncs[i] = function() : void 		// Anonymous functions FTW
				{
					flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] = saveFileNames[i];
					confirmDelete();
				}
			})(i);
		}
		else
			delFuncs[i] = null;	//disable buttons for empty slots
	}

	outputText("\n<b>ONCE DELETED, YOUR SAVE IS GONE FOREVER.</b>");
	menu();
	var s:int = 0;
	while (s < 14) {
		if (delFuncs[s] != null) addButton(s, "Slot " + (s+1), delFuncs[s]);
		s++;
	}
	addButton(14, "Back", returnToSaveMenu);
	/*
	choices("Slot 1", delFuncs[0],
			"Slot 2", delFuncs[1],
			"Slot 3", delFuncs[2],
			"Slot 4", delFuncs[3],
			"Slot 5", delFuncs[4],
			"Slot 6", delFuncs[5],
			"Slot 7", delFuncs[6],
			"Slot 8", delFuncs[7],
			"Slot 9", delFuncs[8],
			"Back", returnToSaveMenu);*/
}

public function confirmDelete():void
{
	clearOutput();
	outputText("You are about to delete the following save: <b>" + flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] + "</b>\n\nAre you sure you want to delete it?");
	simpleChoices("No", deleteScreen, "Yes", purgeTheMutant, "", null, "", null, "", null);
}

public function purgeTheMutant():void
{
	var test:* = SharedObject.getLocal(flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION], "/");
	trace("DELETING SLOT: " + flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION]);
	var blah:Array = ["been virus bombed", "been purged", "been vaped", "been nuked from orbit", "taken an arrow to the knee", "fallen on its sword", "lost its reality matrix cohesion", "been cleansed", "suffered the following error: (404) Porn Not Found", "been deleted"];

	trace(blah.length + " array slots");
	var select:Number = rand(blah.length);
	clearOutput();
	outputText(flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] + " has " + blah[select] + ".");
	test.clear();
	doNext(deleteScreen);
}

public function confirmOverwrite(slot:String):void {
	mainView.nameBox.visible = false;
	clearOutput();
	outputText("You are about to overwrite the following save slot: " + slot + ".");
	outputText("\n\n<i>If you choose to overwrite a save file from the original CoC, it will no longer be playable on the original version. I recommend you use slots 10-14 for saving on the mod.</i>");
	outputText("\n\n<b>ARE YOU SURE?</b>");
	doYesNo(createCallBackFunction(saveGame, slot), saveScreen);
}

public function saveGame(slot:String, bringPrompt:Boolean = false):void
{
	var saveFile:* = SharedObject.getLocal(slot, "/");
	if (player.slotName != slot && saveFile.data.exists && bringPrompt) {
		confirmOverwrite(slot);
		return;
	}
	player.slotName = slot;
	saveGameObject(slot, false);
}

public function loadGame(slot:String):void
{
	var saveFile:* = SharedObject.getLocal(slot, "/");

	// Check the property count of the file
	var numProps:int = 0;
	for (var prop:String in saveFile.data)
	{
		numProps++;
	}

	var sfVer:*;
	if (saveFile.data.version == undefined)
	{
		sfVer = versionProperties["legacy"];
	}
	else
	{
		sfVer = versionProperties[saveFile.data.version];
	}

	if (!(sfVer is Number))
	{
		sfVer = versionProperties["latest"];
	} else {
		sfVer = sfVer as Number;
	}

	trace("File version "+(saveFile.data.version || "legacy")+"expects propNum " + sfVer);

	if (numProps < sfVer)
	{
		trace("Got " + numProps + " file properties -- failed!");
		clearOutput();
		outputText("<b>Aborting load.  The current save file is missing a number of expected properties.</b>\n\n");

		var backup:SharedObject = SharedObject.getLocal(slot + "_backup", "/");

		if (backup.data.exists)
		{
			outputText("Would you like to load the backup version of this slot?");
			menu();
			addButton(0, "Yes", loadGame, (slot + "_backup"));
			addButton(1, "No", saveLoad);
		}
		else
		{
			menu();
			addButton(0, "Next", saveLoad);
		}
	}
	else
	{
		trace("Got " + numProps + " file properties -- success!");
		// I want to be able to write some debug stuff to the GUI during the loading process
		// Therefore, we clear the display *before* calling loadGameObject
		clearOutput();

		loadGameObject(saveFile, slot);
		loadPermObject();
		outputText("Game Loaded");

		if (player.slotName == "VOID")
		{
			trace("Setting in-use save slot to: " + slot);
			player.slotName = slot;
		}
		statScreenRefresh();
		doNext(playerMenu);
	}
}

//Used for tracking achievements.
public function savePermObject(isFile:Boolean):void {
	//Initialize the save file
	var saveFile:*;
	var backup:SharedObject;
	if (isFile)
	{
		saveFile = {};

		saveFile.data = {};
	}
	else
	{
		saveFile = SharedObject.getLocal("CoC_Main", "/");
	}

	saveFile.data.exists = true;
	saveFile.data.version = ver;

	var processingError:Boolean = false;
	var dataError:Error;

	try {
		var i:int;
		//flag settings
		saveFile.data.flags = [];
		for (i = 0; i < achievements.length; i++) {
			if (flags[i] != 0) {
				saveFile.data.flags[i] = 0;
			}
		}
		saveFile.data.flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] = flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM];

		saveFile.data.flags[kFLAGS.SHOW_SPRITES_FLAG] = flags[kFLAGS.SHOW_SPRITES_FLAG];
		saveFile.data.flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = flags[kFLAGS.SILLY_MODE_ENABLE_FLAG];
		saveFile.data.flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS] = flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS];
		saveFile.data.flags[kFLAGS.SCENEHUNTER_OTHER] = flags[kFLAGS.SCENEHUNTER_OTHER];
		saveFile.data.flags[kFLAGS.SCENEHUNTER_DICK_SELECT] = flags[kFLAGS.SCENEHUNTER_DICK_SELECT];
		saveFile.data.flags[kFLAGS.SCENEHUNTER_UNI_HERMS] = flags[kFLAGS.SCENEHUNTER_UNI_HERMS];
        saveFile.data.flags[kFLAGS.WATERSPORTS_ENABLED] = flags[kFLAGS.WATERSPORTS_ENABLED];

		saveFile.data.flags[kFLAGS.LVL_UP_FAST] = flags[kFLAGS.LVL_UP_FAST];
		saveFile.data.flags[kFLAGS.MUTATIONS_SPOILERS] = flags[kFLAGS.MUTATIONS_SPOILERS];
		saveFile.data.flags[kFLAGS.NEWPERKSDISPLAY] = flags[kFLAGS.NEWPERKSDISPLAY];
		saveFile.data.flags[kFLAGS.INVT_MGMT_TYPE] = flags[kFLAGS.INVT_MGMT_TYPE];
		saveFile.data.flags[kFLAGS.CHARVIEWER_ENABLED] = flags[kFLAGS.CHARVIEWER_ENABLED];
		saveFile.data.flags[kFLAGS.CHARVIEW_STYLE] = flags[kFLAGS.CHARVIEW_STYLE];
		saveFile.data.flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN] = flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN];
		saveFile.data.flags[kFLAGS.USE_OLD_INTERFACE] = flags[kFLAGS.USE_OLD_INTERFACE];
		saveFile.data.flags[kFLAGS.USE_OLD_FONT] = flags[kFLAGS.USE_OLD_FONT];
		saveFile.data.flags[kFLAGS.BACKGROUND_STYLE] = flags[kFLAGS.BACKGROUND_STYLE];
		saveFile.data.flags[kFLAGS.IMAGEPACK_OFF] = flags[kFLAGS.IMAGEPACK_OFF];
		saveFile.data.flags[kFLAGS.SPRITE_STYLE] = flags[kFLAGS.SPRITE_STYLE];
		saveFile.data.flags[kFLAGS.WATERSPORTS_ENABLED] = flags[kFLAGS.WATERSPORTS_ENABLED];
		saveFile.data.flags[kFLAGS.USE_12_HOURS] = flags[kFLAGS.USE_12_HOURS];
		saveFile.data.flags[kFLAGS.USE_METRICS] = flags[kFLAGS.USE_METRICS];
		saveFile.data.flags[kFLAGS.AUTO_LEVEL] = flags[kFLAGS.AUTO_LEVEL];
		saveFile.data.flags[kFLAGS.NO_GORE_MODE] = flags[kFLAGS.NO_GORE_MODE];
		saveFile.data.flags[kFLAGS.STRENGTH_SCALING] = flags[kFLAGS.STRENGTH_SCALING];
		saveFile.data.flags[kFLAGS.SPEED_SCALING] = flags[kFLAGS.SPEED_SCALING];
		saveFile.data.flags[kFLAGS.WISDOM_SCALING] = flags[kFLAGS.WISDOM_SCALING];
		saveFile.data.flags[kFLAGS.INTELLIGENCE_SCALING] = flags[kFLAGS.INTELLIGENCE_SCALING];
		saveFile.data.flags[kFLAGS.MELEE_DAMAGE_OVERHAUL] = flags[kFLAGS.MELEE_DAMAGE_OVERHAUL];
		saveFile.data.flags[kFLAGS.SECONDARY_STATS_SCALING] = flags[kFLAGS.SECONDARY_STATS_SCALING];
		saveFile.data.flags[kFLAGS.TOUGHNESS_SCALING] = flags[kFLAGS.TOUGHNESS_SCALING];
		//saveFile.data.settings = [];
		//saveFile.data.settings.useMetrics = Measurements.useMetrics;
		//achievements
		saveFile.data.achievements = [];
		for (i = 0; i < achievements.length; i++)
		{
			// Don't save unset/default achievements
			if (achievements[i] != 0)
			{
				saveFile.data.achievements[i] = achievements[i];
			}
		}
        if (CoC.instance.permObjVersionID != 0)
            saveFile.data.permObjVersionID = CoC.instance.permObjVersionID;
    }
	catch (error:Error)
	{
		processingError = true;
		dataError = error;
		trace(error.message);
	}
	trace("done saving achievements");
}

public function loadPermObject():void {
	var saveFile:* = SharedObject.getLocal("CoC_Main", "/");
	trace("Loading achievements!");
	//Initialize the save file
	//var saveFile:Object = loader.data.readObject();
	if (saveFile.data.exists)
	{
		//Load saved flags.
		if (saveFile.data.flags) {
			if (saveFile.data.flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] != undefined) flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] = saveFile.data.flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM];

			if (saveFile.data.flags[kFLAGS.SHOW_SPRITES_FLAG] != undefined) flags[kFLAGS.SHOW_SPRITES_FLAG] = saveFile.data.flags[kFLAGS.SHOW_SPRITES_FLAG];
			if (saveFile.data.flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] != undefined) flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = saveFile.data.flags[kFLAGS.SILLY_MODE_ENABLE_FLAG];
            if (saveFile.data.flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS] != undefined) flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS] = saveFile.data.flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS];
            if (saveFile.data.flags[kFLAGS.SCENEHUNTER_OTHER] != undefined) flags[kFLAGS.SCENEHUNTER_OTHER] = saveFile.data.flags[kFLAGS.SCENEHUNTER_OTHER];
            if (saveFile.data.flags[kFLAGS.SCENEHUNTER_DICK_SELECT] != undefined) flags[kFLAGS.SCENEHUNTER_DICK_SELECT] = saveFile.data.flags[kFLAGS.SCENEHUNTER_DICK_SELECT];
            if (saveFile.data.flags[kFLAGS.SCENEHUNTER_UNI_HERMS] != undefined) flags[kFLAGS.SCENEHUNTER_UNI_HERMS] = saveFile.data.flags[kFLAGS.SCENEHUNTER_UNI_HERMS];

			if (saveFile.data.flags[kFLAGS.MUTATIONS_SPOILERS] != undefined) flags[kFLAGS.MUTATIONS_SPOILERS] = saveFile.data.flags[kFLAGS.MUTATIONS_SPOILERS];
			if (saveFile.data.flags[kFLAGS.NEWPERKSDISPLAY] != undefined) flags[kFLAGS.NEWPERKSDISPLAY] = saveFile.data.flags[kFLAGS.NEWPERKSDISPLAY];
			if (saveFile.data.flags[kFLAGS.LVL_UP_FAST] != undefined) flags[kFLAGS.LVL_UP_FAST] = saveFile.data.flags[kFLAGS.LVL_UP_FAST];
			if (saveFile.data.flags[kFLAGS.INVT_MGMT_TYPE] != undefined) flags[kFLAGS.INVT_MGMT_TYPE] = saveFile.data.flags[kFLAGS.INVT_MGMT_TYPE];
			if (saveFile.data.flags[kFLAGS.CHARVIEWER_ENABLED] != undefined) flags[kFLAGS.CHARVIEWER_ENABLED] = saveFile.data.flags[kFLAGS.CHARVIEWER_ENABLED];
			if (saveFile.data.flags[kFLAGS.CHARVIEW_STYLE] != undefined) flags[kFLAGS.CHARVIEW_STYLE] = saveFile.data.flags[kFLAGS.CHARVIEW_STYLE];
			if (saveFile.data.flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN] != undefined) flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN] = saveFile.data.flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN];
			if (saveFile.data.flags[kFLAGS.USE_OLD_INTERFACE] != undefined) flags[kFLAGS.USE_OLD_INTERFACE] = saveFile.data.flags[kFLAGS.USE_OLD_INTERFACE];
			if (saveFile.data.flags[kFLAGS.USE_OLD_FONT] != undefined) flags[kFLAGS.USE_OLD_FONT] = saveFile.data.flags[kFLAGS.USE_OLD_FONT];
			if (saveFile.data.flags[kFLAGS.BACKGROUND_STYLE] != undefined) flags[kFLAGS.BACKGROUND_STYLE] = saveFile.data.flags[kFLAGS.BACKGROUND_STYLE];
			if (saveFile.data.flags[kFLAGS.IMAGEPACK_OFF] != undefined) flags[kFLAGS.IMAGEPACK_OFF] = saveFile.data.flags[kFLAGS.IMAGEPACK_OFF];
			if (saveFile.data.flags[kFLAGS.SPRITE_STYLE] != undefined) flags[kFLAGS.SPRITE_STYLE] = saveFile.data.flags[kFLAGS.SPRITE_STYLE];
			if (saveFile.data.flags[kFLAGS.WATERSPORTS_ENABLED] != undefined) flags[kFLAGS.WATERSPORTS_ENABLED] = saveFile.data.flags[kFLAGS.WATERSPORTS_ENABLED];
			if (saveFile.data.flags[kFLAGS.USE_12_HOURS] != undefined) flags[kFLAGS.USE_12_HOURS] = saveFile.data.flags[kFLAGS.USE_12_HOURS];
			if (saveFile.data.flags[kFLAGS.USE_METRICS] != undefined) flags[kFLAGS.USE_METRICS] = saveFile.data.flags[kFLAGS.USE_METRICS];
			if (saveFile.data.flags[kFLAGS.AUTO_LEVEL] != undefined) flags[kFLAGS.AUTO_LEVEL] = saveFile.data.flags[kFLAGS.AUTO_LEVEL];
			if (saveFile.data.flags[kFLAGS.NO_GORE_MODE] != undefined) flags[kFLAGS.NO_GORE_MODE] = saveFile.data.flags[kFLAGS.NO_GORE_MODE];
			if (saveFile.data.flags[kFLAGS.STRENGTH_SCALING] != undefined) flags[kFLAGS.STRENGTH_SCALING] = saveFile.data.flags[kFLAGS.STRENGTH_SCALING];
			if (saveFile.data.flags[kFLAGS.SPEED_SCALING] != undefined) flags[kFLAGS.SPEED_SCALING] = saveFile.data.flags[kFLAGS.SPEED_SCALING];
			if (saveFile.data.flags[kFLAGS.WISDOM_SCALING] != undefined) flags[kFLAGS.WISDOM_SCALING] = saveFile.data.flags[kFLAGS.WISDOM_SCALING];
			if (saveFile.data.flags[kFLAGS.INTELLIGENCE_SCALING] != undefined) flags[kFLAGS.INTELLIGENCE_SCALING] = saveFile.data.flags[kFLAGS.INTELLIGENCE_SCALING];
			if (saveFile.data.flags[kFLAGS.MELEE_DAMAGE_OVERHAUL] != undefined) flags[kFLAGS.MELEE_DAMAGE_OVERHAUL] = saveFile.data.flags[kFLAGS.MELEE_DAMAGE_OVERHAUL];
			if (saveFile.data.flags[kFLAGS.SECONDARY_STATS_SCALING] != undefined) flags[kFLAGS.SECONDARY_STATS_SCALING] = saveFile.data.flags[kFLAGS.SECONDARY_STATS_SCALING];
			if (saveFile.data.flags[kFLAGS.TOUGHNESS_SCALING] != undefined) flags[kFLAGS.TOUGHNESS_SCALING] = saveFile.data.flags[kFLAGS.TOUGHNESS_SCALING];
		}
		//if(saveFile.data.settings){if(saveFile.data.settings.useMetrics != undefined){Measurements.useMetrics = saveFile.data.settings.useMetrics;}}
		//achievements, will check if achievement exists.
		if (saveFile.data.achievements) {
			for (var i:int = 0; i < achievements.length; i++)
			{
				if (saveFile.data.achievements[i] != undefined)
					achievements[i] = saveFile.data.achievements[i];
			}
		}

		if (saveFile.data.permObjVersionID != undefined) {
            CoC.instance.permObjVersionID = saveFile.data.permObjVersionID;
            trace("Found internal permObjVersionID:", CoC.instance.permObjVersionID);
        }

if (CoC.instance.permObjVersionID < 1039900) {
            // apply fix for issue #337 (Wrong IDs in kACHIEVEMENTS conflicting with other achievements)
			achievements[kACHIEVEMENTS.ZONE_EXPLORER] = 0;
			achievements[kACHIEVEMENTS.ZONE_SIGHTSEER] = 0;
			achievements[kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER] = 0;
			achievements[kACHIEVEMENTS.GENERAL_BAD_ENDER] = 0;
            CoC.instance.permObjVersionID = 1039900;
            savePermObject(false);
            trace("PermObj internal versionID updated:", CoC.instance.permObjVersionID);
        }
	}
}

/*

OH GOD SOMEONE FIX THIS DISASTER!!!!111one1ONE!

*/
//FURNITURE'S JUNK
public function saveGameObject(slot:String, isFile:Boolean):void
{
	//Autosave stuff
	if (player.slotName != "VOID")
		player.slotName = slot;

	var backupAborted:Boolean = false;

	saveAllAwareClasses(CoC.instance); //Informs each saveAwareClass that it must save its values in the flags array
    var counter:Number = player.cocks.length;
	//Initialize the save file
	var saveFile:*;
	var backup:SharedObject;
	if (isFile)
	{
		saveFile = {};

		saveFile.data = {};
	}
	else
	{
		saveFile = SharedObject.getLocal(slot, "/");
	}

	//Set a single variable that tells us if this save exists

	saveFile.data.exists = true;
	saveFile.data.version = ver;
	flags[kFLAGS.SAVE_FILE_INTEGER_FORMAT_VERSION] = SAVE_FILE_CURRENT_INTEGER_FORMAT_VERSION;

	saveFile.data.ss = {};
	for (var key:String in _saveableStates) {
		var ss:SaveableState = _saveableStates[key];
		saveFile.data.ss[key] = ss.saveToObject();
	}

	//CLEAR OLD ARRAYS

	//Save sum dataz
	trace("SAVE DATAZ");
	saveFile.data.short = player.short;
	saveFile.data.a = player.a;

	//Notes
	if (mainView.nameBox.text != "")
	{
		saveFile.data.notes = mainView.nameBox.text;
		notes = mainView.nameBox.text;
	}
	else
	{
		saveFile.data.notes = notes;
		mainView.nameBox.visible = false;
	}
	if (flags[kFLAGS.HARDCORE_MODE] > 0)
	{
		saveFile.data.notes = "<font color=\"#ff0000\">HARDCORE MODE</font>";
	}
	var processingError:Boolean = false;
	var dataError:Error;

	try
	{
		//flags
		saveFile.data.flags = [];
		for (var i:int = 0; i < flags.length; i++)
		{
			// Don't save unset/default flags
			if (flags[i] != 0)
			{
				saveFile.data.flags[i] = flags[i];
			}
		}
		saveFile.data.counters = [];

		//CLOTHING/ARMOR
		saveFile.data.armorId = player.armor.id;
		saveFile.data.weaponId = player.weapon.id;
		saveFile.data.weaponRangeId = player.weaponRange.id;
		saveFile.data.weaponFlyingSwordsId = player.weaponFlyingSwords.id;
		saveFile.data.headJewelryId = player.headJewelry.id;
		saveFile.data.necklaceId = player.necklace.id;
		saveFile.data.jewelryId = player.jewelry.id;
		saveFile.data.jewelryId2 = player.jewelry2.id;
		saveFile.data.jewelryId3 = player.jewelry3.id;
		saveFile.data.jewelryId4 = player.jewelry4.id;
		saveFile.data.miscJewelryId = player.miscJewelry.id;
		saveFile.data.miscJewelryId2 = player.miscJewelry2.id;
		saveFile.data.shieldId = player.shield.id;
		saveFile.data.upperGarmentId = player.upperGarment.id;
		saveFile.data.lowerGarmentId = player.lowerGarment.id;
		saveFile.data.armorName = player.modArmorName;
		saveFile.data.vehiclesId = player.vehicles.id;

		//saveFile.data.weaponName = player.weaponName;// uncomment for backward compatibility
		//saveFile.data.weaponVerb = player.weaponVerb;// uncomment for backward compatibility
		//saveFile.data.armorDef = player.armorDef;// uncomment for backward compatibility
		//saveFile.data.armorPerk = player.armorPerk;// uncomment for backward compatibility
		//saveFile.data.weaponAttack = player.weaponAttack;// uncomment for backward compatibility
		//saveFile.data.weaponPerk = player.weaponPerk;// uncomment for backward compatibility
		//saveFile.data.weaponValue = player.weaponValue;// uncomment for backward compatibility
		//saveFile.data.armorValue = player.armorValue;// uncomment for backward compatibility

		//PIERCINGS
		saveFile.data.nipplesPierced = player.nipplesPierced;
		saveFile.data.nipplesPShort = player.nipplesPShort;
		saveFile.data.nipplesPLong = player.nipplesPLong;
		saveFile.data.lipPierced = player.lipPierced;
		saveFile.data.lipPShort = player.lipPShort;
		saveFile.data.lipPLong = player.lipPLong;
		saveFile.data.tonguePierced = player.tonguePierced;
		saveFile.data.tonguePShort = player.tonguePShort;
		saveFile.data.tonguePLong = player.tonguePLong;
		saveFile.data.eyebrowPierced = player.eyebrowPierced;
		saveFile.data.eyebrowPShort = player.eyebrowPShort;
		saveFile.data.eyebrowPLong = player.eyebrowPLong;
		saveFile.data.earsPierced = player.earsPierced;
		saveFile.data.earsPShort = player.earsPShort;
		saveFile.data.earsPLong = player.earsPLong;
		saveFile.data.nosePierced = player.nosePierced;
		saveFile.data.nosePShort = player.nosePShort;
		saveFile.data.nosePLong = player.nosePLong;

		saveFile.data.stats = {};
		for each(var k:String in player.statStore.allStatNames()) {
			var stat:Jsonable = player.statStore.findStat(k) as Jsonable;
			if (stat) {
				saveFile.data.stats[k] = (stat as Jsonable).saveToObject();
			}
		}
		//MAIN STATS
		saveFile.data.str = player.str;
		saveFile.data.tou = player.tou;
		saveFile.data.spe = player.spe;
		saveFile.data.inte = player.inte;
		saveFile.data.wis = player.wis;
		saveFile.data.lib = player.lib;
		saveFile.data.sens = player.sens;
		saveFile.data.cor = player.cor;
		saveFile.data.fatigue = player.fatigue;
		saveFile.data.mana = player.mana;
		saveFile.data.soulforce = player.soulforce;
		saveFile.data.wrath = player.wrath;
		//Combat STATS
		saveFile.data.HP = player.HP;
		saveFile.data.lust = player.lust;
		saveFile.data.teaseLevel = player.teaseLevel;
		saveFile.data.teaseXP = player.teaseXP;
		//Mastery
		saveFile.data.masteryFeralCombatLevel = player.masteryFeralCombatLevel;
		saveFile.data.masteryFeralCombatXP = player.masteryFeralCombatXP;
		saveFile.data.masteryGauntletLevel = player.masteryGauntletLevel;
		saveFile.data.masteryGauntletXP = player.masteryGauntletXP;
		saveFile.data.masteryDaggerLevel = player.masteryDaggerLevel;
		saveFile.data.masteryDaggerXP = player.masteryDaggerXP;
		saveFile.data.masterySwordLevel = player.masterySwordLevel;
		saveFile.data.masterySwordXP = player.masterySwordXP;
		saveFile.data.masteryAxeLevel = player.masteryAxeLevel;
		saveFile.data.masteryAxeXP = player.masteryAxeXP;
		saveFile.data.masteryMaceHammerLevel = player.masteryMaceHammerLevel;
		saveFile.data.masteryMaceHammerXP = player.masteryMaceHammerXP;
		saveFile.data.masteryDuelingSwordLevel = player.masteryDuelingSwordLevel;
		saveFile.data.masteryDuelingSwordXP = player.masteryDuelingSwordXP;
		saveFile.data.masteryPolearmLevel = player.masteryPolearmLevel;
		saveFile.data.masteryPolearmXP = player.masteryPolearmXP;
		saveFile.data.masterySpearLevel = player.masterySpearLevel;
		saveFile.data.masterySpearXP = player.masterySpearXP;
		saveFile.data.masteryWhipLevel = player.masteryWhipLevel;
		saveFile.data.masteryWhipXP = player.masteryWhipXP;
		saveFile.data.masteryExoticLevel = player.masteryExoticLevel;
		saveFile.data.masteryExoticXP = player.masteryExoticXP;
		saveFile.data.masteryArcheryLevel = player.masteryArcheryLevel;
		saveFile.data.masteryArcheryXP = player.masteryArcheryXP;
		saveFile.data.masteryThrowingLevel = player.masteryThrowingLevel;
		saveFile.data.masteryThrowingXP = player.masteryThrowingXP;
		saveFile.data.masteryFirearmsLevel = player.masteryFirearmsLevel;
		saveFile.data.masteryFirearmsXP = player.masteryFirearmsXP;
		saveFile.data.dualWSLevel = player.dualWSLevel;
		saveFile.data.dualWSXP = player.dualWSXP;
		saveFile.data.dualWNLevel = player.dualWNLevel;
		saveFile.data.dualWNXP = player.dualWNXP;
		saveFile.data.dualWLLevel = player.dualWLLevel;
		saveFile.data.dualWLXP = player.dualWLXP;
		saveFile.data.dualWFLevel = player.dualWFLevel;
		saveFile.data.dualWFXP = player.dualWFXP;
		//Mining
		saveFile.data.miningLevel = player.miningLevel;
		saveFile.data.miningXP = player.miningXP;
		//Herbalism
		saveFile.data.herbalismLevel = player.herbalismLevel;
		saveFile.data.herbalismXP = player.herbalismXP;
		//Prison STATS
		saveFile.data.hunger = player.hunger;
		saveFile.data.esteem = player.esteem;
		saveFile.data.obey = player.obey;
		saveFile.data.obeySoftCap = player.obeySoftCap;
		saveFile.data.will = player.will;

		saveFile.data.prisonItems = player.prisonItemSlots;
		//saveFile.data.prisonArmor = prison.prisonItemSlotArmor;
		//saveFile.data.prisonWeapon = prison.prisonItemSlotWeapon;
		//LEVEL STATS
		saveFile.data.XP = player.XP;
		saveFile.data.level = player.level;
		saveFile.data.gems = player.gems;
		saveFile.data.perkPoints = player.perkPoints;
		saveFile.data.statPoints = player.statPoints;
		saveFile.data.superPerkPoints = player.superPerkPoints;
		saveFile.data.ascensionPerkPoints = player.ascensionPerkPoints;
		//Appearance
		saveFile.data.startingRace = player.startingRace;
		saveFile.data.gender = player.gender;
		saveFile.data.femininity = player.femininity;
		saveFile.data.thickness = player.thickness;
		saveFile.data.tone = player.tone;
		saveFile.data.tallness = player.tallness;
		saveFile.data.hairColor = player.hairColor;
		saveFile.data.hairType = player.hairType;
		saveFile.data.hairStyle = player.hairStyle;
		saveFile.data.gillType = player.gills.type;
		saveFile.data.armType = player.arms.type;
		saveFile.data.hairLength = player.hairLength;
		saveFile.data.beardLength = player.beardLength;
		saveFile.data.eyeType = player.eyes.type;
		saveFile.data.eyeColor = player.eyes.colour;
		saveFile.data.beardStyle = player.beardStyle;
		saveFile.data.tongueType = player.tongue.type;
		saveFile.data.earType = player.ears.type;
		saveFile.data.antennae = player.antennae.type;
		saveFile.data.horns = player.horns.count;
		saveFile.data.hornType = player.horns.type;
		saveFile.data.rearBody = player.rearBody.type;
		player.facePart.saveToSaveData(saveFile.data);
		//player.underBody.saveToSaveData(saveFile.data);
		player.lowerBodyPart.saveToSaveData(saveFile.data);
		player.skin.saveToSaveData(saveFile.data);
		player.tail.saveToSaveData(saveFile.data);
		player.clawsPart.saveToSaveData(saveFile.data);

		saveFile.data.wingDesc = player.wings.desc;
		saveFile.data.wingType = player.wings.type;
		saveFile.data.hipRating = player.hips.type;
		saveFile.data.buttRating = player.butt.type;

		//Sexual Stuff
		saveFile.data.balls = player.balls;
		saveFile.data.cumMultiplier = player.cumMultiplier;
		saveFile.data.ballSize = player.ballSize;
		saveFile.data.hoursSinceCum = player.hoursSinceCum;
		saveFile.data.fertility = player.fertility;

		//Preggo stuff
		saveFile.data.pregnancyIncubation = player.pregnancyIncubation;
		saveFile.data.pregnancyType = player.pregnancyType;
		saveFile.data.buttPregnancyIncubation = player.buttPregnancyIncubation;
		saveFile.data.buttPregnancyType = player.buttPregnancyType;

		/*myLocalData.data.furnitureArray = new Array();
		   for (var i:Number = 0; i < GameArray.length; i++) {
		   myLocalData.data.girlArray.push(new Array());
		   myLocalData.data.girlEffectArray.push(new Array());
		 }*/

		saveFile.data.cocks = [];
		saveFile.data.vaginas = [];
		saveFile.data.breastRows = [];
		saveFile.data.perks = [];
		saveFile.data.statusAffects = [];
		saveFile.data.ass = [];
		saveFile.data.keyItems = [];
		saveFile.data.itemStorage = [];
		saveFile.data.pearlStorage = [];
		saveFile.data.gearStorage = [];
		//Set array
		for (i = 0; i < player.cocks.length; i++)
		{
			saveFile.data.cocks.push([]);
		}
		//Populate Array
		for (i = 0; i < player.cocks.length; i++)
		{
			saveFile.data.cocks[i].cockThickness = player.cocks[i].cockThickness;
			saveFile.data.cocks[i].cockLength = player.cocks[i].cockLength;
			saveFile.data.cocks[i].cockType = player.cocks[i].cockType.Index;
			saveFile.data.cocks[i].knotMultiplier = player.cocks[i].knotMultiplier;
			saveFile.data.cocks[i].pierced = player.cocks[i].pierced;
			saveFile.data.cocks[i].pShortDesc = player.cocks[i].pShortDesc;
			saveFile.data.cocks[i].pLongDesc = player.cocks[i].pLongDesc;
			saveFile.data.cocks[i].sock = player.cocks[i].sock;
		}
		//Set Vaginal Array
		for (i = 0; i < player.vaginas.length; i++)
		{
			saveFile.data.vaginas.push([]);
		}
		//Populate Vaginal Array
		for (i = 0; i < player.vaginas.length; i++)
		{
			saveFile.data.vaginas[i].type = player.vaginas[i].type;
			saveFile.data.vaginas[i].vaginalWetness = player.vaginas[i].vaginalWetness;
			saveFile.data.vaginas[i].vaginalLooseness = player.vaginas[i].vaginalLooseness;
			saveFile.data.vaginas[i].fullness = player.vaginas[i].fullness;
			saveFile.data.vaginas[i].virgin = player.vaginas[i].virgin;
			saveFile.data.vaginas[i].labiaPierced = player.vaginas[i].labiaPierced;
			saveFile.data.vaginas[i].labiaPShort = player.vaginas[i].labiaPShort;
			saveFile.data.vaginas[i].labiaPLong = player.vaginas[i].labiaPLong;
			saveFile.data.vaginas[i].clitPierced = player.vaginas[i].clitPierced;
			saveFile.data.vaginas[i].clitPShort = player.vaginas[i].clitPShort;
			saveFile.data.vaginas[i].clitPLong = player.vaginas[i].clitPLong;
			saveFile.data.vaginas[i].clitLength = player.vaginas[i].clitLength;
			saveFile.data.vaginas[i].recoveryProgress = player.vaginas[i].recoveryProgress;
		}
		//NIPPLES
		saveFile.data.nippleLength = player.nippleLength;
		//Set Breast Array
		for (i = 0; i < player.breastRows.length; i++)
		{
			saveFile.data.breastRows.push([]);
				//trace("Saveone breastRow");
		}
		//Populate Breast Array
		for (i = 0; i < player.breastRows.length; i++)
		{
			//trace("Populate One BRow");
			saveFile.data.breastRows[i].breasts = player.breastRows[i].breasts;
			saveFile.data.breastRows[i].breastRating = player.breastRows[i].breastRating;
			saveFile.data.breastRows[i].nipplesPerBreast = player.breastRows[i].nipplesPerBreast;
			saveFile.data.breastRows[i].lactationMultiplier = player.breastRows[i].lactationMultiplier;
			saveFile.data.breastRows[i].milkFullness = player.breastRows[i].milkFullness;
			saveFile.data.breastRows[i].fuckable = player.breastRows[i].fuckable;
			saveFile.data.breastRows[i].fullness = player.breastRows[i].fullness;
		}
		//Set Perk Array
		//Populate Perk Array
		player.perks.forEach(function (perk:PerkClass, ...args):void {
			var savePerk: Object = {
				id: perk.ptype.id,
				value1: perk.value1,
				value2: perk.value2,
				value3: perk.value3,
				value4: perk.value4
			};
			saveFile.data.perks.push(savePerk);
		});

		//Populate Status Array
		for each(var statusEffect:StatusEffectClass in player.statusEffects) {
			var saveStatusEffect: Object = {
				statusAffectName: statusEffect.stype.id,
				value1: statusEffect.value1,
				value2: statusEffect.value2,
				value3: statusEffect.value3,
				value4: statusEffect.value4
			};
			saveFile.data.statusAffects.push(saveStatusEffect);
		}
		//Set keyItem Array
		for (i = 0; i < player.keyItems.length; i++)
		{
			saveFile.data.keyItems.push([]);
				//trace("Saveone keyItem");
		}
		//Populate keyItem Array
		for (i = 0; i < player.keyItems.length; i++)
		{
			//trace("Populate One keyItemzzzzzz");
			saveFile.data.keyItems[i].keyName = player.keyItems[i].keyName;
			saveFile.data.keyItems[i].value1 = player.keyItems[i].value1;
			saveFile.data.keyItems[i].value2 = player.keyItems[i].value2;
			saveFile.data.keyItems[i].value3 = player.keyItems[i].value3;
			saveFile.data.keyItems[i].value4 = player.keyItems[i].value4;
		}
		// Potions
		saveFile.data.potions = [];
		for (i = 0; i < player.potions.length; i++) {
			saveFile.data.potions[i] = {};
			saveFile.data.potions[i].id = player.potions[i].type.ID;
			saveFile.data.potions[i].count = player.potions[i].count;
		}
		// Set storage slot array
		for (i = 0; i < itemStorageGet().length; i++)
		{
			saveFile.data.itemStorage.push([]);
		}

		//Populate storage slot array
		for (i = 0; i < itemStorageGet().length; i++)
		{
			//saveFile.data.itemStorage[i].shortName = itemStorage[i].itype.id;// For backward compatibility
			saveFile.data.itemStorage[i].id = (itemStorageGet()[i].itype == null) ? null : itemStorageGet()[i].itype.id;
			saveFile.data.itemStorage[i].quantity = itemStorageGet()[i].quantity;
			saveFile.data.itemStorage[i].unlocked = itemStorageGet()[i].unlocked;
		}
		//Set gear slot array
		for (i = 0; i < gearStorageGet().length; i++)
		{
			saveFile.data.gearStorage.push([]);
		}

		//Populate gear slot array
		for (i = 0; i < gearStorageGet().length; i++)
		{
			//saveFile.data.gearStorage[i].shortName = gearStorage[i].itype.id;// uncomment for backward compatibility
			saveFile.data.gearStorage[i].id = (gearStorageGet()[i].isEmpty()) ? null : gearStorageGet()[i].itype.id;
			saveFile.data.gearStorage[i].quantity = gearStorageGet()[i].quantity;
			saveFile.data.gearStorage[i].unlocked = gearStorageGet()[i].unlocked;
		}

		//Set gear slot array
		for (i = 0; i < pearlStorageGet().length; i++)
		{
			saveFile.data.pearlStorage.push([]);
		}

		//Populate pearl slot array
		for (i = 0; i < pearlStorageGet().length; i++)
		{
			//saveFile.data.pearlStorage[i].shortName = pearlStorage[i].itype.id;// uncomment for backward compatibility
			saveFile.data.pearlStorage[i].id = (pearlStorageGet()[i].isEmpty()) ? null : pearlStorageGet()[i].itype.id;
			saveFile.data.pearlStorage[i].quantity = pearlStorageGet()[i].quantity;
			saveFile.data.pearlStorage[i].unlocked = pearlStorageGet()[i].unlocked;
		}
		saveFile.data.ass.push([]);
		saveFile.data.ass.analWetness = player.ass.analWetness;
		saveFile.data.ass.analLooseness = player.ass.analLooseness;
		saveFile.data.ass.fullness = player.ass.fullness;
		//EXPLORED
		saveFile.data.exploredLake = player.exploredLake;
		saveFile.data.exploredMountain = player.exploredMountain;
		saveFile.data.exploredForest = player.exploredForest;
		saveFile.data.exploredDesert = player.exploredDesert;
		saveFile.data.explored = player.explored;
		saveFile.data.gameState = gameStateGet();

		//Time and Items
		saveFile.data.minutes = model.time.minutes;
		saveFile.data.hours = model.time.hours;
		saveFile.data.days = model.time.days;
		saveFile.data.autoSave = player.autoSave;

		//PLOTZ
        saveFile.data.monk = JojoScene.monk;
        saveFile.data.sand = SandWitchScene.rapedBefore;
        saveFile.data.beeProgress = 0; //Now saved in a flag. getGame().beeProgress;

		saveFile.data.isabellaOffspringData = [];
		for (i = 0; i < SceneLib.isabellaScene.isabellaOffspringData.length; i++) {
			saveFile.data.isabellaOffspringData.push(SceneLib.isabellaScene.isabellaOffspringData[i]);
		}

		//ITEMZ. Item1s
		saveFile.data.itemSlot1 = [];
		saveFile.data.itemSlot1.quantity = player.itemSlot1.quantity;
		saveFile.data.itemSlot1.id = player.itemSlot1.itype.id;
		saveFile.data.itemSlot1.unlocked = true;

		saveFile.data.itemSlot2 = [];
		saveFile.data.itemSlot2.quantity = player.itemSlot2.quantity;
		saveFile.data.itemSlot2.id = player.itemSlot2.itype.id;
		saveFile.data.itemSlot2.unlocked = true;

		saveFile.data.itemSlot3 = [];
		saveFile.data.itemSlot3.quantity = player.itemSlot3.quantity;
		saveFile.data.itemSlot3.id = player.itemSlot3.itype.id;
		saveFile.data.itemSlot3.unlocked = true;

		saveFile.data.itemSlot4 = [];
		saveFile.data.itemSlot4.quantity = player.itemSlot4.quantity;
		saveFile.data.itemSlot4.id = player.itemSlot4.itype.id;
		saveFile.data.itemSlot4.unlocked = true;

		saveFile.data.itemSlot5 = [];
		saveFile.data.itemSlot5.quantity = player.itemSlot5.quantity;
		saveFile.data.itemSlot5.id = player.itemSlot5.itype.id;
		saveFile.data.itemSlot5.unlocked = true;

		saveFile.data.itemSlot6 = [];
		saveFile.data.itemSlot6.quantity = player.itemSlot6.quantity;
		saveFile.data.itemSlot6.id = player.itemSlot6.itype.id;
		saveFile.data.itemSlot6.unlocked = player.itemSlot6.unlocked;

		saveFile.data.itemSlot7 = [];
		saveFile.data.itemSlot7.quantity = player.itemSlot7.quantity;
		saveFile.data.itemSlot7.id = player.itemSlot7.itype.id;
		saveFile.data.itemSlot7.unlocked = player.itemSlot7.unlocked;

		saveFile.data.itemSlot8 = [];
		saveFile.data.itemSlot8.quantity = player.itemSlot8.quantity;
		saveFile.data.itemSlot8.id = player.itemSlot8.itype.id;
		saveFile.data.itemSlot8.unlocked = player.itemSlot8.unlocked;

		saveFile.data.itemSlot9 = [];
		saveFile.data.itemSlot9.quantity = player.itemSlot9.quantity;
		saveFile.data.itemSlot9.id = player.itemSlot9.itype.id;
		saveFile.data.itemSlot9.unlocked = player.itemSlot9.unlocked;

		saveFile.data.itemSlot10 = [];
		saveFile.data.itemSlot10.quantity = player.itemSlot10.quantity;
		saveFile.data.itemSlot10.id = player.itemSlot10.itype.id;
		saveFile.data.itemSlot10.unlocked = player.itemSlot10.unlocked;

		saveFile.data.itemSlot11 = [];
		saveFile.data.itemSlot11.quantity = player.itemSlot11.quantity;
		saveFile.data.itemSlot11.id = player.itemSlot11.itype.id;
		saveFile.data.itemSlot11.unlocked = player.itemSlot11.unlocked;

		saveFile.data.itemSlot12 = [];
		saveFile.data.itemSlot12.quantity = player.itemSlot12.quantity;
		saveFile.data.itemSlot12.id = player.itemSlot12.itype.id;
		saveFile.data.itemSlot12.unlocked = player.itemSlot12.unlocked;

		saveFile.data.itemSlot13 = [];
		saveFile.data.itemSlot13.quantity = player.itemSlot13.quantity;
		saveFile.data.itemSlot13.id = player.itemSlot13.itype.id;
		saveFile.data.itemSlot13.unlocked = player.itemSlot13.unlocked;

		saveFile.data.itemSlot14 = [];
		saveFile.data.itemSlot14.quantity = player.itemSlot14.quantity;
		saveFile.data.itemSlot14.id = player.itemSlot14.itype.id;
		saveFile.data.itemSlot14.unlocked = player.itemSlot14.unlocked;

		saveFile.data.itemSlot15 = [];
		saveFile.data.itemSlot15.quantity = player.itemSlot15.quantity;
		saveFile.data.itemSlot15.id = player.itemSlot15.itype.id;
		saveFile.data.itemSlot15.unlocked = player.itemSlot15.unlocked;

		saveFile.data.itemSlot16 = [];
		saveFile.data.itemSlot16.quantity = player.itemSlot16.quantity;
		saveFile.data.itemSlot16.id = player.itemSlot16.itype.id;
		saveFile.data.itemSlot16.unlocked = player.itemSlot16.unlocked;

		saveFile.data.itemSlot17 = [];
		saveFile.data.itemSlot17.quantity = player.itemSlot17.quantity;
		saveFile.data.itemSlot17.id = player.itemSlot17.itype.id;
		saveFile.data.itemSlot17.unlocked = player.itemSlot17.unlocked;

		saveFile.data.itemSlot18 = [];
		saveFile.data.itemSlot18.quantity = player.itemSlot18.quantity;
		saveFile.data.itemSlot18.id = player.itemSlot18.itype.id;
		saveFile.data.itemSlot18.unlocked = player.itemSlot18.unlocked;

		saveFile.data.itemSlot19 = [];
		saveFile.data.itemSlot19.quantity = player.itemSlot19.quantity;
		saveFile.data.itemSlot19.id = player.itemSlot19.itype.id;
		saveFile.data.itemSlot19.unlocked = player.itemSlot19.unlocked;

		saveFile.data.itemSlot20 = [];
		saveFile.data.itemSlot20.quantity = player.itemSlot20.quantity;
		saveFile.data.itemSlot20.id = player.itemSlot20.itype.id;
		saveFile.data.itemSlot20.unlocked = player.itemSlot20.unlocked;


		// Keybinds
        saveFile.data.controls = CoC.instance.inputManager.SaveBindsToObj();
		saveFile.data.world = [];
		saveFile.data.world.x = [];
		for each(var npc:XXCNPC in XXCNPC.SavedNPCs){
			npc.save(saveFile.data.world.x);
		}
	}
	catch (error:Error)
	{
		processingError = true;
		dataError = error;
		trace(error.message);
	}


	trace("done saving");
	// Because actionscript is stupid, there is no easy way to block until file operations are done.
	// Therefore, I'm hacking around it for the chaos monkey.
	// Really, something needs to listen for the FileReference.complete event, and re-enable saving/loading then.
	// Something to do in the future
	if (isFile && !processingError)
	{
		if (!(CoC.instance.monkey.run))
		{
			//outputText(serializeToString(saveFile.data), true);
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(saveFile);
			CONFIG::AIR
			{
				// saved filename: "name of character".coc
				var airSaveDir:File = File.documentsDirectory.resolvePath(savedGameDir);
				var airFile:File = airSaveDir.resolvePath(player.short + ".coc");
				var stream:FileStream = new FileStream();
				try
				{
					airSaveDir.createDirectory();
					stream.open(airFile, FileMode.WRITE);
					stream.writeBytes(bytes);
					stream.close();
					clearOutput();
					outputText("Saved to file: " + airFile.url);
					doNext(playerMenu);
				}
				catch (error:Error)
				{
					backupAborted = true;
					clearOutput();
					outputText("Failed to write to file: " + airFile.url + " (" + error.message + ") Go to application and change CoC permission to allow storage of data");
					doNext(playerMenu);
				}
			}
			CONFIG::STANDALONE
			{
				file = new FileReference();
				file.save(bytes, null);
				clearOutput();
				outputText("Attempted to save to file.");
			}
		}
	}
	else if (!processingError)
	{
		// Write the file
		saveFile.flush();

		// Reload it
		saveFile = SharedObject.getLocal(slot, "/");
		backup = SharedObject.getLocal(slot + "_backup", "/");
		var numProps:int = 0;

		// Copy the properties over to a new file object
		for (var prop:String in saveFile.data)
		{
			numProps++;
			backup.data[prop] = saveFile.data[prop];
		}

		// There should be 124 root properties minimum in the save file. Give some wiggleroom for things that might be omitted? (All of the broken saves I've seen are MUCH shorter than expected)
		if (numProps < versionProperties[ver])
		{
			clearOutput();
			outputText("<b>Aborting save.  Your current save file is broken, and needs to be bug-reported.</b>\n\nWithin the save folder for CoC, there should be a pair of files named \"" + slot + ".sol\" and \"" + slot + "_backup.sol\"\n\n<b>We need BOTH of those files, and a quick report of what you've done in the game between when you last saved, and this message.</b>\n\n");
			outputText("When you've sent us the files, you can copy the _backup file over your old save to continue from your last save.\n\n");
			outputText("Alternatively, you can just hit the restore button to overwrite the broken save with the backup... but we'd really like the saves first!");
			trace("Backup Save Aborted! Broken save detected!");
			backupAborted = true;
		}
		else
		{
			// Property count is correct, write the backup
			backup.flush();
		}

		if (!backupAborted) {
			clearOutput();
			outputText("Saved to slot" + slot + "!");
		}
	}
	else
	{
		outputText("There was a processing error during saving. Please report the following message:\n\n");
		outputText(dataError.message);
		outputText("\n\n");
		outputText(dataError.getStackTrace());
	}

	if (!backupAborted)
	{
		doNext(playerMenu);
	}
	else
	{
		menu();
		addButton(0, "Next", playerMenu);
		addButton(9, "Restore", restore, slot);
	}

}

public function restore(slotName:String):void
{
	clearOutput();
	// copy slot_backup.sol over slot.sol
	var backupFile:SharedObject = SharedObject.getLocal(slotName + "_backup", "/");
	var overwriteFile:SharedObject = SharedObject.getLocal(slotName, "/");

	for (var prop:String in backupFile.data)
	{
		overwriteFile.data[prop] = backupFile.data[prop];
	}

	overwriteFile.flush();

	clearOutput();
	outputText("Restored backup of " + slotName);
	menu();
	doNext(playerMenu);
}

public function openSave():void
{

	// Block when running the chaos monkey
	if (!(CoC.instance.monkey.run))
	{
		CONFIG::AIR
		{
			loadScreenAIR();
		}
		CONFIG::STANDALONE
		{
			file = new FileReference();
			file.addEventListener(Event.SELECT, onFileSelected);
			file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			file.browse();
		}
		//var fileObj : Object = readObjectFromStringBytes("");
		//loadGameFile(fileObj);
	}
}


public function onFileSelected(evt:Event):void
{
	CONFIG::AIR
	{
		airFile.addEventListener(Event.COMPLETE, onFileLoaded);
		airFile.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		airFile.load();
	}
	CONFIG::STANDALONE
	{
		file.addEventListener(Event.COMPLETE, onFileLoaded);
		file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		file.load();
	}
}

public function onFileLoaded(evt:Event):void
{
	var tempFileRef:FileReference = FileReference(evt.target);
	trace("File target = ", evt.target);
	loader = new URLLoader();
	loader.dataFormat = URLLoaderDataFormat.BINARY;
	loader.addEventListener(Event.COMPLETE, onDataLoaded);
	loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
	try
	{
		var req:* = new URLRequest(tempFileRef.name);
		loader.load(req);
	}
	catch (error:Error)
	{
		clearOutput();
		outputText("<b>!</b> Save file not found, check that it is in the same directory as the CoC.swf file.\n\nLoad from file is not available when playing directly from a website like furaffinity or fenoxo.com.");
	}
}

public function ioErrorHandler(e:IOErrorEvent):void
{
	clearOutput();
	outputText("<b>!</b> Save file not found, check that it is in the same directory as the CoC_" + ver + ".swf file.\r\rLoad from file is not available when playing directly from a website like furaffinity or fenoxo.com.");
	doNext(returnToSaveMenu);
}

private function returnToSaveMenu():void {
	var f:MouseEvent;
	saveLoad(f);
}

public function onDataLoaded(evt:Event):void
{
	//var fileObj = readObjectFromStringBytes(loader.data);
	try {
		// I want to be able to write some debug stuff to the GUI during the loading process
		// Therefore, we clear the display *before* calling loadGameObject
		clearOutput();
		outputText("Loading save...");
		trace("OnDataLoaded! - Reading data", loader, loader.data.readObject);
		var tmpObj:Object = loader.data.readObject();
		trace("Read in object = ", tmpObj);

		CONFIG::debug
		{
			if (tmpObj == null) {
				throw new Error("Bad Save load?"); // Re throw error in debug mode.
			}
		}
		loadGameObject(tmpObj);
		outputText("Loaded Save");
		statScreenRefresh();
	}
	catch (rangeError:RangeError)
	{
		clearOutput();
		outputText("<b>!</b> File is either corrupted or not a valid save");
		doNext(returnToSaveMenu);
	}
	catch (error:Error)
	{
		clearOutput();
		outputText("<b>!</b> Unhandled Exception");
		outputText("[pg]Failed to load save. The file may be corrupt!");

		doNext(returnToSaveMenu);
	}
	//playerMenu();
}

/**
 * Upgrade loaded saveFile.data object to most recent version
 * so the loadGameObject can proceed without hacks
 */
private function unFuckSaveDataBeforeLoading(data:Object):void {
	if (data.tail === undefined) {
		var venomAsCount:Boolean = data.tailType == Tail.FOX;
		data.tail = {
			type    : data.tailType,
			venom   : venomAsCount ? 0 : data.tailVenum,
			recharge: data.tailRecharge,
			count   : (data.tailType == 0) ? 0 : venomAsCount ? data.tailVenum : 1
		}
	}
}
public function loadGameObject(saveData:Object, slot:String = "VOID"):void
{
    var game:CoC = CoC.instance;
	inDungeon = false;
	inRoomedDungeon = false;
	inRoomedDungeonResume = null;

	//Autosave stuff
	if(player){
        player.slotName = slot;
	}
	trace("Loading save!");

	var saveFile:* = saveData;
	var data:Object = saveFile.data;
	if (saveFile.data.exists)
	{

		//KILL ALL COCKS;
		player = new Player();
		game.flags = new DefaultDict();
		model.player = player;

		//trace("Type of saveFile.data = ", getClass(saveFile.data));

		inventory.clearStorage();
		inventory.clearPearlStorage();
		inventory.clearGearStorage();
		player.short = saveFile.data.short;
		player.a = saveFile.data.a;
		notes = saveFile.data.notes;

		//flags
		for (var i:int = 0; i < flags.length; i++)
		{
			if (saveFile.data.flags[i] != undefined)
				flags[i] = saveFile.data.flags[i];
		}
		if (saveFile.data.versionID != undefined) {
			game.versionID = saveFile.data.versionID;
			trace("Found internal versionID:", game.versionID);
		}
		unFuckSaveDataBeforeLoading(saveFile.data);
		//PIERCINGS

		//trace("LOADING PIERCINGS");
		player.nipplesPierced = saveFile.data.nipplesPierced;
		player.nipplesPShort = saveFile.data.nipplesPShort;
		player.nipplesPLong = saveFile.data.nipplesPLong;
		player.lipPierced = saveFile.data.lipPierced;
		player.lipPShort = saveFile.data.lipPShort;
		player.lipPLong = saveFile.data.lipPLong;
		player.tonguePierced = saveFile.data.tonguePierced;
		player.tonguePShort = saveFile.data.tonguePShort;
		player.tonguePLong = saveFile.data.tonguePLong;
		player.eyebrowPierced = saveFile.data.eyebrowPierced;
		player.eyebrowPShort = saveFile.data.eyebrowPShort;
		player.eyebrowPLong = saveFile.data.eyebrowPLong;
		player.earsPierced = saveFile.data.earsPierced;
		player.earsPShort = saveFile.data.earsPShort;
		player.earsPLong = saveFile.data.earsPLong;
		player.nosePierced = saveFile.data.nosePierced;
		player.nosePShort = saveFile.data.nosePShort;
		player.nosePLong = saveFile.data.nosePLong;
		player.level = saveFile.data.level;

		if (saveFile.data.statPoints == undefined)
			player.statPoints = 0;
		else
			player.statPoints = saveFile.data.statPoints;

		if (data.stats) {
			player.statStore.forEachStat(function(stat:IStat):void {
				if (stat is BuffableStat) {
					(stat as BuffableStat).removeAllBuffs();
				}
			});
			for (var k:String in data.stats) {
				var statdata:* = data.stats[k];
				var stat:IStat = player.statStore.findStat(k);
				if (stat && stat is Jsonable) {
					(stat as Jsonable).loadFromObject(statdata, false);
				}
			}
		} else {
			// we load old save, compensate stat points
			player.statPoints = player.level*5;
		}

		//MAIN STATS

		player.cor = saveFile.data.cor;
		player.fatigue = saveFile.data.fatigue;
		player.mana = saveFile.data.mana;
		player.soulforce = saveFile.data.soulforce;
		player.wrath = saveFile.data.wrath;

		//CLOTHING/ARMOR
		var found:Boolean = false;
		if (saveFile.data.weaponId){
			player.setWeaponHiddenField((ItemType.lookupItem(saveFile.data.weaponId) as Weapon) || WeaponLib.FISTS);
		} else {
			player.setWeapon(WeaponLib.FISTS);
			//player.weapon = WeaponLib.FISTS;
			for each (var itype:ItemType in ItemType.getItemLibrary()) {
				if (itype is Weapon && (itype as Weapon).name == saveFile.data.weaponName){
					player.setWeaponHiddenField(itype as Weapon || WeaponLib.FISTS);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.weaponRangeId){
			player.setWeaponRangeHiddenField((ItemType.lookupItem(saveFile.data.weaponRangeId) as WeaponRange) || WeaponRangeLib.NOTHING);
		} else {
			player.setWeaponRange(WeaponRangeLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is WeaponRange && (itype as WeaponRange).name == saveFile.data.weaponRangeName){
					player.setWeaponRangeHiddenField(itype as WeaponRange || WeaponRangeLib.NOTHING);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.weaponFlyingSwordsId){
			player.setWeaponFlyingSwordsHiddenField((ItemType.lookupItem(saveFile.data.weaponFlyingSwordsId) as FlyingSwords) || FlyingSwordsLib.NOTHING);
		} else {
			player.setWeaponFlyingSwords(FlyingSwordsLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is FlyingSwords && (itype as FlyingSwords).name == saveFile.data.weaponFlyingSwordsName){
					player.setWeaponFlyingSwordsHiddenField(itype as FlyingSwords || FlyingSwordsLib.NOTHING);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.shieldId){
			player.setShieldHiddenField((ItemType.lookupItem(saveFile.data.shieldId) as Shield) || ShieldLib.NOTHING);
		} else {
			player.setShield(ShieldLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Shield && (itype as Shield).name == saveFile.data.shieldName){
					player.setShieldHiddenField(itype as Shield || ShieldLib.NOTHING);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.miscJewelryId){
			player.setMiscJewelryHiddenField((ItemType.lookupItem(saveFile.data.miscJewelryId) as MiscJewelry) || MiscJewelryLib.NOTHING);
		} else {
			player.setMiscJewelry(MiscJewelryLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is MiscJewelry && (itype as MiscJewelry).name == saveFile.data.miscjewelryName){
					player.setMiscJewelryHiddenField(itype as MiscJewelry || MiscJewelryLib.NOTHING);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.miscJewelryId2){
			player.setMiscJewelryHiddenField2((ItemType.lookupItem(saveFile.data.miscJewelryId2) as MiscJewelry) || MiscJewelryLib.NOTHING);
		} else {
			player.setMiscJewelry2(MiscJewelryLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is MiscJewelry && (itype as MiscJewelry).name == saveFile.data.miscjewelryName2){
					player.setMiscJewelryHiddenField2(itype as MiscJewelry || MiscJewelryLib.NOTHING);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.headJewelryId){
			player.setHeadJewelryHiddenField((ItemType.lookupItem(saveFile.data.headJewelryId) as HeadJewelry) || HeadJewelryLib.NOTHING);
		} else {
			player.setHeadJewelry(HeadJewelryLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is HeadJewelry && (itype as HeadJewelry).name == saveFile.data.headjewelryName){
					player.setHeadJewelryHiddenField(itype as HeadJewelry || HeadJewelryLib.NOTHING);
					found = true;
					break;
				}
			}
		}/*
		if (saveFile.data.jewelryId2){
			player.setJewelryHiddenField2((ItemType.lookupItem(saveFile.data.jewelryId2) as Jewelry) || JewelryLib.NOTHING);
		} else {
			player.setJewelry2(JewelryLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Jewelry && (itype as Jewelry).name == saveFile.data.jewelryName2){
					player.setJewelryHiddenField2(itype as Jewelry || JewelryLib.NOTHING);
					found = true;
					break;
				}
			}
		}*/
		if (saveFile.data.necklaceId){
			player.setNecklaceHiddenField((ItemType.lookupItem(saveFile.data.necklaceId) as Necklace) || NecklaceLib.NOTHING);
		} else {
			player.setNecklace(NecklaceLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Necklace && (itype as Necklace).name == saveFile.data.necklaceName){
					player.setNecklaceHiddenField(itype as Necklace || NecklaceLib.NOTHING);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.jewelryId){
			player.setJewelryHiddenField((ItemType.lookupItem(saveFile.data.jewelryId) as Jewelry) || JewelryLib.NOTHING);
		} else {
			player.setJewelry(JewelryLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Jewelry && (itype as Jewelry).name == saveFile.data.jewelryName){
					player.setJewelryHiddenField(itype as Jewelry || JewelryLib.NOTHING);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.jewelryId2){
			player.setJewelryHiddenField2((ItemType.lookupItem(saveFile.data.jewelryId2) as Jewelry) || JewelryLib.NOTHING);
		} else {
			player.setJewelry2(JewelryLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Jewelry && (itype as Jewelry).name == saveFile.data.jewelryName2){
					player.setJewelryHiddenField2(itype as Jewelry || JewelryLib.NOTHING);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.jewelryId3){
			player.setJewelryHiddenField3((ItemType.lookupItem(saveFile.data.jewelryId3) as Jewelry) || JewelryLib.NOTHING);
		} else {
			player.setJewelry3(JewelryLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Jewelry && (itype as Jewelry).name == saveFile.data.jewelryName3){
					player.setJewelryHiddenField3(itype as Jewelry || JewelryLib.NOTHING);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.jewelryId4){
			player.setJewelryHiddenField4((ItemType.lookupItem(saveFile.data.jewelryId4) as Jewelry) || JewelryLib.NOTHING);
		} else {
			player.setJewelry4(JewelryLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Jewelry && (itype as Jewelry).name == saveFile.data.jewelryName4){
					player.setJewelryHiddenField4(itype as Jewelry || JewelryLib.NOTHING);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.vehiclesId){
			player.setVehicleHiddenField((ItemType.lookupItem(saveFile.data.vehiclesId) as Vehicles) || VehiclesLib.NOTHING);
		} else {
			player.setVehicle(VehiclesLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Vehicles && (itype as Vehicles).name == saveFile.data.vehiclesName){
					player.setVehicleHiddenField(itype as Vehicles || VehiclesLib.NOTHING);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.upperGarmentId){
			player.setUndergarmentHiddenField((ItemType.lookupItem(saveFile.data.upperGarmentId) as Undergarment) || UndergarmentLib.NOTHING, UndergarmentLib.TYPE_UPPERWEAR);
		} else {
			player.setUndergarment(UndergarmentLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Undergarment && (itype as Undergarment).name == saveFile.data.upperGarmentName){
					player.setUndergarmentHiddenField(itype as Undergarment || UndergarmentLib.NOTHING, UndergarmentLib.TYPE_UPPERWEAR);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.lowerGarmentId){
			player.setUndergarmentHiddenField((ItemType.lookupItem(saveFile.data.lowerGarmentId) as Undergarment) || UndergarmentLib.NOTHING, UndergarmentLib.TYPE_LOWERWEAR);
		} else {
			player.setUndergarment(UndergarmentLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Undergarment && (itype as Undergarment).name == saveFile.data.lowerGarmentName){
					player.setUndergarmentHiddenField(itype as Undergarment || UndergarmentLib.NOTHING, UndergarmentLib.TYPE_LOWERWEAR);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.armorId){
			player.setArmorHiddenField((ItemType.lookupItem(saveFile.data.armorId) as Armor) || ArmorLib.COMFORTABLE_UNDERCLOTHES);
			if (player.armor.name != saveFile.data.armorName) player.modArmorName = saveFile.data.armorName;
		} else {
			found = false;
			player.setArmor(ArmorLib.COMFORTABLE_UNDERCLOTHES);
			//player.armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Armor && (itype as Armor).name == saveFile.data.armorName){
					player.setArmorHiddenField(itype as Armor || ArmorLib.COMFORTABLE_UNDERCLOTHES);
					found = true;
					break;
				}
			}
			if (!found){
				for each (itype in ItemType.getItemLibrary()){
					if (itype is Armor){
						var a:Armor = itype as Armor;
						if (a.value == saveFile.data.armorValue &&
								a.def == saveFile.data.armorDef &&
								a.perk == saveFile.data.armorPerk){
							player.setArmor(a);
							//player.armor = a;
							player.modArmorName = saveFile.data.armorName;
							found = true;
							break;
						}
					}
				}
			}
		}

		//Combat STATS
		player.HP = saveFile.data.HP;
		player.lust = saveFile.data.lust;
		if (saveFile.data.teaseXP == undefined)
			player.teaseXP = 0;
		else
			player.teaseXP = saveFile.data.teaseXP;
		if (saveFile.data.teaseLevel == undefined)
			player.teaseLevel = 0;
		else
			player.teaseLevel = saveFile.data.teaseLevel;
		//Mastery
		if (saveFile.data.masteryFeralCombatXP == undefined)
			player.masteryFeralCombatXP = 0;
		else
			player.masteryFeralCombatXP = saveFile.data.masteryFeralCombatXP;
		if (saveFile.data.masteryFeralCombatLevel == undefined)
			player.masteryFeralCombatLevel = 0;
		else
			player.masteryFeralCombatLevel = saveFile.data.masteryFeralCombatLevel;
		if (saveFile.data.masteryGauntletXP == undefined)
			player.masteryGauntletXP = 0;
		else
			player.masteryGauntletXP = saveFile.data.masteryGauntletXP;
		if (saveFile.data.masteryGauntletLevel == undefined)
			player.masteryGauntletLevel = 0;
		else
			player.masteryGauntletLevel = saveFile.data.masteryGauntletLevel;
		if (saveFile.data.masteryDaggerXP == undefined)
			player.masteryDaggerXP = 0;
		else
			player.masteryDaggerXP = saveFile.data.masteryDaggerXP;
		if (saveFile.data.masteryDaggerLevel == undefined)
			player.masteryDaggerLevel = 0;
		else
			player.masteryDaggerLevel = saveFile.data.masteryDaggerLevel;
		if (saveFile.data.masterySwordXP == undefined)
			player.masterySwordXP = 0;
		else
			player.masterySwordXP = saveFile.data.masterySwordXP;
		if (saveFile.data.masterySwordLevel == undefined)
			player.masterySwordLevel = 0;
		else
			player.masterySwordLevel = saveFile.data.masterySwordLevel;
		if (saveFile.data.masteryAxeXP == undefined)
			player.masteryAxeXP = 0;
		else
			player.masteryAxeXP = saveFile.data.masteryAxeXP;
		if (saveFile.data.masteryAxeLevel == undefined)
			player.masteryAxeLevel = 0;
		else
			player.masteryAxeLevel = saveFile.data.masteryAxeLevel;
		if (saveFile.data.masteryMaceHammerXP == undefined)
			player.masteryMaceHammerXP = 0;
		else
			player.masteryMaceHammerXP = saveFile.data.masteryMaceHammerXP;
		if (saveFile.data.masteryMaceHammerLevel == undefined)
			player.masteryMaceHammerLevel = 0;
		else
			player.masteryMaceHammerLevel = saveFile.data.masteryMaceHammerLevel;
		if (saveFile.data.masteryWhipXP == undefined)
			player.masteryWhipXP = 0;
		else
			player.masteryWhipXP = saveFile.data.masteryWhipXP;
		if (saveFile.data.masteryWhipLevel == undefined)
			player.masteryWhipLevel = 0;
		else
			player.masteryWhipLevel = saveFile.data.masteryWhipLevel;
		if (saveFile.data.masteryExoticXP == undefined)
			player.masteryExoticXP = 0;
		else
			player.masteryExoticXP = saveFile.data.masteryExoticXP;
		if (saveFile.data.masteryExoticLevel == undefined)
			player.masteryExoticLevel = 0;
		else
			player.masteryExoticLevel = saveFile.data.masteryExoticLevel;
		if (saveFile.data.masteryArcheryXP == undefined)
			player.masteryArcheryXP = 0;
		else
			player.masteryArcheryXP = saveFile.data.masteryArcheryXP;
		if (saveFile.data.masteryArcheryLevel == undefined)
			player.masteryArcheryLevel = 0;
		else
			player.masteryArcheryLevel = saveFile.data.masteryArcheryLevel;
		if (saveFile.data.masteryThrowingXP == undefined)
			player.masteryThrowingXP = 0;
		else
			player.masteryThrowingXP = saveFile.data.masteryThrowingXP;
		if (saveFile.data.masteryThrowingLevel == undefined)
			player.masteryThrowingLevel = 0;
		else
			player.masteryThrowingLevel = saveFile.data.masteryThrowingLevel;
		if (saveFile.data.masteryFirearmsXP == undefined)
			player.masteryFirearmsXP = 0;
		else
			player.masteryFirearmsXP = saveFile.data.masteryFirearmsXP;
		if (saveFile.data.masteryFirearmsLevel == undefined)
			player.masteryFirearmsLevel = 0;
		else
			player.masteryFirearmsLevel = saveFile.data.masteryFirearmsLevel;
		if (saveFile.data.masteryDuelingSwordXP == undefined)
			player.masteryDuelingSwordXP = 0;
		else
			player.masteryDuelingSwordXP = saveFile.data.masteryDuelingSwordXP;
		if (saveFile.data.masteryDuelingSwordLevel == undefined)
			player.masteryDuelingSwordLevel = 0;
		else
			player.masteryDuelingSwordLevel = saveFile.data.masteryDuelingSwordLevel;
		if (saveFile.data.masteryPolearmXP == undefined)
			player.masteryPolearmXP = 0;
		else
			player.masteryPolearmXP = saveFile.data.masteryPolearmXP;
		if (saveFile.data.masteryPolearmLevel == undefined)
			player.masteryPolearmLevel = 0;
		else
			player.masteryPolearmLevel = saveFile.data.masteryPolearmLevel;
		if (saveFile.data.masterySpearXP == undefined)
			player.masterySpearXP = 0;
		else
			player.masterySpearXP = saveFile.data.masterySpearXP;
		if (saveFile.data.masterySpearLevel == undefined)
			player.masterySpearLevel = 0;
		else
			player.masterySpearLevel = saveFile.data.masterySpearLevel;
		if (saveFile.data.dualWSXP == undefined)
			player.dualWSXP = 0;
		else
			player.dualWSXP = saveFile.data.dualWSXP;
		if (saveFile.data.dualWSLevel == undefined)
			player.dualWSLevel = 0;
		else
			player.dualWSLevel = saveFile.data.dualWSLevel;
		if (saveFile.data.dualWNXP == undefined)
			player.dualWNXP = 0;
		else
			player.dualWNXP = saveFile.data.dualWNXP;
		if (saveFile.data.dualWNLevel == undefined)
			player.dualWNLevel = 0;
		else
			player.dualWNLevel = saveFile.data.dualWNLevel;
		if (saveFile.data.dualWLXP == undefined)
			player.dualWLXP = 0;
		else
			player.dualWLXP = saveFile.data.dualWLXP;
		if (saveFile.data.dualWLLevel == undefined)
			player.dualWLLevel = 0;
		else
			player.dualWLLevel = saveFile.data.dualWLLevel;
		if (saveFile.data.dualWFXP == undefined)
			player.dualWFXP = 0;
		else
			player.dualWFXP = saveFile.data.dualWFXP;
		if (saveFile.data.dualWFLevel == undefined)
			player.dualWFLevel = 0;
		else
			player.dualWFLevel = saveFile.data.dualWFLevel;
		//Mining
		if (saveFile.data.miningXP == undefined)
			player.miningXP = 0;
		else
			player.miningXP = saveFile.data.miningXP;
		if (saveFile.data.miningLevel == undefined)
			player.miningLevel = 0;
		else
			player.miningLevel = saveFile.data.miningLevel;
		//Herbalism
		if (saveFile.data.herbalismXP == undefined)
			player.herbalismXP = 0;
		else
			player.herbalismXP = saveFile.data.herbalismXP;
		if (saveFile.data.herbalismLevel == undefined)
			player.herbalismLevel = 0;
		else
			player.herbalismLevel = saveFile.data.herbalismLevel;
		//Prison STATS
		if (saveFile.data.hunger == undefined)
			player.hunger = 50;
		else
			player.hunger = saveFile.data.hunger;
		if (saveFile.data.esteem == undefined)
			player.esteem = 50;
		else
			player.esteem = saveFile.data.esteem;
		if (saveFile.data.obey == undefined)
			player.obey = 0;
		else
			player.obey = saveFile.data.obey;
		if (saveFile.data.will == undefined)
			player.will = 50;
		else
			player.will = saveFile.data.will;
		if (saveFile.data.obeySoftCap == undefined)
			player.obeySoftCap = true;
		else
			player.obeySoftCap = saveFile.data.obeySoftCap;
		//Prison storage
		//Items
		if (saveFile.data.prisonItems == undefined) {
			trace("Not found");
			player.prisonItemSlots = [];
		}
		else {
			trace("Items FOUND!");
			//for (var k:int = 0; k < 10; i++) {
				player.prisonItemSlots = saveFile.data.prisonItems;
			//}
		}
		//Armour
		/*if (saveFile.data.prisonArmor == undefined) {
			trace("Armour not found");
			prison.prisonItemSlotArmor = null;
		}
		else {
			trace("Armour FOUND!");
			if (saveFile.data.prisonArmor is ItemType) {
				trace("Loading prison armour");
				prison.prisonItemSlotArmor = saveFile.data.prisonArmor;
			}
		}
		//Weapon
		if (saveFile.data.prisonWeapon == undefined) {
			trace("Weapon not found");
			prison.prisonItemSlotWeapon = null;
		}
		else {
			trace("Weapon FOUND!");
			if (saveFile.data.prisonWeapon is ItemType) {
				trace("Loading prison weapon");
				prison.prisonItemSlotWeapon = saveFile.data.prisonWeapon;
			}
		}*/
		//LEVEL STATS
		player.XP = saveFile.data.XP;
		player.gems = saveFile.data.gems || 0;
		if (saveFile.data.perkPoints == undefined)
			player.perkPoints = 0;
		else
			player.perkPoints = saveFile.data.perkPoints;

		if (saveFile.data.superPerkPoints == undefined)
			player.superPerkPoints = 0;
		else
			player.superPerkPoints = saveFile.data.superPerkPoints;

		if (saveFile.data.ascensionPerkPoints == undefined)
			player.ascensionPerkPoints = 0;
		else
			player.ascensionPerkPoints = saveFile.data.ascensionPerkPoints;

		//Appearance
		if (saveFile.data.startingRace != undefined)
			player.startingRace = saveFile.data.startingRace;
		if (saveFile.data.femininity == undefined)
			player.femininity = 50;
		else
			player.femininity = saveFile.data.femininity;
		//EYES
		if (saveFile.data.eyeType == undefined)
			player.eyes.type = Eyes.HUMAN;
		else
			player.eyes.type = saveFile.data.eyeType;
		if (saveFile.data.eyeColor == undefined)
			CoC.instance.transformations.EyesChangeColor(["brown"]).applyEffect(false);
		else
			CoC.instance.transformations.EyesChangeColor([saveFile.data.eyeColor]).applyEffect(false);
		//BEARS
		if (saveFile.data.beardLength == undefined)
			player.beardLength = 0;
		else
			player.beardLength = saveFile.data.beardLength;
		if (saveFile.data.beardStyle == undefined)
			player.beardStyle = 0;
		else
			player.beardStyle = saveFile.data.beardStyle;
		//BODY STYLE
		if (saveFile.data.tone == undefined)
			player.tone = 50;
		else
			player.tone = saveFile.data.tone;
		if (saveFile.data.thickness == undefined)
			player.thickness = 50;
		else
			player.thickness = saveFile.data.thickness;

		player.tallness = saveFile.data.tallness;
		player.hairColor = saveFile.data.hairColor;
		if (saveFile.data.hairType == undefined)
			player.hairType = Hair.NORMAL;
		else
			player.hairType = saveFile.data.hairType;
		if (saveFile.data.hairStyle == undefined)
			player.hairStyle = 0;
		else
			player.hairStyle = saveFile.data.hairStyle;
		if (saveFile.data.gillType != undefined)
			player.gills.type = saveFile.data.gillType;
		else if (saveFile.data.gills == undefined)
			player.gills.type = Gills.NONE;
		else
			player.gills.type = saveFile.data.gills ? Gills.ANEMONE : Gills.NONE;
		player.hairLength = saveFile.data.hairLength;
		player.lowerBodyPart.loadFromSaveData(data);
		player.wings.loadFromSaveData(data);
		player.skin.loadFromSaveData(data);
		player.clawsPart.loadFromSaveData(data);
		player.facePart.loadFromSaveData(data);
		player.tail.loadFromSaveData(data);
		if (saveFile.data.armType == undefined)
			player.arms.type = Arms.HUMAN;
		else
			player.arms.type = saveFile.data.armType;
		if (saveFile.data.tongueType == undefined)
			player.tongue.type = Tongue.HUMAN;
		else
			player.tongue.type = saveFile.data.tongueType;
		if (saveFile.data.earType == undefined)
			player.ears.type = Ears.HUMAN;
		else
			player.ears.type = saveFile.data.earType;
		if (saveFile.data.antennae == undefined)
			player.antennae.type = Antennae.NONE;
		else
			player.antennae.type = saveFile.data.antennae;
		player.horns.count = saveFile.data.horns;
		if (saveFile.data.hornType == undefined)
			player.horns.type = Horns.NONE;
		else
			player.horns.type = saveFile.data.hornType;

		// <mod name="Dragon patch" author="Stadler76">
		if (saveFile.data.rearBodyType != undefined)
			saveFile.data.rearBody = saveFile.data.rearBodyType;
		player.rearBody.type = (saveFile.data.rearBody == undefined) ? RearBody.NONE : saveFile.data.rearBody;

		player.wings.desc = saveFile.data.wingDesc;
		player.wings.type = saveFile.data.wingType;
		player.hips.type = saveFile.data.hipRating;
		player.butt.type = saveFile.data.buttRating;

		//Sexual Stuff
		player.balls = saveFile.data.balls;
		player.cumMultiplier = saveFile.data.cumMultiplier;
		player.ballSize = saveFile.data.ballSize;
		player.hoursSinceCum = saveFile.data.hoursSinceCum;
		player.fertility = saveFile.data.fertility;

		//Preggo stuff
		player.knockUpForce(saveFile.data.pregnancyType, saveFile.data.pregnancyIncubation);
		player.buttKnockUpForce(saveFile.data.buttPregnancyType, saveFile.data.buttPregnancyIncubation);

		var hasViridianCockSock:Boolean = false;

		//ARRAYS HERE!
		//Set Cock array
		for (i = 0; i < saveFile.data.cocks.length; i++)
		{
			player.createCock();
		}
		//Populate Cock Array
		for (i = 0; i < saveFile.data.cocks.length; i++)
		{
			player.cocks[i].cockThickness = saveFile.data.cocks[i].cockThickness;
			player.cocks[i].cockLength = saveFile.data.cocks[i].cockLength;
			player.cocks[i].cockType = CockTypesEnum.ParseConstantByIndex(saveFile.data.cocks[i].cockType);
			player.cocks[i].knotMultiplier = saveFile.data.cocks[i].knotMultiplier;
			if (saveFile.data.cocks[i].sock == undefined)
				player.cocks[i].sock = "";
			else
			{
				player.cocks[i].sock = saveFile.data.cocks[i].sock;
				if (player.cocks[i].sock == "viridian") hasViridianCockSock = true;
			}
			if (saveFile.data.cocks[i].pierced == undefined)
			{
				player.cocks[i].pierced = 0;
				player.cocks[i].pShortDesc = "";
				player.cocks[i].pLongDesc = "";
			}
			else
			{
				player.cocks[i].pierced = saveFile.data.cocks[i].pierced;
				player.cocks[i].pShortDesc = saveFile.data.cocks[i].pShortDesc;
				player.cocks[i].pLongDesc = saveFile.data.cocks[i].pLongDesc;

				if (player.cocks[i].pShortDesc == "null" || player.cocks[i].pLongDesc == "null")
				{
					player.cocks[i].pierced = 0;
					player.cocks[i].pShortDesc = "";
					player.cocks[i].pLongDesc = "";
				}
			}
				//trace("LoadOne Cock i(" + i + ")");
		}
		//Set Vaginal Array
		for (i = 0; i < saveFile.data.vaginas.length; i++)
		{
			player.createVagina();
		}
		//Populate Vaginal Array
		for (i = 0; i < saveFile.data.vaginas.length; i++)
		{
			player.vaginas[i].vaginalWetness = saveFile.data.vaginas[i].vaginalWetness;
			player.vaginas[i].vaginalLooseness = saveFile.data.vaginas[i].vaginalLooseness;
			player.vaginas[i].fullness = saveFile.data.vaginas[i].fullness;
			player.vaginas[i].virgin = saveFile.data.vaginas[i].virgin;
			if (saveFile.data.vaginas[i].type == undefined) player.vaginas[i].type = 0;
			else player.vaginas[i].type = saveFile.data.vaginas[i].type;
			if (saveFile.data.vaginas[i].labiaPierced == undefined) {
				player.vaginas[i].labiaPierced = 0;
				player.vaginas[i].labiaPShort = "";
				player.vaginas[i].labiaPLong = "";
				player.vaginas[i].clitPierced = 0;
				player.vaginas[i].clitPShort = "";
				player.vaginas[i].clitPLong = "";
				player.vaginas[i].clitLength = VaginaClass.DEFAULT_CLIT_LENGTH;
				player.vaginas[i].recoveryProgress = 0;
			}
			else
			{
				player.vaginas[i].labiaPierced = saveFile.data.vaginas[i].labiaPierced;
				player.vaginas[i].labiaPShort = saveFile.data.vaginas[i].labiaPShort;
				player.vaginas[i].labiaPLong = saveFile.data.vaginas[i].labiaPLong;
				player.vaginas[i].clitPierced = saveFile.data.vaginas[i].clitPierced;
				player.vaginas[i].clitPShort = saveFile.data.vaginas[i].clitPShort;
				player.vaginas[i].clitPLong = saveFile.data.vaginas[i].clitPLong;
				player.vaginas[i].clitLength = saveFile.data.vaginas[i].clitLength;
				player.vaginas[i].recoveryProgress = saveFile.data.vaginas[i].recoveryProgress;


				// backwards compatibility
				if(saveFile.data.vaginas[i].clitLength == undefined) {
					player.vaginas[i].clitLength = VaginaClass.DEFAULT_CLIT_LENGTH;
					trace("Clit length was not loaded, setting to default.");
				}

				if(saveFile.data.vaginas[i].recoveryProgress == undefined) {
					player.vaginas[i].recoveryProgress = 0;
					trace("Stretch counter was not loaded, setting to 0.");
				}
			}
				//trace("LoadOne Vagina i(" + i + ")");
		}
		//NIPPLES
		if (saveFile.data.nippleLength == undefined)
			player.nippleLength = .25;
		else
			player.nippleLength = saveFile.data.nippleLength;
		//Set Breast Array
		for (i = 0; i < saveFile.data.breastRows.length; i++)
		{
			player.createBreastRow();
				//trace("LoadOne BreastROw i(" + i + ")");
		}
		//Populate Breast Array
		for (i = 0; i < saveFile.data.breastRows.length; i++)
		{
			player.breastRows[i].breasts = saveFile.data.breastRows[i].breasts;
			player.breastRows[i].nipplesPerBreast = saveFile.data.breastRows[i].nipplesPerBreast;
			//Fix nipplesless breasts bug
			if (player.breastRows[i].nipplesPerBreast == 0)
				player.breastRows[i].nipplesPerBreast = 1;
			player.breastRows[i].breastRating = saveFile.data.breastRows[i].breastRating;
			player.breastRows[i].lactationMultiplier = saveFile.data.breastRows[i].lactationMultiplier;
			if (player.breastRows[i].lactationMultiplier < 0)
				player.breastRows[i].lactationMultiplier = 0;
			player.breastRows[i].milkFullness = saveFile.data.breastRows[i].milkFullness;
			player.breastRows[i].fuckable = saveFile.data.breastRows[i].fuckable;
			player.breastRows[i].fullness = saveFile.data.breastRows[i].fullness;
			if (player.breastRows[i].breastRating < 0)
				player.breastRows[i].breastRating = 0;
		}

		// Force the creation of the default breast row onto the player if it's no longer present
		if (player.breastRows.length == 0) player.createBreastRow();

		var hasHistoryPerk:Boolean = false;
		var hasLustyRegenPerk:Boolean = false;
		var addedSensualLover:Boolean = false;

		//Populate Perk Array
		for (i = 0; i < saveFile.data.perks.length; i++)
		{
			var id:String = saveFile.data.perks[i].id || saveFile.data.perks[i].perkName;
			var value1:Number = saveFile.data.perks[i].value1;
			var value2:Number = saveFile.data.perks[i].value2;
			var value3:Number = saveFile.data.perks[i].value3;
			var value4:Number = saveFile.data.perks[i].value4;

			// Fix saves where the Whore perk might have been malformed.
			if (id == "History: Whote") id = "History: Whore";

			// Fix saves where the Lusty Regeneration perk might have been malformed.
			if (id == "Lusty Regeneration")
			{
				hasLustyRegenPerk = true;
			}
			else if (id == "LustyRegeneration")
			{
				id = "Lusty Regeneration";
				hasLustyRegenPerk = true;
			}

			// Some shit checking to track if the incoming data has an available History perk
			if (id.indexOf("History:") != -1) {
				hasHistoryPerk = true;
			}

			var ptype:PerkType = PerkType.lookupPerk(id);

			//This below is some weird witchcraft.... It doesn't update/swap anything, but somehow this fixes the id mismatch from mutations?
			var mutationsShift:Array = [];
			for each (var pperk1:PerkType in MutationsLib.mutationsArray("",true)){
				mutationsShift.push(pperk1.id);
			}

			if (ptype == null) {
				CoC_Settings.error("Unknown perk id=" + id);
				//(saveFile.data.perks as Array).splice(i,1);
				// NEVER EVER EVER MODIFY DATA IN THE SAVE FILE LIKE THIS. EVER. FOR ANY REASON.
			} else {
				trace("Creating perk : " + ptype);
				var cperk:PerkClass = new PerkClass(ptype, value1, value2, value3, value4);

				if (isNaN(cperk.value1)) {
					if (cperk.perkName == "Wizard's Focus") {
						cperk.value1 = .3;
					} else {
						cperk.value1 = 0;
					}

					trace("NaN byaaaatch: " + cperk.value1);
				}

				if (cperk.perkName == "Wizard's Focus") {
					if (cperk.value1 == 0 || cperk.value1 < 0.1) {
						trace("Wizard's Focus boosted up to par (.5)");
						cperk.value1 = .5;
					}
				}
				player.addPerkInstance(cperk);
			}
		}

		// Fixup missing History: Whore perk IF AND ONLY IF the flag used to track the prior selection of a history perk has been set
		if (!hasHistoryPerk && flags[kFLAGS.HISTORY_PERK_SELECTED] != 1)
		{
			player.createPerk(PerkLib.HistoryWhore, 0, 0, 0, 0);
		}

		// Fixup missing Lusty Regeneration perk, if the player has an equipped viridian cock sock and does NOT have the Lusty Regeneration perk
		if (hasViridianCockSock && !hasLustyRegenPerk)
		{
			player.createPerk(PerkLib.LustyRegeneration, 0, 0, 0, 0);
		}

		if (flags[kFLAGS.TATTOO_SAVEFIX_APPLIED] == 0)
		{
			// Fix some tatto texts that could be broken
			if (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] is String && (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] as String).indexOf("lower back.lower back") != -1)
			{
				flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] as String).split(".")[0] + ".";
			}


			var refunds:int = 0;

			if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK] is String)
			{
				refunds++;
				flags[kFLAGS.JOJO_TATTOO_LOWERBACK] = 0;
			}

			if (flags[kFLAGS.JOJO_TATTOO_BUTT] is String)
			{
				refunds++;
				flags[kFLAGS.JOJO_TATTOO_BUTT] = 0;
			}

			if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE] is String)
			{
				refunds++;
				flags[kFLAGS.JOJO_TATTOO_COLLARBONE] = 0;
			}

			if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS] is String)
			{
				refunds++;
				flags[kFLAGS.JOJO_TATTOO_SHOULDERS] = 0;
			}

			player.gems += 50 * refunds;
			flags[kFLAGS.TATTOO_SAVEFIX_APPLIED] = 1;
		}

		if (flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 1)
		{
			flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] = 0;
			trace("Force-reverting Marble At Farm flag to 0.");
		}

		//Set Status Array
		for (i = 0; i < saveFile.data.statusAffects.length; i++)
		{
			if (saveFile.data.statusAffects[i].statusAffectName == "Lactation EnNumbere") continue; // ugh...
			var stype:StatusEffectType = StatusEffectType.lookupStatusEffect(saveFile.data.statusAffects[i].statusAffectName);
			if (stype == null){
				CoC_Settings.error("Cannot find status effect '"+saveFile.data.statusAffects[i].statusAffectName+"'");
				continue;
			}
			player.createStatusEffect(stype,
					saveFile.data.statusAffects[i].value1,
					saveFile.data.statusAffects[i].value2,
					saveFile.data.statusAffects[i].value3,
					saveFile.data.statusAffects[i].value4);
		}
		//Make sure keyitems exist!
		if (saveFile.data.keyItems != undefined)
		{
			//Set keyItems Array
			for (i = 0; i < saveFile.data.keyItems.length; i++)
			{
				player.createKeyItem("TEMP", 0, 0, 0, 0);
			}
			//Populate keyItems Array
			for (i = 0; i < saveFile.data.keyItems.length; i++)
			{
				player.keyItems[i].keyName = saveFile.data.keyItems[i].keyName;
				player.keyItems[i].value1 = saveFile.data.keyItems[i].value1;
				player.keyItems[i].value2 = saveFile.data.keyItems[i].value2;
				player.keyItems[i].value3 = saveFile.data.keyItems[i].value3;
				player.keyItems[i].value4 = saveFile.data.keyItems[i].value4;
					//trace("KeyItem " + player.keyItems[i].keyName + " loaded.");
			}
		}
		//Set storage slot array
		if (saveFile.data.itemStorage == undefined)
		{
			//trace("OLD SAVES DO NOT CONTAIN ITEM STORAGE ARRAY");
		}
		else
		{
			//Populate storage slot array
			for (i = 0; i < saveFile.data.itemStorage.length; i++)
			{
				//trace("Populating a storage slot save with data");
				inventory.createStorage();
				var storage:ItemSlotClass = itemStorageGet()[i];
				var savedIS:* = saveFile.data.itemStorage[i];
				if (savedIS.shortName)
				{
					if (savedIS.shortName.indexOf("Gro+") != -1)
						savedIS.id = "GroPlus";
					else if (savedIS.shortName.indexOf("Sp Honey") != -1)
						savedIS.id = "SpHoney";
				}
				if (savedIS.quantity>0)
					storage.setItemAndQty(ItemType.lookupItem(savedIS.id || savedIS.shortName), savedIS.quantity);
				else
					storage.emptySlot();
				storage.unlocked = savedIS.unlocked;
			}
		}

		//Set pearl slot array
		if (saveFile.data.pearlStorage == undefined)
		{
			//trace("OLD SAVES DO NOT CONTAIN ITEM STORAGE ARRAY - Creating new!");
			inventory.initializePearlStorage();
		}
		else
		{
			for (i = 0; i < saveFile.data.pearlStorage.length && pearlStorageGet().length < 98; i++)
			{
				pearlStorageGet().push(new ItemSlotClass());
					//trace("Initialize a slot for one of the item storage locations to load.");
			}
			//Populate storage slot array
			for (i = 0; i < saveFile.data.pearlStorage.length && i < pearlStorageGet().length; i++)
			{
				//trace("Populating a storage slot save with data");
				storage = pearlStorageGet()[i];
				if ((saveFile.data.pearlStorage[i].shortName == undefined && saveFile.data.pearlStorage[i].id == undefined)
                        || saveFile.data.pearlStorage[i].quantity == undefined
						|| saveFile.data.pearlStorage[i].quantity == 0)
					storage.emptySlot();
				else
					storage.setItemAndQty(ItemType.lookupItem(saveFile.data.pearlStorage[i].id || saveFile.data.pearlStorage[i].shortName),saveFile.data.pearlStorage[i].quantity);
				storage.unlocked = saveFile.data.pearlStorage[i].unlocked;
			}
		}

		//Set gear slot array
		if (saveFile.data.gearStorage == undefined)
		{
			//trace("OLD SAVES DO NOT CONTAIN ITEM STORAGE ARRAY - Creating new!");
			inventory.initializeGearStorage();
		}
		else
		{
			for (i = 0; i < saveFile.data.gearStorage.length && gearStorageGet().length < 90; i++)
			{
				gearStorageGet().push(new ItemSlotClass());
					//trace("Initialize a slot for one of the item storage locations to load.");
			}
			//Populate storage slot array
			for (i = 0; i < saveFile.data.gearStorage.length && i < gearStorageGet().length; i++)
			{
				//trace("Populating a storage slot save with data");
				storage = gearStorageGet()[i];
				if ((saveFile.data.gearStorage[i].shortName == undefined && saveFile.data.gearStorage[i].id == undefined)
                        || saveFile.data.gearStorage[i].quantity == undefined
						|| saveFile.data.gearStorage[i].quantity == 0)
					storage.emptySlot();
				else
					storage.setItemAndQty(ItemType.lookupItem(saveFile.data.gearStorage[i].id || saveFile.data.gearStorage[i].shortName),saveFile.data.gearStorage[i].quantity);
				storage.unlocked = saveFile.data.gearStorage[i].unlocked;
			}
		}

		//Set soulforce
		if (saveFile.data.soulforce == undefined) player.soulforce = 25;
		//Set wisdom
		if (saveFile.data.wis == undefined) player.wisStat.core.value = 15;
		//Set wrath
		if (saveFile.data.wrath == undefined) player.wrath = 0;
		//Set mana
		if (saveFile.data.mana == undefined) player.mana = 50;

		//player.cocks = saveFile.data.cocks;
		player.ass.analLooseness = saveFile.data.ass.analLooseness;
		player.ass.analWetness = saveFile.data.ass.analWetness;
		player.ass.fullness = saveFile.data.ass.fullness;

		//Shit
		gameStateSet(saveFile.data.gameState);
		player.exploredLake = saveFile.data.exploredLake;
		player.exploredMountain = saveFile.data.exploredMountain;
		player.exploredForest = saveFile.data.exploredForest;
		player.exploredDesert = saveFile.data.exploredDesert;
		player.explored = saveFile.data.explored;

		//Days
		//Time and Items
		model.time.minutes = saveFile.data.minutes;
		model.time.hours = saveFile.data.hours;
		model.time.days = saveFile.data.days;
		if (saveFile.data.autoSave == undefined)
			player.autoSave = false;
		else
			player.autoSave = saveFile.data.autoSave;

		//PLOTZ
		JojoScene.monk = saveFile.data.monk;
		SandWitchScene.rapedBefore      = saveFile.data.sand;

		if (saveFile.data.beeProgress != undefined && saveFile.data.beeProgress == 1) SceneLib.forest.beeGirlScene.setTalked(); //Bee Progress update is now in a flag
			//The flag will be zero for any older save that still uses beeProgress and newer saves always store a zero in beeProgress, so we only need to update the flag on a value of one.

		SceneLib.isabellaScene.isabellaOffspringData = [];
		if (saveFile.data.isabellaOffspringData == undefined) {
			//NOPE
		}
		else {
			for (i = 0; i < saveFile.data.isabellaOffspringData.length; i += 2) {
				SceneLib.isabellaScene.isabellaOffspringData.push(saveFile.data.isabellaOffspringData[i], saveFile.data.isabellaOffspringData[i+1])
			}
		}

		// Potions
		if (saveFile.data.potions) {
			for (i = 0; i< saveFile.data.potions.length; i++) {
				var potionId:String = saveFile.data.potions[i].id;
				var potionCount:Number = saveFile.data.potions[i].count;
				var potionType:PotionType = PotionType.ALL_POTIONS[potionId];
				if (potionType) {
					player.potions.push( { type: potionType, count: potionCount});
				} else {
					trace("/!\\ Unknown potion ID "+ potionId);
				}
			}
		}

		//ITEMZ. Item1
		if (saveFile.data.itemSlot1.shortName)
		{
			if (saveFile.data.itemSlot1.shortName.indexOf("Gro+") != -1)
				saveFile.data.itemSlot1.id = "GroPlus";
			else if (saveFile.data.itemSlot1.shortName.indexOf("Sp Honey") != -1)
				saveFile.data.itemSlot1.id = "SpHoney";
		}
		if (saveFile.data.itemSlot2.shortName)
		{
			if (saveFile.data.itemSlot2.shortName.indexOf("Gro+") != -1)
				saveFile.data.itemSlot2.id = "GroPlus";
			else if (saveFile.data.itemSlot2.shortName.indexOf("Sp Honey") != -1)
				saveFile.data.itemSlot2.id = "SpHoney";
		}
		if (saveFile.data.itemSlot3.shortName)
		{
			if (saveFile.data.itemSlot3.shortName.indexOf("Gro+") != -1)
				saveFile.data.itemSlot3.id = "GroPlus";
			else if (saveFile.data.itemSlot3.shortName.indexOf("Sp Honey") != -1)
				saveFile.data.itemSlot3.id = "SpHoney";
		}
		if (saveFile.data.itemSlot4.shortName)
		{
			if (saveFile.data.itemSlot4.shortName.indexOf("Gro+") != -1)
				saveFile.data.itemSlot4.id = "GroPlus";
			else if (saveFile.data.itemSlot4.shortName.indexOf("Sp Honey") != -1)
				saveFile.data.itemSlot4.id = "SpHoney";
		}
		if (saveFile.data.itemSlot5.shortName)
		{
			if (saveFile.data.itemSlot5.shortName.indexOf("Gro+") != -1)
				saveFile.data.itemSlot5.id = "GroPlus";
			else if (saveFile.data.itemSlot5.shortName.indexOf("Sp Honey") != -1)
				saveFile.data.itemSlot5.id = "SpHoney";
		}

		player.itemSlot1.unlocked = true;
		player.itemSlot1.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot1.id || saveFile.data.itemSlot1.shortName),
				saveFile.data.itemSlot1.quantity);
		player.itemSlot2.unlocked = true;
		player.itemSlot2.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot2.id || saveFile.data.itemSlot2.shortName),
				saveFile.data.itemSlot2.quantity);
		player.itemSlot3.unlocked = true;
		player.itemSlot3.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot3.id || saveFile.data.itemSlot3.shortName),
				saveFile.data.itemSlot3.quantity);
		player.itemSlot4.unlocked = true;
		player.itemSlot4.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot4.id || saveFile.data.itemSlot4.shortName),
				saveFile.data.itemSlot4.quantity);
		player.itemSlot5.unlocked = true;
		player.itemSlot5.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot5.id || saveFile.data.itemSlot5.shortName),
				saveFile.data.itemSlot5.quantity);
		//Extra slots from the mod.
		if (saveFile.data.itemSlot6 != undefined && saveFile.data.itemSlot7 != undefined && saveFile.data.itemSlot8 != undefined && saveFile.data.itemSlot9 != undefined && saveFile.data.itemSlot10 != undefined && saveFile.data.itemSlot11 != undefined && saveFile.data.itemSlot12 != undefined
			 && saveFile.data.itemSlot13 != undefined && saveFile.data.itemSlot14 != undefined && saveFile.data.itemSlot15 != undefined && saveFile.data.itemSlot16 != undefined && saveFile.data.itemSlot17 != undefined && saveFile.data.itemSlot18 != undefined && saveFile.data.itemSlot19 != undefined && saveFile.data.itemSlot20 != undefined) {
		player.itemSlot6.unlocked = saveFile.data.itemSlot6.unlocked;
		player.itemSlot6.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot6.id || saveFile.data.itemSlot6.shortName),
				saveFile.data.itemSlot6.quantity);
		player.itemSlot7.unlocked = saveFile.data.itemSlot7.unlocked;
		player.itemSlot7.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot7.id || saveFile.data.itemSlot7.shortName),
				saveFile.data.itemSlot7.quantity);
		player.itemSlot8.unlocked = saveFile.data.itemSlot8.unlocked;
		player.itemSlot8.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot8.id || saveFile.data.itemSlot8.shortName),
				saveFile.data.itemSlot8.quantity);
		player.itemSlot9.unlocked = saveFile.data.itemSlot9.unlocked;
		player.itemSlot9.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot9.id || saveFile.data.itemSlot9.shortName),
				saveFile.data.itemSlot9.quantity);
		player.itemSlot10.unlocked = saveFile.data.itemSlot10.unlocked;
		player.itemSlot10.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot10.id || saveFile.data.itemSlot10.shortName),
				saveFile.data.itemSlot10.quantity);
		player.itemSlot11.unlocked = saveFile.data.itemSlot11.unlocked;
		player.itemSlot11.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot11.id || saveFile.data.itemSlot11.shortName),
				saveFile.data.itemSlot11.quantity);
		player.itemSlot12.unlocked = saveFile.data.itemSlot12.unlocked;
		player.itemSlot12.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot12.id || saveFile.data.itemSlot12.shortName),
				saveFile.data.itemSlot12.quantity);
		player.itemSlot13.unlocked = saveFile.data.itemSlot13.unlocked;
		player.itemSlot13.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot13.id || saveFile.data.itemSlot13.shortName),
				saveFile.data.itemSlot13.quantity);
		player.itemSlot14.unlocked = saveFile.data.itemSlot14.unlocked;
		player.itemSlot14.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot14.id || saveFile.data.itemSlot14.shortName),
				saveFile.data.itemSlot14.quantity);
		player.itemSlot15.unlocked = saveFile.data.itemSlot15.unlocked;
		player.itemSlot15.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot15.id || saveFile.data.itemSlot15.shortName),
				saveFile.data.itemSlot15.quantity);
		player.itemSlot16.unlocked = saveFile.data.itemSlot16.unlocked;
		player.itemSlot16.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot16.id || saveFile.data.itemSlot16.shortName),
				saveFile.data.itemSlot16.quantity);
		player.itemSlot17.unlocked = saveFile.data.itemSlot17.unlocked;
		player.itemSlot17.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot17.id || saveFile.data.itemSlot17.shortName),
				saveFile.data.itemSlot17.quantity);
		player.itemSlot18.unlocked = saveFile.data.itemSlot18.unlocked;
		player.itemSlot18.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot18.id || saveFile.data.itemSlot18.shortName),
				saveFile.data.itemSlot18.quantity);
		player.itemSlot19.unlocked = saveFile.data.itemSlot19.unlocked;
		player.itemSlot19.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot19.id || saveFile.data.itemSlot19.shortName),
				saveFile.data.itemSlot19.quantity);
		player.itemSlot20.unlocked = saveFile.data.itemSlot20.unlocked;
		player.itemSlot20.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot20.id || saveFile.data.itemSlot20.shortName),
				saveFile.data.itemSlot20.quantity);
		}
		for (var key:String in _saveableStates) {
			var ss:SaveableState = _saveableStates[key];
			if (saveFile.data.ss && key in saveFile.data.ss) {
				ss.loadFromObject(saveFile.data.ss[key], true);
			} else {
				ss.loadFromObject(null, true);
			}
		}
		loadAllAwareClasses(CoC.instance); //Informs each saveAwareClass that it must load its values from the flags array
        unFuckSave();

		// Control Bindings
		if (saveFile.data.controls != undefined)
		{
			game.inputManager.LoadBindsFromObj(saveFile.data.controls);
		}

		XXCNPC.unloadSavedNPCs();
		if(saveFile.data.world == undefined){saveFile.data.world = [];}
		if(saveFile.data.world.x == undefined){saveFile.data.world.x = [];}
		for each(var savedNPC:* in saveFile.data.world.x){
			if(savedNPC.myClass != undefined){
                var ref:Class = getDefinitionByName(savedNPC.myClass) as Class;
                ref["instance"].load(saveFile.data.world.x);
			}
		}

		doNext(playerMenu);
	}
}

public function unFuckSave():void
{
	//Fixing shit!

	// Fix duplicate elven bounty perks
	if (player.hasPerk(PerkLib.ElvenBounty)) {
		//CLear duplicates
		while(player.perkDuplicated(PerkLib.ElvenBounty)) player.removePerk(PerkLib.ElvenBounty);
		//Fix fudged preggers value
		if (player.perkv1(PerkLib.ElvenBounty) == 15) {
			player.setPerkValue(PerkLib.ElvenBounty,1,0);
			player.addPerkValue(PerkLib.ElvenBounty,2,15);
		}
	}
	while (player.perkDuplicated(PerkLib.NinetailsKitsuneOfBalance)) player.removePerk(PerkLib.NinetailsKitsuneOfBalance);
	while (player.perkDuplicated(MutationsLib.KitsuneThyroidGland)) player.removePerk(MutationsLib.KitsuneThyroidGland);

	if (player.hasStatusEffect(StatusEffects.KnockedBack))
	{
		player.removeStatusEffect(StatusEffects.KnockedBack);
	}

	if (player.hasStatusEffect(StatusEffects.Tentagrappled))
	{
		player.removeStatusEffect(StatusEffects.Tentagrappled);
	}

	if (isNaN(model.time.minutes)) model.time.minutes = 0;
	if (isNaN(model.time.hours)) model.time.hours = 0;
	if (isNaN(model.time.days)) model.time.days = 0;

	if (player.hasStatusEffect(StatusEffects.SlimeCraving) && player.statusEffectv4(StatusEffects.SlimeCraving) == 1) {
		player.changeStatusValue(StatusEffects.SlimeCraving, 3, player.statusEffectv2(StatusEffects.SlimeCraving)); //Duplicate old combined strength/speed value
		player.changeStatusValue(StatusEffects.SlimeCraving, 4, 1); //Value four indicates this tracks strength and speed separately
	}

	// Fix issues with corrupt cockTypes caused by a error in the serialization code.

	//trace("CockInfo = ", flags[kFLAGS.RUBI_COCK_TYPE]);
	//trace("getQualifiedClassName = ", getQualifiedClassName(flags[kFLAGS.RUBI_COCK_TYPE]));
	//trace("typeof = ", typeof(flags[kFLAGS.RUBI_COCK_TYPE]));
	//trace("is CockTypesEnum = ", flags[kFLAGS.RUBI_COCK_TYPE] is CockTypesEnum);
	//trace("instanceof CockTypesEnum = ", flags[kFLAGS.RUBI_COCK_TYPE] instanceof CockTypesEnum);


	if (!(flags[kFLAGS.RUBI_COCK_TYPE] is CockTypesEnum || flags[kFLAGS.RUBI_COCK_TYPE] is Number)) { // Valid contents of flags[kFLAGS.RUBI_COCK_TYPE] are either a CockTypesEnum or a number

		trace("Fixing save (goo girl)");
		outputText("\n<b>Rubi's cockType is invalid. Defaulting him to human.</b>\n");
		flags[kFLAGS.RUBI_COCK_TYPE] = 0;
	}


	if (!(flags[kFLAGS.GOO_DICK_TYPE] is CockTypesEnum || flags[kFLAGS.GOO_DICK_TYPE] is Number)) { // Valid contents of flags[kFLAGS.GOO_DICK_TYPE] are either a CockTypesEnum or a number

		trace("Fixing save (goo girl)");
		outputText("\n<b>Latex Goo-Girls's cockType is invalid. Defaulting him to human.</b>\n");
		flags[kFLAGS.GOO_DICK_TYPE] = 0;
	}

	var flagData:Array = String(flags[kFLAGS.KATHERINE_BREAST_SIZE]).split("^");
	if (flagData.length < 7 && flags[kFLAGS.KATHERINE_BREAST_SIZE] > 0) { //Older format only stored breast size or zero if not yet initialized
		SceneLib.telAdre.katherine.breasts.cupSize = flags[kFLAGS.KATHERINE_BREAST_SIZE];
        SceneLib.telAdre.katherine.breasts.lactationLevel = BreastStore.LACTATION_DISABLED;
    }

	if (flags[kFLAGS.SAVE_FILE_INTEGER_FORMAT_VERSION] < 816) {
		//Older saves don't have pregnancy types for all impregnable NPCs. Have to correct this.
		//If anything is detected that proves this is a new format save then we can return immediately as all further checks are redundant.
		if (flags[kFLAGS.AMILY_INCUBATION] > 0) {
			if (flags[kFLAGS.AMILY_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.AMILY_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}
		if (flags[kFLAGS.AMILY_OVIPOSITED_COUNTDOWN] > 0) {
			if (flags[kFLAGS.AMILY_BUTT_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			if (player.hasPerk(PerkLib.SpiderOvipositor))
				flags[kFLAGS.AMILY_BUTT_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_DRIDER_EGGS;
			else
				flags[kFLAGS.AMILY_BUTT_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_BEE_EGGS;
		}

		if (flags[kFLAGS.COTTON_PREGNANCY_INCUBATION] > 0) {
			if (flags[kFLAGS.COTTON_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.COTTON_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}

		if (flags[kFLAGS.EMBER_INCUBATION] > 0) {
			if (flags[kFLAGS.EMBER_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.EMBER_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}

		if (flags[kFLAGS.FEMALE_SPIDERMORPH_PREGNANCY_INCUBATION] > 0) {
			if (flags[kFLAGS.FEMALE_SPIDERMORPH_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.FEMALE_SPIDERMORPH_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}

		if (flags[kFLAGS.HELSPAWN_AGE] > 0) {
			SceneLib.helScene.pregnancy.knockUpForce(); //Clear Pregnancy, also removed any old value from HEL_PREGNANCY_NOTICES
		}
		else if (flags[kFLAGS.HEL_PREGNANCY_INCUBATION] > 0) {
			if (flags[kFLAGS.HELIA_PREGNANCY_TYPE] > 3) return; //Must be a new format save
			//HELIA_PREGNANCY_TYPE was previously HEL_PREGNANCY_NOTICES, which ran from 0 to 3. Converted to the new format by multiplying by 65536
			//Since HelSpawn's father is already tracked separately we might as well just use PREGNANCY_PLAYER for all possible pregnancies
			flags[kFLAGS.HELIA_PREGNANCY_TYPE] = (65536 * flags[kFLAGS.HELIA_PREGNANCY_TYPE]) + PregnancyStore.PREGNANCY_PLAYER;
		}

		if (flags[kFLAGS.KELLY_INCUBATION] > 0) {
			if (flags[kFLAGS.KELLY_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.KELLY_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}

		if (flags[kFLAGS.MARBLE_PREGNANCY_TYPE] == PregnancyStore.PREGNANCY_PLAYER) return; //Must be a new format save
		if (flags[kFLAGS.MARBLE_PREGNANCY_TYPE] == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) return; //Must be a new format save
		if (flags[kFLAGS.MARBLE_PREGNANCY_TYPE] == 1) flags[kFLAGS.MARBLE_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		if (flags[kFLAGS.MARBLE_PREGNANCY_TYPE] == 2) flags[kFLAGS.MARBLE_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_OVIELIXIR_EGGS;

		if (flags[kFLAGS.PHYLLA_DRIDER_INCUBATION] > 0) {
			if (flags[kFLAGS.PHYLLA_VAGINAL_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.PHYLLA_VAGINAL_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_DRIDER_EGGS;
			flags[kFLAGS.PHYLLA_DRIDER_INCUBATION] *= 24; //Convert pregnancy to days
		}

		if (flags[kFLAGS.SHEILA_PREGNANCY_INCUBATION] > 0) {
			if (flags[kFLAGS.SHEILA_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.SHEILA_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
			if (flags[kFLAGS.SHEILA_PREGNANCY_INCUBATION] >= 4)
				flags[kFLAGS.SHEILA_PREGNANCY_INCUBATION] = 0; //Was ready to be born
			else
				flags[kFLAGS.SHEILA_PREGNANCY_INCUBATION] = 24 * (4 - flags[kFLAGS.SHEILA_PREGNANCY_INCUBATION]); //Convert to hours and count down rather than up
		}

		if (flags[kFLAGS.SOPHIE_PREGNANCY_TYPE] != 0 && flags[kFLAGS.SOPHIE_INCUBATION] != 0) return; //Must be a new format save
		if (flags[kFLAGS.SOPHIE_PREGNANCY_TYPE] > 0 && flags[kFLAGS.SOPHIE_INCUBATION] == 0) { //She's in the wild and pregnant with an egg
			flags[kFLAGS.SOPHIE_INCUBATION] = flags[kFLAGS.SOPHIE_PREGNANCY_TYPE]; //SOPHIE_PREGNANCY_TYPE was previously SOPHIE_WILD_EGG_COUNTDOWN_TIMER
			flags[kFLAGS.SOPHIE_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}
		else if (flags[kFLAGS.SOPHIE_PREGNANCY_TYPE] == 0 && flags[kFLAGS.SOPHIE_INCUBATION] > 0) {
			flags[kFLAGS.SOPHIE_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}

		if (flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_TYPE] != 0) return; //Must be a new format save
		if (flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] > 0) {
			flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_TYPE]   = PregnancyStore.PREGNANCY_PLAYER;
			flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] *= 24; //Convert pregnancy to days
			flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_COUNT]  = player.statusEffectv3(StatusEffects.Tamani);
		}

		if (flags[kFLAGS.TAMANI_PREGNANCY_TYPE] != 0) return; //Must be a new format save
		if (player.hasStatusEffect(StatusEffects.TamaniFemaleEncounter)) player.removeStatusEffect(StatusEffects.TamaniFemaleEncounter); //Wasn't used in previous code
		if (player.hasStatusEffect(StatusEffects.Tamani)) {
			if (player.statusEffectv1(StatusEffects.Tamani) == -500) { //This used to indicate that a player had met Tamani as a male
				flags[kFLAGS.TAMANI_PREGNANCY_INCUBATION] = 0;
				flags[kFLAGS.TAMANI_MET]                  = 1; //This now indicates the same thing
			}
			else flags[kFLAGS.TAMANI_PREGNANCY_INCUBATION] = player.statusEffectv1(StatusEffects.Tamani) * 24; //Convert pregnancy to days
			flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] = player.statusEffectv2(StatusEffects.Tamani);
			flags[kFLAGS.TAMANI_PREGNANCY_COUNT]     = player.statusEffectv3(StatusEffects.Tamani);
			flags[kFLAGS.TAMANI_TIMES_IMPREGNATED]   = player.statusEffectv4(StatusEffects.Tamani);
			if (flags[kFLAGS.TAMANI_PREGNANCY_INCUBATION] > 0) flags[kFLAGS.TAMANI_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
			player.removeStatusEffect(StatusEffects.Tamani);
		}

		if (flags[kFLAGS.EGG_WITCH_TYPE] == PregnancyStore.PREGNANCY_BEE_EGGS || flags[kFLAGS.EGG_WITCH_TYPE] == PregnancyStore.PREGNANCY_DRIDER_EGGS) return; //Must be a new format save
		if (flags[kFLAGS.EGG_WITCH_TYPE] > 0) {
			if (flags[kFLAGS.EGG_WITCH_TYPE] == 1)
				flags[kFLAGS.EGG_WITCH_TYPE] = PregnancyStore.PREGNANCY_BEE_EGGS;
			else
				flags[kFLAGS.EGG_WITCH_TYPE] = PregnancyStore.PREGNANCY_DRIDER_EGGS;
			flags[kFLAGS.EGG_WITCH_COUNTER] = 24 * (8 - flags[kFLAGS.EGG_WITCH_COUNTER]); //Reverse the count and change to hours rather than days
		}

		if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BEE_EGGS) return; //Must be a new format save
		if (player.buttPregnancyType == PregnancyStore.PREGNANCY_DRIDER_EGGS) return; //Must be a new format save
		if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SANDTRAP_FERTILE) return; //Must be a new format save
		if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SANDTRAP) return; //Must be a new format save
		if (player.buttPregnancyType == 2) player.buttKnockUpForce(PregnancyStore.PREGNANCY_BEE_EGGS, player.buttPregnancyIncubation);
		if (player.buttPregnancyType == 3) player.buttKnockUpForce(PregnancyStore.PREGNANCY_DRIDER_EGGS, player.buttPregnancyIncubation);
		if (player.buttPregnancyType == 4) player.buttKnockUpForce(PregnancyStore.PREGNANCY_SANDTRAP_FERTILE, player.buttPregnancyIncubation);
		if (player.buttPregnancyType == 5) player.buttKnockUpForce(PregnancyStore.PREGNANCY_SANDTRAP, player.buttPregnancyIncubation);

		//If dick length zero then player has never met Kath, no need to set flags. If her breast size is zero then set values for flags introduced with the employment expansion
		if (flags[kFLAGS.KATHERINE_BREAST_SIZE] != 0) return; //Must be a new format save
		if (flags[kFLAGS.KATHERINE_DICK_LENGTH] != 0) {
			flags[kFLAGS.KATHERINE_BREAST_SIZE] = BreastCup.B;
			flags[kFLAGS.KATHERINE_BALL_SIZE] = 1;
			flags[kFLAGS.KATHERINE_HAIR_COLOR] = "neon pink";
			flags[kFLAGS.KATHERINE_HOURS_SINCE_CUM] = 200; //Give her maxed out cum for that first time
		}

		if (flags[kFLAGS.URTA_PREGNANCY_TYPE] == PregnancyStore.PREGNANCY_BEE_EGGS) return; //Must be a new format save
		if (flags[kFLAGS.URTA_PREGNANCY_TYPE] == PregnancyStore.PREGNANCY_DRIDER_EGGS) return; //Must be a new format save
		if (flags[kFLAGS.URTA_PREGNANCY_TYPE] == PregnancyStore.PREGNANCY_PLAYER) return; //Must be a new format save
		if (flags[kFLAGS.URTA_PREGNANCY_TYPE] > 0) { //URTA_PREGNANCY_TYPE was previously URTA_EGG_INCUBATION, assume this was an egg pregnancy
			flags[kFLAGS.URTA_INCUBATION] = flags[kFLAGS.URTA_PREGNANCY_TYPE];
			if (player.hasPerk(PerkLib.SpiderOvipositor))
				flags[kFLAGS.URTA_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_DRIDER_EGGS;
			else
				flags[kFLAGS.URTA_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_BEE_EGGS;
		}
		else if (flags[kFLAGS.URTA_INCUBATION] > 0) { //Assume Urta was pregnant with the player's baby
			flags[kFLAGS.URTA_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
			flags[kFLAGS.URTA_INCUBATION] = 384 - flags[kFLAGS.URTA_INCUBATION]; //Reverse the pregnancy counter since it now counts down rather than up
		}

		if (flags[kFLAGS.EDRYN_PREGNANCY_TYPE] > 0 && flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] == 0) {
			//EDRYN_PREGNANCY_TYPE was previously EDRYN_BIRF_COUNTDOWN - used when Edryn was pregnant with Taoth
			if (flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] > 0)
				flags[kFLAGS.URTA_FERTILE] = PregnancyStore.PREGNANCY_PLAYER;          //These two variables are used to store information on the pregnancy Taoth
			flags[kFLAGS.URTA_PREG_EVERYBODY] = flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION]; //is overriding (if any), so they can later be restored.
			flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] = flags[kFLAGS.EDRYN_PREGNANCY_TYPE];
			flags[kFLAGS.EDRYN_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_TAOTH;
		}
		else if (flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] > 0 && flags[kFLAGS.EDRYN_PREGNANCY_TYPE] == 0) flags[kFLAGS.EDRYN_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
	}
	if (flags[kFLAGS.BEHEMOTH_CHILDREN] > 0) {
		if (flags[kFLAGS.BEHEMOTH_CHILDREN] >= 1 && flags[kFLAGS.BEHEMOTH_CHILD_1_BIRTH_DAY] <= 0) flags[kFLAGS.BEHEMOTH_CHILD_1_BIRTH_DAY] = model.time.days;
		if (flags[kFLAGS.BEHEMOTH_CHILDREN] >= 2 && flags[kFLAGS.BEHEMOTH_CHILD_2_BIRTH_DAY] <= 0) flags[kFLAGS.BEHEMOTH_CHILD_2_BIRTH_DAY] = model.time.days;
		if (flags[kFLAGS.BEHEMOTH_CHILDREN] >= 3 && flags[kFLAGS.BEHEMOTH_CHILD_3_BIRTH_DAY] <= 0) flags[kFLAGS.BEHEMOTH_CHILD_3_BIRTH_DAY] = model.time.days;
	}
	if ((flags[kFLAGS.D3_GARDENER_DEFEATED] > 0 && flags[kFLAGS.D3_CENTAUR_DEFEATED] > 0 && flags[kFLAGS.D3_STATUE_DEFEATED] > 0) && flags[kFLAGS.D3_JEAN_CLAUDE_DEFEATED] == 0) flags[kFLAGS.D3_JEAN_CLAUDE_DEFEATED] = 1;
	if (pearlStorageGet().length < 98) {
		while (pearlStorageGet().length < 98) {
			pearlStorageGet().push(new ItemSlotClass());
		}
	}
	if (gearStorageGet().length < 90) {
		while (gearStorageGet().length < 90) {
			gearStorageGet().push(new ItemSlotClass());
		}
	}
	if (player.hasKeyItem("Laybans") >= 0) {
		flags[kFLAGS.D3_MIRRORS_SHATTERED] = 1;
	}
	flags[kFLAGS.SHIFT_KEY_DOWN] = 0;
}

    private function saveAllAwareClasses(game:CoC):void {
        for (var sac:int = 0; sac < _saveAwareClassList.length; sac++) _saveAwareClassList[sac].updateBeforeSave(game);
    }

    private function loadAllAwareClasses(game:CoC):void {
        for (var sac:int = 0; sac < _saveAwareClassList.length; sac++) _saveAwareClassList[sac].updateAfterLoad(game);
    }

    public static function saveAwareClassAdd(newEntry:SaveAwareInterface):void {
        _saveAwareClassList.push(newEntry);
    }

	public static function registerSaveableState(ss:SaveableState):void {
		var name:String = ss.stateObjectName();
		if (name in _saveableStates && _saveableStates[name] != ss) throw new Error("Duplicate saveable state named "+name);
		_saveableStates[name] = ss;
	}
	public function resetSaveableStates():void {
		for (var key:String in _saveableStates) {
			var ss:SaveableState = _saveableStates[key];
			ss.resetState();
		}
	}

}
}