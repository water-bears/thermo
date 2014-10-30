package context {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	import org.flixel.*;
	
	public class MenuState extends FlxState {
		
		private var backgroundTile:FlxSprite;
		public var title:FloatingText;
		public var prompt:FloatingText;
		
		public var zoom:Number;
		
		private var bubbles:BubbleBackground;
		private var fade:FadeToBlack;
		
		override public function create():void {
			zoom = 1024 / 4;
			var dimensions:FlxPoint = new FlxPoint(4.0 * zoom, 3.0 * zoom);
			
			// Create background gradient
			backgroundTile = MenuUtils.CreateVerticalGradient(dimensions, 0x0066cc, 0x003333);
			add(backgroundTile);
			
			// Initialize bubbles
			bubbles = new BubbleBackground(dimensions, 50, 8, 16);
			bubbles.Register(this);
			
			// Initialize Title Text
			title = new FloatingText(0.4 * dimensions.x, 0.167 * dimensions.y, 0.15 * dimensions.x);
			title.SetOscillationSettings(5, 40);
			title.scale = new FlxPoint(dimensions.x / 64, dimensions.x / 64);
			title.color = 0xff0099ff;
			title.shadow = 0xff003399;
			title.alignment = "center";
			title.text = "Thermo";
			add(title);
			
			// Initialize Prompt
			prompt = new FloatingText(0.375 * dimensions.x, 0.667 * dimensions.y, 0.25 * dimensions.x);
			prompt.SetOscillationSettings(-4, 25);
			prompt.scale = new FlxPoint(dimensions.x / 160, dimensions.x / 160);
			prompt.color = 0xff0099ff;
			prompt.shadow = 0xff003399;
			prompt.alignment = "center";
			prompt.text = "Press ENTER";
			add(prompt);
			
			//fade = new FadeToBlack(dimensions, 50);
			//fade.Register(this);
			//fade.BeginFadeIn(null);
		}
		
		override public function update():void {
			title.update();
			prompt.update();
			bubbles.Update();
			//fade.Update();
			if (FlxG.keys.ENTER) {
				//fade.BeginFadeOut(goToNextState);
				goToNextState();
			}
			if (FlxG.keys.TAB) {
				FlxG.switchState(new ExperimentalState());
			}
		}
		
		private function goToNextState():void {
			var p : PlayState = new PlayState();
			FlxG.switchState(p);
		}
	}
}