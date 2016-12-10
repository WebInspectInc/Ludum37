package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import entities.Entity;

class Entity extends FlxSprite {
	private var moving:Bool;
	private var moveAngle:Float;

	private var moveSpeed:Int = 200;
	public var state:PlayState;

	override public function update(delta:Float) {
		if (this.moving) {
			velocity.set(this.moveSpeed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), this.moveAngle);
		} else {
			velocity.set(0, 0);
		}

		super.update(delta);
	}
}