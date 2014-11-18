package {
	import org.flixel.FlxSprite;
	
	public class Grass extends FlxSprite {
		
		public function Grass(sprite:FlxSprite) {
			super();
			
			setOriginToCorner();
			
			this.x = sprite.x;
			this.y = sprite.y;
			angle = sprite.angle;
			scale = sprite.scale;
			scrollFactor = sprite.scrollFactor;
			width = width * scale.x;
			height = height * scale.y;
			
			var a0:int = this.x % 4;
			var a1:int = (this.x + 1) % 4;
			var a2:int = (this.x + 2) % 4;
			var a3:int = (this.x + 3) % 4;
			addAnimation("sway", [0, 1, 2, 3, 2, 1], Assets.FRAME_RATE / 5, true);
			addAnimation("blow", [0, 1, 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2, 1], Assets.FRAME_RATE / 3, true);
			loadGraphic(Assets.grassSprite, true, false, Assets.grassSpriteX, Assets.grassSpriteY);
			
			play("sway");
		}
	}
}