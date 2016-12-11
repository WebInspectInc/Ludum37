package entities.weapons;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.math.FlxAngle;

import flixel.addons.display.FlxNestedSprite;
import flixel.group.FlxGroup;

import entities.bullets.Bullet;

class Weapon extends FlxNestedSprite
{
	public var state:PlayState;
	public var ammo:Int = 15;

	private var reloadTimer:Float = 0;

	override public function update(delta:Float) {
		super.update(delta);
	}

	public function fire() {
	}
}