package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.addons.display.FlxNestedSprite;

import flixel.group.FlxGroup;

import entities.Entity;
import entities.weapons.*;
import entities.bullets.*;
import entities.placeable.*;

class Player extends Entity
{
	private static inline var SPRITE_HEIGHT:Int = 100;
	private static inline var SPRITE_WIDTH:Int = 68;

	public var playerWeapon:Weapon;

	public var center:FlxNestedSprite;

	public var placing:Placeable;

	public function new(playState:PlayState, ?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
		state = playState;
		this.health = 10;
		loadGraphic(AssetPaths.gnome__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);

		animation.add('idle', [8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33], 26);
		animation.add('walk', [34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60], 26);
		animation.add('eyebrows', [0,1,2,3,4,5,6,7], 4);
		animation.play('idle');

		setSize(24, 58);
		offset.set(30, 30);

		playerWeapon = new PeaShooter();
		playerWeapon.solid = false;
		playerWeapon.state = state;
		add(playerWeapon);

		center = new FlxNestedSprite();
		center.makeGraphic(1, 1, FlxColor.TRANSPARENT);
		center.relativeX = 50;
		center.relativeY = 43;
		add(center);
	}

	public function setMoving(moving:Bool) {
		this.moving = moving;
		if (moving) {
			animation.play('walk');
		} else {
			animation.play('idle');
		}
	}

	public function setMoveAngle(moveAngle:Float) {
		this.moveAngle = moveAngle;
	}

	public function useWeapon(angle:Float)
	{
		playerWeapon.fire();
	}

	override public function update(delta:Float)
	{
		playerWeapon.relativeAngle = angleToMouse();

		if (this.moving) {
			velocity.set(this.moveSpeed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), this.moveAngle);
		} else {
			velocity.set(0, 0);
		}

		movePlacing();

		super.update(delta);
	}

	public function pickupWeapon() {
		FlxG.overlap(this, state.groundWeapons, pickup);
	}

	public function pickup(player:Player, weapon:Weapon) {
		remove(playerWeapon);
		state.groundWeapons.add(playerWeapon);
		playerWeapon.setPosition(x, y);
		playerWeapon.velocity.set(0, 0);
		playerWeapon.solid = true;

		state.groundWeapons.remove(weapon);
		weapon.setPosition(0, 0);
		add(weapon);
		weapon.solid = false;
		playerWeapon = weapon;
	}

	public function angleToMouse():Float {
		return FlxAngle.angleBetweenMouse(center, true);
	}

	public function place() {
		var barrier = new CookieBarrier(0, 0, cast(state.placedObjects), state);
		placing = barrier;
		movePlacing();
	}

	public function movePlacing() {
		if (placing == null) return;
		var angle = angleToMouse();
		var dir = FlxAngle.getCartesianCoords(1, angle);

		dir.x = Math.round(dir.x) * 170;
		dir.y = Math.round(dir.y) * 170;

		var hitbox = placing.getHitbox();

		var pos = new FlxPoint();
		if (Math.abs(dir.y) > Math.abs(dir.x)) {
			pos.x = center.x - placing.height / 2;
			pos.y = center.y + dir.y - placing.width / 2;
		} else {
			pos.x = center.x + dir.x - placing.width / 2;
			pos.y = center.y - placing.height / 2;
		}
		placing.setPosition(pos.x, pos.y);
	}

	public function setDown() {
		placing.setDown();
		placing = null;
	}
}