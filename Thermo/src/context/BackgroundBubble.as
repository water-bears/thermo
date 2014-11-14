package context 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author KJin
	 */
	public class BackgroundBubble
	{
		private var bubble:FlxSprite;
		private var start:FlxPoint;
		private var end:FlxPoint;
		private var time:Number;
		private var increase:Number;
		private var bubbleBackground:BubbleBackground;
		
		public function BackgroundBubble(bubbleBackground:BubbleBackground) 
		{
			this.bubbleBackground = bubbleBackground;
			start = new FlxPoint();
			end = new FlxPoint();
			Reset();
			bubble = MenuUtils.CreateBubble(uint(Math.random() * (bubbleBackground.maxRadius - bubbleBackground.minRadius) + bubbleBackground.minRadius));
		}
		
		public function Reset() : void
		{
			bubbleBackground.GetEdgePosition(start);
			bubbleBackground.GetEdgePosition(end);
			time = 0;
			increase = 0.001 * Math.random() + 0.001;
		}
		
		public function Register(state:FlxState) : void
		{
			state.add(bubble);
		}
		
		public function Update() : void
		{
			time += increase;
			if (time > 0 && time < 1)
			{
				bubble.x = start.x + time * (end.x - start.x);
				bubble.y = start.y + time * (end.y - start.y);
				bubble.alpha = 0.2 * (1 - Math.pow(2 * time - 1, 2));
			}
			if (time >= 1)
			{
				Reset();
			}
		}
	}
}