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

	override public function update(delta:Float) {
		// relativeAngle = FlxAngle.angleBetweenMouse(this, true);

		super.update(delta);
	}

	public function fire() {

	}
}