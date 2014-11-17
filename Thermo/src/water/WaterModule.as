package water
{
	import org.flixel.*;
	import flash.display.*;
	/**
	 * ...
	 * @author KJin
	 */
	public class WaterModule extends FlxGroup
	{
		private var waterNodes:Vector.<WaterNode>;
		private var arcNodes:Vector.<FlxPoint>;
		
		public var PerturbationPosition:FlxPoint = new FlxPoint();
		public var PerturbationDirection:Number = 0;
		
		public function WaterModule(points:Vector.<FlxPoint>) 
		{
			waterNodes = new Vector.<WaterNode>();
			arcNodes = new Vector.<FlxPoint>();
			
			var i:uint;
			for (i = 0; i < points.length; i++)
			{
				waterNodes.push(new WaterNode(this, points[i].x, points[i].y, 0, 1));
				add(waterNodes[i]);
				if (i > 0)
				{
					waterNodes[i].PrevNode = waterNodes[i - 1];
					waterNodes[i - 1].NextNode = waterNodes[i];
				}
			}
			var i2:uint = points.length - 1;
			for (i = 0; i < points.length; i++)
			{
				arcNodes.push(new FlxPoint());
				arcNodes[i].x = waterNodes[i].Position.x + (waterNodes[i2].Position.x - waterNodes[i].Position.x) / 2;
				arcNodes[i].y = waterNodes[i].Position.y + (waterNodes[i2].Position.y - waterNodes[i].Position.y) / 2;
				waterNodes[i].PrevNode = waterNodes[i2];
				waterNodes[i2].NextNode = waterNodes[i];
				waterNodes[i].SetOscillation(60 * i, 0.1, 155);
				i2 = i;
			}
		}
		
		public function Draw1() : void
		{
			var gfx:Graphics = FlxG.flashGfx;
			var i:uint;
			var i2:uint = arcNodes.length - 1;
			for (i = 0; i < arcNodes.length; i++)
			{
				arcNodes[i].x = waterNodes[i].Position.x + (waterNodes[i2].Position.x - waterNodes[i].Position.x) / 2;
				arcNodes[i].y = waterNodes[i].Position.y + (waterNodes[i2].Position.y - waterNodes[i].Position.y) / 2;
				i2 = i;
			}
			i2 = arcNodes.length - 1;
			for (i = 0; i < arcNodes.length; i++)
			{
				gfx.moveTo(arcNodes[i].x, arcNodes[i].y);
				gfx.curveTo(waterNodes[i2].Position.x, waterNodes[i2].Position.y,
					arcNodes[i2].x, arcNodes[i2].y);
				i2 = i;
			}
		}
		
		public function Draw2(fill:FlxSprite, color:uint) : void
		{
			fill.pixels.floodFill(waterNodes[0].Position.x + WaterWaves.BlockSize / 2, waterNodes[0].Position.y + WaterWaves.BlockSize / 2, color);
		}
	}

}