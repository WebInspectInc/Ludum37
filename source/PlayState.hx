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

import entities.*;
import entities.weapons.*;
import entities.bullets.*;
import controllers.PlayerController;

import Wave;

class PlayState extends FlxState
{
	private var playerController:PlayerController;
	public var player:Player;
	private var level:LevelState;
	private var barriers:Barriers;

	public var enemies:FlxTypedGroup<Entity>;
	public var playerBullets:FlxTypedGroup<Bullet>;
	public var groundWeapons:FlxTypedGroup<Weapon>;

	override public function create():Void
	{
		level = new LevelState(this);
		enemies = new FlxTypedGroup<Entity>();
		playerBullets = new FlxTypedGroup<Bullet>();
		add(playerBullets);
		groundWeapons = new FlxTypedGroup<Weapon>();
		add(groundWeapons);

		add(level);

		super.create();

		player = new Player(this);
		add(player);

		var triple = new Triple(500, 600);
		triple.state = this;
		groundWeapons.add(triple);

		var roaches = Wave.getWave(0).createEnemies(cast(enemies));
		for (roach in roaches) {
			roach.state = this;
			add(roach);
		}

		playerController = new PlayerController(this.player);

		barriers = new Barriers(this, player);

		FlxG.camera.follow(player, FlxCameraFollowStyle.TOPDOWN);
		FlxG.camera.setScrollBoundsRect(0, 0, level.width, level.height, true);

		var healthBar = new FlxBar(7, 7, LEFT_TO_RIGHT, 100, 20, player, "health", 0, 10, true);
		healthBar.scrollFactor.set(0, 0);
		add(healthBar);
	}

	override public function update(elapsed:Float):Void
	{
		this.playerController.update();
		barriers.update(elapsed);

		FlxG.collide(player, barriers.walls);
		FlxG.collide(enemies, barriers.walls);
		FlxG.collide(enemies, enemies);
		FlxG.overlap(player.playerWeapon.bulletArray, barriers.walls, destroyBullet);

		super.update(elapsed);
	}

	function destroyBullet(bullet:Bullet, wall:FlxSprite):Void {
		bullet.kill();
	}
}
