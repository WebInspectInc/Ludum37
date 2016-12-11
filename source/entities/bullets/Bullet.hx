package entities.bullets;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;
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
	private var hitEnemies:Array<Entity>;

	public var skipEnemyCheck:Bool = false;

	public var isEvil:Bool = false;

	public function new(X:Float, Y:Float, State:PlayState, Speed:Int, Direction:Float, Damage:Float, Group:FlxGroup)
	{
	    super(X, Y, Group);
	    state = State;
	    moving = true;
	    moveSpeed = Speed;
	    moveAngle = Direction;
	    angle = Direction;
	    damage = Damage;

	    hitEnemies = new Array<Entity>();
	}

	public function hit(e:Entity) {
	}

	override public function update(delta:Float) {
		if ((isTouching(FlxObject.ANY) && !skipEnemyCheck) || !isOnScreen()) {
			kill();
			return;
		}

		if (!isEvil) {
			for (e in state.enemies) {
				if (overlaps(e) && hitEnemies.indexOf(e) == -1) {
					hitEnemies.push(e);
					hit(e);
					return;
				}
			}
		} else {
			if (overlaps(state.player)) {
				hitEnemies.push(state.player);
				hit(state.player);
				return;
			}
		}

		super.update(delta);
	}
}