package {
	
	import org.flixel.FlxSprite;
	//import data.Library;
	
	public class Spike extends FlxSprite {
		
		public function Spike(sprite:FlxSprite) {
			super(sprite.x, sprite.y);
			loadGraphic(Assets.spikeSprite);
			
			angle = sprite.angle;
			scale = sprite.scale;
			this.setOriginToCorner();
		}
		
	}
	
}