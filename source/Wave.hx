package;

import flixel.group.FlxGroup;
import entities.*;

typedef WaveData = {enemyClass:Class<Entity>, enemyCount:Int};

class Wave {
	private static var waves:Array<Wave> = null;

	private var waveData:Array<WaveData>;

	public function new(Data:Array<WaveData>) {
		waveData = Data;
	}

	public function createEnemies(group:FlxGroup):Array<Entity> {
		var y = 0.0;
		var enemies = new Array<Entity>();
		for (waveGroup in waveData) {
			y += 40;
			for (i in 0...waveGroup.enemyCount) {
				var x = i * 40 + 200;
				var enemy = Type.createInstance(waveGroup.enemyClass, [x, y, group]);
				enemies.push(enemy);
			}
		}
		return enemies;
	}

	public static function getWave(WaveNumber:Int):Wave {
		return genWaves()[WaveNumber];
	}

	public static function genWaves():Array<Wave> {
		if (waves == null) {
			waves = [
				new Wave([{enemyClass: Cockroach, enemyCount: 3},
						  {enemyClass: Cockroach, enemyCount: 3},
						  {enemyClass: Cockroach, enemyCount: 3},
						  {enemyClass: Cockroach, enemyCount: 3},
						  {enemyClass: Cockroach, enemyCount: 3},
						  {enemyClass: Cockroach, enemyCount: 3}])
			];
		}
		return waves;
	}
}