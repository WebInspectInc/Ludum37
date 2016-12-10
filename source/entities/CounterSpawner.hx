package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;

import entities.*;

class CounterSpawner extends Entity {

	public var sideways:Bool = false;

	public function new(State:PlayState, X:Float, Y:Float, Sideways:Bool = false, Flip:Bool = false) {
		super(X, Y);
		health = 5;
		state = State;
		sideways = Sideways;

		if (Sideways) {
			loadGraphic(AssetPaths.side_counter__png);
		} else {
			loadGraphic(AssetPaths.counter__png);
		}
	}

	override public function hurt(damage:Float) {
		health = Math.max(1, health - damage);
		var assetPath = null;
		if (!sideways) {
			switch (Math.floor(health)) {
				case 5: assetPath = AssetPaths.counter__png;
				case 4: assetPath = AssetPaths.counter_broken_1__png;
				case 3: assetPath = AssetPaths.counter_broken_2__png;
				case 2: assetPath = AssetPaths.counter_broken_3__png;
				case 1: assetPath = AssetPaths.counter_destroy__png;
			}
		} else {
			switch (Math.floor(health)) {
				case 5: assetPath = AssetPaths.side_counter__png;
				case 4: assetPath = AssetPaths.side_counter_broken_1__png;
				case 3: assetPath = AssetPaths.side_counter_broken_2__png;
				case 2: assetPath = AssetPaths.side_counter_broken_3__png;
				// case 1: assetPath = AssetPaths.side_counter_destroy__png;
			}
		}
		loadGraphic(assetPath);
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