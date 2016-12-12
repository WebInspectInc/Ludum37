package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.ui.FlxBar;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;
import flixel.system.FlxAssets;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;

import entities.*;
import entities.weapons.*;
import entities.bullets.*;
import entities.placeable.*;
import entities.enemies.*;
import entities.obstacles.*;
import controllers.PlayerController;

import Wave;

class PlayState extends FlxState
{
	private var playerController:PlayerController;
	public var player:Player;
	public var level:LevelState;

	private static var mainTheme:FlxSoundAsset = AssetPaths.menuTheme__wav;
	private static var actionTheme:FlxSoundAsset = AssetPaths.shootingTheme__wav;
	public var musicPlaying:FlxSoundAsset = mainTheme;

	public var enemies:FlxTypedGroup<Enemy>;
	public var obstacles:FlxTypedGroup<Obstacle>;
	public var playerBullets:FlxTypedGroup<Bullet>;
	public var evilBullets:FlxTypedGroup<Bullet>;
	public var groundWeapons:FlxTypedGroup<Weapon>;
	public var placedObjects:FlxTypedGroup<Placeable>;
	public var corpses:FlxTypedGroup<Corpse>;

	public var currentWave:Wave;
	public var waveNumber:Int = 0;
	public var currentText:FlxText;

	public var spawnTimer:Float = 6;
	public var resetSpawn:Bool = true;

	override public function create():Void
	{
		level = new LevelState(this);
		add(level);
		corpses = new FlxTypedGroup<Corpse>();
		add(corpses);
		obstacles = new FlxTypedGroup<Obstacle>();
		add(obstacles);
		placedObjects = new FlxTypedGroup<Placeable>();
		add(placedObjects);
		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);
		playerBullets = new FlxTypedGroup<Bullet>();
		add(playerBullets);
		evilBullets = new FlxTypedGroup<Bullet>();
		add(evilBullets);
		groundWeapons = new FlxTypedGroup<Weapon>();
		add(groundWeapons);

		super.create();

		player = new Player(this, 500, 500);
		add(player);

		// var triple = new Triple(500, 600);
		// triple.state = this;
		// groundWeapons.add(triple);

		// var pepper = new PepperGun(250, 500);
		// pepper.state = this;
		// groundWeapons.add(pepper);

		// var baked = new BakedBomb(350, 300);
		// baked.state = this;
		// groundWeapons.add(baked);

		// var launcher = new Launcher(650, 400);
		// launcher.state = this;
		// groundWeapons.add(launcher);

		currentWave = Wave.getWave(waveNumber);

		playerController = new PlayerController(this.player, level);

		FlxG.camera.follow(player, FlxCameraFollowStyle.TOPDOWN);
		FlxG.camera.setScrollBoundsRect(0, 0, level.width, level.height);

		var healthBar = new FlxBar(7, 7, LEFT_TO_RIGHT, 100, 20, player, "health", 0, 10, true);
		healthBar.scrollFactor.set(0, 0);
		add(healthBar);

		// var ammoBar = new FlxBar(7, 34, LEFT_TO_RIGHT, 100, 5, player.playerWeapon, "ammo", 0, 15, false);
		// ammoBar.scrollFactor.set(0, 0);
		// add(ammoBar);

		FlxG.sound.playMusic(mainTheme, 1, true);
		musicPlaying = mainTheme;

		announceWave();
	}

	override public function update(elapsed:Float):Void
	{
		this.playerController.update();

		spawnTimer -= elapsed;
		if (spawnTimer <= 0) {
			spawnSpawn();
		}

		if (enemies.countLiving() <= 0 && currentWave.isWaveComplete() && resetSpawn) {
			spawnTimer = 6;
			waveNumber += 1;
			currentWave = Wave.getWave(waveNumber);
			resetSpawn = false;

			announceWave();

			if (waveNumber == 2) {
				var pepper = new PepperGun(250, 500);
				pepper.state = this;
				groundWeapons.add(pepper);
			}

			if (waveNumber == 5) {
				var launcher = new Launcher(650, 400);
				launcher.state = this;
				groundWeapons.add(launcher);
			}

			if (musicPlaying != mainTheme) {
				FlxG.sound.playMusic(mainTheme, 1, true);
				musicPlaying = mainTheme;
			}
		}

		FlxG.collide(player, placedObjects);
		FlxG.collide(enemies, placedObjects);
		FlxG.collide(enemies, enemies);
		FlxG.overlap(playerBullets, placedObjects, destroyBullet);
		FlxG.overlap(evilBullets, placedObjects, destroyBullet);
		FlxG.overlap(obstacles, player, collideWithObstacle);

		super.update(elapsed);
	}

	public function createBarriers() {
		var center = new FlxPoint(600, 575);
		var random = FlxG.random;
		var location = FlxAngle.getCartesianCoords(random.int(400, 400), random.int(0, 400), center);

		var barrier = new CookieBarrier(location.x, location.y, cast(placedObjects), this);
		barrier.setDown();
		var barrier1 = new CookieBarrier(center.x + 120, center.y + 120, cast(placedObjects), this);
		barrier1.setDown();
	}

	public function announceWave() {
		var names = currentWave.waveNames;

		currentText = new FlxText(0, 0, -1, names[waveNumber], 20);
		currentText.color = FlxColor.BLACK;
		currentText.screenCenter();
		currentText.scrollFactor.set(0, 0);
		add(currentText);
	}

	public function spawnSpawn() {
		spawnTimer = 1;
		remove(currentText);

		var center = new FlxPoint(600, 475);
		var random = FlxG.random;
		var location = FlxAngle.getCartesianCoords(random.int(1000, 1100), random.int(0, 360));
		location.x += center.x;
		location.y += center.y;

		resetSpawn = true;

		var newEnemies = currentWave.nextGroup(cast(enemies));
		if (newEnemies != null) {
			for (enemy in newEnemies) {
				enemy.state = this;
				enemy.setPosition(enemy.x + location.x, enemy.y + location.y);
				// add(enemy);
			}
		}

		if (musicPlaying != actionTheme) {
			FlxG.sound.playMusic(actionTheme, 0.7, true);
			musicPlaying = actionTheme;
		}
	}

	function collideWithObstacle(obstacle:Obstacle, player:Player){
		obstacle.collideWithPlayer();
	}

	function destroyBullet(bullet:Bullet, wall:FlxSprite):Void {
		bullet.kill();
	}
}
