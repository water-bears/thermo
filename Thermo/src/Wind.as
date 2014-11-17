package {
	import org.flixel.FlxSprite;
	
	public class Wind extends FlxSprite {
		private var intensity:Number = 20;
		
		/* Directions
		 * 1 - left
		 * 2 - right
		 * 3 - up
		 * 4 - down
		 */
		private var direction:int;
		
		public function Wind(sprite:FlxSprite, direction:int = 1) {
			super();
			
			if (direction == 2) {
				loadGraphic(Assets.windrightSprite, false, false, Assets.windrightSpriteX, Assets.windrightSpriteY);
			} else {
				loadGraphic(Assets.windleftSprite, false, false, Assets.windleftSpriteX, Assets.windleftSpriteY);
			}
			
			setOriginToCorner();
			
			this.direction = direction;
			this.x = sprite.x;
			this.y = sprite.y;
			scale = sprite.scale;
			width = width * scale.x;
			height = height * scale.y;
		}
		
		public function blow(player:Player):void {
			if (player.bubble) {
				switch(direction) {						
				case 2:
					player.wind.x += intensity;
					break;
				case 3:
					player.wind.y += intensity;
					break;
				case 4:
					player.wind.y -= intensity;
					break;
				default:
					player.wind.x -= intensity;
					break;
				}
			}
		}
	}
}