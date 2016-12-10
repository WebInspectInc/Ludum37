package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.FlxObject;
import flixel.tweens.FlxTween;

import flixel.addons.display.FlxNestedSprite;
import flixel.group.FlxGroup;

import entities.Bullet;

class Weapon extends FlxNestedSprite
{
	private static inline var SPRITE_HEIGHT:Int = 52;
	private static inline var SPRITE_WIDTH:Int = 200;

	public var state:PlayState;
	public var bulletArray:FlxTypedGroup<Bullet>;

	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		loadGraphic(AssetPaths.pea_shooter__png, false, SPRITE_WIDTH, SPRITE_HEIGHT);
		scale.set(0.5, 0.5);
		origin.set(0, SPRITE_HEIGHT * 0.5);
		offset.set(-90, -65);
		solid = false;

		bulletArray = new FlxTypedGroup<Bullet>();
	}

	public function fire(angle:Float) {
		var newBullet = new Bullet(x + relativeX - offset.x, y + relativeY - offset.y, 500, angle, 10, cast(bulletArray));
	}

	override public function update(delta:Float) {
		for (b in bulletArray) {

			if (b.isTouching(FlxObject.ANY) || !b.isOnScreen()) {
				b.kill();
				continue;
			}
			
			for (e in state.enemies) {
				if (b.overlaps(e)) {
					b.hit(e);
					break;
				}
			}
		}

		relativeAngle = FlxAngle.angleBetweenMouse(this, true);

		super.update(delta);
	}
}