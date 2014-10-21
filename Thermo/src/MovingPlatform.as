package {
	import org.flixel.FlxSprite;
	import data.Library;
	
	public class MovingPlatform extends FlxSprite {
		
		private var startPos:int
		private var endPos:int

		/* Directions
		 * 1 - right
		 * 2 - left
		 * 3 - up
		 * 4 - down
		 */
		private var direction:int;
		
		public function MovingPlatform(x:int, y:int, startPos:int, endPos:int, direction:int):void {
			super(x, y);
			// load sprite image
			
			this.startPos = startPos;
			this.endPos = endPos;
			
			this.direction = direction;
			switch (direction) {
				case 1:
					velocity.x = 50;
					break;
				case 2:
					velocity.x = -50;
					break;
				case 3:
					velocity.y = 50;
					break;
				case 4:
					velocity.y = -50;
					break;
			}
			
			this.drag.x = this.drag.y = 0;
		}

		override public function update():void {			
			switch (direction) {
				case 1:
					if (this.x >= this.endPos) flipDirection();
					break;
				case 2:
					if (this.x <= this.startPos) flipDirection();
					break;
				case 3:
					if (this.y >= this.endPos) flipDirection();
					break;
				case 4:
					if (this.y <= this.startPos) flipDirection();
					break;
			}
			
			super.update();
		}
		
		public function flipDirection():void {
			switch (direction) {
				case 1:
					direction = 2;
					break;
				case 2:
					direction = 1;
					break;
				case 3:
					direction = 4;
					break;
				case 4:
					direction = 3;
					break;
			}
			velocity.x *= -1;
			velocity.y *= -1;
		}
	}
}