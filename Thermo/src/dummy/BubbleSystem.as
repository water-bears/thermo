package dummy {
	import dummy.Bubble;
	import flash.display.BitmapData;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author KJin
	 */
	public class BubbleSystem
	{
		private var numBubbles:uint;
		private var bubbles:Vector.<Bubble>;
		
		public var minRadius:uint;
		public var maxRadius:uint;
		
		var player:Player;
		
		public function BubbleSystem(player:Player, numBubbles:uint, minRadius:uint, maxRadius:uint) 
		{
			this.numBubbles = numBubbles;
			this.minRadius = minRadius;
			this.maxRadius = maxRadius;
			this.player = player;
			bubbles = new Vector.<Bubble>(numBubbles);
			for (var i:uint = 0; i < numBubbles; i++)
			{
				bubbles[i] = new Bubble(this);
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
			pointOut.x = player.x + player.width * Math.random();
			pointOut.y = player.y + player.height * Math.random() * 0.8;
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