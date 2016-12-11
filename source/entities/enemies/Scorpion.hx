package entities.enemies;

import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.math.FlxAngle;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;

import entities.bullets.PeaBullet;

class Scorpion extends Enemy {

	private var fireTimer:Float = 0;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);

		makeGraphic(50, 30, FlxColor.BLUE);

		moveSpeed = 130;
		// setSize(130, 88);
		// offset.set(41, 86);

		health = 20;

		this.moving = true;
	}

	override public function update(delta:Float) {
		fireTimer -= delta;

		if (fireTimer <= 0) {
			var bullet = new PeaBullet(x, y, state, 250, FlxAngle.angleBetween(this, state.player.center, true), 1, cast(state.evilBullets));
			bullet.isEvil = true;
			fireTimer = 1;
		}

		var distance = FlxMath.distanceBetween(state.player.center, this);
		trace(distance);

		moving = true;
		if (distance > 450) {
			moveAngle = FlxAngle.angleBetween(this, state.player.center, true);
		} else if (distance < 300) {
			moveAngle = FlxAngle.angleBetween(state.player.center, this, true);
		} else {
			moving = false;
		}

		super.update(delta);
	}
}