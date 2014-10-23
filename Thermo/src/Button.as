package {
	import org.flixel.FlxSprite;
	
	public class Button extends FlxSprite {
		
		private var isPressed:Boolean;
		private var trapdoor:Trapdoor;
		
		public function Button(x:Number, y:Number, trapdoor:Trapdoor) {
			super(x, y);
			
			this.loadGraphic(Assets.buttonSprite);
			this.trapdoor = trapdoor;
			this.isPressed = false;
		}
		
		public function pushed():void {
			if (!isPressed)
				trapdoor.open();
			this.isPressed = true;
			this.kill();
			// Change button to buttonPushed sprite
		}
	}
}