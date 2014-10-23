package {
	import context.LevelSelectState;
	
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import context.TransitionState;
	import levelgen.*;
	
	import org.flixel.*;
	
	public class PlayState extends FlxState {
		private var background:FlxSprite;
		
		private var player:Player;
		
		// Groups that will allow us to make gate and water tiles
		public var waterTiles:FlxTilemap;
		public var groundTiles:FlxTilemap;
		
		public var freezeGroup:FlxGroup;
		public var heatGroup:FlxGroup;
		public var flashGroup:FlxGroup;

		public var exitGroup:FlxGroup;
		public var keyGroup:FlxGroup;
		
		public var spikeTiles:FlxTilemap;
		public var movingPlatTiles:FlxTilemap;
		
		public var spikeTest:FlxSprite;
		
		// Group for ice blocks
		public var iceGroup:FlxGroup = new FlxGroup(4);
		
		// This is currently being used as a method of debugging
		public var status:FlxText;
		
		public var BLUE:uint = 0x0000FF;
		public var RED:uint = 0x00FF00FF;
		public var GREEN:uint = 0x00FF00;
		public var WHITE:uint = 0xffffffff;
		public var BLACK:uint = 0x000000;
		
		private var level:Level;
		
		private const FREEZE:int = 1;
		private const HEAT:int = 2;
		private const FLASH:int = 3;
		
		public function setLevel(inputLevel:Level): void {
			level = inputLevel;
		}
		
		override public function create():void {
			// Make the background
			if (background == null)
				setBackground(0);
			add(background);
			
			//load the level
			if (level == null) {
				level = new Level(1);
			}

			//add the ground
			groundTiles = level.ground;
			add(groundTiles);
			
			//add the water
			waterTiles = level.water;
			add(waterTiles);
			
			//add the gates
			freezeGroup = level.freezeGates
			add(freezeGroup);
			
			heatGroup = level.heatGates
			add(heatGroup);
			
			flashGroup = level.flashGates
			add(flashGroup);		
			
			//add the exit
			exitGroup = level.exits;
			add(exitGroup);
			
			//add the keyssss
			keyGroup = level.keys;
			add(keyGroup);
			
			// This will be essentially for debugging or other info we want
			status = new FlxText(FlxG.width - 158, 2, 160);
			status.shadow = 0xff000000;
			status.alignment = "right";
			status.text = "none";
			add(status);
			
			// Display a message that TAB takes you to the level select screen.
			var levelSelectMessage:FlxText = new FlxText(0, FlxG.height - 25, 200, "Press TAB to go to level select screen");
			levelSelectMessage.setOriginToCorner();
			levelSelectMessage.scale = new FlxPoint(2, 2);
			add(levelSelectMessage);
			
			// Create and add the player
			if (level.player == null) {
				player = new Player(0, 0, waterTiles, this);
			} else {
				player = new Player(level.player.x, level.player.y, waterTiles, this);
			}
			add(player);
			
			/*
			spikeTest = new Spike((level.start_x+4)*32, (level.start_y)*32, 1)
			add(spikeTest);*/
			
			//FlxG.camera.follow(player);
			//FlxG.camera.zoom = 1.5;
			//FlxG.camera.deadzone(FlxCamera.STYLE_PLATFORMER);
			
			//UNCOMMENT THE FOLLOWING WHEN TILEMAPS SET
			
			// Create and add moving platforms
			/*movingPlatTiles = level.layerMovingTiles;
			add(level.layerMovingTiles);*/
			
			// create and add any spikes
			/* spiketiles = level.layerSpiketiles;
			add(spikeTiles); */
			
			
			this.add(iceGroup);
		}
		
		override public function update():void {
			super.update();
			
			// Make Player Collide With Level
			FlxG.collide(groundTiles, player);
			FlxG.collide(iceGroup, player);
			
			// Uncomment this when we have this tileMap set up
			//FlxG.collide(movingPlatTiles, player);
			
			/*if(player.overlaps(spikeTest)){ FlxG.resetState();}*/
			
			if (player.overlaps(waterTiles) && player.overlapsAt(player.x, player.y + player.getHeight() - 1, waterTiles) && (!player.bubble && !player.superBubble)) {
				player.slowSpeed();
			} else if (!player.bubble && !player.superBubble) {
				player.normalSpeed();
			}
			
			// Receive key 
			if (FlxG.overlap(keyGroup, player)) {
				getKey(keyGroup, player);
			}
			
			// Calls getGate function when we touch/cross/etc. a gate
			if (FlxG.overlap(freezeGroup, player)) {
				player.updatePower(FREEZE);
			}
			if (FlxG.overlap(heatGroup, player)) {
				player.updatePower(HEAT);
			}
			if (FlxG.overlap(flashGroup,player)) {
				player.updatePower(FLASH);
			}
			
			// If player has the key and touches the exit, they win
			if (player.hasKey && FlxG.overlap(exitGroup, player)) {
				win(exitGroup, player);
			}
			
			//Check for player lose conditions
			// If we press a button like um TAB we can go to level select
			if (player.y > FlxG.height || FlxG.keys.R) {
				FlxG.switchState(new TransitionState(level.levelNum));
			}
			if (FlxG.keys.TAB) {
				FlxG.switchState(new TransitionState(0));
			}
			
			status.text = player.stat;
		}
		
		/** when player retrieves key **/
		public function getKey(key:FlxGroup, player:Player):void {
			key.kill();
			player.hasKey = true;
		}
		
		/** Win function **/
		public function win(Exit:FlxGroup, player:Player):void {
			FlxG.switchState(new TransitionState(level.levelNum + 1));
		}
		
		/** Sets the background based on the level index **/
		public function setBackground(level:int):void {
			level %= Assets.b_list.length;
			
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