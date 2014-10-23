package context {
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author KJin
	 */
	public class BubbleBackground 
	{
		private var numBubbles:uint;
		private var bubbles:Vector.<FlxSprite>;
		
		private var width:uint;
		private var height:uint;
		
		public function BubbleBackground() 
		{
			numBubbles = 50;
			bubbles = new Vector.<FlxSprite>(numBubbles);
			for (var i:uint = 0; i < numBubbles; i++)
			{
				bubbles[i] = new FlxSprite(0, 0);
			}
		}
		
		// 0 or 1 = top left
		// 0.5 = bottom right
		public static function GetEdgePosition(percent:Number, pointOut:FlxPoint)
		{
			var distance:Number = percent * 2 * (width + height);
			if (distance <= width)
			{
				pointOut.x = distance;
				pointOut.y = 0;
			}
			else if (distance <= width + height)
			{
				pointOut.x = width;
				pointOut.y = distance - width;
			}
			else if (distance <= 2 * width + height)
			{
				pointOut.x = 2 * width - distance + height;
			}
		}
	}

}