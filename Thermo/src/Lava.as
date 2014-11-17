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
			
			addAnimation("flow", [0, 1, 2, 3, 4, 3, 2, 1], Assets.FRAME_RATE / 3, true);
			loadGraphic(hot ? Assets.hotLavaSprite : Assets.coldLavaSprite, true, false, Assets.lavaSpriteX, Assets.lavaSpriteY);
			
			play("flow");
		}
	}
}