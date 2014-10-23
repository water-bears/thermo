package {
	import org.flixel.*;
	
	public class Trapdoor extends FlxSprite {
		

		public function Trapdoor(x:Number, y:Number) {
        
			super(x, y);
			this.makeGraphic(32, 32, FlxG.WHITE);
			immovable = true;
            
		}
		
		public function open():void {
			// Change door to open sprite
			this.kill();
		}
	}
}