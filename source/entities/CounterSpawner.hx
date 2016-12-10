package entities;

import flixel.util.FlxColor;

import entities.*;

class CounterSpawner extends Entity {

	public function new(State:PlayState, X:Float, Y:Float) {
		super(X, Y);
		state = State;

		makeGraphic(32, 16, FlxColor.RED);
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