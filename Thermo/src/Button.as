package {
	import org.flixel.FlxSprite;
	
	public class Button extends FlxSprite {
		
		private var isPressed:Boolean;
		private var door:Door;
		
		public function Button(x:Number, y:Number, door:Door) {
			super(x, y);
			
			this.loadGraphic(Assets.buttonSprite);
			this.door = door;
			this.isPressed = false;
		}
		
		public function pushed():void {
			if (!isPressed)
				door.open();
				
			this.isPressed = true;
			this.kill();
			// Change button to buttonPushed sprite
		}
	}
}