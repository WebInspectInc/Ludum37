package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;

import flixel.addons.display.FlxNestedSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Entity extends FlxNestedSprite {
	public var customMovement:Bool = false; // Hack to get around entity class :'(
	private var moving:Bool;
	private var moveAngle:Float;

	public var moveSpeed:Int = 200;
	public var state:PlayState;

	public var parentGroup:FlxGroup;

	public function new(X:Float=0, Y:Float=0, ?Group:FlxGroup, ?State:PlayState) {
		super(X, Y);
		parentGroup = Group;
		state = State;
		if (parentGroup != null) {
			parentGroup.add(this);
		}
	}

	override public function update(delta:Float) {
		if (!customMovement) {
			if (this.moving) {
				velocity.set(this.moveSpeed, 0);
				velocity.rotate(FlxPoint.weak(0, 0), this.moveAngle);
			} else {
				velocity.set(0, 0);
			}
		}

		super.update(delta);
	}

	override public function kill() {
		if (parentGroup != null)
		{
			parentGroup.remove(this);
		}

		destroy();
	}
}