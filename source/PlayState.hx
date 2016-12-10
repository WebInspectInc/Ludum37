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

import entities.Weapon;
import entities.Bullet;
import entities.Player;
import entities.Cockroach;
import controllers.PlayerController;

class PlayState extends FlxState
{
	private var playerController:PlayerController;
	public var player:Player;
	private static var level:LevelState;

	override public function create():Void
	{
		level = new LevelState(this);

		add(level);

		super.create();

		this.player = new Player(this);
		add(player);

		var roach = new Cockroach(400, 400);
		roach.state = this;
		add(roach);

		playerController = new PlayerController(this.player);

		FlxG.camera.follow(player, FlxCameraFollowStyle.TOPDOWN);
		FlxG.camera.setScrollBoundsRect(0, 0, level.width, level.height, true);

		var healthBar = new FlxBar(7, 7, LEFT_TO_RIGHT, 100, 20, player, "health", 0, 10, true);
		add(healthBar);
	}

	override public function update(elapsed:Float):Void
	{
		this.playerController.update();

		super.update(elapsed);
	}
}
