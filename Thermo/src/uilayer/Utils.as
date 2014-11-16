package uilayer {
	import uilayer.PiecewiseInterpolationNode;
	import uilayer.PiecewiseInterpolationMachine;

	public class Utils {
		public static function Clamp(value:Number, min:Number, max:Number):Number
		{
			value = ((value > max) ? max : value);
			value = ((value < min) ? min : value);
			return value;
		}
		
		public static function ReverseLerp(a:Number, b:Number, v:Number):Number
		{
			if (a == b) return Number.NaN;
			return (v - a) / (b - a);
		}
		
		/*
		 * All interpolation functions below have the following properties:
		 * f(0) = a
		 * f(1) = b
		 * f'(t) >= 0 for 0 <= t <= 1 (in other words, monotonically increasing between a and b)
		 */
		
		// Linear interpolation
		public static function Lerp(a:Number, b:Number, t:Number) : Number
		{
			return a + t * (b - a);
		}
		
		// Cubic Smooth step interpolation
		public static function SmoothStep(a:Number, b:Number, t:Number) : Number
		{
			var num:Number = Clamp(t, 0, 1);
			return Lerp(a, b, num * num * (3.0 - 2.0 * num));
		}
		
		// Concave quarter-sine interpolation
		public static function ConcaveSine(a:Number, b:Number, t:Number) : Number
		{
			return Lerp(a, b, Math.sin(t * Math.PI / 2));
		}
		
		// Convex quarter-sine interpolation
		public static function ConvexSine(a:Number, b:Number, t:Number) : Number
		{
			return Lerp(a, b, 1 - Math.cos(t * Math.PI / 2));
		}
		
		public static function Hermite(a:Number, b:Number, at:Number, bt:Number, t:Number) : Number
		{
			var num:Number = t * t;
			var num2:Number = t * num;
			var num3:Number = 2 * num2 - 3 * num + 1;
			var num4:Number = -2 * num2 + 3 * num;
			var num5:Number = num2 - 2 * num + t;
			var num6:Number = num2 - num;
			return a * num3 + b * num4 + at * num5 + bt * num6;
		}
		
		/*
		 * Common interpolation patterns.
		 */
		
		public static function CreatePeriodic(dc:Number, amplitude:Number, period:Number, phase:Number = 0) : PiecewiseInterpolationMachine
		{
			return new PiecewiseInterpolationMachine(true,
				new PiecewiseInterpolationNode(ConcaveSine, 0, dc),
				new PiecewiseInterpolationNode(ConvexSine, period / 4, dc + amplitude),
				new PiecewiseInterpolationNode(ConcaveSine, period / 2, dc),
				new PiecewiseInterpolationNode(ConvexSine, 3 * period / 4, dc - amplitude),
				new PiecewiseInterpolationNode(null, period, dc));
		}
	}
}