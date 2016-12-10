package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class LevelState extends FlxState
{
	private static var width:Int = 900;
	private static var height:Int = 650;
	public function new(state:PlayState):Void
	{
		var level = new FlxSprite();
		level.makeGraphic(width, height, FlxColor.BROWN);

		var doors = new FlxSprite();
		doors.makeGraphic(width, 30, FlxColor.RED);

		state.add(level);
		state.add(doors);

		super();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
