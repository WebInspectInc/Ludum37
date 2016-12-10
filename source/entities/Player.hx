package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

class Player extends FlxSprite
{
	private var moving:Bool;
	private var moveAngle:Float;

	private var moveSpeed:Int = 200;
	public var state:PlayState;

	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
		makeGraphic(16, 16, FlxColor.RED);
	}

	public function setMoving(moving:Bool)
	{
		this.moving = moving;
	}

	public function setMoveAngle(moveAngle:Float)
	{
		this.moveAngle = moveAngle;
	}

	override public function update(delta:Float)
	{
		if (this.moving) {
			velocity.set(this.moveSpeed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), this.moveAngle);
		} else {
			velocity.set(0, 0);
		}

		super.update(delta);
	}
}