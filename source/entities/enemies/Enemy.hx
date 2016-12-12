package entities.enemies;

class Enemy extends Entity {
	override public function update(delta:Float) {
		if (x > state.level.width) {
			moveAngle = 180;
		} else if (x < 0) {
			moveAngle = 0;
		} else if (y > state.level.height) {
			moveAngle = -90;
		} else if (y < 0) {
			moveAngle = 90;
		}
		super.update(delta);
	}

	public function attack(player:Player) {
		
	}
}