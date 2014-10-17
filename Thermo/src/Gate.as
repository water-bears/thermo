package {
	import org.flixel.FlxSprite;
	
	public class Gate extends FlxSprite {
		/* Gate types
		 * 1 - Freeze
		 * 2 - Heat
		 * 3 - Flash
		 */
		private var type:int;
		
		public function Gate(x:Number, y:Number, type:int) {
			super(x, y);
			
			this.type = type;
		}
	}
