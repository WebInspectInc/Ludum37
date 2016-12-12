package entities.enemies;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.math.FlxRandom;
import flixel.group.FlxGroup;
import flixel.FlxG;
import entities.Entity;

class Spiderling extends Enemy {

	private static inline var SPRITE_WIDTH:Int = 60;
	private static inline var SPRITE_HEIGHT:Int = 54;

	private var accelerationSpeed:Int = 1000;

	private var lastRushTime:Float = 0;

	private var attackCooldown:Float = 0;
	private var randomPoint:FlxPoint = new FlxPoint();
	public var chaseTime:Float = 0;
	private var isSuperAnt:Bool = false;

	private var mother:MotherSpider;
	public var targetPlayer:Bool = true;

	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup, State:PlayState, Mother:MotherSpider) {
		super(X, Y, Group);

		state = State;
		mother = Mother;
		mother.spiderlings.push(this);

		health = 10;
		this.moveSpeed = 200;
		loadGraphic(AssetPaths.super_small_spider_walk__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);
		corpse = AssetPaths.small_spider_corpse__png;
		greyCorpse = AssetPaths.grey_small_spider_corpse__png;

		setSize(20, 10);
		offset.set(15, 15);

		animation.add('walk', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], 25);
		animation.play('walk');

		lastRushTime = state.time;

		this.maxVelocity = new FlxPoint(150, 150);
		this.moving = true;
	}

	override public function update(delta: Float) {
		attackCooldown -= delta;
		chaseTime -= delta;

		var rnd = new FlxRandom();
		if (chaseTime <= 0 || (x < randomPoint.x + 75 && x > randomPoint.x - 75 && y < randomPoint.y + 75 && y > randomPoint.y - 75)) {
			if (targetPlayer) {
				randomPoint = new FlxPoint(state.player.x + state.player.width/2 + rnd.int(-100, 100), state.player.y + state.player.height/2 + rnd.int(-100, 100));
			} else {
				randomPoint = new FlxPoint(mother.x + mother.width/2 + rnd.int(-400, 400), mother.y + mother.height/2 + rnd.int(-400, 400));
			}
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

		var now = state.time;
		if (now - lastRushTime > 5) {
			lastRushTime = now;
			targetPlayer = FlxG.random.weightedPick([5, 1]) == 1;
			if (targetPlayer) {
				chaseTime = 0;
				loadGraphic(AssetPaths.super_small_spider_walk__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);
			} else {
				loadGraphic(AssetPaths.small_spider_walk__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);
			}
		}

		super.update(delta);
	}

	override public function kill() {
		mother.spiderlings.remove(this);
		super.kill();
	}
}