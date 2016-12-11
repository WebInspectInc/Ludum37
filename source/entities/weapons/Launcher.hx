package entities.weapons;

import flixel.FlxG;
import flixel.system.FlxSound;
import entities.bullets.*;

class Launcher extends Weapon {

	private var cooldown:Float = 0;

	private static inline var SPRITE_HEIGHT:Int = 70;
	private static inline var SPRITE_WIDTH:Int = 111;
	private static inline var DAMAGE:Int = 30;

	private var fireSound:FlxSound = FlxG.sound.load(AssetPaths.peashooter__wav, .2);
	public var isLoaded:Bool = false;
	
	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		loadGraphic(AssetPaths.launcher__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);

		animation.add('loaded', [0], 1, true);
		animation.add('empty', [1], 1, true);
		animation.play('empty');

		origin.set(SPRITE_WIDTH * 0.25, SPRITE_HEIGHT * 0.5);
		offset.set(-30, -60);
		solid = true;
	}

	override public function update(delta:Float) {
		cooldown -= delta;

		reloadTimer -= delta;

		if (reloadTimer <= 0 && ammo < 15) {
			ammo += 1;
			reloadTimer = 0.1;
		}

		super.update(delta);
	}

	override public function fire() {
		if (cooldown <= 0) {
			if (isLoaded) {
				animation.play('empty');
				reloadTimer = 1;
				ammo -= 1;

				cooldown = 0.5;
				var newBullet = new Toothpick(x + relativeX - offset.x, y + relativeY - offset.y, state, 1000, angle, 30, cast(state.playerBullets));
				newBullet.skipEnemyCheck = true;
				isLoaded = false;
			} else {
				cooldown = 0.25;
				animation.play('loaded');
				isLoaded = true;
			}
			//fireSound.play(true);
			//FlxG.camera.shake(0.002, 0.15);
		}

		super.fire();
	}
}