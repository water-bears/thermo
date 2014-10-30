package context 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GradientType;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author KJin
	 */
	public class GlowingBackground 
	{
		private var buffer:BitmapData;
		private var filter:BitmapFilter;
		private var sprite:FlxSprite;
		//private var masterSprite:FlxSprite;
		private var input:Vector.<uint>;
		private var realDim:FlxPoint = new FlxPoint(1024, 768);
		private var scale:Number = 32;
		private var dim:FlxPoint = new FlxPoint(realDim.x / scale, realDim.y / scale);
		private var rect:Rectangle = new Rectangle(0, 0, dim.x, dim.y);
		private var p:Point = new Point(0, 0);
		var timer = 0;
		private var bubbles:BubbleBackgroundInternal;
		
		var colors:Array = new Array(0xff0000, 0x0000ff);
		var alphas:Array = new Array(1, 1);
		var ratios:Array = new Array(0x00, 0xff);
		
		public function GlowingBackground():void 
		{
			var color:uint = 0xff66cc99;
			// Initialize bubbles
			bubbles = new BubbleBackgroundInternal(dim, 20, 5, 15, color);
			
			sprite = MenuUtils.CreateSolid(new FlxPoint(dim.x, dim.y), color);
			sprite.setOriginToCorner();
			sprite.scale.x = scale;
			sprite.scale.y = scale;
			input = new Vector.<uint>();
			input.length = dim.x * dim.y;
			input.fixed = true;
			for (var i:uint = 0; i < input.length; i++)
			{
				input[i] = color - 0xcc000000;
			}
			buffer = sprite.pixels.clone();
			buffer.setVector(rect, input);
			var a:Array = new Array(1,4,7,4,1,4,16,26,16,4,7,26,41,26,7,4,16,26,16,4,1,4,7,4,1);
			filter = new ConvolutionFilter(5, 5, a, 273);
		}
		
		public function Update():void 
		{
			bubbles.Update();
			bubbles.DrawToBitmap(sprite.pixels);
			sprite.pixels.draw(buffer);
			sprite.pixels.applyFilter(sprite.pixels, rect, p, filter);
			sprite.dirty = true;
		}
		
		public function Register(state:FlxState) : void
		{
			state.add(sprite);
		}
	}

}