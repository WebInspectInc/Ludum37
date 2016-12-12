package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.addons.display.FlxNestedSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.misc.ColorTween;

import entities.enemies.Corpse;

class Entity extends FlxNestedSprite {
	public var customMovement:Bool = false; // Hack to get around entity class :'(
	private var moving:Bool;
	private var moveAngle:Float;

	public var moveSpeed:Float = 200;
	public var state:PlayState;

	public var hurtTime:Float;

	public var parentGroup:FlxGroup;

	public var corpse:String = null;
	public var greyCorpse:String = null;

	public function new(X:Float=0, Y:Float=0, ?Group:FlxGroup, ?State:PlayState) {
		super(X, Y);
		parentGroup = Group;
		state = State;
		if (parentGroup != null) {
			parentGroup.add(this);
		}
	}

	override public function update(delta:Float) {
		if (!customMovement) {
			if (this.moving) {
				velocity.set(this.moveSpeed, 0);
				velocity.rotate(FlxPoint.weak(0, 0), this.moveAngle);
			} else {
				velocity.set(0, 0);
			}
		}

		if (hurtTime >= 0) {
			if (hurtTime % 2 == 0) {
				alpha = 0.5;
			} else {
				alpha = 1;
			}
			hurtTime -= 0.5;
		} else {
			alpha = 1;
		}

		super.update(delta);
	}

	override public function kill() {
		if (corpse != null) {
			var corpseEntity = new Corpse(x - offset.x, y - offset.y, corpse, greyCorpse);
			corpseEntity.flipX = flipX;
			state.corpses.add(corpseEntity);
		}

		if (parentGroup != null)
		{
			// parentGroup.remove(this);
			parentGroup.members.remove(this);
		}

		destroy();
	}

	override public function hurt(Damage:Float) {
		hurtTime = 30; //frames

		health = health - Damage;
		if (health <= 0)
		{
			kill();
		}
	}
}