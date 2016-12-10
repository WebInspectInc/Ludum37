package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import entities.Entity;
import flixel.math.FlxAngle;

class Cockroach extends Entity {

	private var accelerationSpeed:Int = 1000;

	private var attackCooldown:Float = 0;

	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		makeGraphic(16, 16, FlxColor.ORANGE);

		this.moveSpeed = 100;

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