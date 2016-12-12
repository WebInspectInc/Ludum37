package entities.enemies;

import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.math.FlxAngle;
import flixel.FlxG;

class ScorpionEgg extends Enemy {
	
	public var timer:Float = 4;
	public var z:Float = 0;
	public var zVel:Float;
	public var grounded:Bool = false;
	public var mother:MotherSpider;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);
		customMovement = true;
		loadGraphic(AssetPaths.spike_egg__png);
		corpse = AssetPaths.spike_egg_corpse__png;

		health = 60;

		zVel = FlxG.random.float(200, 300);
		velocity.set(FlxG.random.float(-200, 200), FlxG.random.float(-200, 200));
		solid = false;
	}


	override public function update(delta:Float) {
		super.update(delta);

		y = y + z;
		z += zVel * delta;
		if (!grounded) {
			zVel -= 250 * delta;
		}
		y = y - z;

		if (!grounded) {		
			if (z <= 0) {
				z = 0;
				zVel = 0;
				velocity.set(0, 0);
				grounded = true;
				solid = true;
			}
		}

		timer -= delta;
		if (timer <= 0) {
			for (i in 0...4) {
				var pos = FlxAngle.getCartesianCoords(i * 10, i * 70);
				var enemy:Enemy = null;
				if (i < 2) {
					enemy = new Spider(pos.x + x, pos.y + y, parentGroup);
				} else if (i < 3) {
					enemy = new Scorpion(pos.x + x, pos.y + y, parentGroup);
				} else {
					enemy = new SuperScorpion(pos.x + x, pos.y + y, parentGroup);
				}
				enemy.state = state;
			}
			kill();
			return;
		}
	}
}