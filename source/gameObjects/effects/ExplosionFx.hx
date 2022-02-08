package gameObjects.effects;

import flixel.graphics.frames.FlxAtlasFrames;
import meta.CoolUtil;
import meta.data.dependency.FNFSprite;

class ExplosionFx extends FNFSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		//frames = Paths.getSparrowAtlas('characters/Cameos');
		loadGraphic(Paths.image('effects/explosion'), true, 58, 81);

		animation.add('boom', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17],18,false);

		animation.play('boom');
		setGraphicSize(Std.int(width * 6));
		updateHitbox();
		antialiasing = false;
	}
}
