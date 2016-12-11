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
import controllers.PlayerController;

import Wave;

class PlayState extends FlxState
{
	private var playerController:PlayerController;
	public var player:Player;
	private var level:LevelState;

	private static var mainTheme:FlxSoundAsset = AssetPaths.strategyTheme__wav;
	private static var actionTheme:FlxSoundAsset = AssetPaths.shootingTheme__wav;
	public var musicPlaying:FlxSoundAsset = mainTheme;

	public var enemies:FlxTypedGroup<Enemy>;
	public var playerBullets:FlxTypedGroup<Bullet>;
	public var groundWeapons:FlxTypedGroup<Weapon>;
	public var placedObjects:FlxTypedGroup<Placeable>;

	public var currentWave:Wave;
	public var waveNumber:Int = 0;

	public var spawnTimer:Float = 6;

	override public function create():Void
	{
		level = new LevelState(this);
		add(level);
		placedObjects = new FlxTypedGroup<Placeable>();
		add(placedObjects);
		enemies = new FlxTypedGroup<Enemy>();
		playerBullets = new FlxTypedGroup<Bullet>();
		add(playerBullets);
		groundWeapons = new FlxTypedGroup<Weapon>();
		add(groundWeapons);

		super.create();

		player = new Player(this, 500, 500);
		add(player);

		var triple = new Triple(500, 600);
		triple.state = this;
		groundWeapons.add(triple);

		var pepper = new PepperGun(250, 500);
		pepper.state = this;
		groundWeapons.add(pepper);

		currentWave = Wave.getWave(waveNumber);

		playerController = new PlayerController(this.player);

		FlxG.camera.follow(player, FlxCameraFollowStyle.TOPDOWN);
		FlxG.camera.setScrollBoundsRect(0, 0, level.width, level.height, true);

		var healthBar = new FlxBar(7, 7, LEFT_TO_RIGHT, 100, 20, player, "health", 0, 10, true);
		healthBar.scrollFactor.set(0, 0);
		add(healthBar);

		var ammoBar = new FlxBar(7, 34, LEFT_TO_RIGHT, 100, 5, player.playerWeapon, "ammo", 0, 15, false);
		ammoBar.scrollFactor.set(0, 0);
		add(ammoBar);

		if (FlxG.sound.music == null) {
			FlxG.sound.playMusic(mainTheme, 1, true);
			musicPlaying = mainTheme;
		}
	}

	override public function update(elapsed:Float):Void
	{
		this.playerController.update();

		spawnTimer -= elapsed;
		if (spawnTimer <= 0) {
			spawnSpawn();
		}

		if (enemies.countLiving() <= 0 && currentWave.isWaveComplete()) {
			if (musicPlaying != mainTheme) {
				FlxG.sound.playMusic(mainTheme, 1, true);
				musicPlaying = mainTheme;
			}
		}

		FlxG.collide(player, placedObjects);
		FlxG.collide(enemies, placedObjects);
		FlxG.collide(enemies, enemies);
		FlxG.overlap(playerBullets, placedObjects, destroyBullet);

		super.update(elapsed);
	}

	public function spawnSpawn() {
		spawnTimer = 1;

		var center = new FlxPoint(600, 475);
		var random = FlxG.random;
		var location = FlxAngle.getCartesianCoords(random.int(1000, 1100), random.int(0, 360), center);

		var newEnemies = currentWave.nextGroup(cast(enemies));
		if (newEnemies != null) {
			for (enemy in newEnemies) {
				enemy.state = this;
				enemy.setPosition(enemy.x + location.x, enemy.y + location.y);
				add(enemy);
			}
		}

		if (musicPlaying != actionTheme) {
			FlxG.sound.playMusic(actionTheme, 1, true);
			musicPlaying = actionTheme;
		}
	}

	function destroyBullet(bullet:Bullet, wall:FlxSprite):Void {
		bullet.kill();
	}
}
