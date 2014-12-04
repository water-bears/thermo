package uilayer 
{
	import flash.geom.Rectangle;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class LevelSelectItem extends FlxGroup
	{
		public static var xMin:Number = 0.2 * FlxG.width;
		public static var xMax:Number = 0.8 * FlxG.width;
		public static var yMin:Number = 0.4 * FlxG.height;
		public static var yMax:Number = 0.8 * FlxG.height;
		
		private var itemText:FlxText;
		private var lockedNumber:FlxText;
		private var symbol:FlxSprite;
		
		private var itemText_x12:PiecewiseInterpolationMachine;
		private var itemText_y2:PiecewiseInterpolationMachine;
		
		public var levelNum:uint;
		public var levelName:String;
		public var levelColor:uint;
		public var completed:Boolean;
		public var locked:Boolean;
		
		public var selected:Boolean;
		public var state:uint;
		
		public var MouseOverRectangle:Rectangle;
		
		public function LevelSelectItem(x:uint, y:uint) 
		{
			super();
			levelNum = MenuUI.levelSelectWidth * y + x;
			levelName = LevelServices.GetHumanReadableLevelName(levelNum);
			levelColor = LevelServices.GetLevelSelectColor(levelNum);
			completed = LevelServices.Completed(levelNum);
			locked = !LevelServices.Unlocked(levelNum);
			itemText = new FlxText(Utils.Lerp(xMin, xMax, x / (MenuUI.levelSelectWidth - 1)),
								   Utils.Lerp(yMin, yMax, y / (MenuUI.levelSelectHeight - 1)),
								   50, levelName);
			itemText.setFormat(Assets.font_name, 15, 0xffffffff, "center");
			
			if (completed)
			{
				symbol = new FlxSprite(0, 0, Assets.starSprite);
			}
			if (locked)
			{
				symbol = new FlxSprite(0, 0, Assets.lockSprite);
				if (levelNum >= LevelServices.NUM_LEVELS)
				{
					lockedNumber = new FlxText(0, 0, 20, String(LevelServices.S_LEVEL_UNLOCKED_AFTER[levelNum - LevelServices.NUM_LEVELS]));
					lockedNumber.setFormat(Assets.font_name, 10, 0xff9999, "center");
					symbol.color = 0xff0000;
				}
			}
			
			if (symbol != null)
			{
				add(symbol);
			}
			if (lockedNumber != null)
			{
				add(lockedNumber);
			}
			else if (symbol != null)
			{
				symbol.scale.x = symbol.scale.y = 0.5;
			}
			
			itemText_x12 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Hermite, 0, 2 * FlxG.width, 0, 0),
				new PiecewiseInterpolationNode(null, 80, itemText.x));
			itemText_y2 = Utils.CreatePeriodic(itemText.y, 5, 100);
			MouseOverRectangle = new Rectangle(itemText.x, itemText.y, itemText.width - 20, itemText.height);
			MouseOverRectangle.inflate(30, 10);
			
			add(itemText);
		}
		
		override public function update():void
		{
			if (selected)
			{
				if (Math.abs(itemText.size - 25) > 0.1)
				{
					itemText.size = Utils.Lerp(itemText.size, 25, 0.2);
				}
				if (itemText.color != 0x00ff00)
				{
					itemText.color = 0x00ff00;
				}
			}
			else
			{
				if (Math.abs(itemText.size - 15) > 0.1)
				{
					itemText.size = Utils.Lerp(itemText.size, 15, 0.2);
				}
				if (locked)
				{
					if (itemText.color != 0x000000)
					{
						itemText.color = 0x000000;
					}
				}
				else
				{
					if (itemText.color != levelColor)
					{
						itemText.color = levelColor;
					}
				}
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
			if (symbol != null)
			{
				symbol.x = itemText.x + 0;
				symbol.y = itemText.y + 0;
			}
			if (lockedNumber != null)
			{
				lockedNumber.x = itemText.x - 2;
				lockedNumber.y = itemText.y + 9;
			}
			MouseOverRectangle.x = itemText.x;
			MouseOverRectangle.y = itemText.y;
		}
	}

}