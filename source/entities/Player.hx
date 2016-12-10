package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

import flixel.group.FlxGroup;

import entities.Entity;
import entities.weapons.*;
import entities.bullets.*;

class Player extends Entity
{
	public var playerWeapon:Weapon;
	public var playerBullets:FlxTypedGroup<Bullet>;

	public function new(playState:PlayState, ?X:Float=0, ?Y:Float=0)
	{
		state = playState;
		super(X, Y);
		this.health = 10;
		makeGraphic(16, 16, FlxColor.RED);

		playerWeapon = new Weapon();
		playerWeapon.state = state;
		add(playerWeapon);
	}

	public function setMoving(moving:Bool) {
		this.moving = moving;
	}

	public function setMoveAngle(moveAngle:Float) {
		this.moveAngle = moveAngle;
	}

	public function useWeapon(angle:Float)
	{
		playerWeapon.fire(angle);
	}

	override public function update(delta:Float)
	{
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
		state.groundWeapons.add(playerWeapon);
		remove(playerWeapon);
		state.groundWeapons.remove(weapon);
		add(weapon);
		playerWeapon.setPosition(x, y);
		playerWeapon = weapon;
	}
}