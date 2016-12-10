package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.group.FlxGroup;
import entities.Entity;

class Deathroach extends Entity {
	private static inline var SPRITE_HEIGHT:Int = 256;
	private static inline var SPRITE_WIDTH:Int = 252;

	private var accelerationSpeed:Int = 500;

	private var attackCooldown:Float = 0;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);
		loadGraphic(AssetPaths.death_roach_walk__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);

		animation.add('walk', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], 25);
		animation.play('walk');

		setSize(130, 88);
		offset.set(41, 86);

		health = 60;

		this.moveSpeed = 40;

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

		super.update(delta);
	}
}