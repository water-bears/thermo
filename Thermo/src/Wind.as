package {
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxBasic;
	
	public class Wind extends FlxGroup {
		private var intensity:Number = 30;
		
		private static const BUBBLE_DIAMETER:int = 3;
		
		private static const MIN_VELOCITY:Number = 10;
		private static const SCALE_VELOCITY:Number = 40;
		private static const DENSITY:Number = .5;
		private static const AMPLITUDE:Number = 20;
		private static const PERIOD:Number = 20;
		
		private static const COLOR:uint = 0x88ffffff;
		
		private var num_bubbles:int = 0;
		//private var bubbles:FlxGroup = new FlxGroup();
		private var bubbles:Array = new Array();
		private var main_sprite:FlxSprite = new FlxSprite();
		
		/* Directions
		 * 1 - left
		 * 2 - right
		 * 3 - up
		 * 4 - down
		 */
		private var direction:int;
		
		public function Wind(sprite:FlxSprite, direction:int = 1) {
			super();
			
			//main_sprite:FlxSprite = new FlxSprite();
			/*
			if (direction == 2) {
				main_sprite.loadGraphic(Assets.windrightSprite, false, false, Assets.windrightSpriteX, Assets.windrightSpriteY);
			} else {
				main_sprite.loadGraphic(Assets.windleftSprite, false, false, Assets.windleftSpriteX, Assets.windleftSpriteY);
			}
			*/
			
			main_sprite.setOriginToCorner();
			
			this.direction = direction;
			main_sprite.x = sprite.x;
			main_sprite.y = sprite.y;
			main_sprite.scale = sprite.scale;
			main_sprite.width = main_sprite.width * main_sprite.scale.x;
			main_sprite.height = main_sprite.height * main_sprite.scale.y;
			
			//add(main_sprite);
			//add(bubbles);
			
			for (var i:int = 0; i < main_sprite.width * main_sprite.health * DENSITY; i++ ) {
				
				var bubble:FlxSprite = new FlxSprite(main_sprite.x + Math.random() * (main_sprite.width - BUBBLE_DIAMETER),
					main_sprite.y + Math.random() * (main_sprite.height - BUBBLE_DIAMETER));
					
				bubble.loadGraphic(Assets.bubbleSprite);
					
				
				switch(direction) {
				case 2:
					bubble.velocity.x = MIN_VELOCITY + Math.random() * SCALE_VELOCITY;
					break;
				case 3:
					bubble.velocity.y = MIN_VELOCITY + Math.random() * SCALE_VELOCITY;
					break;
				case 4:
					bubble.velocity.y = -(MIN_VELOCITY + Math.random() * SCALE_VELOCITY);
					break;
				default:
					bubble.velocity.x = -(MIN_VELOCITY + Math.random() * SCALE_VELOCITY);
					break;
				}
				
				bubbles.push(bubble);
				this.add(bubble);
			}
		}
		
		public function blow(player:Player):void {
			if (player.bubble) {
				switch(direction) {						
				case 2:
					player.wind.x += intensity;
					break;
				case 3:
					player.wind.y += intensity;
					break;
				case 4:
					player.wind.y -= intensity;
					break;
				default:
					player.wind.x -= intensity;
					break;
				}
			}
		}
		
		override public function update():void {
			for (var i:int = 0; i < bubbles.length; i++) {
				var b:FlxSprite = bubbles[i];
				if (b.x < main_sprite.x || b.x+b.width > main_sprite.x + main_sprite.width
					|| b.y < main_sprite.y || b.y+b.height > main_sprite.y + main_sprite.height) {
						
					switch(direction) {
					case 2:
						b.x = main_sprite.x;
						b.y = main_sprite.y + Math.random() * (main_sprite.height - BUBBLE_DIAMETER);
						
						b.velocity.y = AMPLITUDE * Math.sin(b.x * 2 * Math.PI / PERIOD);
						break;
					case 3:
						b.x = main_sprite.x + Math.random() * (main_sprite.width - BUBBLE_DIAMETER);
						b.y = main_sprite.y;
						
						b.velocity.x = AMPLITUDE * Math.sin(b.y * 2 * Math.PI / PERIOD);
						break;
					case 4:
						b.x = main_sprite.x + Math.random() * (main_sprite.width - BUBBLE_DIAMETER);
						b.y = main_sprite.y + main_sprite.height - b.height;
						
						b.velocity.x = AMPLITUDE * Math.sin(b.y * 2 * Math.PI / PERIOD);
						break;
					default:
						b.x = main_sprite.x + main_sprite.width - b.width;
						b.y = main_sprite.y + Math.random() * (main_sprite.height - BUBBLE_DIAMETER);
						
						b.velocity.y = AMPLITUDE * Math.sin(b.x * 2 * Math.PI / PERIOD);
						break;
					}
				}
				
				switch(direction) {
				case 2:
					b.velocity.y = AMPLITUDE * Math.sin(b.x * 2 * Math.PI / PERIOD);
					/*
					if (b.x - main_sprite.x < 5)
						b.color += 20;
					else if (main_sprite.x + main_sprite.width - (b.x + b.width) < 5)
						b.color -= 20;
					*/
					break;
				case 3:
					b.velocity.x = AMPLITUDE * Math.sin(b.y * 2 * Math.PI / PERIOD);
					break;
				case 4:
					b.velocity.x = AMPLITUDE * Math.sin(b.y * 2 * Math.PI / PERIOD);
					break;
				default:
					b.velocity.y = AMPLITUDE * Math.sin(b.x * 2 * Math.PI / PERIOD);
					break;
				}
			}
			
			super.update();
		}
	}
}