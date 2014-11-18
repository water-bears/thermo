package {
	
	import org.flixel.FlxSprite;
	//import data.Library;
	
	public class Spike extends FlxSprite {
		
		public function Spike(sprite:FlxSprite, up:Boolean = false) {
			super();
			
			if (up) {
				loadGraphic(Assets.upspikeSprite);
			} else {
				loadGraphic(Assets.spikeSprite);
			}
			
			setOriginToCorner();
			
			this.x = sprite.x;
			this.y = sprite.y;
			scale = sprite.scale;
			//width = width * scale.x;
			//height = height * scale.y;
			width = 18;
			height = 10;
		}
	}
	
}