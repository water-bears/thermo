package {
	import org.flixel.FlxSprite;
	
	public class Lava extends FlxSprite {
		
		public function Lava(sprite:FlxSprite, hot:Boolean) {
			super();
			
			this.x = sprite.x;
			this.y = sprite.y;
			angle = sprite.angle;
			scale = sprite.scale;
			scrollFactor = sprite.scrollFactor;
			width = width * scale.x;
			height = height * scale.y;
			
			addAnimation("flow", [0, 1, 2, 3, 4], Assets.FRAME_RATE / 5, true);
			loadGraphic(hot ? Assets.hotLavaSprite : Assets.coldLavaSprite, true, false, Assets.lavaSpriteX, Assets.lavaSpriteY);
			
			play("flow");
		}
	}
}