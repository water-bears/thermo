package {
	
	import org.flixel.FlxSprite;
	//import data.Library;
	
	public class Spike extends FlxSprite {
		
		/*
		dir is the direction the spike is facing
		1 = up
		2 = down
		3 = left
		4 = right
		*/
		public var dir:int;
		
		public function Spike(x:Number, y:Number, direction:int) {
			super(x,y);
			
			
			this.dir = direction;
			
			// loading the spike image in the correct orientation
			// Right now this is iceSprite just as a filler 
			switch(dir){
				case 1:
					this.loadRotatedGraphic(Assets.iceSprite, 4, 0);
				case 2:
					this.loadRotatedGraphic(Assets.iceSprite, 4, 1);
				case 3:
					this.loadRotatedGraphic(Assets.iceSprite, 4, 2);
				case 4:
					this.loadRotatedGraphic(Assets.iceSprite, 4, 3);
			}
			
			
		}
		
	}
	
}