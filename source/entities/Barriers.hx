package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.FlxObject;

import flixel.addons.display.FlxNestedSprite;
import flixel.group.FlxGroup;

using flixel.util.FlxSpriteUtil;

class Barriers extends FlxSprite
{
	public var walls:FlxTypedGroup<FlxSprite>;
	public var player:Player;
	public var state:PlayState;

	private var canvas:FlxSprite;
	private var showingUI:Bool = false;
	private var UIx:Int = 0;
	private var UIy:Int = 0;
	private var testObject:FlxObject;

	private var wallWidth:Int = 80;
	private var wallHeight:Int = 40;

	public function new(stateRef:PlayState, playerRef:Player, ?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		state = stateRef;
		player = playerRef;
		walls = new FlxTypedGroup<FlxSprite>();
		state.add(walls);

		canvas = new FlxSprite();
	}

	public function createWall(X:Float, Y:Float, flipAxis:Bool) {
		var newWall = new FlxSprite(X, Y);
		if (flipAxis) {
			newWall.makeGraphic(wallHeight, wallWidth, FlxColor.BLACK);
		} else {
			newWall.makeGraphic(wallWidth, wallHeight, FlxColor.BLACK);
		}
		newWall.immovable = true;
		walls.add(newWall);
	}

	private function showWallUI() {
		if (UIx == 0 && UIy == 0) {
			UIx = FlxG.mouse.x;
			UIy = FlxG.mouse.y;
			testObject = new FlxObject(UIx, UIy);
		}

		canvas.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		state.add(canvas);
		var lineStyle:LineStyle = { color: FlxColor.BLACK, thickness: 1 };
		var drawStyle:DrawStyle = { smoothing: true };
		canvas.drawCircle(UIx, UIy, 10, FlxColor.BLACK, lineStyle, drawStyle);
		canvas.drawLine(UIx, UIy, FlxG.mouse.x, FlxG.mouse.y, lineStyle);

		angle = FlxAngle.angleBetweenMouse(testObject, true);
	}

	private function hideWallUI() {
		canvas.fill(FlxColor.TRANSPARENT);
		UIx = 0;
		UIy = 0;
	}

	override public function update(delta:Float) {
		if (FlxG.mouse.pressedRight && !showingUI) {
			showWallUI();
		}
		if (FlxG.mouse.justReleasedRight) {
			var flipAxis:Bool = false;
			if ((angle < 225 && angle > 135) || (angle < 45 || angle > 315)) {
				flipAxis = true;
			}

			this.createWall(player.x, player.y, flipAxis);
			hideWallUI();
		}

		super.update(delta);
	}
}