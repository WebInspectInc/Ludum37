package entities.bullets;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.util.FlxColor;

class PeaExplosion extends Bullet {
	private static inline var SPRITE_HEIGHT:Int = 95;
	private static inline var SPRITE_WIDTH:Int = 100;

	override public function new(X:Float, Y:Float, State:PlayState, Speed:Int, Direction:Float, Damage:Float, Group:FlxGroup) {
		super(X, Y, State, Speed, Direction, Damage, Group);
		loadGraphic(AssetPaths.pea_hit__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);

		animation.add('explode', [0,1,2,3], 25, false);
		animation.play('explode');
	}

	override public function update(delta:Float) {
		if (animation.finished) {
			kill();
			return;
		}

		super.update(delta);
	}
}