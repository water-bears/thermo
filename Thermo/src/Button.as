package {
	import org.flixel.FlxSprite;
	
	public class Button extends FlxSprite {
		
		private var isPressed:Boolean;
		private var door:Door;
		
		public function Button(x:Number, y:Number, door:Door) {
			super(x, y);
			
			this.door = door;
			this.isPressed = false;
		}
		
		public function pushed():void {
			this.isPressed = true;
			// Notify door that it should open
			door.open();
			// Change button to buttonPushed sprite
		}
	}
}