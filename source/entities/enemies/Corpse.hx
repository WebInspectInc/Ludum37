package entities.enemies;

import flixel.FlxSprite;

class Corpse extends FlxSprite {

	private var fadeTimer:Float = 10;

	public function new(X, Y, Asset:String) {
		super(X, Y);
		loadGraphic(Asset);
		solid = false;
	}

	override public function update(delta:Float) {
		if (fadeTimer > 0) {
			fadeTimer -= delta;
		}

		if (fadeTimer < 2) {
			this.alpha = Math.max(0.5, fadeTimer / 2);
		}
	}
}