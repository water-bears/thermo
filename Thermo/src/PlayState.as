package {
	import Logging;
	
	import context.BubbleBackground;
	import context.LevelSelectState;
	import context.TransitionState;
	
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.utils.getTimer;
	
	import levelgen.*;
	
	import org.flixel.*;
	
	import uilayer.LevelUI;
	
	//import org.flintparticles.twoD.renderers.DisplayObjectRenderer;
	
	public class PlayState extends FlxState {
		/* Action identifiers for //logger:
		0 = used a power
		1 = went through a power gate
		2 = retrieved a key
		3 = completed the level
		4 = died
		5 = reset level
		6 = went to level select screen
		*/
		public var logger:Logging;
		private var startTime:int;
		
		// Checking if we have JUST lost
		public var alreadyLost:Boolean = false;
		
		// This is for checking when we JUST entered the water
		public var justEntered:Boolean = false;
		
		private var background:FlxSprite;
		
		private var player:Player;
		
		// Groups that will allow us to make gate and water tiles
		public var waterTiles:FlxTilemap;
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
		public var movingGroup:FlxGroup = new FlxGroup;
		
		// Group for ice blocks
		public var iceGroup:FlxGroup = new FlxGroup(4);
		
		// This is currently being used as a method of debugging
		public var status:FlxText;
		private var ui:LevelUI;
		
		public var BLUE:uint = 0x0000FF;
		public var RED:uint = 0x00FF00FF;
		public var GREEN:uint = 0x00FF00;
		public var WHITE:uint = 0xffffffff;
		public var BLACK:uint = 0x000000;
		
		private var level:Level;
		
		private const FREEZE:int = 1;
		private const HEAT:int = 2;
		private const FLASH:int = 3;
		
		public var bubbles:BubbleBackground;
		//private var pb:PixelBubbleSystem;
		
		public function setLevel(inputLevel:Level): void {
			level = inputLevel;
		}
		
		public function PlayState(logger:Logging) {
			this.logger=logger;
		}
		
		override public function create():void {
			// Make the background
			if (background == null)
				setBackground(0);
			add(background);
			
			// Initialize bubbles
			bubbles = new BubbleBackground(new FlxPoint(FlxG.width, FlxG.height), 40, 8, 12);
			bubbles.Register(this);
			
			//load the level
			if (level == null) {
				level = new Level(1);
			}

			//add the background sprites
			add(level.backSprites);
			
			//add the ground
			groundTiles = level.ground;
			add(groundTiles);
			
			//add the water
			waterTiles = level.water;
			// adding the water after player to make it feel like player is really in the wate
			
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
			
			//spikes
			spikeGroup = level.spikes;
			add(spikeGroup);
			
			movingGroup = level.movingplatforms;
			add(movingGroup);
			
			if (level.trapdoor != null) {
				solidGroup.add(level.trapdoor);
				if (level.button != null) {
					buttonGroup.add(level.button);
					add(buttonGroup);
				}
			}
			
			add(solidGroup);
			
			//add the front sprites
			add(level.frontSprites);
			
			// Display a message that TAB takes you to the level select screen.
			var levelSelectMessage:FlxText = new FlxText(0, FlxG.height - 25, 200, "Press TAB to go to level select screen\nPress SPACE to use power");
			levelSelectMessage.setOriginToCorner();
			levelSelectMessage.scale = new FlxPoint(1, 1);
			add(levelSelectMessage);
			// Create and add the player
			if (level.player == null) {
				player = new Player(0, 0, waterTiles, this, logger, level);  //logger);
			} else {
				player = new Player(level.player.x, level.player.y, waterTiles, this, logger, level); //logger);
			}
			//pb = new PixelBubbleSystem(20, player);
			//add(pb);
			add(player);
			add(waterTiles);
			
			this.add(iceGroup);
			
			/*var emitter:ParticleEffects = new ParticleEffects();

			var renderer:DisplayObjectRenderer = new DisplayObjectRenderer();
			renderer.addEmitter(emitter);
			
			var rend:FlxSprite = new FlxSprite();
			rend.framePixels.draw(renderer);
			emitter.start();
			emitter.runAhead(10);
			FlxG.stage.addChild(renderer);*/
			
			startTime = getTimer();
			
			// Create and add the UI layer
			// This NEEDS to be last. Otherwise objects will linger when the screen fades out.
			ui = new LevelUI(level.levelNum);
			add(ui);
		}
		
		override public function update():void {
			super.update();
			
			bubbles.Update();
			
			// Make Player Collide With Level
			FlxG.collide(groundTiles, player);
			FlxG.collide(iceGroup, player);
			FlxG.collide(solidGroup, player);
			FlxG.collide(movingGroup, player);
			
			// Make Keys Collide With level
			FlxG.collide(groundTiles, keyGroup);
			FlxG.collide(iceGroup, keyGroup);
			FlxG.collide(solidGroup, keyGroup);
			
			// Uncomment this when we have this tileMap set up
			//FlxG.collide(movingPlatTiles, player);
			
			if (player.x < 0) {
				player.setX(0);
			} else if (player.x > Thermo.WIDTH-player.width) {
				player.setX(Thermo.WIDTH-player.width);
			}
			
			if (player.y <= 0 && !player.superBubble && player.bubble) {
				player.popBubble();
			} else if (player.y < 0) {
				player.setY(0);
				player.velocity.y = 0;
			}
			
			if (player.overlaps(waterTiles) && player.overlapsAt(player.x, player.y + player.getHeight() - 1, waterTiles) && (!player.bubble && !player.superBubble)) {
				player.slowSpeed();
				if(justEntered == false) {
					justEntered = true;
					//logger.recordEvent(level.levelNum, 0, "version 1 $ (" + player.x +  ", " + player.y + ") + $ $ time = " + (getTimer() - startTime).toString());
				}
			} else if (!player.bubble && !player.superBubble) {
				player.normalSpeed();
				justEntered = false;
			}
			
			var i:int;
			
			// Receive key 
			if (FlxG.overlap(keyGroup, player)) {
				for (i = 0; i < exitGroup.members.length; i++) {
					(exitGroup.members[i] as Door).open();
				}
				getKey(keyGroup, player);
			}
			
			// Calls getGate function when we touch/cross/etc. a gate
			for (i = 0; i < freezeGroup.members.length; i++) {
				if (FlxG.overlap(freezeGroup.members[i], player)) {
					(freezeGroup.members[i] as Gate).trigger();
					player.gateOneTouch = true;
					player.updatePower(Gate.FREEZE);
				} else {
					(freezeGroup.members[i] as Gate).untrigger();
					player.gateOneTouch = false;
				}
			}
			
			for (i = 0; i < heatGroup.members.length; i++) {
				if (FlxG.overlap(heatGroup.members[i], player)) {
					(heatGroup.members[i] as Gate).trigger();
					player.gateOneTouch = true;
					player.updatePower(Gate.HEAT);
				} else {
					(heatGroup.members[i] as Gate).untrigger();
					player.gateOneTouch = false;
				}
			}
							
			for (i = 0; i < flashGroup.members.length; i++) {
				if (FlxG.overlap(flashGroup.members[i], player)) {
					(flashGroup.members[i] as Gate).trigger();
					player.gateOneTouch = true;
					player.updatePower(Gate.FLASH);
				} else {
					(flashGroup.members[i] as Gate).untrigger();
					player.gateOneTouch = false;
				}
			}
							
			for (i = 0; i < neutralGroup.members.length; i++) {
				if (FlxG.overlap(neutralGroup.members[i], player)) {
					(neutralGroup.members[i] as Gate).trigger();
					player.gateOneTouch = true;
					player.updatePower(Gate.NEUTRAL);
				} else {
					(neutralGroup.members[i] as Gate).untrigger();
					player.gateOneTouch = false;
				}
			}
							
			if (FlxG.overlap(buttonGroup, player)) {
				for (i = 0; i < buttonGroup.members.length; i++) {
					if (FlxG.overlap(buttonGroup.members[i], player)) {
						(buttonGroup.members[i] as Button).pushed();
					}
				}
			}
			
			if (FlxG.keys.SPACE || FlxG.keys.ENTER) {
				ui.FastForward();
			}
			
			// If player has the key and touches the exit, they win
			if (player.hasKey && FlxG.overlap(exitGroup, player)) {
				player.visible = false;
				logger.recordEvent(level.levelNum, 3, "v2 $ $ win $ time = " + getTimer().toString());
				logger.recordLevelEnd();
				win(exitGroup, player);
			}
			
			//Check for player lose conditions
			if (player.y > FlxG.height || FlxG.overlap(player, spikeGroup)) {
				if(alreadyLost == false){
				logger.recordEvent(level.levelNum, 4, "v2 $ $ lose $ time =" + (startTime - getTimer()).toString());
				logger.recordLevelEnd();
				alreadyLost == true;
				}
				ui.BeginExitSequence(reset);
				player.visible = false;
			}
			if(FlxG.keys.R){
				logger.recordEvent(level.levelNum, 5, "v2 $ $ reset $ time =" + (startTime - getTimer()).toString());
				logger.recordLevelEnd();
				ui.BeginExitSequence(reset);
				player.visible = false;
			}
			
			//Tab for level select
			if (FlxG.keys.ESCAPE) {
				logger.recordEvent(level.levelNum, 6, "v2 $ $ levelSelect $ time =" + (startTime - getTimer()).toString());
				logger.recordLevelEnd();
				ui.BeginExitSequence(levelSelect);
			}
		}
		
		/** when player retrieves key **/
		public function getKey(key:FlxGroup, player:Player):void {
			key.kill();
			player.hasKey = true;
			logger.recordEvent(level.levelNum, 2, "v2 $ $ key retreival $ time = " + getTimer().toString());
		}
		
		/** Win function **/
		public function win(Exit:FlxGroup, player:Player):void {
			ui.BeginExitSequence(goToNextLevel);
		}
		
		public function goToNextLevel() : void {
			FlxG.switchState(new TransitionState(level.levelNum + 1, logger, level.levelNum));
		}
		
		/** Reset function **/
		public function reset():void {
			//logger.recordEvent(level.levelNum, 4, "version 1 $ $ reset level $ time =" + (startTime - getTimer()).toString());
			//logger.recordLevelEnd();
			FlxG.switchState(new TransitionState(level.levelNum, logger, level.levelNum));
		}
		
		/** Level select function **/
		public function levelSelect():void {
			FlxG.switchState(new TransitionState(0, logger, level.levelNum));
		}
		
		/** Sets the background based on the level index **/
		public function setBackground(level:int):void {
			level = (level - 1) % Assets.b_list.length;
			
			if (background == null) {
				background = new FlxSprite(0, 0);
			}
			
			background.loadGraphic(Assets.b_list[level]);
			
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
