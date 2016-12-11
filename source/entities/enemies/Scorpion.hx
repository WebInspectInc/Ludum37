package entities.enemies;

import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.math.FlxAngle;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;

import entities.bullets.PeaBullet;

class Scorpion extends Enemy {

	private static inline var SPRITE_WIDTH:Int = 119;
	private static inline var SPRITE_HEIGHT:Int = 110;

	private var fireTimer:Float = 0;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);

		loadGraphic(AssetPaths.scorp_walk__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);
		animation.add('walk', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], 25);
		animation.play('walk');

		moveSpeed = 130;
		// setSize(130, 88);
		// offset.set(41, 86);

		health = 20;

		this.moving = true;
	}

	override public function update(delta:Float) {
		fireTimer -= delta;

		if (fireTimer <= 0) {
			var bullet = new PeaBullet(x, y, state, 250, FlxAngle.angleBetween(this, state.player.center, true), 1, cast(state.evilBullets), true);
			fireTimer = 1;
		}

		var distance = FlxMath.distanceBetween(state.player.center, this);

		moving = true;
		if (distance > 400) {
			moveAngle = FlxAngle.angleBetween(this, state.player.center, true);
		} else if (distance < 280) {
			moveAngle = FlxAngle.angleBetween(state.player.center, this, true);
		} else {
			moving = false;
		}

		super.update(delta);
	}
}