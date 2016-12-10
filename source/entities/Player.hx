package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import entities.Entity;

class Player extends entities.Entity {

	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		this.health = 10;
		makeGraphic(16, 16, FlxColor.RED);
		this.moveSpeed = 200;
	}

	public function setMoving(moving:Bool) {
		this.moving = moving;
	}

	public function setMoveAngle(moveAngle:Float) {
		this.moveAngle = moveAngle;
	}
}