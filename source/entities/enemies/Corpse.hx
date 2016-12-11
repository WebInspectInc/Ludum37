package entities.enemies;

import flixel.FlxSprite;

class Corpse extends FlxSprite {

	private var fadeTimer:Float = 7;

	private var greyAsset:String;

	public function new(X, Y, Asset:String, GreyAsset:String) {
		super(X, Y);
		greyAsset = GreyAsset;
		loadGraphic(Asset);
		solid = false;
	}

	override public function update(delta:Float) {
		if (greyAsset != null) {
			if (fadeTimer > 0) {
				fadeTimer -= delta;
			} else {
				loadGraphic(greyAsset);
			}
		}
	}
}