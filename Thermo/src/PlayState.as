// ActionScript file

package {
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	
	import org.flixel.*;
	
	public class PlayState extends FlxState {
		
		public var level:FlxTilemap;
		public var player:FlxSprite;
		public var exit:FlxSprite;
		
		// Groups that will allow us to make gate and water tiles
		public var gateTiles:FlxGroup = new FlxGroup();
		public var waterTiles:FlxGroup = new FlxGroup();
		
		public var bubble:Boolean = false;
		
		// This is currently being used as a method of debugging
		public var status:FlxText;
		
		public var BLUE:uint = 0x0000FF;
		public var RED:uint = 0x00FF00FF;
		public var GREEN:uint = 0x00FF00;
		public var WHITE:uint = 0xffffffff;
		public var BLACK:uint = 0x000000;
		
		/* curPow (fake enumeration, as3 has annoying enumerations) 
		Initialized to 0 for no power
		1 for freeze
		2 for heat
		3 for flash freeze
		4 for flash heat
		*/
		public var curPow:int = 0;
		
		override public function create():void {
			FlxG.bgColor = 0xffaaaaaa;
			
			var data:Array = new Array (
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1,
				1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 );
			level = new FlxTilemap();
			level.loadMap(FlxTilemap.arrayToCSV(data,40), FlxTilemap.ImgAuto, 0, 0, FlxTilemap.AUTO);
			add(level);
			
			// Make the exit door
			exit = new FlxSprite(35*8+1,25*8);
			exit.makeGraphic(14,16,0xff3f3f3f);
			exit.exists = true;
			add(exit);
			
			// Create different color gates
			createGate(21, 4, 1);
			createGate(26,2, 2);
			createGate(31,5,3);
			add(gateTiles);
			
			// Places water tiles
			createWater(4,23);
			createWater(5,23);
			createWater(12,26);
			createWater(34,5);
			add(waterTiles);

			
			// This will be essentially for debugging or other info we want
			status = new FlxText(FlxG.width-160-2,2,160);
			status.shadow = 0xff000000;
			status.alignment = "right";
			status.text = "none";
			add(status);
			
			//Create player (a white box)
			player = new FlxSprite(FlxG.width / 2 - 5);
			player.makeGraphic(10, 12, WHITE);
			player.maxVelocity.x = 200;
			player.maxVelocity.y = 200;
			player.acceleration.y = 600;
			player.drag.x = int.MAX_VALUE;
			add(player);
			
		}
		
		override public function update():void {
			player.acceleration.x = 0;
			if(FlxG.keys.LEFT || FlxG.keys.A)
				player.velocity.x = -player.maxVelocity.x;
			if(FlxG.keys.RIGHT || FlxG.keys.D)
				player.velocity.x = player.maxVelocity.x;
			if((FlxG.keys.W || FlxG.keys.UP) && player.isTouching(FlxObject.FLOOR))
				player.velocity.y = -player.maxVelocity.y;
			if((FlxG.keys.W || FlxG.keys.UP || FlxG.keys.S || FlxG.keys.DOWN) && bubble){
				player.velocity.y = 0;
				player.acceleration.y = 600;
				bubble = false;
				status.text = "popped bubble";
			}
			if(FlxG.keys.SPACE){
				// action key
				if(FlxG.overlap(waterTiles,player))
					usePower(player, curPow);
			}
			super.update();
			
			// Calls getGate function when we touch/cross/etc. a gate
			FlxG.overlap(gateTiles,player,getGate);
			
			FlxG.collide(level, player);
			
			// "Pops" bubbles when they hit the ceiling
			if(bubble == true && player.isTouching(FlxObject.CEILING)){
				player.velocity.y = 0;
				player.acceleration.y = 600;
				bubble = false;
			}
			
			//Check for player lose conditions
			if(player.y > FlxG.height)
			{
				curPow=0;
				FlxG.resetState();
			}
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
			gateTiles.add(gate);
		}
		
		/**Creates water tiles based on the specified x and y coordinates **/
		public function createWater(X:uint, Y:uint):void {
			var wat:FlxSprite = new FlxSprite(X*8+3, Y*8-4);
			wat.makeGraphic(10,12,FlxG.BLUE);
			waterTiles.add(wat);
		}
		
		// What happens when you enter a gate, updates player power
		public function getGate(Gate:FlxSprite,Player:FlxSprite):void{
			var col:uint = Gate.color;
			switch (col) {
				// Player hit freeze gate
				case BLUE: 
					curPow = 1; 
					status.text = "freeze";
					break;
				// Player hit heat gate
				case RED: 
					curPow = 2;
					status.text = "heat";
					break;
				//Player hit neutral gate TBC WHEN FREEZE/HEAT DONE
				case 0x00FFFF00: curPow
					if(curPow == 1) {
						curPow = 3;
						status.text = "flash freeze";
					}
					if(curPow == 2) {
						curPow = 4;
						status.text = "flash heat";
					}
					break;
			}
		}
		
		public function usePower(Player:FlxSprite, curPow:int):void{
			switch (curPow) {
				case 1:
					// freeze, create temp platform here
					break;
				case 2:
					// heat, bubble up until you hit something, will need to add check for in water later
					player.velocity.y = -player.maxVelocity.y/10;
					player.acceleration.y = 0;
					status.text = "used bubble";
					bubble = true;				
					break;
				case 3:
					status.text = "flash frozen";
					break;
				case 4:
					status.text = "flash heated";
					break;
			}
		}
		
		public function win(Exit:FlxSprite, Player:FlxSprite):void{
			
		}
	}
	
}