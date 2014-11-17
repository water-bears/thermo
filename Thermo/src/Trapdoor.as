package {
	import org.flixel.*;
	
	public class Trapdoor extends FlxSprite {
		
		public function Trapdoor(x:Number, y:Number) {
			super();
			
			this.loadGraphic(Assets.trapdoorClosedSprite);
			
			setOriginToCorner();
			scale.x = 20 / Assets.trapdoorClosedSpriteX;
			scale.y = 10 / Assets.trapdoorClosedSpriteY;
			width = 20;
			height = 10;
			this.x = x;
			this.y = y;
			
			immovable = true;
		}
		
		public function open():void {
			// Change door to open sprite
			this.solid = false;
			this.loadGraphic(Assets.trapdoorOpenSprite);
		}
	}
}