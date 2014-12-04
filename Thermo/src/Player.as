package {
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import levelgen.*;
	import audio.AudioManager;
	
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	
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
		public var upsideDown:Boolean = false;
		public var bubble:Boolean = false;
		public var underwater:Boolean = false;
		public var floatUp:Boolean = false;
		
		public var waterTiles:FlxTilemap;
		public var hasKey:Boolean = false;
		public var playstate:PlayState;
		
		public var t1:int;
		public var level:Level;
		public var logger:Logging;
		
		private var ice:Array;
		private var iceCount:int;
		
		private var startTime:int;
		
		public var wind:FlxPoint = new FlxPoint;
		
		public var gateOneTouch:Boolean = false;
		
		public function Player(x:Number, y:Number, waterT:FlxTilemap, playstate:PlayState, logger:Logging, level:Level):void{
			super();
			this.logger = logger;
			this.level = level;
			
			const f:uint = 96 * 2;
			const h:uint = 96;
			const n:uint = 96 * 3;
			
			{ //Animations
			// Normal
			this.addAnimation("stand0", [
				0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
				13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25
			], Assets.FRAME_RATE, true);
			this.addAnimation("walk0", [
				26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38,
				39, 40, 41, 42, 43
			], Assets.FRAME_RATE, true);
			this.addAnimation("jump0", [
				44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56,
				57, 58, 59, 60, 61, 62, 63
			], Assets.FRAME_RATE, false);
			this.addAnimation("bubble0", [
				64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76,
				77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89,
				90, 91, 92, 93, 94, 95
			], Assets.FRAME_RATE, true);
			
			// Freeze
			this.addAnimation("stand1", [
				f+0, f+1, f+2, f+3, f+4, f+5, f+6, f+7, f+8, f+9, f+10, f+11, f+12,
				f+13, f+14, f+15, f+16, f+17, f+18, f+19, f+20, f+21, f+22, f+23, f+24, f+25
			], Assets.FRAME_RATE, true);
			this.addAnimation("walk1", [
				f+26, f+27, f+28, f+29, f+30, f+31, f+32, f+33, f+34, f+35, f+36, f+37, f+38,
				f+39, f+40, f+41, f+42, f+43
			], Assets.FRAME_RATE, true);
			this.addAnimation("jump1", [
				f+44, f+45, f+46, f+47, f+48, f+49, f+50, f+51, f+52, f+53, f+54, f+55, f+56,
				f+57, f+58, f+59, f+60, f+61, f+62, f+63
			], Assets.FRAME_RATE, false);
			this.addAnimation("bubble1", [
				f+64, f+65, f+66, f+67, f+68, f+69, f+70, f+71, f+72, f+73, f+74, f+75, f+76,
				f+77, f+78, f+79, f+80, f+81, f+82, f+83, f+84, f+85, f+86, f+87, f+88, f+89,
				f+90, f+91, f+92, f+93, f+94, f+95
			], Assets.FRAME_RATE, true);
			
			// Heat
			this.addAnimation("stand2", [
				h+0, h+1, h+2, h+3, h+4, h+5, h+6, h+7, h+8, h+9, h+10, h+11, h+12,
				h+13, h+14, h+15, h+16, h+17, h+18, h+19, h+20, h+21, h+22, h+23, h+24, h+25
			], Assets.FRAME_RATE, true);
			this.addAnimation("walk2", [
				h+26, h+27, h+28, h+29, h+30, h+31, h+32, h+33, h+34, h+35, h+36, h+37, h+38,
				h+39, h+40, h+41, h+42, h+43
			], Assets.FRAME_RATE, true);
			this.addAnimation("jump2", [
				h+44, h+45, h+46, h+47, h+48, h+49, h+50, h+51, h+52, h+53, h+54, h+55, h+56,
				h+57, h+58, h+59, h+60, h+61, h+62, h+63
			], Assets.FRAME_RATE, false);
			this.addAnimation("bubble2", [
				h+64, h+65, h+66, h+67, h+68, h+69, h+70, h+71, h+72, h+73, h+74, h+75, h+76,
				h+77, h+78, h+79, h+80, h+81, h+82, h+83, h+84, h+85, h+86, h+87, h+88, h+89,
				h+90, h+91, h+92, h+93, h+94, h+95
			], Assets.FRAME_RATE, true);
			
			// Flash Freeze
			this.addAnimation("stand3", [
				f+0, f+1, f+2, f+3, n+4, n+5, n+6, n+7, f+8, f+9, f+10, f+11, n+12,
				n+13, n+14, n+15, f+16, f+17, f+18, f+19, n+20, n+21, n+22, n+23, n+24, f+25
			], Assets.FRAME_RATE, true);
			this.addAnimation("walk3", [
				f+26, f+27, f+28, f+29, n+30, n+31, n+32, n+33, f+34, f+35, f+36, f+37, n+38,
				n+39, n+40, n+41, n+42, f+43
			], Assets.FRAME_RATE, true);
			this.addAnimation("jump3", [
				f+44, f+45, f+46, f+47, n+48, n+49, n+50, n+51, f+52, f+53, f+54, f+55, n+56,
				n+57, n+58, n+59, n+60, n+61, f+62, f+63
			], Assets.FRAME_RATE, false);
			this.addAnimation("bubble3", [
				f+64, f+65, f+66, f+67, n+68, n+69, n+70, n+71, f+72, f+73, f+74, f+75, n+76,
				n+77, n+78, n+79, f+80, f+81, f+82, f+83, n+84, n+85, n+86, n+87, f+88, f+89,
				f+90, f+91, n+92, n+93, n+94, n+95
			], Assets.FRAME_RATE, true);
			
			// Flash Heat
			this.addAnimation("stand4", [
				h+0, h+1, h+2, h+3, n+4, n+5, n+6, n+7, h+8, h+9, h+10, h+11, n+12,
				n+13, n+14, n+15, h+16, h+17, h+18, h+19, n+20, n+21, n+22, n+23, n+24, h+25
			], Assets.FRAME_RATE, true);
			this.addAnimation("walk4", [
				h+26, h+27, h+28, h+29, n+30, n+31, n+32, n+33, h+34, h+35, h+36, h+37, n+38,
				n+39, n+40, n+41, n+42, h+43
			], Assets.FRAME_RATE, true);
			this.addAnimation("jump4", [
				h+44, h+45, h+46, h+47, n+48, n+49, n+50, n+51, h+52, h+53, h+54, h+55, n+56,
				n+57, n+58, n+59, n+60, n+61, h+62, h+63
			], Assets.FRAME_RATE, false);
			this.addAnimation("bubble4", [
				h+64, h+65, h+66, h+67, n+68, n+69, n+70, n+71, h+72, h+73, h+74, h+75, n+76,
				n+77, n+78, n+79, h+80, h+81, h+82, h+83, n+84, n+85, n+86, n+87, h+88, h+89,
				h+90, h+91, n+92, n+93, n+94, n+95
			], Assets.FRAME_RATE, true);}
			
			this.facing = FlxObject.LEFT;
			this.loadGraphic(Assets.playerSprite, true, true, Assets.playerSpriteX, Assets.playerSpriteY);
			
			//Set proper bounding box location and size (19x19)
			this.offset.x = 8;
			this.offset.y = 22;
			width = 19;
			height = 19;
			this.x = x;
			this.y = y - this.height;
			
			this.play("stand" + curPow);
			
			this.maxVelocity.x = 400;
			this.maxVelocity.y = 300;
			this.acceleration.y = 1000;
			this.drag.x = int.MAX_VALUE;
			this.waterTiles = waterT;
			this.curPow = 0;
			this.iceCount = 0;
			
			this.playstate = playstate;
			
			this.ice = new Array();

			for (var i:int = 0; i <= 3; i++) {
				var icePlat:FlxSprite = new FlxSprite();
				
				icePlat.addAnimation("state1", [0]);
				icePlat.addAnimation("state2", [1]);
				icePlat.addAnimation("state3", [2]);
				
				icePlat.loadGraphic(Assets.flashSprite, false, false, 35, 11);
				icePlat.allowCollisions = UP;
				icePlat.immovable = true;
				this.ice.push(icePlat);
			}
			
			var tempPlat:FlxSprite = new FlxSprite();
			tempPlat.loadGraphic(Assets.iceSprite);
			tempPlat.immovable = true;
			this.ice[3] = tempPlat;
			
			startTime = getTimer();
		}
		
		public function getHeight():Number {
			return this.height;
		}
		
		public function getWidth():Number {
			return this.width;
		}
		
		override public function update():void {
			if (!bubble && !floatUp) {
				if (FlxG.keys.LEFT || FlxG.keys.A) {
					velocity.x = -maxVelocity.x;
					this.facing = FlxObject.RIGHT;
				}
				if (FlxG.keys.RIGHT || FlxG.keys.D) {
					velocity.x = maxVelocity.x;
					this.facing = FlxObject.LEFT;
				}
			
				if ((FlxG.keys.justPressed("W") || FlxG.keys.justPressed("UP")) && isTouching(FlxObject.FLOOR)) {
					velocity.y = -maxVelocity.y;
				} else if (FlxG.keys.justReleased("W") || FlxG.keys.justReleased("UP")) {
					if (velocity.y < -200 && velocity.y > -100) {
						velocity.y = -200;
					} else if (velocity.y < -100) {
						velocity.y = -100;
					}
				}
			}
			
			if (FlxG.keys.justPressed("SPACE") && !bubble && !superBubble && underwater) {
				usePower(waterTiles, this);
			} else if (FlxG.keys.justPressed("SPACE") && (bubble || superBubble)) {
				popBubble();
			}
			
			if (bubble && isTouching(FlxObject.CEILING)) {
				popBubble();
			}
			
			// Reverses gravity in superbubble on ceiling
			if (superBubble) {
				if(isTouching(FlxObject.CEILING) || this.y <= 0) {
					floatUp = false;
					acceleration.y = -500;
					this.drag.x = int.MAX_VALUE;
					upsideDown = true;
					if (FlxG.keys.justPressed("W") || FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("S")) {
						velocity.y = maxVelocity.y;
					}
				} else if (FlxG.keys.justReleased("W") || FlxG.keys.justReleased("UP") || FlxG.keys.justReleased("DOWN") || FlxG.keys.justReleased("S")) {
					if (velocity.y > 200 && velocity.y < 100) {
						velocity.y = 200;
					} else if (velocity.y > 100) {
						velocity.y = 100;
					}
				}
				if (upsideDown)
				{					
					// converge to -1 scale if super bubble hit the ceiling
					this.offset.y += (-this.offset.y) / 2;
					this.scale.y += (-1 - this.scale.y) / 2;
				}
			}
			else
			{
				upsideDown = false;
				// converge back to +1 scale
				this.offset.y += (22 - this.offset.y) / 2;
				this.scale.y += (1 - this.scale.y) / 2;
			}
			
			// Makes ice platform solid when in any type of bubble
			if(bubble || superBubble){
				for(var i:int = 0; i < 3; i++){
					this.ice[i].solid = true;
				}
			}
			else{
				for(var j:int = 0; j < 3; j++){
					this.ice[j].allowCollisions = UP;
				}
			}

			// Kills the ice platforms 
			if (getTimer() - this.t1 >= 100 && (!isTouching(FLOOR) || FlxG.keys.justPressed("SPACE"))) {
				this.ice[3].kill();
			}

			// Play the appropriate animation
			if (bubble || superBubble) {
				play("bubble" + curPow);
			} else {
				if (velocity.y == 0) {
					if (velocity.x == 0) {
						play("stand" + curPow);
					} else {
						play("walk" + curPow);
					}
				} else {
					if (_curAnim.name != "jump" + curPow)
						play("jump" + curPow);
				}
			}
			
			// Get affected by wind
			velocity.x += wind.x;
			velocity.y += wind.y;
			wind.x = 0;
			wind.y = 0;
			
			super.update();
		}
		
		public function updatePower(newPower:int):void {
			// Update player's sprite to correct power
			switch (newPower) {
				case 0:
					if (curPow != 0) {
						AudioManager.PlaySound(Assets.sfx_gate);
						logger.recordEvent(level.levelNum, 1, "v2 $ " + this.x +  "$ " + this.y + " $ "  + getTimer().toString() + "$");
					}
					this.curPow = 0;
					break;
				case 1:
					if (curPow != 1) {
						AudioManager.PlaySound(Assets.sfx_freezegate);
						logger.recordEvent(level.levelNum, 1, "v2 $ " + this.x +  "$ " + this.y + " $ "  +  getTimer().toString() + "$");
					}
					this.curPow = 1;
					break;
				case 2:
					if (curPow != 2) {
						AudioManager.PlaySound(Assets.sfx_heatgate);
						logger.recordEvent(level.levelNum, 1, "v2 $ " + this.x +  "$ " + this.y + " $ "  +  getTimer().toString() + "$");
					}
					this.curPow = 2;
					break;
				case 3:
					if (this.curPow == 1) {
						this.curPow = 3;
						AudioManager.PlaySound(Assets.sfx_flashgate);
						logger.recordEvent(level.levelNum, 1, "v2 $ " + this.x +  "$ " + this.y + " $ "  +  getTimer().toString()+ "$");
					}
					else if (this.curPow == 2) {
						AudioManager.PlaySound(Assets.sfx_flashgate);
						logger.recordEvent(level.levelNum, 1, "v2 $ " + this.x +  "$ " + this.y + " $ "  +  getTimer().toString()+ "$");
						this.curPow = 4;
					}
					break;
				case 4:
					if (this.curPow != 0) {
						AudioManager.PlaySound(Assets.sfx_neutralgate);
					}
					this.curPow = 0;
					break;
			}
		}
		
		public function usePower(currentWater:FlxTilemap, player:Player):void {
			switch (curPow) {
				// Freeze
				case 1:
					if (!isTouching(FLOOR)) {
						AudioManager.PlaySound(Assets.sfx_ice);
						if (!this.ice[3].exists) this.ice[3].reset(this.x, this.y + this.height);
						this.maxVelocity.y = -10;
						playstate.iceGroup.add(this.ice[3]);
						logger.recordEvent(level.levelNum, 0, "v2 $ " + this.x +  "$ " + this.y + " $ "  +  getTimer().toString()+ "$");
						t1 = getTimer();
					}
					break;
				// Heat
				case 2:
					if (!bubble) {
						AudioManager.PlaySound(Assets.sfx_bubble);
						player.drag.x = 900;
						acceleration.y = -500;
						bubble = true;
						superBubble = false;
						logger.recordEvent(level.levelNum, 0, "v2 $ " + this.x +  "$ " + this.y + " $ "  +  getTimer().toString()+ "$");

					}
					break;
				// Flash Freeze
				case 3:
					if (!isTouching(FLOOR)) {
						AudioManager.PlaySound(Assets.sfx_ice);
						switch (iceCount % 3) {
							case 0:
								this.ice[0].x = this.x;
								this.ice[0].y = this.y + this.height;
								playstate.iceGroup.add(this.ice[0]);
								this.maxVelocity.y = 0;
								this.ice[0].play("state1");
								this.ice[1].play("state3");
								this.ice[2].play("state2");
								break;
							case 1:
								this.ice[1].x = this.x;
								this.ice[1].y = this.y + this.height;
								playstate.iceGroup.add(this.ice[1]);
								this.maxVelocity.y = 0;
								this.ice[0].play("state2");
								this.ice[1].play("state1");
								this.ice[2].play("state3");
								break;
							case 2:
								this.ice[2].x = this.x;
								this.ice[2].y = this.y + this.height;
								playstate.iceGroup.add(this.ice[2]);
								this.maxVelocity.y = 0;
								this.ice[0].play("state3");
								this.ice[1].play("state2");
								this.ice[2].play("state1");
								break;
						}
						logger.recordEvent(level.levelNum, 0, "v2 $ " + this.x +  "$ " + this.y + " $ "  +  getTimer().toString()+ "$");
						iceCount++;
					}
					break;
				// Flash Heat
				case 4:
					if (!superBubble) {
						AudioManager.PlaySound(Assets.sfx_bubble);
						bubble = false;
						player.drag.x = 900;
						acceleration.y = -500;
						superBubble = true;
						floatUp = true;
						logger.recordEvent(level.levelNum, 0, "v2 $ " + this.x +  "$ " + this.y + " $ "  +  getTimer().toString()+ "$");
					}
					break;
			}
		}
		
		public function popBubble():void {
			AudioManager.PlaySound(Assets.sfx_bubblepop);
			velocity.y = 0;
			acceleration.y = 600;
			superBubble = false;
			bubble = false;
			floatUp = false;
		}
		
		public function enterWater():void {
			if (!underwater) {
				AudioManager.PlaySound(Assets.sfx_splash);
			}
			underwater = true;
			if (!bubble && !superBubble) {
				slowSpeed();
			}
		}
		
		public function exitWater():void {
			if (underwater) {
				AudioManager.PlaySound(Assets.sfx_splash_out);
			}
			underwater = false;
			if (!bubble && !superBubble) {
				normalSpeed();
			}
		}
		
		public function slowSpeed():void {
			this.maxVelocity.x = 250;
			this.maxVelocity.y = 250;
			this.acceleration.y = 400;
			this.drag.x = int.MAX_VALUE;
		}
		
		public function normalSpeed():void {
			this.maxVelocity.x = 400;
			this.maxVelocity.y = 300;
			this.acceleration.y = 1000;
			this.drag.x = int.MAX_VALUE;
		}
		
		public function setX(x:int):void {
			this.x = x;
		}
		
		public function setY(y:int):void {
			this.y = y;
		}
	}
}
