package entities.weapons;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.FlxObject;

import flixel.addons.display.FlxNestedSprite;
import flixel.group.FlxGroup;

import entities.bullets.Bullet;

class Weapon extends FlxNestedSprite
{
	public var state:PlayState;

	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		makeGraphic(8, 8, FlxColor.BLUE);
	}

	public function fire(angle:Float) {
		var newBullet = new Bullet(this.x, this.y, state, 500, angle, 10, cast(state.playerBullets));
	}
}