package;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxAngle;
import entities.enemies.*;

typedef WaveData = {enemyClass:Class<Enemy>, enemyCount:Int};

class Wave {
	private static var waves:Array<Wave> = null;

	private var waveData:Array<WaveData>;
	private var groupNumber:Int = 0;

	public var waveNames:Array<String> = new Array<String>();

	public function new(Data:Array<WaveData>) {
		waveData = Data;
		waveNames = [
			'Wave 1: Our Epic Battle Begins',
			'Wave 2: Watch Yer Back, Young’n',
			'Wave 3: A Sticky Situation',
			'Wave 4: Right Back At Ya, Bro',
			'Wave 5: The Deathroach',
			'Wave 6: Testing Your Gnomish Metal',
			'Wave 7: New Ways to Die',
			'Wave 8: Mother'
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
				new Wave([{enemyClass: Ant, enemyCount: 10},
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
						  {enemyClass: Ant, enemyCount: 5},
						  {enemyClass: Ant, enemyCount: 10},
						  {enemyClass: Ant, enemyCount: 10}
						  ]),
				new Wave([{enemyClass: Scorpion, enemyCount: 1},
						  {enemyClass: Deathroach, enemyCount: 1},
						  {enemyClass: Scorpion, enemyCount: 1},
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
						  {enemyClass: Spider, enemyCount: 3}
						  ])
			];
		}
		return waves;
	}
}