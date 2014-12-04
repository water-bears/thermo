package uilayer {
	import flash.geom.Rectangle;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import audio.AudioManager;
	
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
		private var pause:FlxSprite;
		private var mute:FlxSprite;
		
		public var alpha:Number;
		public var liveMouse:Boolean;
		public var mousePosition:FlxPoint;
		
		private var pauseCallback:Function;
		
		public function MouseLayer(autoFade:Boolean, fadeTime:uint = 200)
		{
			AutoFade = autoFade;
			this.fadeTime = fadeTime;
			add(cursor = new FlxSprite(0, 0, Assets.cursorSprite));
			add(pause = new FlxSprite(FlxG.width - 50, 5, Assets.pauseSprite));
			pause.visible = false;
			add(mute = new FlxSprite(FlxG.width - 25, 5, Assets.muteSprite));
			mute.loadGraphic(Assets.muteSprite, true, false, 20, 20);
			mute.frame = AudioManager.GetMute() ? 1 : 0;
			cursor.alpha = mute.alpha = alpha = 0;
			mousePosition = new FlxPoint();
		}
		
		//if this function isn't called (ie in menu), don't show the pause button.
		public function SetTogglePauseCallback(pauseCallback:Function) : void
		{
			this.pauseCallback = pauseCallback;
			pause.visible = true;
		}
		
		override public function update():void 
		{
			super.update();
			liveMouse = false;
			if (counter <= fadeTime)
			{
				alpha = 1 - (1 - alpha) * dampening2;
			}
			if (FlxG.mouse.screenX != cursor.x || FlxG.mouse.screenY != cursor.y || FlxG.mouse.justPressed())
			{
				liveMouse = true;
				// set sprite position to mouse position
				mousePosition.x = cursor.x = FlxG.mouse.screenX;
				mousePosition.y = cursor.y = FlxG.mouse.screenY;
				counter = 0;
			}
			else if (AutoFade)
			{
				counter++;
				//if (!interior.contains(cursor.x, cursor.y))
				//{
				counter += 5;
				//}
				if (counter > fadeTime)
				{
					alpha = alpha * dampening;
				}
			}
			updateAlpha();
			// Do things when the mouse is clicked
			if (mute.overlapsPoint(mousePosition))
			{
				mute.color = 0xff0000;
				if (FlxG.mouse.pressed())
				{
					mute.color = 0x000000;
					if (FlxG.mouse.justPressed())
					{
						AudioManager.SetMute(!AudioManager.GetMute());
						mute.frame = AudioManager.GetMute() ? 1 : 0;
					}
				}
				counter = 0;
			}
			else
			{
				if (mute.color != 0xffffff)
				{
					mute.color = 0xffffff;
				}
			}
			
			if (pause.visible && pause.overlapsPoint(mousePosition))
			{
				pause.color = 0xff0000;
				if (FlxG.mouse.pressed())
				{
					pause.color = 0x000000;
					if (FlxG.mouse.justPressed())
					{
						pauseCallback();
					}
				}
				counter = 0;
			}
			else
			{
				if (pause.color != 0xffffff)
				{
					pause.color = 0xffffff;
				}
			}
		}
		
		public function updateAlpha():void
		{
			if (alpha == 1 || alpha == 0) {}
			else if (alpha < 1 && alpha > 0.99)
			{
				cursor.alpha = pause.alpha = mute.alpha = alpha = 1;
			}
			else if (alpha > 0 && alpha < 0.01)
			{
				cursor.alpha = pause.alpha = mute.alpha = alpha = 0;
			}
			else
			{
				cursor.alpha = pause.alpha = mute.alpha = alpha;
			}
		}
	}

}