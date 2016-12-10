package controllers;

import flixel.FlxG;
import flixel.math.FlxAngle;
import entities.Player;

class PlayerController 
{
	var _up:Bool = false;
	var _down:Bool = false;
	var _left:Bool = false;
	var _right:Bool = false;
	var _fire:Bool = false;
	var _pickup:Bool = false;
	var _place:Bool = false;
	var _setDown:Bool = false;

	var playerEntity:Player;

	public function new(playerEntity:Player) {
		this.playerEntity = playerEntity;
	}

	public function update() {
		_up = FlxG.keys.anyPressed([UP, W]);
		_down = FlxG.keys.anyPressed([DOWN, S]);
		_left = FlxG.keys.anyPressed([LEFT, A]);
		_right = FlxG.keys.anyPressed([RIGHT, D]);
		_fire = FlxG.mouse.pressed;
		_pickup = FlxG.keys.anyJustPressed([E]);
		_place = FlxG.mouse.justPressedRight;
		_setDown = FlxG.mouse.justReleasedRight;

		// Cancel opposite directions
		if (_up && _down)
		{
			_up = _down = false;
		}
		if (_left && _right)
		{
			_left = _right = false;
		}

		var mA:Float = 0;
		if (_up) {
		    mA = -90;
		    if (_left)
		        mA -= 45;
		    else if (_right)
		        mA += 45;
		}
		else if (_down) {
		    mA = 90;
		    if (_left)
		        mA += 45;
		    else if (_right)
		        mA -= 45;
		}
		else if (_left)
		{
		    mA = 180;
		    playerEntity.flipX = true;
		}
		else if (_right)
		{
		    mA = 0;
		    playerEntity.flipX = false;
		}

		if (_up || _down || _left || _right) {
			playerEntity.setMoving(true);
			playerEntity.setMoveAngle(mA);
		} else {
			playerEntity.setMoving(false);
		}

		if (_fire) {
			playerEntity.useWeapon(FlxAngle.angleBetweenMouse(this.playerEntity, true));
		}

		if (_pickup) {
			playerEntity.pickupWeapon();
		}

		if (_place) {
			playerEntity.place();
		}

		if (_setDown) {
			playerEntity.setDown();
		}
	}
}