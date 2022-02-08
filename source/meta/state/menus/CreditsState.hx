package meta.state.menus;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.ColorTween;
import flixel.util.FlxColor;
import lime.utils.Assets;
import gameObjects.userInterface.CreditIcon;
import meta.MusicBeat.MusicBeatState;
import meta.data.*;
import meta.data.dependency.Discord;
import meta.data.font.Alphabet;
import openfl.media.Sound;
import sys.FileSystem;
//import sys.thread.Thread;

using StringTools;

class CreditsState extends MusicBeatState
{
	//
	var devs:Array<Dynamic> = [
	["SAKK","sakk","Spriter and Charter"],
	["Nimbus","nimbus","Composer"],
	["BernardO","bernard","Coder"],
	["InfiniteSpirit","infinite","Playtester"],
	["JustJerome","jerome","Playtester"],
	["SpiderBoi","spider","Preview Artist"]

	];

	var selector:FlxText;
	var curSelected:Int = 0;

	private var grpDevs:FlxTypedGroup<Alphabet>;
	private var grpDesc:FlxTypedGroup<Alphabet>;

	private var iconArray:Array<CreditIcon> = [];

	private var mainColor = FlxColor.WHITE;
	private var bg:FlxSprite;

	override function create()
	{
		super.create();

		#if !html5
		Discord.changePresence('CREDITS MENU', 'Main Menu');
		#end

		// LOAD CHARACTERS

		bg = new FlxSprite().loadGraphic(Paths.image('menus/base/menuDesat'));
		add(bg);

		grpDevs = new FlxTypedGroup<Alphabet>();
		add(grpDevs);
		grpDesc = new FlxTypedGroup<Alphabet>();
		add(grpDesc);

		for (i in 0...devs.length)
		{
			var devText:Alphabet = new Alphabet(10, (80 * i) + 30, devs[i][0], true, false);
			devText.isMenuItem = true;
			devText.targetY = i;
			grpDevs.add(devText);
			

			//later also add description text
			var descText:Alphabet = new Alphabet(45, (80 * i) + 55, devs[i][2], true, false, 0.7);
			descText.isMenuItem = true;
			descText.ownerText = devText;
			grpDesc.add(descText);

			var icon:CreditIcon;
			if (FileSystem.exists(Paths.image('credits/icon-'+devs[i][1]))) {
				icon = new CreditIcon(devs[i][1]);
				icon.sprTracker = devText;
			} else {
				icon = new CreditIcon("empty");
				icon.sprTracker = devText;
			}
			

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

		}

		changeSelection();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxTween.color(bg, 0.35, bg.color, mainColor);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
			changeSelection(-1);
		else if (downP)
			changeSelection(1);

		if (controls.BACK)
		{
			Main.switchState(this, new MainMenuState());
		}

		if (accepted)
		{
			//play a funny sound depending on current dev
			if (FileSystem.exists(Paths.sound('credits-'+devs[curSelected][1]))) {
				FlxG.sound.play(Paths.sound('credits-'+devs[curSelected][1]));
			} else {
				FlxG.sound.play(Paths.sound('explosion'));
			}
		}
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = devs.length - 1;
		if (curSelected >= devs.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		// switching stuffs
		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpDevs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
		for (item2 in grpDesc.members)
		{
			var itemOwner = item2.ownerText;
			item2.x = itemOwner.x + 35;
			item2.y = itemOwner.y + 30;
			//item2.targetY = bullShit - curSelected;

			item2.alpha = 0.6;
			//item2.setGraphicSize(Std.int(item2.width * 0.6));

			if (itemOwner.targetY == 0)
			{
				item2.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
		//

		//trace("curSelected: " + curSelected);

	}
}