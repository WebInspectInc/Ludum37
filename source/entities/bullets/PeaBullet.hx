package entities.bullets;

import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.FlxG;

class PeaBullet extends Bullet {

	private var explosionSound:FlxSound = FlxG.sound.load(AssetPaths.explosion_short__wav, .2);

	override public function new(X:Float, Y:Float, State:PlayState, Speed:Int, Direction:Float, Damage:Float, Group:FlxGroup, ?IsEvil:Bool) {
		super(X, Y, State, Speed, Direction, Damage, Group);
		isEvil = IsEvil;
		if (isEvil) {
			loadGraphic(AssetPaths.roach_bullet__png, false, 61, 44);
		} else {
	    	loadGraphic(AssetPaths.pea_shooter_bullet__png, false, 61, 44);
		}
	}

	override public function hit(e:Entity) {
		e.hurt(damage);
		explosionSound.play();
		kill();
	}
}