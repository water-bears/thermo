package context 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GradientType;
	import flash.display.BlendMode;
	import flash.geom.Matrix;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author KJin
	 */
	public class BackgroundBubbleInternal
	{
		var x;
		var y;
		private var start:FlxPoint;
		private var end:FlxPoint;
		private var time:Number;
		private var increase:Number;
		private var bubbleBackground:BubbleBackgroundInternal;
		private var radius:uint;
		
		var colors:Array;
		var alphas:Array;
		var ratios:Array = new Array(0x00, 0xff);
		var matr:Matrix = new Matrix();
		
		public function BackgroundBubbleInternal(bubbleBackground:BubbleBackgroundInternal, color:uint) 
		{
			this.bubbleBackground = bubbleBackground;
			start = new FlxPoint();
			end = new FlxPoint();
			Reset();
			radius = uint(Math.random() * (bubbleBackground.maxRadius - bubbleBackground.minRadius) + bubbleBackground.minRadius);
			var red:uint = (color & 0xff0000) >> 16;
			var green:uint = (color & 0xff00) >> 8;
			var blue:uint = (color & 0xff);
			var scale:Number = 1;
			var color1:uint = (uint(red * scale) << 16) + (uint(green * scale) << 8) + uint(blue * scale);
			scale = 1;
			var color2:uint = (uint(red * scale) << 16) + (uint(green * scale) << 8) + uint(blue * scale);
			
			colors = new Array(color1, color2);
			alphas = new Array(0, 0);
		}
		
		public function Reset() : void
		{
			bubbleBackground.GetEdgePosition(start);
			bubbleBackground.GetEdgePosition(end);
			time = 0;
			increase = 0.001 * Math.random() + 0.0005;
		}
		
		public function Update() : void
		{
			time += increase;
			if (time > 0 && time < 1)
			{
				x = start.x + time * (end.x - start.x);
				y = start.y + time * (end.y - start.y);
				alphas[0] = alphas[1] = 0.5 * (1 - Math.pow(2 * time - 1, 2));
			}
			matr.createGradientBox(radius, radius, 0, x - radius / 2, y - radius / 2);
			if (time >= 1)
			{
				Reset();
			}
		}
		
		public function DrawToBitmap(bitmap:BitmapData) : void
		{
			var gfx:Graphics = FlxG.flashGfx;
			gfx.clear();
			gfx.beginGradientFill(GradientType.RADIAL, colors, alphas, ratios, matr);
			gfx.drawCircle(x, y, radius);
			gfx.endFill();
			bitmap.draw(FlxG.flashGfxSprite, null, null, BlendMode.MULTIPLY);
		}
	}
}