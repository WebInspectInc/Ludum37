package entities.enemies;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.group.FlxGroup;
import flixel.addons.display.FlxNestedSprite;
import entities.Entity;

import entities.enemies.AntBomb;

class Deathroach extends Enemy {
	private static inline var SPRITE_WIDTH:Int = 409;
	private static inline var SPRITE_HEIGHT:Int = 404;

	private static inline var BOOM_WIDTH:Int = 405;
	private static inline var BOOM_HEIGHT:Int = 265;


	private var accelerationSpeed:Int = 500;

	private var eggTimer:Float = 15;

	private var boomSprite:FlxNestedSprite;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);
		loadGraphic(AssetPaths.death_roach_walk__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);
		corpse = AssetPaths.death_roach_corpse__png;
		greyCorpse = AssetPaths.grey_death_roach_corpse__png;

		animation.add('walk', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], 25);
		animation.play('walk');

		setSize(191, 171);
		offset.set(93, 114);

		health = 400;

		this.moveSpeed = 40;

		this.maxVelocity = new FlxPoint(150, 150);
		this.moving = true;

		boomSprite = new FlxNestedSprite();
		boomSprite.loadGraphic(AssetPaths.boom__png, true, BOOM_WIDTH, BOOM_HEIGHT);
		boomSprite.animation.add("boom", [0,1,2,3,4,5,6,7,8], 20, false);
	}

	override public function update(delta: Float) {
		eggTimer -= delta;

		if (eggTimer <= 0) {
			eggTimer = 7;
			var bomb = new AntBomb(x, y, cast(state.enemies));
			bomb.state = state;
			// state.add(bomb);

			add(boomSprite);
			boomSprite.animation.play("boom");
		}

		if (boomSprite.animation.finished) {
			remove(boomSprite);
		}

		var angle = FlxAngle.angleBetween(this, this.state.player, true);

		moveAngle = angle;

		super.update(delta);
	}

	override public function hurt(Damage:Float) {
		health = health - Damage;
		if (health <= 0)
		{
			kill();
		}
	}

	override public function attack(player:Player) {
		if (overlaps(player)) {
			player.hurt(1);
		}
	}
}