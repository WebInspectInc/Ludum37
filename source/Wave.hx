package;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxAngle;
import flixel.FlxSprite;
import entities.enemies.*;

typedef WaveData = {enemyClass:Class<Enemy>, enemyCount:Int};

class Wave {
	private static var waves:Array<Wave> = null;

	private var waveData:Array<WaveData>;
	private var groupNumber:Int = 0;

	public var waveNames:Array<FlxSprite> = new Array<FlxSprite>();

	public function new(Data:Array<WaveData>) {
		waveData = Data;
		waveNames = [
			new FlxSprite(0,0,AssetPaths.wave_1__png),
			new FlxSprite(0,0,AssetPaths.wave_2__png),
			new FlxSprite(0,0,AssetPaths.wave_3__png),
			new FlxSprite(0,0,AssetPaths.wave_4__png),
			new FlxSprite(0,0,AssetPaths.wave_5__png),
			new FlxSprite(0,0,AssetPaths.wave_6__png),
			new FlxSprite(0,0,AssetPaths.wave_7__png),
			new FlxSprite(0,0,AssetPaths.wave_8__png)
		];
	}
 
	public function createEnemies(group:FlxGroup):Array<Enemy> {
		var y = 0.0;
		var enemies = new Array<Enemy>();
		for (waveGroup in waveData) {
			y += 40;
			for (i in 0...waveGroup.enemyCount) {
				var x = i * 75;
				var enemy = Type.createInstance(waveGroup.enemyClass, [x, y, group]);
				enemies.push(enemy);
			}
		}
		return enemies;
	}

	public function nextGroup(group:FlxGroup):Array<Enemy> {
		if (groupNumber >= waveData.length) return null;
		var waveGroup = waveData[groupNumber];
		groupNumber++;
		var enemies = new Array<Enemy>();
		for (i in 0...waveGroup.enemyCount) {
			var pos = FlxAngle.getCartesianCoords(i * 40, i * 120);
			var enemy = Type.createInstance(waveGroup.enemyClass, [pos.x, pos.y, group]);
			enemies.push(enemy);
		}
		return enemies;
	}

	public function isWaveComplete():Bool {
		return groupNumber >= waveData.length;
	}

	public static function getWave(WaveNumber:Int):Wave {
		var w = genWaves();
		if (WaveNumber >= w.length) {
			FlxG.switchState(new WinState());
		}
		return genWaves()[WaveNumber];
	}

	public static function genWaves():Array<Wave> {
		if (waves == null) {
			waves = [
				new Wave([{enemyClass: Ant, enemyCount: 10}
						  ])
			];
		}
		return waves;
	}
}