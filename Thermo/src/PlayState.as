package {
	import Logging;
	
	import audio.AudioManager;
	
	import context.BubbleBackground;
	import context.LevelSelectState;
	import context.TransitionState;
	
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import io.ThermoSaves;
	
	import levelgen.*;
	
	import org.flixel.*;
	
	import uilayer.LevelServices;
	import uilayer.LevelUI;
	import uilayer.Utils;
	
	import water.WaterWaves;
		
	public class PlayState extends FlxState {
		/* Action identifiers for //logger:
		0 = used power
		1 = went through a power gate
		2 = retrieved a key
		3 = completed the level
		4 = lose
		5 = reset
		6 = level select
		7 = 1s pulling
		8 = skipped level
		*/
		
		public var logger:Logging;
		private var startTime:int;
		private var pullTimer:Timer = new Timer(1000);	
		public var prevPosition:Point;
		public var curPosition:Point = new Point(0,0);
		
		// Checking if we have JUST lost
		public var alreadyLost:Boolean = false;
		
		private var background:FlxSprite;
		
		private var player:Player;
		private var goldenBubble:FlxSprite;
		
		// Groups that will allow us to make gate and water tiles
		public var waterTiles:FlxTilemap;
		private var waterWaves:WaterWaves;
		public var groundTiles:FlxTilemap;
		
		public var freezeGroup:FlxGroup = new FlxGroup;
		public var heatGroup:FlxGroup = new FlxGroup;
		public var flashGroup:FlxGroup = new FlxGroup;
		public var neutralGroup:FlxGroup = new FlxGroup;
		public var exitGroup:FlxGroup = new FlxGroup;
		public var keyGroup:FlxGroup = new FlxGroup;
		public var buttonGroup:FlxGroup = new FlxGroup;
		public var solidGroup:FlxGroup = new FlxGroup;
		public var spikeGroup:FlxGroup = new FlxGroup;
		public var hotlavaGroup:FlxGroup = new FlxGroup;
		public var coldlavaGroup:FlxGroup = new FlxGroup;
		public var movingGroup:FlxGroup = new FlxGroup;
		public var windGroup:FlxGroup = new FlxGroup;
		
		// Group for ice blocks
		public var iceGroup:FlxGroup = new FlxGroup(4);
		
		private var ui:LevelUI;
		
		private var level:Level;
		
		private const FREEZE:int = 1;
		private const HEAT:int = 2;
		private const FLASH:int = 3;
		
		public var bubbles:BubbleBackground;
		
		private var key_spacebar:FlxSprite = new FlxSprite();
		private var spacebar_playing:Boolean = false;
		private var key_arrows:FlxSprite = new FlxSprite();
		private var arrows_playing:Boolean = false;
		
		public function setLevel(inputLevel:Level):void {
			level = inputLevel;
		}
		
		public function PlayState(logger:Logging) {
			this.logger = logger;
		}
		
		override public function create():void {
			AudioManager.PlaySound(Assets.sfx_wave);
			
			// timer
			pullTimer.addEventListener(TimerEvent.TIMER, pullTimerListener);
			pullTimer.start();
			
			// Make the background
			if (background == null)
				setBackground(0);
			add(background);
			
			// Initialize bubbles
			bubbles = new BubbleBackground(new FlxPoint(FlxG.width, FlxG.height), 40, 8, 12);
			bubbles.Register(this);
			
			//load the level
			if (level == null) {
				level = new Level(0);
			}

			//add the background sprites
			add(level.backSprites);
			
			//add the ground
			groundTiles = level.ground;
			
			//add the water
			waterTiles = level.water;
			waterWaves = new WaterWaves(waterTiles);
			
			//add the gates
			freezeGroup = level.freezeGates;
			add(freezeGroup);
			
			heatGroup = level.heatGates;
			add(heatGroup);
			
			flashGroup = level.flashGates;
			add(flashGroup);
			
			neutralGroup = level.neutralGates;
			add(neutralGroup);
			
			//add the exit
			exitGroup = level.exits;
			add(exitGroup);
			
			//add the keys
			keyGroup = level.keys;
			add(keyGroup);
			
			//spikes and lava
			spikeGroup = level.spikes;
			add(spikeGroup);
			
			hotlavaGroup = level.hotlava;
			add(hotlavaGroup);
			
			coldlavaGroup = level.coldlava;
			add(coldlavaGroup);
			
			movingGroup = level.movingplatforms;
			add(movingGroup);
			
			if (level.trapdoor != null) {
				solidGroup.add(level.trapdoor);
				if (level.button != null) {
					buttonGroup.add(level.button);
					add(buttonGroup);
				}
			}
			
			//wind
			windGroup = level.winds;
			add(windGroup);
			
			add(solidGroup);
			
			// Create and add the player
			if (level.player == null) {
				player = new Player(0, 0, waterTiles, this, logger, level);  //logger);
			} else {
				player = new Player(level.player.x, level.player.y, waterTiles, this, logger, level); //logger);
			}
			goldenBubble = new FlxSprite(player.x, player.y, Assets.goldenBubbleSprite);
			goldenBubble.alpha = 0.5;
			goldenBubble.visible = false;
			
			prevPosition = new Point(player.x, player.y);


			//Order matters - Add water after player and ground after water for layering effect
			add(player);
			add(goldenBubble);
			add(waterWaves);
			add(groundTiles);
			add(iceGroup);
			
			//add the front sprites
			add(level.frontSprites);
			startTime = getTimer();
			
			//if (level.levelNum == 0) logger.recordEvent(0, 9, "$ $ $ $ " + Level.ab);
			
			// Create and add the UI layer
			// This NEEDS to be last. Otherwise objects will linger when the screen fades out.
			ui = new LevelUI(level, logger);
			ui.SetSelectCallback(1, reset);
			ui.SetSelectCallback(2, levelSelect);
			AudioManager.SetFade(AudioManager.OUTSIDE_WATER);
			// add(ui);
		}
		
		override public function update():void {
			if (!ui.IsPaused()) {
				super.update();
				bubbles.Update();
				
				waterWaves.PlayerPosition.x = player.x + player.width / 2;
				waterWaves.PlayerPosition.y = player.y + player.height / 2;
				waterWaves.PlayerInWater = player.underwater;
				
				// Make Player Collide With Level
				FlxG.collide(groundTiles, player);
				FlxG.collide(iceGroup, player);
				FlxG.collide(solidGroup, player);
				FlxG.collide(movingGroup, player);
				
				// Make Keys Collide With level
				FlxG.collide(groundTiles, keyGroup);
				FlxG.collide(iceGroup, keyGroup);
				FlxG.collide(solidGroup, keyGroup);
				
				if (player.x < 0) {
					player.setX(0);
				} else if (player.x > Thermo.WIDTH - player.width) {
					player.setX(Thermo.WIDTH - player.width);
				}
				
				if (player.y <= 0 && !player.superBubble && player.bubble) {
					player.popBubble();
				} else if (player.y < 0) {
					player.setY(0);
					player.velocity.y = 0;
				}
				
				var playerPowerPoint:FlxPoint = new FlxPoint(player.x + player.width / 2, player.y + player.getHeight() - 1);
				if (player.overlaps(waterTiles) && playerPowerPoint.y < 480 && waterTiles.overlapsPoint(playerPowerPoint)) {
					player.enterWater();
				} else {
					player.exitWater();
				}
				
				var i:int;
				
				if (FlxG.overlap(keyGroup, player)) {
					for (i = 0; i < exitGroup.length; i++) {
						(exitGroup.members[i] as Door).open();
					}
					getKey(keyGroup, player);
				}
				
                // Get affected by winds
                for (i = 0; i < windGroup.length; i++) {
                    if (FlxG.overlap(windGroup.members[i], player)) {
                        (windGroup.members[i] as Wind).blow(player);
                    }
                }
                
                // Calls getGate function when we touch/cross/etc. a gate
                for (i = 0; i < freezeGroup.length; i++) {
                    if (FlxG.overlap(freezeGroup.members[i], player)) {
                        (freezeGroup.members[i] as Gate).trigger();
                        player.gateOneTouch = true;
                        player.updatePower(Gate.FREEZE);
                    } else {
                        (freezeGroup.members[i] as Gate).untrigger();
                        player.gateOneTouch = false;
                    }
                }
                
                for (i = 0; i < heatGroup.length; i++) {
                    if (FlxG.overlap(heatGroup.members[i], player)) {
                        (heatGroup.members[i] as Gate).trigger();
                        player.gateOneTouch = true;
                        player.updatePower(Gate.HEAT);
                    } else {
                        (heatGroup.members[i] as Gate).untrigger();
                        player.gateOneTouch = false;
                    }
                }
                                
                for (i = 0; i < flashGroup.length; i++) {
                    if (FlxG.overlap(flashGroup.members[i], player)) {
                        (flashGroup.members[i] as Gate).trigger();
                        player.gateOneTouch = true;
                        player.updatePower(Gate.FLASH);
                    } else {
                        (flashGroup.members[i] as Gate).untrigger();
                        player.gateOneTouch = false;
                    }
                }
                                
                for (i = 0; i < neutralGroup.length; i++) {
                    if (FlxG.overlap(neutralGroup.members[i], player)) {
                        (neutralGroup.members[i] as Gate).trigger();
                        player.gateOneTouch = true;
                        player.updatePower(Gate.NEUTRAL);
                    } else {
                        (neutralGroup.members[i] as Gate).untrigger();
                        player.gateOneTouch = false;
                    }
                }
				
				// comment this out if we want the superbubble to have this overlay
				/*if (player.superBubble)
				{
					goldenBubble.visible = true;
					goldenBubble.x = player.x - player.offset.x;
					goldenBubble.y = player.y - player.offset.y;
					goldenBubble.scale.y = player.scale.y;
				}
				else
				{
					goldenBubble.visible = false;
				}*/
                
                if (FlxG.overlap(buttonGroup, player)) {
                    for (i = 0; i < buttonGroup.length; i++) {
                        if (FlxG.overlap(buttonGroup.members[i], player)) {
                            (buttonGroup.members[i] as Button).pushed();
                        }
                    }
                }
				
				if (player.visible)
				{
					// If player has the key and touches the exit, they win
					if (player.hasKey && FlxG.overlap(exitGroup, player)) {
						player.visible = false;
						win(exitGroup, player);
					}
					
					//Check for player lose conditions
					if (player.y > (FlxG.height + 50) || FlxG.overlap(player, spikeGroup)) {
						pullTimer.removeEventListener(TimerEvent.TIMER, pullTimerListener);
						ui.BeginExitSequence(lose);
						player.visible = false;
					}
					if (FlxG.keys.R && player.visible){
						pullTimer.removeEventListener(TimerEvent.TIMER, pullTimerListener);
						ui.BeginExitSequence(reset);
						player.visible = false;
					}
					
					//Check for player lose conditions specific for lava
					if (FlxG.overlap(player, hotlavaGroup) && (player.curPow != 2 && player.curPow != 4)) {
						pullTimer.removeEventListener(TimerEvent.TIMER, pullTimerListener);
						ui.BeginExitSequence(lose);
						player.visible = false;	
					}
					
					if (FlxG.overlap(player, coldlavaGroup) && (player.curPow != 1 && player.curPow != 3)) {
						pullTimer.removeEventListener(TimerEvent.TIMER, pullTimerListener);
						ui.BeginExitSequence(lose);
						player.visible = false;	
					}
				}
				
				/**
				 * Flash the spacebar above the player's head if we meet the correct conditions
				 */
				if (level.levelNum == 1 && player.curPow == 2 && !player.bubble && !spacebar_playing && player.overlaps(waterTiles)) {
					key_spacebar.addAnimation("flash", [0, 0, 1], Assets.FRAME_RATE / 10, true);
					key_spacebar.loadGraphic(Assets.spacebarSprite, true, false, 64, 20);
					key_spacebar.play("flash");
					key_spacebar.x = player.x + player.width/2 - key_spacebar.width/2;
					key_spacebar.y = player.y - player.height - key_spacebar.height;
					this.add(key_spacebar);
					spacebar_playing = true;
				} else if (level.levelNum == 1 && spacebar_playing && !player.bubble && player.overlaps(waterTiles)) {
					key_spacebar.x = player.x + player.width/2 - key_spacebar.width/2;
					key_spacebar.y = player.y - player.height - key_spacebar.height;
				} else if (level.levelNum == 1 && spacebar_playing && player.bubble) {
					//key_spacebar.kill();
					this.remove(key_spacebar);
					spacebar_playing = false;
				}
				
				/**
				 * Flash the spacebar above the player's head if we meet the correct conditions
				 */
				if (level.levelNum == 2 && player.curPow == 1 && !spacebar_playing && player.overlaps(waterTiles)) {
					key_spacebar.addAnimation("flash", [0, 0, 1], Assets.FRAME_RATE / 10, true);
					key_spacebar.loadGraphic(Assets.spacebarSprite, true, false, 64, 20);
					key_spacebar.play("flash");
					key_spacebar.x = player.x + player.width/2 - key_spacebar.width/2;
					key_spacebar.y = player.y - player.height - key_spacebar.height;
					this.add(key_spacebar);
					spacebar_playing = true;
				} else if (level.levelNum == 2 && spacebar_playing && iceGroup.length == 0 && player.overlaps(waterTiles)) {
					key_spacebar.x = player.x + player.width/2 - key_spacebar.width/2;
					key_spacebar.y = player.y - player.height - key_spacebar.height;
				} else if (level.levelNum == 2 && spacebar_playing && iceGroup.length > 0) {
					key_spacebar.kill();
					//this.remove(key_spacebar);
					spacebar_playing = false;
				}
				
				/**
				 * Flash the arrows above the player's head if we meet the correct conditions
				 */
				if (level.levelNum == 0 && !arrows_playing) {
					key_arrows.addAnimation("flash", [0, 0, 2, 1, 1, 2], Assets.FRAME_RATE / 10, true);
					key_arrows.loadGraphic(Assets.arrowsSprite, true, false, 60, 40);
					key_arrows.play("flash");
					key_arrows.x = player.x + player.width/2 - key_spacebar.width/2;
					key_arrows.y = player.y - player.height - key_spacebar.height;
					this.add(key_arrows);
					arrows_playing = true;
				} else if (level.levelNum == 0 && arrows_playing && !player.overlaps(waterTiles)) {
					key_arrows.x = player.x + player.width/2 - key_arrows.width/2;
					key_arrows.y = player.y - player.height - key_arrows.height;
				} else if (level.levelNum == 0 && arrows_playing && player.overlaps(waterTiles)) {
					key_arrows.kill();
					//this.remove(key_arrows);
					arrows_playing = false;
				}
			}
			
			//Needs to be at the bottom so that the player actually dies
			FlxG.collide(hotlavaGroup, player);
			FlxG.collide(coldlavaGroup, player);
			
			ui.update();
			AudioManager.SetFade(AudioManager.GetFade() + (player.underwater ? AudioManager.INSIDE_WATER : AudioManager.OUTSIDE_WATER) * 0.1);
		}
		
		override public function draw():void {
			super.draw();
			ui.draw();
		}
		
		/** when player retrieves key **/
		public function getKey(key:FlxGroup, player:Player):void {
			key.kill();
			AudioManager.PlaySound(Assets.sfx_key);
			AudioManager.PlaySound(Assets.sfx_door);
			player.hasKey = true;
			logger.recordEvent(level.levelNum, 2, "v2 $ $  $ " + getTimer().toString() + "$");
		}
		
		/** Win function **/
		public function win(Exit:FlxGroup, player:Player):void {
			ThermoSaves.MarkLevelAsCleared(level.levelNum);
			ui.BeginExitSequence(goToNextLevel);
		}
		
		public function goToNextLevel() : void {			
			logger.recordEvent(level.levelNum, 3, "v2 $ " + player.x +  "$ " + player.y + " $ "  +  getTimer().toString());
			logger.recordLevelEnd();
			pullTimer.removeEventListener(TimerEvent.TIMER, pullTimerListener);
			FlxG.switchState(new TransitionState(LevelServices.NextLevel(level.levelNum), logger, level.levelNum));
		}
		
		/** Reset function **/
		public function lose():void {
			logger.recordEvent(level.levelNum, 4, "v2 $ " + player.x +  "$ " + player.y + " $ "  +  getTimer().toString());
			logger.recordLevelEnd();
			pullTimer.removeEventListener(TimerEvent.TIMER, pullTimerListener);
			FlxG.switchState(new TransitionState(level.levelNum, logger, level.levelNum));
		}
		
		/** Reset function **/
		public function reset():void {
			logger.recordEvent(level.levelNum, 5, "v2 $ " + player.x +  "$ " + player.y + " $ "  +  getTimer().toString());
			logger.recordLevelEnd();
			pullTimer.removeEventListener(TimerEvent.TIMER, pullTimerListener);
			FlxG.switchState(new TransitionState(level.levelNum, logger, level.levelNum));
		}
		
		/** Level select function **/
		public function levelSelect():void {
			pullTimer.removeEventListener(TimerEvent.TIMER, pullTimerListener);
			FlxG.switchState(new TransitionState(-1, logger, level.levelNum));
		}
		
		/** logs at 1 s intervals based on pullTimer 
		 * Records where the player is and at what time **/
		public function pullTimerListener(e:TimerEvent):void {
			curPosition = new Point(player.x, player.y);
			if(curPosition.x != prevPosition.x && curPosition.y != prevPosition.y){
				logger.recordEvent(level.levelNum, 7, "v2 $ " + player.x +  "$ " + player.y + " $ "  + getTimer().toString());
				prevPosition = curPosition;
			}
			
		}
		
		/** Sets the background based on the level index **/
		public function setBackground(level:int):void {
			level = level % Assets.b_list.length;
			
			if (background == null) {
				background = new FlxSprite(0, 0);
			}
			
			background.loadGraphic(Assets.b_list[level]);
			
			var tints:Array = [
				// Row 1
				0x00BBBBBB, // Black
				// Row 2
				0x00FFFFFF, // Purple
				// Row 3
				0x00DDFFEE, // Green
				// Row 4
				0x00FFFFBB, // Yellow
				// Row 5
				0x00FFFFFF, // No change
				// Row S
				0x00FFFFFF, // No change
			];
				
			background.color = tints[(int)(level / 5)];
			
			// Scale and reposition background
			background.x -= background.width / 2;
			background.y -= background.height / 2;
			
			background.scale.x = FlxG.width / background.width;
			background.scale.y = FlxG.height / background.height;
			
			background.x += background.width * background.scale.x / 2;
			background.y += background.height * background.scale.y / 2;
		}
	}
}
