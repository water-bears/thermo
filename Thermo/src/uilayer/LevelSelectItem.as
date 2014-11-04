package uilayer 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class LevelSelectItem extends FlxGroup
	{
		static var xMin = 0.2 * FlxG.width;
		static var xMax = 0.8 * FlxG.width;
		static var yMin = 0.4 * FlxG.height;
		static var yMax = 0.8 * FlxG.height;
		
		private var itemText:FlxText;
		
		private var itemText_x12:PiecewiseInterpolationMachine;
		private var itemText_y2:PiecewiseInterpolationMachine;
		
		public var levelNum:uint;
		
		public var selected:Boolean;
		public var state:uint;
		
		public function LevelSelectItem(x:uint, y:uint) 
		{
			super();
			levelNum = MenuUI.levelSelectWidth * y + x;
			itemText = new FlxText(Utils.Lerp(xMin, xMax, x / (MenuUI.levelSelectWidth - 1)),
								   Utils.Lerp(yMin, yMax, y / (MenuUI.levelSelectHeight - 1)),
								   50, String(levelNum + 1));
			
			itemText_x12 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Hermite, 0, 2 * FlxG.width, 0, 0),
				new PiecewiseInterpolationNode(null, 80, itemText.x));
			itemText_y2 = Utils.CreatePeriodic(itemText.y, 5, 100);
			
			add(itemText);
		}
		
		override public function update():void 
		{
			super.update();
			if (selected)
			{
				itemText.scale.x = itemText.scale.y = 2;
			}
			else
			{
				itemText.scale.x = itemText.scale.y = 1;
			}
			if (state == 0)
			{
				itemText.x = itemText_x12.Evaluate();
			}
			else if (state == 1)
			{
				itemText.x = itemText_x12.EvaluateAndAdvance();
				itemText.y = itemText_y2.EvaluateAndAdvance();
			}
			else if (state == 2)
			{
				itemText_x12.FastForward();
				itemText.x = itemText_x12.Evaluate();
				itemText.y = itemText_y2.EvaluateAndAdvance();
			}
		}
	}

}