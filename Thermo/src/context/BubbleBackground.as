package context {
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author KJin
	 */
	public class BubbleBackground 
	{
		private var numBubbles:uint;
		private var bubbles:Vector.<BackgroundBubble>;
		
		public var minRadius:uint;
		public var maxRadius:uint;
		
		private var width:uint;
		private var height:uint;
		
		public function BubbleBackground(dimensions:FlxPoint, numBubbles:uint, minRadius:uint, maxRadius:uint) 
		{
			this.numBubbles = numBubbles;
			this.minRadius = minRadius;
			this.maxRadius = maxRadius;
			bubbles = new Vector.<BackgroundBubble>(numBubbles);
			width = dimensions.x;
			height = dimensions.y;
			for (var i:uint = 0; i < numBubbles; i++)
			{
				bubbles[i] = new BackgroundBubble(this);
			}
		}
		
		public function Register(state:FlxState) : void
		{
			for (var i:uint = 0; i < numBubbles; i++)
			{
				bubbles[i].Register(state);
			}
		}
		
		public function GetEdgePosition(pointOut:FlxPoint) : void
		{
			pointOut.x = width * Math.random();
			pointOut.y = height * Math.random();
			/*if (distance < 0) distance = 0;
			if (distance > 1) distance = 1;
			var distance:Number = percent * 2 * (width + height);
			if (distance <= width)
			{
				pointOut.x = distance;
				pointOut.y = 0;
				return;
			}
			distance -= width;
			if (distance <= height)
			{
				pointOut.x = width;
				pointOut.y = distance;
				return;
			}
			distance -= height;
			if (distance <= width)
			{
				pointOut.x = width - distance;
				pointOut.y = height;
				return;
			}
			distance -= width;
			pointOut.x = 0;
			pointOut.y = height - distance;*/
		}
		
		public function Update() : void
		{
			for (var i:uint = 0; i < numBubbles; i++)
			{
				bubbles[i].Update();
			}
		}
	}

}