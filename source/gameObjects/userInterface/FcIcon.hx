package gameObjects.userInterface;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import sys.FileSystem;

using StringTools;

class FcIcon extends FlxSprite
{
	// rewrite using da new icon system as ninjamuffin would say it
	public var sprTracker:FlxSprite;
	public var initialWidth:Float = 0;
	public var initialHeight:Float = 0;
	public var curframeidk:Float = 0;
	public var songWasFc:Bool = false;

	public function new(songfcd:Bool = false)
	{
		songWasFc = songfcd;
		super();
		updateIcon();
	}

	public function updateIcon()
	{

		//antialiasing = true;
		frames = Paths.getSparrowAtlas('hud/FC');

		initialWidth = width;
		initialHeight = height;

		animation.addByPrefix('iconfc','FC FullCombo', 30, false);
		animation.play('iconfc');
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 145, sprTracker.y - 30);
	}
}
