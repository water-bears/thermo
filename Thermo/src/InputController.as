package {
	public class InputController {
		public function update():void {
			if (!bubble && !floatUp) {
				if (FlxG.keys.LEFT || FlxG.keys.A) {
					velocity.x = -maxVelocity.x;
					this.facing = FlxObject.RIGHT;
				}
			
				if (FlxG.keys.RIGHT || FlxG.keys.D) {
					velocity.x = maxVelocity.x;
					this.facing = FlxObject.LEFT;
				}
			
				if ((FlxG.keys.justPressed("W") || FlxG.keys.justPressed("UP")) && isTouching(FlxObject.FLOOR)) {
					velocity.y = -maxVelocity.y;
				} else if (FlxG.keys.justReleased("W") || FlxG.keys.justReleased("UP")) {
					if (velocity.y < -200 && velocity.y > -100) {
						velocity.y = -200;
					} else if (velocity.y < -100) {
						velocity.y = -100;
					}
				}
			}
			
			if (FlxG.keys.justPressed("SPACE") && !bubble && !superBubble && underwater) {
				usePower(waterTiles, this);
			} else if (FlxG.keys.justPressed("SPACE") && (bubble || superBubble)) {
				popBubble();
			}
			
			if (FlxG.keys.R){
					logger.recordEvent(level.levelNum, 5, "v2 $" + player.x +  ", " + player.y +"$ reset $ time =" + getTimer().toString());
					logger.recordLevelEnd();
					ui.BeginExitSequence(reset);
					player.visible = false;
			}
			
			if (FlxG.keys.SPACE || FlxG.keys.ENTER) {
					ui.FastForward();
			}
		}
	}
}