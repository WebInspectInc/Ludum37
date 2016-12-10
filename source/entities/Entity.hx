package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;

import flixel.addons.display.FlxNestedSprite;

class Entity extends FlxNestedSprite {
	private var moving:Bool;
	private var moveAngle:Float;

	private var moveSpeed:Int = 200;
	public var state:PlayState;

	public var group:FlxGroup;

	public function new(X:Float=0, Y:Float=0, ?Group:FlxGroup) {
		super(X, Y);
		group = Group;
		if (group != null) {
			group.add(this);
		}
	}

	override public function update(delta:Float) {
		if (this.moving) {
			velocity.set(this.moveSpeed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), this.moveAngle);
		} else {
			velocity.set(0, 0);
		}

		super.update(delta);
	}

	override public function kill() {
		if (group != null)
		{
			group.remove(this);
		}

		destroy();
	}
}