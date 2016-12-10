package entities.weapons;

import flixel.util.FlxColor;

import entities.bullets.*;

class Triple extends Weapon {

	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		makeGraphic(8, 8, FlxColor.YELLOW);
	}

	override public function fire() {
		var newBullet = new Bullet(this.x, this.y, state, 500, angle, 10, cast(state.playerBullets));
		var newBullet = new Bullet(this.x, this.y, state, 500, angle + 10, 10, cast(state.playerBullets));
		var newBullet = new Bullet(this.x, this.y, state, 500, angle - 10, 10, cast(state.playerBullets));
	}
}