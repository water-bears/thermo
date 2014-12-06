package water
{
	import flash.geom.Rectangle;
	import org.flixel.*;
	import flash.display.*;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class WaterWaves extends FlxGroup 
	{
		private static var waterColor:uint = 0x660099FF;
		private static var rect:Rectangle = new Rectangle(0, 0, 640, 480);
		public static var BlockSize:uint = 20;
		
		public var PlayerPosition:FlxPoint = new FlxPoint();
		public var PlayerInWater:Boolean = false;
		
		private var modules:Vector.<WaterModule>;
		private var fill:FlxSprite = new FlxSprite(0, 0);
		
		public function WaterWaves(tiles:FlxTilemap) 
		{
			super();
			var points:Vector.<FlxPoint> = new Vector.<FlxPoint>();
			var marchInterval:Number = 20;
			var x:Number = 100;
			var y:Number = 100;
			fill.makeGraphic(rect.width, rect.height);
			add(fill);
			
			// iterate through our tilemap and collect borders
			var borders:Vector.<Vector.<FlxPoint>> = WaterUtils.GetBorders(tiles);
			modules = new Vector.<WaterModule>();
			for (var i:uint = 0; i < borders.length; i++)
			{
				for (var j:uint = 0; j < borders[i].length; j++)
				{
					borders[i][j].x *= BlockSize;
					borders[i][j].y *= BlockSize;
				}
				modules.push(new WaterModule(borders[i]));
				add(modules[i]);
			}
		}
		
		override public function update():void 
		{
			var i:uint;
			for (i = 0; i < modules.length; i++)
			{
				modules[i].PerturbationPosition.x = PlayerPosition.x;
				modules[i].PerturbationPosition.y = PlayerPosition.y;
				modules[i].PerturbationDirection = PlayerInWater ? 1 : 0;
			}
			super.update();
			var gfx:Graphics = FlxG.flashGfx;
			gfx.clear();
			gfx.lineStyle(1, waterColor);
			for (i = 0; i < modules.length; i++)
			{
				modules[i].Draw1();
			}
			fill.pixels.fillRect(rect, 0x00FFFFFF);
			fill.pixels.draw(FlxG.flashGfxSprite);
			for (i = 0; i < modules.length; i++)
			{
				modules[i].Draw2(fill, waterColor);
			}
			//fill.pixels.floodFill(nodes[0].Position.x + 20, nodes[0].Position.y + 20, waterColor);
			
			fill.dirty = true;
		}
	}
}