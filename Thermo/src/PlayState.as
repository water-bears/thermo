package {
	import Menu.LevelSelectState;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	
	import org.flixel.*;
	
	public class PlayState extends FlxState {
		private var background:FlxSprite;
		
		private var player:Player;
		
		// Groups that will allow us to make gate and water tiles
		public var freezeTiles:FlxTilemap;
		public var heatTiles:FlxTilemap;
		public var flashTiles:FlxTilemap;
		public var waterTiles:FlxTilemap;
		public var groundTiles:FlxTilemap;
		public var exitTiles:FlxTilemap;
		public var keyTiles:FlxTilemap;
		
		// Group for ice blocks
		public var iceGroup:FlxGroup = new FlxGroup(4);
		
		// This is currently being used as a method of debugging
		public var status:FlxText;
		
		public var BLUE:uint = 0x0000FF;
		public var RED:uint = 0x00FF00FF;
		public var GREEN:uint = 0x00FF00;
		public var WHITE:uint = 0xffffffff;
		public var BLACK:uint = 0x000000;
		
		private var level:BaseLevel;
		
		private const FREEZE:int = 1;
		private const HEAT:int = 2;
		private const FLASH:int = 3;
		
		public function setLevel(inputLevel:BaseLevel): void {
			level = inputLevel;
		}
		
		override public function create():void {
			// Make the background
			if (background == null)
				setBackground(0);
			add(background);
			
			//load the level
			if (level == null) {
				level = new Level_1(false);
			}
			
			//add the ground
			groundTiles = level.layerGroup1Ground;
			add(groundTiles);
			
			//add the water
			waterTiles = level.layerGroup1Water;
			add(waterTiles);
			
			//add the gates
			freezeTiles = level.layerGroup1FreezeGates;
			add(freezeTiles);
			
			heatTiles = level.layerGroup1HeatGates;
			add(heatTiles);
			
			flashTiles = level.layerGroup1FlashGates;
			add(flashTiles);		
			
			//add the exit
			exitTiles = level.layerGroup1Door;
			add(exitTiles);
			
			//add the keyssss
			keyTiles = level.layerGroup1Key;
			add(keyTiles);
			
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
			player = new Player(level.start_x * 32, level.start_y * 32, waterTiles, this);
			add(player);
			
			this.add(iceGroup);
		}
		
		override public function update():void {
			super.update();
			
			// Make Player Collide With Level
			FlxG.collide(groundTiles, player);
			FlxG.collide(iceGroup, player);
			
			if (player.overlaps(waterTiles) && player.overlapsAt(player.x, player.y + player.getHeight(), waterTiles) && (!player.bubble && !player.superBubble)) {
				player.slowSpeed();
			} else if (!player.bubble && !player.superBubble) {
				player.normalSpeed();
			}
			
			// Receive key 
			if (keyTiles.overlaps(player)) {
				getKey(keyTiles, player);
			}
			
			// Calls getGate function when we touch/cross/etc. a gate
			if (freezeTiles.overlaps(player)) {
				player.updatePower(FREEZE);
			}
			if (heatTiles.overlaps(player)) {
				player.updatePower(HEAT);
			}
			if (flashTiles.overlaps(player)) {
				player.updatePower(FLASH);
			}
			
			// If player has the key and touches the exit, they win
			if (player.hasKey && exitTiles.overlaps(player)) {
				win(exitTiles, player);
			}
			
			//Check for player lose conditions
			// If we press a button like um TAB we can go to level select
			if (player.y > FlxG.height || FlxG.keys.TAB) {
				FlxG.switchState(new LevelSelectState());
			}
			
			status.text = player.stat;
		}
		
		/** when player retrieves key **/
		public function getKey(key:FlxTilemap, player:Player):void {
			key.kill();
			player.hasKey = true;
		}
		
		/** Win function **/
		public function win(Exit:FlxTilemap, player:Player):void {
			FlxG.switchState(new LevelSelectState());
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