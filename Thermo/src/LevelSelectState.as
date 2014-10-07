// ActionScript file

package {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.utils.*;
	
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
			levelNames.push("TestWDoor");
						
			//this is stupid and hacky but it must happen
			//because actionscript is stupid and hacky
			Level_1;
			Level_2;
			Level_3;
			Level_TestWDoor;
			
			menu = new ListMenu(100, 100);
			var i:uint;
			for (i = 0; i < levelNames.length; i++)
			{
				var ft:FlxText = new FlxText(0, 0, 100, levelNames[i]);
				ft.setOriginToCorner();
				ft.scale = new FlxPoint(2, 2);
				menu.add(ft);
			}
			menu.setActive(true);
			add(menu);
			
			time = 0.0;
		}
		
		override public function update():void {
			time++;
			//title.y = titleY + 5 * Math.cos(time / 40.0);
			//prompt.y = promptY - 4 * Math.cos(time / 25.0);
			menu.update();
			if (FlxG.keys.ENTER)
			{
				var className:String = "Level_" + levelNames[menu.getSelectedIndex()];
				var nextLevel:Class = getDefinitionByName(className) as Class;
				var nextLevelInstance:* = new nextLevel(false);
				var p : PlayState = new PlayState();
				p.setLevel(nextLevelInstance);
				FlxG.switchState(p);
			}
		}
	}
	
}