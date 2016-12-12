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

class LoseState extends FlxState
{
	public var image:FlxSprite;

	private static var lossTheme:FlxSoundAsset = AssetPaths.lossTheme__wav;

	public var loseImage:String = AssetPaths.you_died_screen__png;

	override public function create():Void
	{
		super.create();

		image = new FlxSprite(0, 0, loseImage);
		image.screenCenter();
		add(image);

		FlxG.sound.playMusic(lossTheme, 1, true);
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.mouse.pressed) {
			FlxG.resetGame();
		}

		super.update(elapsed);
	}
}
