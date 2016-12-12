package entities.enemies;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.math.FlxRandom;
import flixel.group.FlxGroup;
import entities.Entity;
import entities.obstacles.SpiderWeb;
import flixel.math.FlxMath;
import flixel.FlxG;

class Spider extends Enemy {
	private static inline var SPRITE_WIDTH:Int = 205;
	private static inline var SPRITE_HEIGHT:Int = 179;

	private var accelerationSpeed:Int = 1000;

	private var lastWeb:Float = 0;

	private var turnDirection:Float = 0;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);
		loadGraphic(AssetPaths.spider_walk__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);
		corpse = AssetPaths.spider_corpse__png;
		greyCorpse = AssetPaths.grey_spider_corpse__png;

		animation.add('walk', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], 15);
		animation.play('walk');

		setSize(130, 88);
		offset.set(41, 86);

		health = 20;

		var rnd = new FlxRandom();
		moveSpeed = 300 + rnd.int(-30, 30);

		turnDirection = FlxG.random.weightedPick([50, 0, 50]) - 1;

		// this.maxVelocity = new FlxPoint(150, 150);
		this.moving = true;
	}

	override public function update(delta: Float) {
		var angle = FlxAngle.angleBetween(this, this.state.player, true);

		var distance = FlxMath.distanceBetween(this, this.state.player);
		if (distance < 400) {
			angle = angle + 90 * turnDirection;
		}

		if (state.time - lastWeb > 5.2) {
			var web = new SpiderWeb(x, y, cast(state.obstacles), state);
			web.state = state;
			lastWeb = state.time;
		}

		moveAngle = angle;

		if (velocity.x < 0) {
			flipX = true;
		}

		super.update(delta);
	}

	override public function attack(player:Player) {
		if (overlaps(player)) {
			player.hurt(1);
		}
	}
}