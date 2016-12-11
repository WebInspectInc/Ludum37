package entities.enemies;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Spider extends Enemy {
	public function new(?X:Float=0, ?Y:Float=0, Group:FlxGroup) {
		super(X, Y, Group);

		makeGraphic(60, 45, FlxColor.black);

		health = 20;

		var rnd = new FlxRandom();
		moveSpeed = 100 + rnd.int(-30, 30);

		this.maxVelocity = new FlxPoint(150, 150);
		this.moving = true;
	}

}