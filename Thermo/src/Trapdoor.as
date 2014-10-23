package {
	import org.flixel.FlxSprite;
	
	public class Trapdoor extends FlxSprite {
		

		public function Trapdoor(x:Number, y:Number) {
        
			super(x, y);
			this.loadGraphic(Assets.trapdoorSprite);
			immovable = true;
            
		}
		
		public function open():void {
			// Change door to open sprite
			this.kill();
		}
	}
}