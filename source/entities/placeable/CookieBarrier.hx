package entities.placeable;

import flixel.group.FlxGroup;

class CookieBarrier extends Placeable {
	override public function new (X:Float, Y:Float, Group:FlxGroup, State:PlayState) {
		super(X, Y, Group, State);
		loadGraphic(AssetPaths.cookie__png);
		immovable = true;
	}

	
}