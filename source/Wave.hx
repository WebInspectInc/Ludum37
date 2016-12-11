package;

import flixel.group.FlxGroup;
import flixel.math.FlxAngle;
import entities.*;

typedef WaveData = {enemyClass:Class<Entity>, enemyCount:Int};

class Wave {
	private static var waves:Array<Wave> = null;

	private var waveData:Array<WaveData>;
	private var groupNumber:Int = 0;

	public function new(Data:Array<WaveData>) {
		waveData = Data;
	}

	public function createEnemies(group:FlxGroup):Array<Entity> {
		var y = 0.0;
		var enemies = new Array<Entity>();
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

	public function nextGroup(group:FlxGroup):Array<Entity> {
		if (groupNumber >= waveData.length) return null;
		var waveGroup = waveData[groupNumber];
		groupNumber++;
		var enemies = new Array<Entity>();
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
		return genWaves()[WaveNumber];
	}

	public static function genWaves():Array<Wave> {
		if (waves == null) {
			waves = [
				new Wave([{enemyClass: Cockroach, enemyCount: 1},
						  {enemyClass: Deathroach, enemyCount: 1},
						  // {enemyClass: Cockroach, enemyCount: 1},
						  // {enemyClass: Cockroach, enemyCount: 1},
						  // {enemyClass: Cockroach, enemyCount: 1},
						  // {enemyClass: Cockroach, enemyCount: 1},
						  // {enemyClass: Ant, enemyCount: 5},
						  // {enemyClass: Ant, enemyCount: 10},
						  // {enemyClass: Ant, enemyCount: 10}
						  ])
			];
		}
		return waves;
	}
}