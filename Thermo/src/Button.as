package {
	import org.flixel.FlxSprite;
	
	public class Button extends FlxSprite {
		
		private var isPressed:Boolean;
		public var trapdoor:Trapdoor;
		
		public function Button(x:Number, y:Number, trapdoor:Trapdoor) {
			super();
			
			this.loadGraphic(Assets.buttonSprite);
			
			setOriginToCorner();
			scale.x = 20 / Assets.buttonSpriteX;
			scale.y = 20 / Assets.buttonSpriteY;
			width = 20;
			height = 20;
			this.x = x;
			this.y = y;
			
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