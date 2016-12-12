package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.system.macros.FlxAssetPaths;
import flixel.system.FlxAssets;
import flixel.system.FlxSound;

class MenuState extends FlxState
{
	public var image:FlxSprite;

	private static var menuTheme:FlxSoundAsset = AssetPaths.strategyTheme__wav;

	public var startImage:String = AssetPaths.intro_screen__png;
	public var loseImage:String = AssetPaths.you_died_screen__png;
	public var winImage:String = AssetPaths.you_won_screen__png;

	override public function create():Void
	{
		super.create();

		if (FlxG.sound.music == null) {
			FlxG.sound.playMusic(menuTheme, 1, true);
		}

		image = new FlxSprite(0, 0, startImage);
		image.screenCenter();
		add(image);
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.mouse.pressed) {
			FlxG.switchState(new PlayState());
		}

		super.update(elapsed);
	}
}
