package entities.bullets;

import flixel.group.FlxGroup;

class PeaBullet extends Bullet {
	override public function new(X:Float, Y:Float, State:PlayState, Speed:Int, Direction:Float, Damage:Float, Group:FlxGroup) {
		super(X, Y, State, Speed, Direction, Damage, Group);
	    sprite.loadGraphic(AssetPaths.pea_shooter_bullet__png, false, 61, 44);
	}

	override public function hit(e:Entity) {
		e.hurt(damage);
		kill();
	}
}