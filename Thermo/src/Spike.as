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
					width = 18;
					height = 10;
					break;
				case 3:
					loadGraphic(Assets.leftspikeSprite);
					width = 10;
					height = 18;
					break;
				case 4:
					loadGraphic(Assets.rightspikeSprite);
					width = 10;
					height = 18;
					break;
				default:
					loadGraphic(Assets.upspikeSprite);
					width = 18;
					height = 10;
					break;
            }

			
			setOriginToCorner();
			
			this.x = sprite.x;
			this.y = sprite.y;
			scale = sprite.scale;
		}
	}
	
}