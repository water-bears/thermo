import context.PixelBubble;
package context {
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author KJin
	 */
	public class PixelBubbleSystem extends FlxGroup
	{
		var bubbles:Vector.<PixelBubble>;
		public var player:Player;
		public var color:uint;
		
		public function PixelBubbleSystem(numBubbles:uint, player:Player) 
		{
			super();
			bubbles = new Vector.<PixelBubble>();
			this.player = player;
			for (var i:uint = 0; i < numBubbles; i++)
			{
				bubbles.push(new PixelBubble(this));
				add(bubbles[i]);
			}
		}
		
		override public function update():void 
		{
			super.update();
			if (player.curPow == 1 || player.curPow == 3)
			{
				color = 0x00ffff;
			}
			else if (player.curPow == 2 || player.curPow == 4)
			{
				color = 0xff0000;
			}
		}
	}

}