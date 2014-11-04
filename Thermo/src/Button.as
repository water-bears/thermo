package {
	import org.flixel.FlxSprite;
	
	public class Button extends FlxSprite {
		
		private var isPressed:Boolean;
		public var trapdoor:Trapdoor;
		
		public function Button(x:Number, y:Number, trapdoor:Trapdoor) {
			super();
			
			this.loadGraphic(Assets.buttonSprite, true, false, 20, 8);
			
			this.addAnimation("flash", [0, 1], Assets.FRAME_RATE / 15, true);
			this.addAnimation("pressed", [2]);
			
			//setOriginToCorner();
			//scale.x = 20 / Assets.buttonSpriteX;
			//scale.y = 20 / Assets.buttonSpriteY;
			//width = 20;
			//height = 20;
			this.x = x;
			this.y = y + 12;
			
			this.trapdoor = trapdoor;
			this.isPressed = false;
			
			this.play("flash");
		}
		
		public function pushed():void {
			if (!isPressed)
				trapdoor.open();
			this.isPressed = true;
			//this.kill();
			// Change button to buttonPushed sprite
			this.play("pressed");
		}
	}
}