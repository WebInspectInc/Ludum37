package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.FlxCamera.FlxCameraFollowStyle;

import entities.Player;
import controllers.PlayerController;

class PlayState extends FlxState
{
	private var playerController:PlayerController;
	private var player:Player;
	private static var level:LevelState;
	override public function create():Void
	{
		level = new LevelState(this);

		add(level);

		super.create();

		this.player = new Player();
		this.player.state = this;
		add(player);

		playerController = new PlayerController(this.player);

		FlxG.camera.follow(player, FlxCameraFollowStyle.TOPDOWN);
		FlxG.camera.setScrollBoundsRect(0, 0, level.width, level.height, true);
	}

	override public function update(elapsed:Float):Void
	{
		this.playerController.update();

		super.update(elapsed);
	}
}
