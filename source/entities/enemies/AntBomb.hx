package entities.enemies;

import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.math.FlxAngle;
import flixel.FlxG;

class AntBomb extends Enemy {
	
	public var timer:Float = 8;
	public var z:Float = 0;
	public var zVel:Float;
	public var grounded:Bool = false;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);
		customMovement = true;
		loadGraphic(AssetPaths.Roach_egg__png);
		corpse = AssetPaths.Roach_egg_corpse__png;

		health = 60;

		zVel = FlxG.random.float(200, 300);
		velocity.set(FlxG.random.float(-200, 200), FlxG.random.float(-200, 200));
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
				timer -= 5;
			}
		}

		timer -= delta;
		if (timer <= 0) {
			for (i in 0...8) {
				var pos = FlxAngle.getCartesianCoords(i * 10, i * 70);
				var enemy = new Ant(pos.x + x, pos.y + y, parentGroup, i < 2);
				enemy.state = state;
				state.add(enemy);
			}
			kill();
			return;
		}
	}
}