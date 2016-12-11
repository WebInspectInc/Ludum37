package entities.enemies;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.math.FlxRandom;
import flixel.group.FlxGroup;
import entities.Entity;

class Cockroach extends Enemy {
	private static inline var SPRITE_HEIGHT:Int = 256;
	private static inline var SPRITE_WIDTH:Int = 252;

	private var accelerationSpeed:Int = 1000;

	private var attackCooldown:Float = 0;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);
		loadGraphic(AssetPaths.roach_walk__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);
		corpse = AssetPaths.roach_corpse__png;

		animation.add('walk', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], 25);
		animation.play('walk');

		setSize(130, 88);
		offset.set(41, 86);

		health = 20;

		var rnd = new FlxRandom();
		moveSpeed = 100 + rnd.int(-30, 30);

		this.maxVelocity = new FlxPoint(150, 150);
		this.moving = true;
	}

	override public function update(delta: Float) {
		attackCooldown -= delta;

		var angle = FlxAngle.angleBetween(this, this.state.player, true);

		if (overlaps(state.player) && attackCooldown <= 0) {
			attackCooldown = 1;
			state.player.hurt(1);
		}

		moveAngle = angle;

		if (velocity.x < 0) {
			flipX = true;
		}

		super.update(delta);
	}
}