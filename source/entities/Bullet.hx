package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.FlxObject;

import flixel.addons.display.FlxNestedSprite;

class Bullet extends FlxNestedSprite
{
	private var speed:Float;
	private var direction:Int;
	private var damage:Float;

	public function new(X:Float, Y:Float, Speed:Float, Direction:Int, Damage:Float)
	{
	    super(X,Y);
	    speed = Speed;
	    direction = Direction;
	    damage = Damage;

	    makeGraphic(4, 4, FlxColor.GREEN);
	}

	override public function update(delta:Float) {
	    super.update(delta);
	    if (direction == FlxObject.LEFT){
	        velocity.x = -speed;     
	    }
	    if (direction == FlxObject.RIGHT){
	        velocity.x = speed;     
	    }
	    if (direction == FlxObject.FLOOR){
	        velocity.y = speed;     
	    }
	    if (direction == FlxObject.CEILING){
	        velocity.y = -speed;     
	    }
	    
	}

	override public function destroy():Void
	{
	    super.destroy();
	}
}