package;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxAngle;
import flixel.FlxSprite;
import entities.enemies.*;

typedef WaveData = {enemyClass:Class<Enemy>, enemyCount:Int};

class Wave {
	public static var waves:Array<Wave> = null;

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
		if (WaveNumber >= waves.length) {
			FlxG.switchState(new WinState());
			return null;
		}
		return waves[WaveNumber];
	}

	public static function genWaves() {
		waves = [
			new Wave([{enemyClass: Ant, enemyCount: 1},
					  {enemyClass: Ant, enemyCount: 10}
					  ]),
			new Wave([{enemyClass: Ant, enemyCount: 10},
					  {enemyClass: Ant, enemyCount: 10},
					  {enemyClass: Cockroach, enemyCount: 1},
					  {enemyClass: Cockroach, enemyCount: 1},
					  {enemyClass: Cockroach, enemyCount: 2}
					  ]),
			new Wave([{enemyClass: Ant, enemyCount: 10},
					  {enemyClass: Spider, enemyCount: 2},
					  {enemyClass: Spider, enemyCount: 1},
					  {enemyClass: Scorpion, enemyCount: 2},
					  {enemyClass: Spider, enemyCount: 1},
					  {enemyClass: Spider, enemyCount: 2},
					  {enemyClass: Spider, enemyCount: 2}
					  ]),
			new Wave([{enemyClass: Ant, enemyCount: 10},
					  {enemyClass: Spider, enemyCount: 2},
					  {enemyClass: Scorpion, enemyCount: 2},
					  {enemyClass: Scorpion, enemyCount: 2},
					  {enemyClass: Cockroach, enemyCount: 1},
					  {enemyClass: Cockroach, enemyCount: 2},
					  {enemyClass: Spider, enemyCount: 1},
					  {enemyClass: Spider, enemyCount: 2}
					  ]),
			new Wave([{enemyClass: Deathroach, enemyCount: 1}
					  ]),
			new Wave([{enemyClass: Cockroach, enemyCount: 1},
					  {enemyClass: Scorpion, enemyCount: 1},
					  {enemyClass: Cockroach, enemyCount: 1},
					  {enemyClass: Cockroach, enemyCount: 1},
					  {enemyClass: Cockroach, enemyCount: 1},
					  {enemyClass: SuperScorpion, enemyCount: 1},
					  {enemyClass: Ant, enemyCount: 5},
					  {enemyClass: Ant, enemyCount: 10},
					  {enemyClass: Ant, enemyCount: 10}
					  ]),
			new Wave([{enemyClass: SuperScorpion, enemyCount: 1},
					  {enemyClass: Deathroach, enemyCount: 1},
					  {enemyClass: SuperScorpion, enemyCount: 1},
					  {enemyClass: Scorpion, enemyCount: 2},
					  {enemyClass: Cockroach, enemyCount: 1},
					  {enemyClass: Cockroach, enemyCount: 1},
					  {enemyClass: Cockroach, enemyCount: 1},
					  {enemyClass: Ant, enemyCount: 5},
					  {enemyClass: Ant, enemyCount: 10},
					  {enemyClass: Ant, enemyCount: 10}
					  ]),
			new Wave([{enemyClass: MotherSpider, enemyCount: 1},
					  {enemyClass: Ant, enemyCount: 10},
					  {enemyClass: Spider, enemyCount: 3},
					  {enemyClass: SuperScorpion, enemyCount: 1},
					  {enemyClass: Ant, enemyCount: 10}
					  ])
		];
	}
}