// ActionScript file

package {
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	
	import org.flixel.*;
	
	public class Player extends FlxSprite {
		
		/* curPow (fake enumeration, as3 has annoying enumerations) 
		Initialized to 0 for no power
		1 for freeze
		2 for heat
		3 for flash freeze
		4 for flash heat
		*/
		public var curPow:int = 0;
		
		public var bubble:Boolean = false;
		public var underwater:Boolean = false;
		public var waterTiles:FlxGroup;
		public var hasKey:Boolean = false;
		public var stat:String = "none";
		public var key:FlxSprite;
		public var exit:FlxSprite;
		
		
		public function Player(X:Number, Y:Number, waterT:FlxGroup, k:FlxSprite, e:FlxSprite):void{
			super(X,Y);
			key = k;
			exit = e;
			
			// Right now makeGraphic is a placeholder until we actually get a character asset
			makeGraphic(X, Y, FlxG.WHITE);
			maxVelocity.x = 200;
			maxVelocity.y = 200;
			acceleration.y = 600;
			drag.x = int.MAX_VALUE;
			waterTiles = waterT;
			
			// Add animations in the space right below this when we get them
						
			// After animations are set, set  facing = RIGHT;
		}
		
		override public function update():void {
			acceleration.x = 0;
			
			if(FlxG.keys.LEFT || FlxG.keys.A)
				velocity.x = -maxVelocity.x;
			
			
			if(FlxG.keys.RIGHT || FlxG.keys.D)
				velocity.x = maxVelocity.x;
			
			if((FlxG.keys.W || FlxG.keys.UP) && isTouching(FlxObject.FLOOR))
				velocity.y = -maxVelocity.y;
			
			// pops bubble when one of these are pressed
			if((FlxG.keys.W || FlxG.keys.UP || FlxG.keys.S || FlxG.keys.DOWN) && bubble){
				velocity.y = 0;
				acceleration.y = 600;
				bubble = false;
			}
			
			if(FlxG.keys.SPACE){
				// action key, only works if Player is in water
				if(underwater)
					usePower(waterTiles, this);
			}
			// "Pops" bubbles when they hit the ceiling
			if(bubble == true && isTouching(FlxObject.CEILING)){
				velocity.y = 0;
				acceleration.y = 600;
				bubble = false;
			}
			
			//update this
			super.update();
			
		}
		
		public function usePower(currentWater:FlxGroup, player:Player):void{
			switch (curPow) {
				case 1:
					// freeze, create temp platform here
					
					break;
				case 2:
					// heat, bubble up until you hit something, will need to add check for in water later
					velocity.y = -200/10;
					acceleration.y = 0;
					stat = "used bubble";
					bubble = true;				
					break;
				case 3:
					stat = "flash frozen";
					break;
				case 4:
					stat = "flash heated";
					//FlxG.overlap(waterT, currentWater, kill)
					currentWater.kill();
					break;
			}
		}
		
	}
}
