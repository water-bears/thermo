package  
{
	import org.flixel.FlxSprite;
	
	public class Tree extends FlxSprite {
		
		public function Tree(sprite:FlxSprite) {
			super();
			
			this.x = sprite.x;
			this.y = sprite.y;
			angle = sprite.angle;
			scale = sprite.scale;
			scrollFactor = sprite.scrollFactor;
			width = width * scale.x;
			height = height * scale.y;
			
			//addAnimation("sway", [0, 1, 2, 3, 4, 3, 2, 1], Assets.FRAME_RATE / 10, true);
			loadGraphic(Assets.treeSprite, true, false, Assets.treeSpriteX, Assets.treeSpriteY);
			
			//play("sway");
		}
	}

}