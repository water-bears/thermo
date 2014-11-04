package uilayer {
	import uilayer.Utils;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import context.MenuUtils;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class MenuUI extends FlxGroup 
	{
		public static var levelSelectWidth:uint = 5;
		public static var levelSelectHeight:uint = 3;
		public static var levelAdvanceRate:uint = 10;
		
		private var dimmer:FlxSprite;
		private var titleText:FlxText;
		private var promptText:FlxText;
		private var levelSelectText:FlxText;
		private var levelSelectItems:Array;
		
		private var dimmer_alpha1:PiecewiseInterpolationMachine;
		private var titleText_y01:PiecewiseInterpolationMachine;
		private var titleText_y1:PiecewiseInterpolationMachine;
		private var levelSelectText_y1:PiecewiseInterpolationMachine;
		private var levelSelectText_y12:PiecewiseInterpolationMachine;
		private var promptText_y01:PiecewiseInterpolationMachine;
		private var promptText_y1:PiecewiseInterpolationMachine;
		
		private var state:uint;
		private var callback:Function;
		
		public function MenuUI(initialState:uint, callback:Function)
		{
			super(0);
			state = initialState;
			this.callback = callback;
			
			var dimensions:FlxPoint = new FlxPoint(FlxG.width, FlxG.height);
			
			// Title Text
			titleText = new FlxText(0, 0, FlxG.width, "Thermo");
			titleText.alignment = "center";
			titleText.scale.x = titleText.scale.y = dimensions.x / 64;
			titleText.color = 0xff0099ff;
			titleText.shadow = 0xff003399;
			titleText.alignment = "center";
			add(titleText);
			
			promptText = new FlxText(0, 0, FlxG.width, "Press ENTER");
			promptText.scale.x = promptText.scale.y = dimensions.x / 160;
			promptText.color = 0xff0099ff;
			promptText.shadow = 0xff003399;
			promptText.alignment = "center";
			add(promptText);
			
			levelSelectText = new FlxText(0, 0, FlxG.width, "Level Select");
			levelSelectText.alignment = "center";
			levelSelectText.scale.x = levelSelectText.scale.y = dimensions.x / 64;
			levelSelectText.color = 0xff0099ff;
			levelSelectText.shadow = 0xff003399;
			levelSelectText.alignment = "center";
			add(levelSelectText);
			
			levelSelectItems = new Array(levelSelectWidth);
			for (var i:uint = 0; i < levelSelectWidth; i++)
			{
				levelSelectItems[i] = new Array(levelSelectHeight);
				for (var j:uint = 0; j < levelSelectHeight; j++)
				{
					levelSelectItems[i][j] = new LevelSelectItem(i, j);
					add(levelSelectItems[i][j]);
				}
			}
			
			selectedSquare = new FlxPoint();
			selectedLevel = 0;
			keyFramesDown = 0;
			
			// Something that helps darken the level when important UI is up
			// This should come up last so it covers everything.
			dimmer = MenuUtils.CreateSolid(new FlxPoint(dimensions.x + 1, dimensions.y), 0x000000);
			add(dimmer);
			
			dimmer.alpha = 0;
			dimmer_alpha1 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 0),
				new PiecewiseInterpolationNode(null, 20, 1));
			
			titleText_y01 = Utils.CreatePeriodic(0.2 * dimensions.y, 20, 400);
			promptText_y01 = Utils.CreatePeriodic(0.7 * dimensions.y, 10, 200);
			titleText_y1 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.SmoothStep, 0, 0),
				new PiecewiseInterpolationNode(null, 100, -500));
			promptText_y1 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.SmoothStep, 0, 0),
				new PiecewiseInterpolationNode(null, 100, 400));
			levelSelectText_y1 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.SmoothStep, 0, -500),
				new PiecewiseInterpolationNode(null, 40, 0));
			levelSelectText_y12 = Utils.CreatePeriodic(0.05 * dimensions.y, 10, 400);
		}
		
		override public function update():void 
		{
			super.update();
			// Adjust values depending on time.
			for (var i:uint = 0; i < levelSelectWidth; i++)
			{
				for (var j:uint = 0; j < levelSelectHeight; j++)
				{
					levelSelectItems[i][j].selected = this.selectedLevel == levelSelectItems[i][j].levelNum;
					levelSelectItems[i][j].state = state;
				}
			}
			// TITLE SCREEN
			if (state == 0)
			{
				titleText.y = titleText_y01.EvaluateAndAdvance();
				promptText.y = promptText_y01.EvaluateAndAdvance();
				levelSelectText.alpha = 0;
				if (FlxG.keys.ENTER)
				{
					state = 1;
				}
			}
			// TITLE SCREEN OUT, LEVEL SELECT IN
			else if (state == 1)
			{
				titleText.y = titleText_y01.EvaluateAndAdvance() + titleText_y1.EvaluateAndAdvance();
				promptText.y = promptText_y01.EvaluateAndAdvance() + promptText_y1.EvaluateAndAdvance();
				levelSelectText.y = levelSelectText_y1.EvaluateAndAdvance() + levelSelectText_y12.EvaluateAndAdvance();
				levelSelectText.alpha = 1;
				if (titleText_y1.complete)
				{
					state = 2;
				}
			}
			// LEVEL SELECT
			else if (state == 2)
			{
				titleText.alpha = 0;
				promptText.alpha = 0;
				levelSelectText.y = levelSelectText_y12.EvaluateAndAdvance();
				// choose yer level
				chooseLevel();
				selectedLevel = selectedSquare.y * MenuUI.levelSelectWidth + selectedSquare.x;
				if (FlxG.keys.ENTER)
				{
					state = 3;
				}
			}
			// LEVEL SELECT OUT, FADE OUT
			else if (state == 3)
			{
				dimmer.alpha = dimmer_alpha1.EvaluateAndAdvance();
				dimmer_alpha1.CallUponCompletion(callback);
			}
		}
		
		private var selectedSquare:FlxPoint;
		private var selectedSquarePrev:FlxPoint = new FlxPoint();
		public var selectedLevel:uint;
		private var keyFramesDown:uint;
		
		private function chooseLevel():void
		{
			var selectedSquareTemp:FlxPoint = new FlxPoint();
			var keyDirectionTemp:uint = 0;
			if (FlxG.keys.LEFT)
			{
				selectedSquareTemp.x--;
			}
			if (FlxG.keys.RIGHT)
			{
				selectedSquareTemp.x++;
			}
			if (FlxG.keys.UP)
			{
				selectedSquareTemp.y--;
			}
			if (FlxG.keys.DOWN)
			{
				selectedSquareTemp.y++;
			}
			if (selectedSquareTemp.x != 0 || selectedSquareTemp.y != 0)
			{
				if (selectedSquarePrev.x == selectedSquareTemp.x && selectedSquarePrev.y == selectedSquareTemp.y)
				{
					keyFramesDown++;
				}
				else
				{
					keyFramesDown = 0;
				}
				if (keyFramesDown % levelAdvanceRate == 0)
				{
					selectedSquare.x += selectedSquareTemp.x;
					selectedSquare.y += selectedSquareTemp.y;
				}
				if (selectedSquare.x < 0)
				{
					selectedSquare.x += MenuUI.levelSelectWidth;
				}
				if (selectedSquare.x >= MenuUI.levelSelectWidth)
				{
					selectedSquare.x -= MenuUI.levelSelectWidth;
				}
				if (selectedSquare.y < 0)
				{
					selectedSquare.y += MenuUI.levelSelectHeight;
				}
				if (selectedSquare.y >= MenuUI.levelSelectHeight)
				{
					selectedSquare.y -= MenuUI.levelSelectHeight;
				}
				selectedSquarePrev.x = selectedSquareTemp.x;
				selectedSquarePrev.y = selectedSquareTemp.y;
			}
			else
			{
				keyFramesDown = 0;
				selectedSquarePrev.x = selectedSquarePrev.y = 0;
			}
		}
	}

}