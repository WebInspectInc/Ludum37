package entities.weapons;

import flixel.FlxG;
import flixel.system.FlxSound;
import entities.bullets.*;

class BakedBomb extends Weapon {

	private var cooldown:Float = 0;

	private static inline var SPRITE_HEIGHT:Int = 34;
	private static inline var SPRITE_WIDTH:Int = 89;

	private var fireSound:FlxSound = FlxG.sound.load(AssetPaths.peashooter__wav, .2);
	
	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		loadGraphic(AssetPaths.pepper_mill__png, false, SPRITE_WIDTH, SPRITE_HEIGHT);
		origin.set(SPRITE_WIDTH * 0.25, SPRITE_HEIGHT * 0.5);
		offset.set(-30, -60);
		solid = true;
	}

	override public function update(delta:Float) {
		cooldown -= delta;
		super.update(delta);
	}

	override public function fire() {
		if (cooldown <= 0) {
			cooldown = 1;
			var newBullet = new BakedBullet(x + relativeX - offset.x, y + relativeY - offset.y, state, 50, angle, 10, cast(state.playerBullets));
		}
	}
}