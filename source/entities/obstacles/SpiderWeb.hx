package entities.obstacles;

import flixel.util.FlxColor;
import flixel.group.FlxGroup;

class SpiderWeb extends Obstacle {
	override public function new(X:Float=0, Y:Float=0, ?Group:FlxGroup, ?State:PlayState) {
		super(X, Y, Group, State);

		loadGraphic(AssetPaths.web__png);
	}

	override public function collideWithPlayer() {
		state.player.moveSpeed = cast(state.player.moveSpeed / 2);
	}
}