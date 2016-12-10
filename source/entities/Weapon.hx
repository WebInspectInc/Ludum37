package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.FlxObject;

import flixel.addons.display.FlxNestedSprite;
import flixel.group.FlxGroup;

import entities.Bullet;

class Weapon extends FlxNestedSprite
{
	public var bulletArray:FlxTypedGroup<Bullet>;

	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		makeGraphic(4, 4, FlxColor.BLUE);

		bulletArray = new FlxTypedGroup<Bullet>();
	}

	public function fire() {
		var newBullet = new Bullet(this.x, this.y, 500, FlxObject.RIGHT, 10);
		bulletArray.add(newBullet);
	}

	override public function update(delta:Float) {

		for (b in bulletArray) {
			if (b.isTouching(FlxObject.ANY) || !b.isOnScreen()) {
				bulletArray.remove(b);
				b.destroy();
			}
		}

		super.update(delta);
	}
}