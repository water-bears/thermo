package {
	import org.flixel.FlxSprite;
	
	public class Key extends FlxSprite {
		
		private var gravity:Boolean;
		
		public function Key(x:Number, y:Number, gravity:Boolean = false) {
			super(x, y);
			
			this.gravity = gravity;
		}
		
	}
}