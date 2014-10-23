package context {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.utils.*;
	import levelgen.Level;
	import context.ListMenu;
	import context.MenuUtils;
	
	import org.flixel.*;
	
	public class LevelSelectState extends FlxState {
		public var menu:ListMenu;
		public var levelNames:Vector.<String>;
		
		public var time:Number;
		public var zoom:Number;
		
		override public function create():void {
			zoom = 640 / 4;
			var dimensions:FlxPoint = new FlxPoint(4.0 * zoom, 3.0 * zoom);
			
			// Create background gradient
			var backgroundTile:FlxSprite = MenuUtils.CreateVerticalGradient(dimensions, 0x66cc00, 0x333300);
			add(backgroundTile);
			
			levelNames = new Vector.<String>();
			levelNames.push("1");
			levelNames.push("2");
			levelNames.push("3");
			levelNames.push("4aaa");
			levelNames.push("5bbb");
			levelNames.push("6ccc");
			//levelNames.push("TestWDoor");
			
			menu = new ListMenu(100, 100, 2);
			var i:uint;
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
			
			time = 0.0;
		}
		
		override public function update():void {
			time++;
			menu.Update();
			if (FlxG.keys.ENTER) {
				var level:int = menu.GetSelectedId() + 1;
				FlxG.switchState(new TransitionState(level));
			}
		}
	}
}