package  
{
	/**
	 * ...
	 * @author KJin
	 */
	public class Utils 
	{
		public static function Clamp(value:Number, min:Number, max:Number) : Number
		{
			value = ((value > max) ? max : value);
			value = ((value < min) ? min : value);
			return value;
		}
		
		public static function Lerp(a:Number, b:Number, t:Number) : Number
		{
			return a + t * (b - a);
		}
		
		public static function ReverseLerp(a:Number, b:Number, v:Number) : Number
		{
			if (a == b) return Number.NaN;
			return (v - a) / (b - a);
		}
		
		public static function SmoothStep(a:Number, b:Number, t:Number) : Number
		{
			var num:Number = Clamp(t, 0, 1);
			return Lerp(a, b, num * num * (3 - 2 * num));
		}
	}

}