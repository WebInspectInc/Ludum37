package entities;

import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.math.FlxAngle;
import flixel.FlxG;

class AntBomb extends Entity {
	
	public var timer:Float = 12;
	public var z:Float = 0;
	public var zVel:Float;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);
		makeGraphic(60, 40, FlxColor.BLUE);

		setSize(56, 37);

		health = 60;

		zVel = FlxG.random.float(200, 300);
		velocity.set(FlxG.random.float(50, 100), FlxG.random.float(50, 100));
	}

	override public function update(delta:Float) {
		super.update(delta);

		y = y + z;
		z += zVel * delta;
		zVel -= 250 * delta;
		y = y - z;

		if (z <= 0) {
			z = 0;
			zVel = 0;
		}

		timer -= delta;
		if (timer <= 0) {
			for (i in 0...8) {
				var pos = FlxAngle.getCartesianCoords(i * 40, i * 120);
				var enemy = new Ant(pos.x + x, pos.y + y, parentGroup);
				enemy.state = state;
				state.add(enemy);
			}
			kill();
		}

	}
}