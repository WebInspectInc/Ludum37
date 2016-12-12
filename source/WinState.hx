package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.system.macros.FlxAssetPaths;
import flixel.system.FlxAssets;

class WinState extends FlxState
{
	public var image:FlxSprite;

	public var winImage:String = AssetPaths.you_won_screen__png;

	override public function create():Void
	{
		super.create();

		image = new FlxSprite(0, 0, winImage);
		image.screenCenter();
		add(image);
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.mouse.pressed) {
			FlxG.resetGame();
		}

		super.update(elapsed);
	}
}
