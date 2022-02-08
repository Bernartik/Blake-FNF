package gameObjects.background;

import flixel.graphics.frames.FlxAtlasFrames;
import meta.CoolUtil;
import meta.data.dependency.FNFSprite;

class BlakeFriends extends FNFSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas('characters/Cameos');

		animation.addByPrefix('idle', 'Cameos Stage3 Cameos', 24, false);

		animation.play('idle');
	}
	public function dance():Void
	{
		animation.play('idle',true);
	}
}
