package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import entities.Entity;

import flixel.addons.display.FlxNestedSprite;

class Bullet extends entities.Entity
{
	private var damage:Float;

	public function new(X:Float, Y:Float, Speed:Int, Direction:Float, Damage:Float)
	{
	    super(X,Y);
	    moving = true;
	    moveSpeed = Speed;
	    moveAngle = Direction;
	    damage = Damage;

	    makeGraphic(4, 4, FlxColor.GREEN);
	}

	override public function destroy():Void
	{
	    super.destroy();
	}
}