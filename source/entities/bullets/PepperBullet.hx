package entities.bullets;

import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.FlxG;

class PepperBullet extends Bullet {

	private var explosionSound:FlxSound = FlxG.sound.load(AssetPaths.explosion_short__wav, .2);
	private var explosionDelay:Float = 5;
	private var exploded:Bool = false;

	override public function new(X:Float, Y:Float, State:PlayState, Speed:Int, Direction:Float, Damage:Float, Group:FlxGroup) {
		super(X, Y, State, Speed, Direction, Damage, Group);
	    loadGraphic(AssetPaths.flaming_peppercorn__png, true, 34, 36);

	    animation.add('flaming', [0,1]);
	    animation.play('flaming');

	    state = State;
	}

	public function explode() {
		var ex = new Explosion(x, y, state, 0, 0, 50, cast(state.playerBullets));
		FlxG.camera.shake(0.05, 0.2);
		kill();
	}

	override public function hit(e:Entity) {
		explode();
		moveSpeed = 0;
		explosionSound.play();
		e.hurt(damage);
	}

	override public function update(delta:Float) {
		explosionDelay -= delta;

		if (explosionDelay <= 0) {
			explode();
			return;
		}

		if (moveSpeed > 0) {
			moveSpeed -= 5;
		}

		super.update(delta);
	}
}