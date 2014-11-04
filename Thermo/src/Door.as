package {
	import org.flixel.FlxSprite;
	
	public class Door extends FlxSprite {
		
		public function Door(sprite:FlxSprite) {
			
			super();			
			//angle = sprite.angle;
			//scale.x = sprite.scale.x;
			//scale.y = sprite.scale.y
			//scrollFactor.x = sprite.scrollFactor.x;
			//scrollFactor.y = sprite.scrollFactor.y;
			
			addAnimation("closed", [1]);
			addAnimation("open", [1, 4, 7, 10], Assets.FRAME_RATE, false);
			loadGraphic(Assets.doorSprite, true, false, Assets.doorSpriteX, Assets.doorSpriteY);
			
			setOriginToCorner();
			scale.x = 20 / Assets.doorSpriteX;
			scale.y = 20 / Assets.doorSpriteY;
			width = 20;
			height = 20;
			x = sprite.x;
			y = sprite.y;
			
			play("closed");
		}
		
		public function open():void {
			play("open");
		}
	}
}