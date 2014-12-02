package context 
{
	import flash.geom.Rectangle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class MouseSprite extends FlxSprite 
	{
		private static const fade_threshold:uint = 120;
		private static const dampening:Number = 0.9;
		private static const dampening2:Number = 0.5;
		private static const borderPadding:Number = 15;
		private var counter:uint = 0;
		private var autoFade:Boolean;
		private var interior:Rectangle = new Rectangle(borderPadding, borderPadding, FlxG.width - 2 * borderPadding, FlxG.height - 2 * borderPadding);
		
		public function MouseSprite(autoFade:Boolean) 
		{
			super(0, 0, Assets.cursorSprite);
			this.autoFade = autoFade;
		}
		
		override public function update():void 
		{
			super.update();
			if (FlxG.mouse.screenX != x || FlxG.mouse.screenY != y)
			{
				// set sprite position to mouse position
				x = FlxG.mouse.screenX;
				y = FlxG.mouse.screenY;
				counter = 0;
				if (alpha < 1 && alpha > 0.99)
				{
					alpha = 1;
				}
				else
				{
					alpha = 1 - (1 - alpha) * dampening2;
				}
			}
			else if (autoFade)
			{
				counter++;
				if (!interior.contains(x, y))
				{
					counter += 5;
				}
				if (counter > fade_threshold)
				{
					if (alpha > 0 && alpha < 0.01)
					{
						alpha = 0;
					}
					else
					{
						alpha = alpha * dampening;
					}
				}
			}
		}
	}

}