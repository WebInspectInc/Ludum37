package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

import flixel.group.FlxGroup;

import entities.Entity;
import entities.Weapon;
import entities.Bullet;

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
		add(playerWeapon);
		state.add(playerWeapon.bulletArray);
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
}