package uilayer {
	import flash.geom.Rectangle;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class MouseLayer extends FlxGroup
	{
		public var AutoFade:Boolean;
		
		private var fadeTime:uint;
		private static const dampening:Number = 0.9;
		private static const dampening2:Number = 0.8;
		private static const borderPadding:Number = 15;
		private var counter:uint = 0;
		private var interior:Rectangle = new Rectangle(borderPadding, borderPadding, FlxG.width - 2 * borderPadding, FlxG.height - 2 * borderPadding);
		
		private var cursor:FlxSprite;
		private var mute:FlxSprite;
		
		public var alpha:Number;
		
		public function MouseLayer(autoFade:Boolean, fadeTime:uint = 120)
		{
			AutoFade = autoFade;
			this.fadeTime = fadeTime;
			add(cursor = new FlxSprite(0, 0, Assets.cursorSprite));
			add(mute = new FlxSprite(0, 0, Assets.cursorSprite));
			cursor.alpha = mute.alpha = alpha = 0;
		}
		
		override public function update():void 
		{
			super.update();
			if (FlxG.mouse.screenX != cursor.x || FlxG.mouse.screenY != cursor.y || FlxG.mouse.justPressed())
			{
				// set sprite position to mouse position
				cursor.x = FlxG.mouse.screenX;
				cursor.y = FlxG.mouse.screenY;
				counter = 0;
				alpha = 1 - (1 - alpha) * dampening2;
			}
			else if (AutoFade)
			{
				counter++;
				if (!interior.contains(cursor.x, cursor.y))
				{
					counter += 5;
				}
				if (counter > fadeTime)
				{
					alpha = alpha * dampening;
				}
			}
			updateAlpha();
		}
		
		public function updateAlpha():void
		{
			if (alpha == 1 || alpha == 0) {}
			else if (alpha < 1 && alpha > 0.99)
			{
				cursor.alpha = mute.alpha = alpha = 1;
			}
			else if (alpha > 0 && alpha < 0.01)
			{
				cursor.alpha = mute.alpha = alpha = 0;
			}
			else
			{
				cursor.alpha = mute.alpha = alpha;
			}
		}
	}

}