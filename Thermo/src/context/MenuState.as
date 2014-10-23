package context {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	import org.flixel.*;
	
	public class MenuState extends FlxState {
		
		private var backgroundTile:FlxSprite;
		public var title:FlxText;
		public var prompt:FlxText;
		public var time:Number;
		
		public var zoom:Number;
		public var titleY:Number;
		public var promptY:Number;
		
		public var bubbles:BubbleBackground;
		
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
			title = new FlxText(0.425 * dimensions.x, 0.167 * dimensions.y, 0.15 * dimensions.x);
			title.scale = new FlxPoint(dimensions.x / 64, dimensions.x / 64);
			title.color = 0xff0099ff;
			title.shadow = 0xff003399;
			title.alignment = "center";
			title.text = "Thermo";
			titleY = title.y;
			add(title);
			
			// Initialize Prompt
			prompt = new FlxText(0.375 * dimensions.x, 0.667 * dimensions.y, 0.25 * dimensions.x);
			prompt.scale = new FlxPoint(dimensions.x / 160, dimensions.x / 160);
			prompt.color = 0xff0099ff;
			prompt.shadow = 0xff003399;
			prompt.alignment = "center";
			prompt.text = "Press TAB";
			promptY = prompt.y;
			add(prompt);
			
			time = 0.0;
		}
		
		override public function update():void {
			time++;
			title.y = titleY + 5 * Math.cos(time / 40.0);
			prompt.y = promptY - 4 * Math.cos(time / 25.0);
			bubbles.Update();
			if (FlxG.keys.TAB) {
				var p : PlayState = new PlayState();
				FlxG.switchState(p);
			}
		}
	}
}