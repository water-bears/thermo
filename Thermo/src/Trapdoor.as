package {
	import org.flixel.*;
	
	public class Trapdoor extends FlxSprite {
		
		public function Trapdoor(x:Number, y:Number) {
			super();
			
			this.makeGraphic(Assets.trapdoorSpriteX, Assets.trapdoorSpriteY, FlxG.WHITE);
			
			setOriginToCorner();
			scale.x = 20 / Assets.trapdoorSpriteX;
			scale.y = 20 / Assets.trapdoorSpriteY;
			width = 20;
			height = 20;
			this.x = x;
			this.y = y;
			
			immovable = true;
		}
		
		public function open():void {
			// Change door to open sprite
			this.kill();
		}
	}
}