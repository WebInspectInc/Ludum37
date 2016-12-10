package entities;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.math.FlxRandom;
import flixel.group.FlxGroup;
import entities.Entity;

class Ant extends Entity {
	private static inline var SPRITE_HEIGHT:Int = 105;
	private static inline var SPRITE_WIDTH:Int = 102;

	private var accelerationSpeed:Int = 1000;

	private var attackCooldown:Float = 0;
	private var randomPoint:FlxPoint = new FlxPoint();
	private var chaseTime:Float = 6;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);
		loadGraphic(AssetPaths.ant_walk__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);

		animation.add('walk', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], 25);
		animation.play('walk');

		setSize(52, 37);
		offset.set(21, 33);

		health = 20;

		this.moveSpeed = 200;

		var rnd = new FlxRandom();
		randomPoint = new FlxPoint(500, 500);

		this.maxVelocity = new FlxPoint(150, 150);
		this.moving = true;
	}

	override public function update(delta: Float) {
		attackCooldown -= delta;
		chaseTime -= delta;

		var rnd = new FlxRandom();
		if (chaseTime <= 0 || (x < randomPoint.x + 75 && x > randomPoint.x - 75 && y < randomPoint.y + 75 && y > randomPoint.y - 75)) {
			randomPoint = new FlxPoint(state.player.x + rnd.int(-150, 150), state.player.y + rnd.int(-150, 150));
			chaseTime = 6;
		}
		var angle = FlxAngle.angleBetweenPoint(this, randomPoint, true);

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