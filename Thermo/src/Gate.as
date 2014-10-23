package {
	import org.flixel.FlxSprite;
	
	public class Gate extends FlxSprite {
		
		public static const FREEZE:int = 1;
		public static const HEAT:int = 2;
		public static const FLASH:int = 3;
		
		/* Gate types
		 * 1 - Freeze
		 * 2 - Heat
		 * 3 - Flash
		 */
		private var type:int;
		
		public function Gate(sprite:FlxSprite, type:int) {
			super(sprite.x, sprite.y);
			
			angle = sprite.angle;
			scale.x = sprite.scale.x;
			scale.y = sprite.scale.y
			scrollFactor.x = sprite.scrollFactor.x;
			scrollFactor.y = sprite.scrollFactor.y;
		
			this.type = type;
			
			addAnimation("normal", [type]);
			addAnimation("trigger", [type+4, type, 4, type], Assets.FRAME_RATE, false);
			loadGraphic(Assets.gateSprite, true, false, 16, 64);
			
			play("normal");
		}
		
		public function trigger():void {
			// Play triggered animation
			play("trigger");
		}
		
		override public function update():void {
			// Play standard animation (needed in update?)
		}
	}
}