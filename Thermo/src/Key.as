package {
	import org.flixel.FlxSprite;

	
	public class Key extends FlxSprite {
		
		private var gravity:Boolean;
		
		public function Key(x:Number, y:Number, gravity:Boolean = false) {
			super(x, y);
			loadGraphic(Assets.exitSprite, false, false, 32, 32)
			frame = 2;
			
			maxVelocity.y = 80;
			maxVelocity.x = 0;
			acceleration.y = 600;
			this.gravity = gravity;
			this.solid = true;
		}
		
		/*override public function update():void {
			
		}*/
		
	}
	
}