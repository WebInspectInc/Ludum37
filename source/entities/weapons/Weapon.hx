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
	private static inline var SPRITE_HEIGHT:Int = 52;
	private static inline var SPRITE_WIDTH:Int = 200;

	public var state:PlayState;

	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		loadGraphic(AssetPaths.pea_shooter__png, false, SPRITE_WIDTH, SPRITE_HEIGHT);
		scale.set(0.5, 0.5);
		origin.set(0, SPRITE_HEIGHT * 0.5);
		offset.set(-90, -65);
		solid = true;
	}

	public function fire(angle:Float) {
		var newBullet = new Bullet(x + relativeX - offset.x, y + relativeY - offset.y, state, 500, angle, 10, cast(state.playerBullets));
	}

	override public function update(delta:Float) {
		relativeAngle = FlxAngle.angleBetweenMouse(this, true);

		super.update(delta);
	}
}