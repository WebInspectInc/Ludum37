package entities.enemies;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.group.FlxGroup;
import entities.Entity;

import entities.enemies.AntBomb;

class Deathroach extends Enemy {
	private static inline var SPRITE_HEIGHT:Int = 404;
	private static inline var SPRITE_WIDTH:Int = 402;

	private var accelerationSpeed:Int = 500;

	private var attackCooldown:Float = 0;

	private var eggTimer:Float = 15;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);
		loadGraphic(AssetPaths.death_roach_walk__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);

		animation.add('walk', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], 25);
		animation.play('walk');

		setSize(191, 171);
		offset.set(93, 114);

		health = 400;

		this.moveSpeed = 40;

		this.maxVelocity = new FlxPoint(150, 150);
		this.moving = true;
	}

	override public function update(delta: Float) {
		attackCooldown -= delta;
		eggTimer -= delta;

		if (eggTimer <= 0) {
			eggTimer = 7;
			var bomb = new AntBomb(x, y, cast(state.enemies));
			bomb.state = state;
			state.add(bomb);
		}

		var angle = FlxAngle.angleBetween(this, this.state.player, true);

		if (overlaps(state.player) && attackCooldown <= 0) {
			attackCooldown = 1;
			state.player.hurt(1);
		}

		moveAngle = angle;

		super.update(delta);
	}
}