package entities.enemies;

import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.math.FlxAngle;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.FlxG;

import entities.bullets.PeaBullet;

class SuperScorpion extends Enemy {
	
	private static inline var SPRITE_WIDTH:Int = 119;
	private static inline var SPRITE_HEIGHT:Int = 110;

	private var fireRate:Float = 1;
	private var lastFired:Float = 1;
	private var firePattern:Int = 0;

	private var turnDirection:Float = 0;
	private var followDistance:Float = 350;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);

		loadGraphic(AssetPaths.super_scorp_walk__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);
		corpse = AssetPaths.super_scorp_corpse__png;
		greyCorpse = AssetPaths.grey_scorp_corpse__png;
		animation.add('walk', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], 25);
		animation.play('walk');

		moveSpeed = 130;
		setSize(52, 37);
		offset.set(21, 33);

		health = 20;

		fireRate = FlxG.random.float(1.3, 2);

		turnDirection = FlxG.random.weightedPick([50, 0, 50]) - 1;
		followDistance = FlxG.random.float(250, 450);

		this.moving = true;
	}

	override public function update(delta:Float) {

		var now = state.time;
		if (now - lastFired > fireRate) {
			firePattern = FlxG.random.weightedPick([2,1,2]);

			switch (firePattern) {
				case 0: // normal
					var bullet = new PeaBullet(x, y, state, 250, FlxAngle.angleBetween(this, state.player.center, true), 1, cast(state.evilBullets), true);
				case 1: // random
					var bulletAngle:Float = FlxAngle.angleBetween(this, state.player.center, true);
					bulletAngle += FlxG.random.float(-30, 30);
					var bullet = new PeaBullet(x, y, state, 250, bulletAngle, 1, cast(state.evilBullets), true);
				case 2: // leading
					var targetPos = state.player.center.getPosition();
					var distance = FlxMath.distanceBetween(this, state.player.center);
					var time = distance / 250;
					targetPos.set(targetPos.x + state.player.velocity.x * time, targetPos.y + state.player.velocity.y * time);
					var bulletAngle = FlxAngle.angleBetweenPoint(this, targetPos, true);
					var bullet = new PeaBullet(x, y, state, 250, bulletAngle, 1, cast(state.evilBullets), true);
			}
			lastFired = now;
		}

		var distance = FlxMath.distanceBetween(state.player.center, this);

		if (distance > followDistance + 60) {
			moveAngle = FlxAngle.angleBetween(this, state.player.center, true);
		} else if (distance < followDistance - 60) {
			moveAngle = FlxAngle.angleBetween(state.player.center, this, true);
		} else {
			moveAngle = FlxAngle.angleBetween(this, state.player.center, true) + 90 * turnDirection;
		}

		super.update(delta);
	}
}