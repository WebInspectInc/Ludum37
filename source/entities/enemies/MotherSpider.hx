package entities.enemies;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.group.FlxGroup;
import flixel.addons.display.FlxNestedSprite;
import entities.Entity;
import flixel.FlxG;

class MotherSpider extends Enemy {
	private static inline var SPRITE_WIDTH:Int = 551;
	private static inline var SPRITE_HEIGHT:Int = 552;

	private static inline var BOOM_WIDTH:Int = 405;
	private static inline var BOOM_HEIGHT:Int = 265;

	private var accelerationSpeed:Int = 500;

	private var attackCooldown:Float = 0;

	private var eggTimer:Float = 6;
	private var eggType:Int = 0;
	private var eggsLeft:Int = 0;

	private var boomSprite:FlxNestedSprite;

	public var spiderlings:Array<Spiderling>;

	private var vel:FlxPoint;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);
		loadGraphic(AssetPaths.Death_spider_walk__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);

		animation.add('walk', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], 25);
		animation.play('walk');

		setSize(191, 171);
		offset.set(93, 114);

		health = 800;

		this.moveSpeed = 30;

		this.moving = true;

		boomSprite = new FlxNestedSprite();
		boomSprite.loadGraphic(AssetPaths.boom__png, true, BOOM_WIDTH, BOOM_HEIGHT);
		boomSprite.animation.add("boom", [0,1,2,3,4,5,6,7,8], 20, false);

		spiderlings = new Array<Spiderling>();
		vel = new FlxPoint(0,0);

		immovable = true;
		customMovement = true;
	}

	override public function update(delta: Float) {
		attackCooldown -= delta;
		eggTimer -= delta;

		if (eggTimer <= 0 && eggsLeft == 0) {
			eggType = FlxG.random.weightedPick([1,1,2]);
			if (eggType == 2) {
				if (spiderlings.length > 150) {
					eggType = FlxG.random.weightedPick([50, 50]);
				}
				eggsLeft = 5;
			} else {
				eggsLeft = 1;
			}
		}

		if (eggsLeft > 0 && eggTimer <= 0) {
			switch (eggType) {
				case 0:
					var bomb = new AntBomb(x, y, cast(state.enemies));
					bomb.state = state;
				case 1:
					var bomb = new ScorpionEgg(x, y, cast(state.enemies));
					bomb.state = state;
				case 2:
					var bomb = new SpiderEgg(x, y, cast(state.enemies));
					bomb.mother = this;
					bomb.state = state;
					eggTimer = 0.3;
			}
			eggsLeft -= 1;

			add(boomSprite);
			boomSprite.animation.play("boom");

			if (eggsLeft == 0) {
				eggTimer = 7;
			}
		}

		if (boomSprite.animation.finished) {
			remove(boomSprite);
		}

		var angle = FlxAngle.angleBetween(this, this.state.player, true);
		moveAngle = angle;

		if (this.moving) {
			vel = FlxAngle.getCartesianCoords(moveSpeed, moveAngle);
		} else {
			vel.set(0, 0);
		}

		if (overlaps(state.player) && attackCooldown <= 0) {
			attackCooldown = 1;
			state.player.hurt(1);
		}

		this.x += vel.x * delta;
		this.y += vel.y * delta;

		super.update(delta);
	}
}
