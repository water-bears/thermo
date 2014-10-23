package context {
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author KJin
	 */
	public class XShiftComponentMotion extends ComponentMotion 
	{
		protected var maxX:Number;
		protected var x:Number;
		protected var alpha:Number;
		
		public function XShiftComponentMotion(x:Number=1, alpha:Number=0.5) 
		{
			super();
			this.x = 1;
			maxX = x;
			this.alpha = alpha;
		}
		
		override public function ForwardMotion():void 
		{
			x += (maxX - x) * alpha;
			position.x = x;
		}
		
		override public function BackwardMotion():void 
		{
			x += (1 - x) * alpha;
			position.x = x;
		}
	}

}