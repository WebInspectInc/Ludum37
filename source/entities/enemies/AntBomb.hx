package entities.enemies;

import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.math.FlxAngle;
import flixel.FlxG;
import flixel.system.FlxSound;

class AntBomb extends Enemy {
	
	public var timer:Float = 5;
	public var z:Float = 0;
	public var zVel:Float;
	public var grounded:Bool = false;

	private var explosionSound:FlxSound = FlxG.sound.load(AssetPaths.big_explosion__wav, .2);

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);
		customMovement = true;
		loadGraphic(AssetPaths.Roach_egg__png);
		corpse = AssetPaths.Roach_egg_corpse__png;

		health = 50;

		zVel = FlxG.random.float(200, 300);
		velocity.set(FlxG.random.float(-200, 200), FlxG.random.float(-200, 200));
		solid = false;
		FlxG.camera.shake(0.09, 0.1);
		explosionSound.play();
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
			for (i in 0...5) {
				var pos = FlxAngle.getCartesianCoords(i * 10, i * 70);
				var enemy = new Ant(pos.x + x, pos.y + y, parentGroup, i < 1);
				enemy.state = state;
			}
			var enemy = new Scorpion(x, y, parentGroup);
			enemy.state = state;
			kill();
			return;
		}
	}
}