package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;

import flixel.addons.display.FlxNestedSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Entity extends flixel.group.FlxSpriteGroup {
	private var moving:Bool;
	private var moveAngle:Float;

	private var moveSpeed:Int = 200;
	public var state:PlayState;

	public var sprite:FlxSprite;

	public var parentGroup:FlxGroup;

	public function new(X:Float=0, Y:Float=0, ?Group:FlxGroup) {
		super(X, Y);
		sprite = new FlxSprite();
		add(sprite);
		parentGroup = Group;
		if (parentGroup != null) {
			parentGroup.add(this);
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
		if (parentGroup != null)
		{
			parentGroup.remove(this);
		}

		destroy();
	}
}