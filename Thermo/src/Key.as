package {
	import org.flixel.FlxSprite;
	
	public class Key extends FlxSprite {
		
		private var gravity:Boolean;
		
		public function Key(x:Number, y:Number, gravity:Boolean = false) {
			super(x, y);
			loadGraphic(Assets.keySprite, false, false, 32, 32);
			frame = 2;
			
			setOriginToCorner();
			scale.x = 20 / Assets.keySpriteX;
			scale.y = 20 / Assets.keySpriteY;
			width = 20;
			height = 20;
			this.x = x;
			this.y = y;
			
			maxVelocity.y = 500;
			maxVelocity.x = 0;
			acceleration.y = 1000;
			this.gravity = gravity;
			this.solid = true;
		}
		
		/*override public function update():void {
			
		}*/	
	}
}