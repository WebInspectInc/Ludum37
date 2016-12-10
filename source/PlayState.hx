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
import entities.Weapon;
import entities.Bullet;
import entities.Player;
import entities.Cockroach;
import controllers.PlayerController;

import Wave;

class PlayState extends FlxState
{
	private var playerController:PlayerController;
	public var player:Player;
	private static var level:LevelState;

	public var enemies:FlxTypedGroup<Entity>;

	override public function create():Void
	{
		level = new LevelState(this);
		enemies = new FlxTypedGroup<Entity>();

		add(level);

		super.create();

		this.player = new Player(this);
		add(player);

		// var roach = new Cockroach(400, 400, cast(enemies));
		// roach.state = this;
		// add(roach);

		var roaches = Wave.getWave(0).createEnemies(cast(enemies));
		for (roach in roaches) {
			roach.state = this;
			add(roach);
		}

		playerController = new PlayerController(this.player);

		FlxG.camera.follow(player, FlxCameraFollowStyle.TOPDOWN);
		FlxG.camera.setScrollBoundsRect(0, 0, level.width, level.height, true);

		var healthBar = new FlxBar(7, 7, LEFT_TO_RIGHT, 100, 20, player, "health", 0, 10, true);
		healthBar.scrollFactor.set(0, 0);
		add(healthBar);
	}

	override public function update(elapsed:Float):Void
	{
		this.playerController.update();

		super.update(elapsed);
	}
}
