package {
	import org.flixel.FlxSprite;
	
	public class Key extends FlxSprite {
		
		private var gravity:Boolean;
		
		public function Key(x:Number, y:Number, gravity:Boolean = true) {
			super(x, y);
			loadGraphic(Assets.keySprite, false, false, 20, 20);
			
			
			//setOriginToCorner();
			//scale.x = 15 / Assets.keySpriteX;
			//scale.y = 15 / Assets.keySpriteY;
			//width = 15;
			//height = 15;
			this.x = x;
			this.y = y - 10;
			
			maxVelocity.y = 500;
			maxVelocity.x = 0;
			
			if (gravity)
			{
				acceleration.y = 1000;
			}
			this.solid = true;
		}
		
		override public function update():void {
			super.update();
			angle += 2;
		}
	}
}