package entities.bullets;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import entities.Entity;


import flixel.addons.display.FlxNestedSprite;

class Bullet extends entities.Entity
{
	private static inline var SPRITE_HEIGHT:Int = 44;
	private static inline var SPRITE_WIDTH:Int = 61;

	private var damage:Float;

	public function new(X:Float, Y:Float, State:PlayState, Speed:Int, Direction:Float, Damage:Float, Group:FlxGroup)
	{
	    super(X, Y, Group);
	    state = State;
	    moving = true;
	    moveSpeed = Speed;
	    moveAngle = Direction;
	    angle = Direction;
	    damage = Damage;

	    sprite.loadGraphic(AssetPaths.pea_shooter_bullet__png, false, 61, 44);
	}

	override public function destroy():Void
	{
	    super.destroy();
	}

	public function hit(e:Entity) {
		e.hurt(damage);
		kill();
	}

	override public function update(delta:Float) {
		if (isTouching(FlxObject.ANY) || !isOnScreen()) {
			kill();
			return;
		}

		for (e in state.enemies) {
			if (overlaps(e)) {
				hit(e);
				return;
			}
		}

		super.update(delta);
	}
}