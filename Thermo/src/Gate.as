package {
	import adobe.utils.CustomActions;
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
		private var timer:uint;
		
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
			
			var slow:uint = 20;
			var fast:uint = 32;
			
			if (type == FLASH) {
				addAnimation("normal", constructAlternatingArray(156, 208, 52, 4), slow, true);
				//addAnimation("trigger", constructAlternatingArray(156, 0, 52, 6), fast, true);
			} else if (type == FREEZE) {
				addAnimation("normal", constructArray(104, 52), slow);
				//addAnimation("trigger", constructAlternatingArray(104, 0, 52, 6), fast, true);
			} else if (type == HEAT) {
				addAnimation("normal", constructArray(52, 52), slow);
				//addAnimation("trigger", constructAlternatingArray(52, 0, 52, 6), fast, true);
			} else /*if (type == NEUTRAL)*/ {
				addAnimation("normal", constructArray(0, 52), slow);
				//addAnimation("trigger", constructArray(0, 52), fast, true);
			}
			
			play("normal");
		}
		
		public function trigger():void {
			triggered = true;
		}
		
		override public function update():void {
			// Play standard animation (needed in update?)
			timer++;
			if (triggered)
				alpha = Math.sin(timer / 4) / 2 + 0.5;
				//play("trigger");
			else
				alpha = 1;
				//play("normal");
		}
		
		public function untrigger():void {
			triggered = false;
		}
		
		private static function constructArray(start:uint, numFrames:uint):Array {
			var a:Array = new Array();
			for (var i:uint = 0; i < numFrames; i++)
			{
				a.push(i + start);
			}
			return a;
		}
		
		private static function constructAlternatingArray(start:uint, start2:uint, numFrames:uint, altEvery:uint):Array {
			var a:Array = new Array();
			for (var i:uint = 0; i < numFrames; i++)
			{
				if (i % (2 * altEvery) < altEvery)
				{
					a.push(i + start);
				}
				else
				{
					a.push(i + start2);
				}
			}
			return a;
		}
	}
}