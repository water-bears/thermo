package {
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import org.flixel.system.FlxTile;
	
	import org.flixel.*;
	
	// Really should use this.value when changing player's internal values...
	public class Player extends FlxSprite {
		
		/* curPow (fake enumeration, as3 has annoying enumerations) 
			Initialized to 0 for no power
			1 for freeze
			2 for heat
			3 for flash freeze
			4 for flash heat
		*/
		public var curPow:int;
		
		public var superBubble:Boolean = false;
		public var bubble:Boolean = false;
		public var underwater:Boolean = false;
		public var waterTiles:FlxTilemap;
		public var hasKey:Boolean = false;
		public var stat:String = "none";
		public var playState:PlayState;
		
		public var t1:int;
		
		/** Animation frames per second */
		private static const FR:int = 10;
		
		private var ice:Array;
		private var iceCount:int;
		
		public function Player(x:Number, y:Number, waterT:FlxTilemap, playState:PlayState):void{
			super(x, y);
		
			this.addAnimation("stand", [0]);
			this.addAnimation("walk", [0, 1, 2], FR, true);
			this.addAnimation("jump", [3]);
			this.addAnimation("bubble", [5]);
			this.facing = FlxObject.RIGHT;
			this.loadGraphic(Assets.playerSprite, true, true, 23, 28);
			
			this.play("stand");
			
			this.maxVelocity.x = 200;
			this.maxVelocity.y = 200;
			this.acceleration.y = 600;
			this.drag.x = int.MAX_VALUE;
			this.waterTiles = waterT;
			this.curPow = 0;
			this.iceCount = 0;
			
			this.playState = playState;
			
			this.ice = new Array();
			// Someone please figure out why the <= is necessary - It's driving me insane and I can't figure out why!?
			for (var i:int = 0; i <= 3; i++) {
				var icePlat:FlxSprite = new FlxSprite();
				icePlat.loadGraphic(Assets.flashSprite);
				icePlat.immovable = true;
				this.ice.push(icePlat);
			}
			
			var tempPlat:FlxSprite = new FlxSprite();
			tempPlat.loadGraphic(Assets.iceSprite);
			tempPlat.immovable = true;
			this.ice[3] = tempPlat;
			
			// Add animations in the space right below this when we get them
			
			// After animations are set, set  facing = RIGHT;
		}
		
		public function getHeight():Number {
			return this.height;
		}
		
		public function getWidth():Number {
			return this.width;
		}
		
		override public function update():void {
			acceleration.x = 0;
			
			if (!bubble) {
				if (FlxG.keys.LEFT || FlxG.keys.A) {
					velocity.x = -maxVelocity.x;
					this.facing = FlxObject.LEFT;
				}
			
				if (FlxG.keys.RIGHT || FlxG.keys.D) {
					velocity.x = maxVelocity.x;
					this.facing = FlxObject.RIGHT;
				}
			
				if ((FlxG.keys.W || FlxG.keys.UP) && isTouching(FlxObject.FLOOR))
					velocity.y = -maxVelocity.y;
			}
			
			if (FlxG.keys.justPressed("SPACE") && !bubble && !superBubble && underwater) {
				usePower(waterTiles, this);
			} else if (FlxG.keys.justPressed("SPACE") && (bubble || superBubble)) {
				popBubble();
			}
			
			if ((bubble || superBubble) && isTouching(FlxObject.CEILING)) {
				popBubble();
			}

			if (getTimer() - this.t1 >= 100 && !isTouching(FLOOR)) {
				this.ice[3].kill();
			}

			if (FlxG.keys.R){
				FlxG.resetState();
			}
			
			// Play the appropriate animation
			if (bubble || superBubble) {
				play("bubble");
			} else {
				if (velocity.y == 0) {
					if (velocity.x == 0) {
						play("stand");
					} else {
						play("walk");
					}
				} else {
					play("jump");
				}
			}
			
			super.update();
		}
		
		public function updatePower(newPower:int):void {
			// Update player's sprite to correct power
			
			switch (newPower) {
				case 1:
					this.curPow = 1;
					break;
				case 2:
					this.curPow = 2;
					break;
				case 3:
					if (this.curPow == 1) this.curPow = 3;
					else if (this.curPow == 2) this.curPow = 4;
					break;
			}
		}
		
		public function usePower(currentWater:FlxTilemap, player:Player):void {
			switch (curPow) {
				// Freeze
				case 1:
					if (!isTouching(FLOOR)) {
						if (!this.ice[3].exists) this.ice[3].reset(this.x, this.y + this.height);
						this.maxVelocity.y = 0;
						playState.iceGroup.add(this.ice[3]);
						
						t1 = getTimer();
					}
					break;
				// Heat
				case 2:
					if (!bubble) {
						velocity.y = -80;
						acceleration.y = 0;
						stat = "used bubble";
						bubble = true;
						superBubble = false;
					}
					break;
				// Flash Freeze
				case 3:
					if (!isTouching(FLOOR)) {
						stat = "flash frozen";
						switch (iceCount % 3) {
							case 0:
								this.ice[0].x = this.x;
								this.ice[0].y = this.y + this.height;
								playState.iceGroup.add(this.ice[0]);
								this.maxVelocity.y = 0;
								break;
							case 1:
								this.ice[1].x = this.x;
								this.ice[1].y = this.y + this.height;
								playState.iceGroup.add(this.ice[1]);
								this.maxVelocity.y = 0;
								break;
							case 2:
								this.ice[2].x = this.x;
								this.ice[2].y = this.y + this.height;
								playState.iceGroup.add(this.ice[2]);
								this.maxVelocity.y = 0;
								break;
						}
						iceCount++;
					}
					break;
				// Flash Heat
				case 4:
					if (!superBubble) {
						bubble = false;
						velocity.y = -80;
						acceleration.y = 0;
						stat = "super bubble";
						superBubble = true;
					}
					//evaporateWater(int(x / 32), int(y / 32));
					break;
			}
		}
		
		public function popBubble():void {
			velocity.y = 0;
			acceleration.y = 600;
			superBubble = false;
			bubble = false;
		}
		
		public function slowSpeed():void {
			this.maxVelocity.x = 150;
			this.maxVelocity.y = 150;
			this.acceleration.y = 300;
			this.underwater = true;
		}
		
		public function normalSpeed():void {
			this.maxVelocity.x = 200;
			this.maxVelocity.y = 200;
			this.acceleration.y = 600;
			this.underwater = false;
		}
				
		/*public function evaporateWater(x:uint, y:uint):void {
			waterTiles.setTile(x, y, 0, true);
			if (waterTiles.getTile(x + 1, y) > 0) {
				evaporateWater(x + 1, y);
			}
			if (waterTiles.getTile(x - 1, y) > 0) {
				evaporateWater(x - 1, y);
			}
			if (waterTiles.getTile(x, y + 1) > 0) {
				evaporateWater(x, y + 1);
			}
			if (waterTiles.getTile(x, y - 1) > 0) {
				evaporateWater(x, y - 1);
			}
		}*/
	}
}
