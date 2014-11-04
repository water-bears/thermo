package context {
	import context.ListMenu;
	import context.MenuUtils;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.utils.*;
	import Logging;
	
	import levelgen.Level;
	
	import org.flixel.*;
	
	public class LevelSelectState extends FlxState {
		public var menu:ListMenu;
		public var levelNames:Vector.<String>;
		
		public var time:Number;
		public var zoom:Number;
		
		public var title:FloatingText;
		
		public var bubbles:BubbleBackground;
		public var logger:Logging;

		public function LevelSelectState(logger:Logging){this.logger = logger;}
		
		override public function create():void {
			zoom = 1024 / 4;
			var dimensions:FlxPoint = new FlxPoint(4.0 * zoom, 3.0 * zoom);
			
			// Create background gradient
			var backgroundTile:FlxSprite = MenuUtils.CreateVerticalGradient(dimensions, 0x0066cc, 0x003333);
			add(backgroundTile);
			
			// Initialize bubbles
			bubbles = new BubbleBackground(dimensions, 50, 8, 16);
			bubbles.Register(this);
			
			// Initialize Title Text
			title = new FloatingText(0.4 * dimensions.x, 0.1 * dimensions.y, 0.15 * dimensions.x);
			title.SetOscillationSettings(5, 40);
			title.scale = new FlxPoint(dimensions.x / 64, dimensions.x / 64);
			title.color = 0xff0099ff;
			title.shadow = 0xff003399;
			title.alignment = "center";
			title.text = "Level Select";
			add(title);
			
			var i:uint;
			
			levelNames = new Vector.<String>();

			for (i = 0; i < TransitionState.numLevels; i++)
				levelNames.push(String(i + 1));
			//levelNames.push("TestWDoor");
			
			menu = new ListMenu(480, 300, 2);
			for (i = 0; i < levelNames.length; i++) {
				var ft:FlxText = new FlxText(0, 0, 100, levelNames[i]);
				ft.setOriginToCorner();
				var rmc:ReactiveMenuComponent = new ReactiveMenuComponent(ft);
				rmc.AddMotion(new UniformScaleComponentMotion());
				rmc.AddMotion(new XShiftComponentMotion(5));
				menu.AddComponent(rmc);
			}
			
			menu.SetIsActive(true);
			menu.Register(this);
		}
		
		override public function update():void {
			title.update();
			menu.Update();
			bubbles.Update();
			if (FlxG.keys.ENTER) {
				var level:int = menu.GetSelectedId() + 1;
				FlxG.switchState(new TransitionState(level, logger, level));
			}
		}
	}
}