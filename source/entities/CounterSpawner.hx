package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;

import entities.*;

class CounterSpawner extends Entity {

	public function new(State:PlayState, X:Float, Y:Float, Sideways:Bool = false) {
		super(X, Y);
		state = State;

		if (Sideways) {
			loadGraphic(AssetPaths.side_counter__png);
		} else {
			loadGraphic(AssetPaths.counter__png);
		}
	}

	public function spawn() {
		var enemies = state.currentWave.nextGroup(cast(state.enemies));
		if (enemies == null) return;

		for (enemy in enemies) {
			enemy.state = state;
			enemy.setPosition(enemy.x + this.x, enemy.y + this.y);
			state.add(enemy);
		}
	}
}