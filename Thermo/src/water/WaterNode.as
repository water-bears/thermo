package water
{
	import org.flixel.*;
	/**
	 * ...
	 * @author KJin
	 */
	public class WaterNode extends FlxBasic
	{
		private static const WATER_FORCE:Number = 15;
		
		private static var decay:Number = .99;
		// find out what these stand for
		private static var pwr:Number = 0.025;
		private static var ent:Number = 0.25;
		
		// Allow get or set
		public var Position:FlxPoint = new FlxPoint(0, 0);
		public var Velocity:FlxPoint = new FlxPoint(0, 0);
		public var InitialPosition:FlxPoint = new FlxPoint(0, 0);
		
		private var offsetAxis:FlxPoint;
		
		public var PrevNode:WaterNode = null;
		public var NextNode:WaterNode = null;
		private var time:uint;
		private var amplitude:Number;
		private var period:Number;
		
		private var module:WaterModule;
		
		public function WaterNode(module:WaterModule, pos_x:Number, pos_y:Number, tan_x:Number=0, tan_y:Number=0)
		{
			this.module = module;
			//deal with position
			Position.x = InitialPosition.x = pos_x;
			Position.y = InitialPosition.y = pos_y;
			
			// deal with offset axis
			var axisLength:Number = Math.sqrt(tan_x * tan_x + tan_y * tan_y);
			offsetAxis = new FlxPoint(tan_x, tan_y);
			if (axisLength > 0)
			{
				offsetAxis.x /= axisLength;
				offsetAxis.y /= axisLength;
			}
			time = 0;
			this.amplitude = 0;
			this.period = 0;
		}
		
		public function SetOscillation(initialTime:uint, amplitude:Number, period:Number) : void
		{
			time = initialTime;
			this.amplitude = amplitude;
			this.period = period;
		}
		
		override public function update():void 
		{
			super.update();
			
			Velocity.x *= decay;
			Velocity.y *= decay;
			
			Velocity.x -= (Position.x - InitialPosition.x) * pwr;
			Velocity.y -= (Position.y - InitialPosition.y) * pwr;
			
			Position.x += Velocity.x;
			Position.y += Velocity.y;
			
			var xd:Number, yd:Number, d:Number;
			xd = NextNode.Position.x - Position.x;
			yd = NextNode.Position.y - Position.y;
			d = xd * xd + yd * yd;
			if (d > WaterWaves.BlockSize * WaterWaves.BlockSize)
			{
				d = Math.sqrt(d);
				Position.x += ent * xd / d;
				Position.y += ent * yd / d;
				NextNode.Position.x -= ent * xd / d;
				NextNode.Position.y -= ent * yd / d;
			}
			time++;
			var p:Number = amplitude * Math.sin(time * 2 * Math.PI / period);
			Velocity.x += p * offsetAxis.x;
			Velocity.y += p * offsetAxis.y;
			
			xd = Position.x - module.PerturbationPosition.x;
			yd = Position.y - module.PerturbationPosition.y;
			d = Math.sqrt(xd * xd + yd * yd);
			if (d > 0 && d < WATER_FORCE)
			{
				xd /= d;
				yd /= d;
				Velocity.x = module.PerturbationDirection * WATER_FORCE * xd / d;
				Velocity.y = module.PerturbationDirection * WATER_FORCE * yd / d;
			}
			
			//HARD LIMIT on position to prevent overlap
			xd = Position.x - InitialPosition.x;
			yd = Position.y - InitialPosition.y;
			d = xd * xd + yd * yd;
			if (d > WaterWaves.BlockSize * WaterWaves.BlockSize * 0.2)
			{
				d = Math.sqrt(d);
				xd *= 0.4 * WaterWaves.BlockSize / d;
				yd *= 0.4 * WaterWaves.BlockSize / d;
				Position.x = InitialPosition.x + xd;
				Position.y = InitialPosition.y + yd;
			}
		}
	}

}