// ActionScript file

package {
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	
	import org.flixel.*;
	
	public class PlayState extends FlxState {
		
		public var level:FlxTilemap;
		private var player:Player;
		public var exit:FlxSprite;
		public var key:FlxSprite;
		
		// Groups that will allow us to make gate and water tiles
		public var freezeTiles:FlxTilemap;
		public var heatTiles:FlxTilemap;
		public var flashTiles:FlxTilemap;
		public var waterTiles:FlxTilemap;
		public var groundTiles:FlxTilemap;
		
		// This is currently being used as a method of debugging
		public var status:FlxText;
		
		public var BLUE:uint = 0x0000FF;
		public var RED:uint = 0x00FF00FF;
		public var GREEN:uint = 0x00FF00;
		public var WHITE:uint = 0xffffffff;
		public var BLACK:uint = 0x000000;
		
		override public function create():void {
			FlxG.bgColor = 0xffaaaaaa;
			
			// Make the exit door
			exit = new FlxSprite(35*8+1,25*8);
			exit.makeGraphic(14,16,0xff3f3f3f);
			add(exit);
			
			// Create the key that needs to be collected before exiting the level
			key = new FlxSprite(38*8+3,17*8+2);
			key.makeGraphic(5,5,0xffffff00);
			add(key);
			
			//load the level
			var level:Level_TestWGates = new Level_TestWGates(false);
			
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
			
			// This will be essentially for debugging or other info we want
			status = new FlxText(FlxG.width-160-2,2,160);
			status.shadow = 0xff000000;
			status.alignment = "right";
			status.text = "none";
			add(status);
			
			// Create and add the player
			player = new Player(10, 12, waterTiles, key, exit);
			add(player);
			
		}
		
		override public function update():void {
			super.update();
			status.text = player.stat;
			
			// Slow player down if they are in water
			if (waterTiles.overlaps(player) && !player.bubble) {
				slowPlayer(player);
			}
				// Put player back to normal speed in air
			else if (!player.bubble) {
				fastPlayer(player);
			}
			
			// Receive key 
			FlxG.overlap(key,player,getKey);
			
			// Calls getGate function when we touch/cross/etc. a gate
			if (freezeTiles.overlaps(player)) {
				getFreeze(freezeTiles, player);
			}
			if (heatTiles.overlaps(player)) {
				getHeat(heatTiles, player);
			}
			if (flashTiles.overlaps(player)) {
				getFlash(flashTiles, player);
			}
			
			// If player has the key and touches the exit, they win
			if(player.hasKey && FlxG.overlap(exit, player)) {win(exit,player);}
			
			//Check for player lose conditions
			if(player.y > FlxG.height)
			{
				player.curPow=0;
				FlxG.resetState();
			}
			
			// Make Player Collide With Level
			FlxG.collide(groundTiles,player);
			status.text=player.stat;
		}
		
		/**Creates gate based on the specified x and y coordinates and the power we want them to be
		 Power is consistent with curPow properties**/
		public function createGate(X:uint,Y:uint,power:uint):void {
			var gate:FlxSprite = new FlxSprite(X*8+3,Y*8-4);
			gate.makeGraphic(2,12,0xffffff00);
			
			switch (power){
				// blue, freeze
				case 1: gate.color = (BLUE);
					break;
				// red, heat
				case 2: gate.color = (RED);
					break;
				// flash, neutral
				case 3: gate.color = (0x00FFFF00);
					break;
			}
			//gateTiles.add(gate);
		}
		
		/**Creates water tiles based on the specified x and y coordinates **/
		public function createWater(X:uint, Y:uint):void {
			var wat:FlxSprite = new FlxSprite(X*8+3, Y*8-4);
			wat.makeGraphic(10,12,FlxG.BLUE);
			//waterTiles.add(wat);
		}
		
		/**What happens when you enter a gate, updates player power**/
		public function getGate(Gate:FlxSprite,player:Player):void{
			var col:uint = Gate.color;
			switch (col) {
				// Player hit freeze gate
				case BLUE: 
					player.curPow = 1; 
					status.text = "freeze";
					player.stat = status.text;
					break;
				// Player hit heat gate
				case RED: 
					player.curPow = 2;
					status.text = "heat";
					player.stat = status.text;
					break;
				//Player hit neutral gate TBC WHEN FREEZE/HEAT DONE
				case 0x00FFFF00:
					if(player.curPow == 1) {
						player.curPow = 3;
						status.text = "flash freeze";
						player.stat = status.text;
					}
					if(player.curPow == 2) {
						player.curPow = 4;
						status.text = "flash heat";
						player.stat = status.text;
					}
					break;
			}
		}
		
		/**What happens when you enter a freeze gate, updates player power**/
		public function getFreeze(x:FlxTilemap, p:FlxSprite):void
		{
			player.curPow = 1; 
			status.text = "freeze";
			player.stat = status.text;
		}
		
		/**What happens when you enter a heat gate, updates player power**/
		public function getHeat(x:FlxTilemap, p:FlxSprite):void
		{
			player.curPow = 2;
			status.text = "heat";
			player.stat = status.text;			
		}
		
		/**What happens when you enter a flash gate, updates player power**/
		public function getFlash(x:FlxTilemap, p:FlxSprite):void
		{
			if(player.curPow == 1) {
				player.curPow = 3;
				status.text = "flash freeze";
				player.stat = status.text;
			}
			if(player.curPow == 2) {
				player.curPow = 4;
				status.text = "flash heat";
				player.stat = status.text;
			}
		}
		
		/** Slows player down in water */
		public function slowPlayer(player:Player):void{
			player.maxVelocity.x = 100;
			player.maxVelocity.y = 100;
			player.acceleration.y = 300;
			player.underwater = true;
		}
		
		/** Player back to normal speed outside of water */
		public function fastPlayer(player:Player):void{
			player.maxVelocity.x = 200;
			player.maxVelocity.y = 200;
			player.acceleration.y = 600;
			player.underwater = false;
		}
		
		/** when player retrieves key **/
		public function getKey(key:FlxSprite, player:Player):void{
			key.kill();
			player.hasKey = true;
		}
		
		/** Win function **/
		public function win(Exit:FlxSprite, player:Player):void{			
			// Below is for now, when we have more levels this will change 
			FlxG.resetState();
		}
		
	}
	
}