package {
	
	import org.flixel.FlxSprite;
	//import data.Library;
	
	//direction: 1 = up, 2 = down, 3 = left, 4 = right;
	
	public class Spike extends FlxSprite {
		
		public function Spike(sprite:FlxSprite, direction:int = 1) {
			super();
			
			switch(direction) {
				case 2:
					loadGraphic(Assets.spikeSprite);
					width = 17;
					height = 7;
					break;
				case 3:
					loadGraphic(Assets.leftspikeSprite);
					width = 7;
					height = 17;
					break;
				case 4:
					loadGraphic(Assets.rightspikeSprite);
					width = 7;
					height = 17;
					break;
				default:
					loadGraphic(Assets.upspikeSprite);
					width = 17;
					height = 7;
					break;
            }

			
			setOriginToCorner();
			
			this.x = sprite.x;
			this.y = sprite.y;
			scale = sprite.scale;
		}
	}
	
}