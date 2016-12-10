package entities.weapons;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.system.FlxSound;

import entities.bullets.*;

class Triple extends Weapon {

	private var cooldown:Float = 0;

	private static inline var SPRITE_HEIGHT:Int = 58;
	private static inline var SPRITE_WIDTH:Int = 100;

	private var fireSound:FlxSound = FlxG.sound.load(AssetPaths.biggun__wav, .2);

	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		loadGraphic(AssetPaths.triple_pea_shooter__png, false, SPRITE_WIDTH, SPRITE_HEIGHT);
		origin.set(SPRITE_WIDTH * 0.25, SPRITE_HEIGHT * 0.5);
		offset.set(-30, -60);
		solid = true;
	}

	override public function update(delta:Float)
	{
		cooldown -= delta;
		super.update(delta);
	}

	override public function fire() {
		if (cooldown <= 0) {
			cooldown = 0.25;
			var newBullet = new PeaBullet(this.x, this.y, state, 500, angle, 10, cast(state.playerBullets));
			var newBullet = new PeaBullet(this.x, this.y, state, 500, angle + 10, 10, cast(state.playerBullets));
			var newBullet = new PeaBullet(this.x, this.y, state, 500, angle - 10, 10, cast(state.playerBullets));
			
			fireSound.play(true);
			FlxG.camera.shake(0.01, 0.15);
		}

	}
}