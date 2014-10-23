package {
	import org.flixel.FlxSprite;
	
	public class Door extends FlxSprite {
		
		public function Door(x:Number, y:Number) {
			super(x, y);
			this.loadGraphic(Assets.doorSprite);
			immovable = true;
		}
		
		public function open() {
			// Change door to open sprite
			this.kill();
		}
	}
}