package context {
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author KJin
	 */
	public class UniformScaleComponentMotion extends ComponentMotion 
	{
		protected var maxZoom:Number;
		protected var zoom:Number;
		protected var alpha:Number;
		
		public function UniformScaleComponentMotion(zoom:Number=2, alpha:Number=0.5) 
		{
			super();
			this.zoom = 1;
			maxZoom = zoom;
			this.alpha = alpha;
		}
		
		override public function ForwardMotion():void 
		{
			zoom += (maxZoom - zoom) * alpha;
			scale.x = zoom;
			scale.y = zoom;
		}
		
		override public function BackwardMotion():void 
		{
			zoom += (1 - zoom) * alpha;
			scale.x = zoom;
			scale.y = zoom;
		}
	}
}