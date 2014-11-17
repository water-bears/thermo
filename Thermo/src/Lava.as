package {
	import org.flixel.FlxSprite;
	
	public class Lava extends FlxSprite {
		
		public var hot:Boolean;
		
		public function Lava(sprite:FlxSprite, hot:Boolean) {
			super();
			
			this.hot = hot;
			this.x = sprite.x;
			this.y = sprite.y;
			angle = sprite.angle;
			scale = sprite.scale;
			scrollFactor = sprite.scrollFactor;
			width = width * scale.x;
			height = height * scale.y;
			this.immovable = true;
			
			addAnimation("flow", [0, 1, 2, 1, 0, 4, 5, 4], Assets.FRAME_RATE / 2, true);
			loadGraphic(hot ? Assets.hotLavaSprite : Assets.coldLavaSprite, true, false, Assets.lavaSpriteX, Assets.lavaSpriteY);
			
			play("flow");
		}
	}
}