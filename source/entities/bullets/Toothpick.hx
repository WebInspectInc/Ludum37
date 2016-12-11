package entities.bullets;

import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.FlxG;

class Toothpick extends Bullet {

	private var explosionSound:FlxSound = FlxG.sound.load(AssetPaths.explosion_short__wav, .2);

	override public function new(X:Float, Y:Float, State:PlayState, Speed:Int, Direction:Float, Damage:Float, Group:FlxGroup) {
		super(X, Y, State, Speed, Direction, Damage, Group);
	    loadGraphic(AssetPaths.launcher_bullet__png, false, 125, 32);
	}

	override public function hit(e:Entity) {
		e.hurt(damage);
		explosionSound.play();
		if (hitEnemies.length >= 2) {
			kill();
		}
	}
}