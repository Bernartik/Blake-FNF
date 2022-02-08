package meta.state.menus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import gameObjects.userInterface.menu.*;
import meta.MusicBeat.MusicBeatState;
import meta.data.*;
import meta.data.dependency.Discord;
import meta.data.dependency.FNFSprite;

using StringTools;

class EndWeekState extends MusicBeatState
{
	var numMisses:Int = 0;
	var curWeek:Int = 0;
	public var sceneNum:String = "1";
	var stopspamming:Bool = false;
	private var bg:FlxSprite;

	override function create()
	{
		super.create();

		#if !html5
		Discord.changePresence('STORY MENU', 'Main Menu');
		#end

		// freeaaaky
		//ForeverTools.resetMenuMusic();

		//later adjust position & add scenenum stuff
		var SceneBG = new FlxSprite(0,0).loadGraphic(Paths.image('cutscene/blake/Cutscenes'+sceneNum));

		add(SceneBG);

		var widShit = Std.int(SceneBG.width * 2);
		SceneBG.setGraphicSize(widShit);
		SceneBG.updateHitbox();
	}

	override function update(elapsed:Float)
	{	
		//if select return to menu
		if (controls.ACCEPT && !stopspamming) {
			Main.switchState(this, new StoryMenuState());
			stopspamming = true;
		}

		super.update(elapsed);
	}
}
