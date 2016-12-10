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

class Player extends Entity
{
	private static inline var SPRITE_HEIGHT:Int = 100;
	private static inline var SPRITE_WIDTH:Int = 85;

	public var playerWeapon:Weapon;

	public var center:FlxNestedSprite;

	public function new(playState:PlayState, ?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
		state = playState;
		this.health = 10;
		loadGraphic(AssetPaths.gnome__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);

		animation.add('idle', [0,1,2,3,4,5,6,7,8,9,10], 8);
		animation.add('walk', [12,13,14,15,16,17,18,19,20,21,22], 4);
		animation.play('idle');

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
		playerWeapon.relativeAngle = FlxAngle.angleBetweenMouse(center, true);

		if (this.moving) {
			velocity.set(this.moveSpeed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), this.moveAngle);
		} else {
			velocity.set(0, 0);
		}

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
}