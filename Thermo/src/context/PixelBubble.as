import context.PixelBubbleSystem;
package context {
	import flash.display.ColorCorrection;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import flash.display.Graphics;
	/**
	 * ...
	 * @author KJin
	 */
	public class PixelBubble extends FlxSprite
	{
		var on:Boolean;
		var countDown:uint;
		var system:PixelBubbleSystem;
		var radius:uint = 1;
		var myColor:uint;
		
		public function PixelBubble(system:PixelBubbleSystem) 
		{
			super();
			this.system = system;
			on = false;
			init();
		}
		
		private function init()
		{
			on = !on;
			if (!on)
			{
				makeGraphic(2 * radius, 2 * radius, 0x00ffffff);
				
				var gfx:Graphics = FlxG.flashGfx;
				gfx.clear();
				gfx.beginFill(system.color, 0.5);
				gfx.drawCircle(radius, radius, radius);
				
				pixels.draw(FlxG.flashGfxSprite);
				dirty = true;
				alpha = 0;
				this.myColor = system.color;
			}
			else
			{
				alpha = 1;
				x = system.player.x + system.player.width / 2 + system.player.width * (Math.random() - 0.5);
				y = system.player.y + system.player.height * (Math.random() - 0.5);
			}
			countDown = int(Math.random() * 50) + 5;
		}
		
		override public function update():void 
		{
			super.update();
			if (on)
			{
				y -= 0.5;
			}
			if (countDown > 0)
				countDown--;
			else
				init();
			if (system.player.curPow == 0 || myColor & 0xffffff == 0)
			{
				alpha = 0;
			}
		}
	}

}