package {
	import org.flixel.FlxSprite;
	
	public class Door extends FlxSprite {
		
		public function Door(sprite:FlxSprite) {
			super(sprite.x, sprite.y);
			
			angle = sprite.angle;
			scale.x = sprite.scale.x;
			scale.y = sprite.scale.y
			scrollFactor.x = sprite.scrollFactor.x;
			scrollFactor.y = sprite.scrollFactor.y;
			
			addAnimation("closed", [1]);
			addAnimation("open", [1, 4, 7, 10], Assets.FRAME_RATE, false);
			loadGraphic(Assets.doorSprite, true, false, 32, 32);
			
			play("closed");
		}
		
		public function open():void {
			play("open");
		}
	}
}