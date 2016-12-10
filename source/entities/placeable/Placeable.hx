package entities.placeable;

import flixel.group.FlxGroup;

import entities.Entity;

class Placeable extends Entity {

	override public function new (X:Float, Y:Float, Group:FlxGroup, State:PlayState) {
		super(X, Y, Group, State);

		alpha = 0.25;
		solid = false;
	}

	public function setDown() {
		alpha = 1.0;
		solid = true;
	}
}