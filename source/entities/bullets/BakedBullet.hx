package entities.bullets;

import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.FlxG;

class BakedBullet extends Bullet {

	private var explosionSound:FlxSound = FlxG.sound.load(AssetPaths.explosion_short__wav, .2);
	private var tickSound:FlxSound = FlxG.sound.load(AssetPaths.ticking__wav, .4, true);
	private var explosionDelay:Float = 5;

	override public function new(X:Float, Y:Float, State:PlayState, Speed:Int, Direction:Float, Damage:Float, Group:FlxGroup) {
		super(X, Y, State, Speed, Direction, Damage, Group);
	    loadGraphic(AssetPaths.flaming_peppercorn__png, true, 34, 36);

	    animation.add('flaming', [0,1]);
	    animation.play('flaming');

	    tickSound.play();

	    state = State;
	}

	public function explode() {
		var ex1 = new Explosion(x, y, state, 20, 0, 50, cast(state.playerBullets));
		var ex2 = new Explosion(x, y, state, 20, 30, 50, cast(state.playerBullets));
		var ex3 = new Explosion(x, y, state, 20, 60, 50, cast(state.playerBullets));
		var ex4 = new Explosion(x, y, state, 20, 90, 50, cast(state.playerBullets));
		var ex5 = new Explosion(x, y, state, 20, 120, 50, cast(state.playerBullets));
		var ex6 = new Explosion(x, y, state, 20, 150, 50, cast(state.playerBullets));
		var ex7 = new Explosion(x, y, state, 20, 180, 50, cast(state.playerBullets));
		var ex8 = new Explosion(x, y, state, 20, 210, 50, cast(state.playerBullets));
		var ex9 = new Explosion(x, y, state, 20, 240, 50, cast(state.playerBullets));
		var ex10 = new Explosion(x, y, state, 20, 270, 50, cast(state.playerBullets));
		var ex11 = new Explosion(x, y, state, 20, 300, 50, cast(state.playerBullets));
		var ex12 = new Explosion(x, y, state, 20, 330, 50, cast(state.playerBullets));
		FlxG.camera.shake(0.05, 0.2);
		explosionSound.play();
		tickSound.stop();
		kill();
	}

	override public function hit(e:Entity) {
		e.hurt(damage);
		explode();
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