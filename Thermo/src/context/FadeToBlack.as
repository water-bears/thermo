package context 
{
	import flash.display.Shader;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	/**
	 * A FlxSprite that is simply a large black square drawn over everything.
	 * @author KJin
	 */
	public class FadeToBlack
	{
		private var sprite:FlxSprite;
		private var timeToFade:Number;
		private var fadeDirection:int;
		private var time:Number;
		private var completionCallback:Function;
		
		public function FadeToBlack(Dimensions:FlxPoint, TimeToFade:uint) 
		{
			this.timeToFade = TimeToFade;
			sprite = MenuUtils.CreateSolid(Dimensions, 0x000000);
			sprite.alpha = 0;
			fadeDirection = 0;
			completionCallback = null;
		}
		
		public function BeginFadeIn(OnCompletion:Function) : void
		{
			sprite.alpha = 1;
			fadeDirection = -1;
			time = timeToFade;
			completionCallback = OnCompletion;
		}
		
		public function BeginFadeOut(OnCompletion:Function) : void
		{
			sprite.alpha = 0;
			fadeDirection = 1;
			time = timeToFade;
			completionCallback = OnCompletion;
		}
		
		public function Register(state:FlxState) : void
		{
			state.add(sprite);
		}
		
		public function Update():void
		{
			if (fadeDirection == -1)
			{
				sprite.alpha = time / (timeToFade + 0.0);
			}
			else if (fadeDirection == 1)
			{
				sprite.alpha = 1 - time / (timeToFade + 0.0);
			}
			if (fadeDirection != 0 && time == 0)
			{
				fadeDirection = 0;
				if (completionCallback != null)
				{
					completionCallback();
				}
			}
			if (time > 0)
			{
				time--;
			}
		}
	}

}