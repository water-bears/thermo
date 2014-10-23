package context {
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author KJin
	 */
	public class ComponentMotion 
	{
		protected var sprite:FlxSprite;
		protected var position:FlxPoint;
		protected var scale:FlxPoint;
		
		public function ComponentMotion() { }
		
		public function Initialize(component:MenuComponent) : void
		{
			this.sprite = component.GetSprite();
			this.position = component.GetLocalPosition();
			this.scale = component.GetLocalScale();
			InitializePrivate();
		}
		
		private function InitializePrivate() : void
		{
			// Implement
		}
		
		public function ForwardMotion() : void
		{
			// Implement
		}
		public function BackwardMotion() : void
		{
			// Implement
		}
	}

}