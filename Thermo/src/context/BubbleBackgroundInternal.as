package context {
	import flash.display.BitmapData;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author KJin
	 */
	public class BubbleBackgroundInternal
	{
		private var numBubbles:uint;
		private var bubbles:Vector.<BackgroundBubbleInternal>;
		
		public var minRadius:uint;
		public var maxRadius:uint;
		
		private var width:uint;
		private var height:uint;
		
		public function BubbleBackgroundInternal(dimensions:FlxPoint, numBubbles:uint, minRadius:uint, maxRadius:uint, color:uint) 
		{
			this.numBubbles = numBubbles;
			this.minRadius = minRadius;
			this.maxRadius = maxRadius;
			bubbles = new Vector.<BackgroundBubbleInternal>(numBubbles);
			width = dimensions.x;
			height = dimensions.y;
			for (var i:uint = 0; i < numBubbles; i++)
			{
				bubbles[i] = new BackgroundBubbleInternal(this, color);
			}
		}
		
		public function GetEdgePosition(pointOut:FlxPoint) : void
		{
			pointOut.x = 2 * width * Math.random() - width / 2;
			pointOut.y = 2 * height * Math.random() - height / 2;
		}
		
		public function Update() : void
		{
			for (var i:uint = 0; i < numBubbles; i++)
			{
				bubbles[i].Update();
			}
		}
		
		public function DrawToBitmap(bitmap:BitmapData) : void
		{
			for (var i:uint = 0; i < numBubbles; i++)
			{
				bubbles[i].DrawToBitmap(bitmap);
			}
		}
	}

}