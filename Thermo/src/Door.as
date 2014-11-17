package {
	import org.flixel.FlxSprite;
	
	public class Door extends FlxSprite {
		
		public function Door(sprite:FlxSprite) {
			super();
			
			//addAnimation("closed", [1]);
			//addAnimation("open", [1, 4, 7, 10], Assets.FRAME_RATE, false);
			loadGraphic(Assets.doorSprite, false, false, Assets.doorSpriteX, Assets.doorSpriteY);
			
			x = sprite.x;
			y = sprite.y - 4;
			scale.x = 20 / Assets.doorSpriteX;
			scale.y = 20 / Assets.doorSpriteY;
			offset.x = 52;
			offset.y = 52;
			width = 25;
			height = 25;
		}
		
		override public function update():void {
			this.angle += 5;
		}
		
		public function open():void {
			this.loadGraphic(Assets.door1Sprite, false, false, Assets.door1SpriteX, Assets.door1SpriteY);
			width = 25;
			height = 25;
		}
	}
}