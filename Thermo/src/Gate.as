package {
	import org.flixel.FlxSprite;
	
	public class Gate extends FlxSprite {
		
		public static const SHEET_WIDTH:int = 6;
		
		public static const FREEZE:int = 1;
		public static const HEAT:int = 2;
		public static const FLASH:int = 3;
		public static const NEUTRAL:int = 4;
		
		/* Gate types
		 * 1 - Freeze
		 * 2 - Heat
		 * 3 - Flash
		 * 4 - Neutral
		 */
		private var type:int;
		private var triggered:Boolean = false;
		
		public function Gate(sprite:FlxSprite, type:int) {
			super();
			loadGraphic(Assets.gateSprite, true, false, Assets.gateSpriteX, Assets.gateSpriteY);
			
			setOriginToCorner();
			scale.x = 10 / Assets.gateSpriteX;
			scale.y = 40 / Assets.gateSpriteY;
			width = 10;
			height = 40;
			x = sprite.x;
			y = sprite.y;
		
			this.type = type;
			
			if (type == FLASH) {
				addAnimation("normal", [type, SHEET_WIDTH], Assets.FRAME_RATE / 5 / 2, true);
				addAnimation("trigger", [type+SHEET_WIDTH, type], Assets.FRAME_RATE / 5, false);
			} else {
				addAnimation("normal", [type]);
				addAnimation("trigger", [type+SHEET_WIDTH, type, SHEET_WIDTH, type], Assets.FRAME_RATE / 5, false);
			}
			
			play("normal");
		}
		
		public function trigger():void {
			triggered = true;
		}
		
		override public function update():void {
			// Play standard animation (needed in update?)
			if (triggered)
				play("trigger");
			else
				play("normal");
		}
		
		public function untrigger():void {
			triggered = false;
		}
	}
}