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
			switch(dir) {
				case 1:
					// load spike up image
					break;
				case 2:
					// load spike down image
					break;
				case 3:
					// load spike left image
					break;
				case 4:
					// load spike right image
					break;
			}
			
			
		}
		
	}
	
}