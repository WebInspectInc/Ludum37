package entities.weapons;

import entities.bullets.PeaBullet;

class PeaShooter extends Weapon {

	private var cooldown:Float = 0;

	private static inline var SPRITE_HEIGHT:Int = 26;
	private static inline var SPRITE_WIDTH:Int = 100;
	
	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		loadGraphic(AssetPaths.pea_shooter__png, false, SPRITE_WIDTH, SPRITE_HEIGHT);
		origin.set(SPRITE_WIDTH * 0.25, SPRITE_HEIGHT * 0.5);
		offset.set(-30, -60);
		solid = true;
	}

	override public function update(delta:Float) {
		cooldown -= delta;
		super.update(delta);
	}

	override public function fire() {
		if (cooldown <= 0) {
			cooldown = 0.17;
			var newBullet = new PeaBullet(x + relativeX - offset.x, y + relativeY - offset.y, state, 500, angle, 10, cast(state.playerBullets));
		}
	}
}