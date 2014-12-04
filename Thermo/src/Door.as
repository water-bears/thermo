package {
	import org.flixel.FlxSprite;
	
	public class Door extends FlxSprite {
		
		public function Door(sprite:FlxSprite) {
			super();
			
			addAnimation("closed", [0, 1, 2, 3, 4, 3, 2, 1], Assets.FRAME_RATE / 4, true);
			addAnimation("opening", [
				0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
				10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
				20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
				30, 31, 32, 33, 34, 35, 36, 37, 38, 39,
				40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
				50, 51, 52, 53, 54, 55, 56, 57, 58, 59,
				60, 61, 62, 63, 64, 65, 66, 67, 68, 69,
				70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
				80, 81, 82, 83, 84, 85, 86, 87, 88, 89,
				90, 91, 92, 93, 94, 95, 96, 97, 98, 99,
				100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
				110, 111, 112, 113, 114, 115, 116, 117, 118, 119,
				120, 121, 122, 123, 124, 125, 126, 127
			], Assets.FRAME_RATE * 4, false);
			addAnimation("open", [124, 125, 126, 127], 12, true);
			addAnimationCallback(animCallback);
			loadGraphic(Assets.doorSprite, true, false, Assets.doorSpriteX, Assets.doorSpriteY);
			
			/*
			x = sprite.x;
			y = sprite.y - 4;
			scale.x = 20 / Assets.doorSpriteX;
			scale.y = 20 / Assets.doorSpriteY;
			offset.x = 52;
			offset.y = 52;
			width = 25;
			height = 25;
			*/
			x = sprite.x - 8;
			y = sprite.y - 27;
			width *= 1;
			height *= 1;
			scale.x *= 1;
			scale.y *= 1;
			
			play("closed");
		}
		
		override public function update():void {
			//this.angle += 5;
		}
		
		public function open():void {
			//this.loadGraphic(Assets.door1Sprite, false, false, Assets.door1SpriteX, Assets.door1SpriteY);
			play("opening");
			//width = 25;
			//height = 25;
		}
		
		private function animCallback(animationName:String, currentFrame:uint, currentFrameIndex:uint):void {
		  if (animationName == "opening" && currentFrame >= 127)
		  {
			 play("open");
		  }
		}
	}
}