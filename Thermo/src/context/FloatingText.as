package context 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class FloatingText extends FlxText 
	{
		public var realPosition:FlxPoint;
		
		public var amplitude:Number;
		public var period:Number;
		public var phase:Number;
		
		public var time:Number;
		
		public function FloatingText(X:Number, Y:Number, Width:uint, Text:String=null, EmbeddedFont:Boolean=true) 
		{
			super(X, Y, Width, Text, EmbeddedFont);
			realPosition = new FlxPoint(X, Y);
			time = 0;
		}
		
		public function SetOscillationSettings
			(amplitude:Number, period:Number, phase:Number=0) : void
		{
			this.amplitude = amplitude;
			this.period = period;
			this.phase = phase;
		}
		
		override public function update():void 
		{
			super.update();
			time++;
			y = realPosition.y + amplitude * Math.sin(time / period + phase);
		}
	}

}