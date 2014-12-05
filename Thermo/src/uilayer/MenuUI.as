package uilayer {
	import context.MenuUtils;
	//import org.flintparticles.common.displayObjects.Rect;
	
	import io.ThermoSaves;
	
	import audio.AudioManager;
	
	import flash.geom.Rectangle;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	import uilayer.Utils;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class MenuUI extends FlxGroup 
	{
		public static const levelSelectWidth:uint = 5;
		public static const levelSelectHeight:uint = 6;
		public static const NUM_OPEN_LEVELS:uint = 3;
		private static var levelAdvanceRate:uint = 10;
		
		private var dimmer:FlxSprite;
		private var titleText:FlxText;
		private var promptText:FlxText;
		private var levelSelectText:FlxText;
		private var levelSelectItems:Array;
		
		private var dimmer_alpha0:PiecewiseInterpolationMachine;
		private var dimmer_alpha1:PiecewiseInterpolationMachine;
		private var titleText_y01:PiecewiseInterpolationMachine;
		private var titleText_y1:PiecewiseInterpolationMachine;
		private var levelSelectText_y1:PiecewiseInterpolationMachine;
		private var levelSelectText_y12:PiecewiseInterpolationMachine;
		private var promptText_y01:PiecewiseInterpolationMachine;
		private var promptText_y1:PiecewiseInterpolationMachine;
		
		private var state:uint;
		private var callback:Function;
		
		private var mouseValidRectangle:Rectangle;
		private var mouseLayer:MouseLayer;
		
		//Robyn
		public var initialLevel:uint;
		public var logger:Logging;
		
		public function MenuUI(initialState:uint, initialLevel:uint, callback:Function, logger:Logging)
		{
			super(0);
			state = initialState;
			this.callback = callback;
			this.initialLevel = initialLevel;
			this.logger = logger;
			
			var dimensions:FlxPoint = new FlxPoint(FlxG.width, FlxG.height);
			
			// Title Text
			titleText = new FlxText(0, 0, FlxG.width, "Thermo");
			titleText.setFormat(Assets.font_name, 120, 0xff0099ff, "center", 0xff003399);
			add(titleText);
			
			promptText = new FlxText(0, 0, FlxG.width, "Press ENTER");
			promptText.setFormat(Assets.font_name, 40, 0xff0099ff, "center", 0xff003399);
			add(promptText);
			
			levelSelectText = new FlxText(0, 0, FlxG.width, "Level Select");
			levelSelectText.setFormat(Assets.font_name, 80, 0xff0099ff, "center", 0xff003399);
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
			
			selectedLevel = initialLevel;
			selectedSquare = new FlxPoint(selectedLevel % levelSelectWidth, int(selectedLevel / levelSelectWidth));
			
			keyFramesDown = 0;
			
			// Something that helps darken the level when important UI is up
			// This should come up last so it covers everything.
			dimmer = MenuUtils.CreateSolid(new FlxPoint(dimensions.x + 1, dimensions.y), 0x000000);
			add(dimmer);
			
			dimmer.alpha = 0;
			dimmer_alpha0 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 1),
				new PiecewiseInterpolationNode(null, 30, 0));
			dimmer_alpha1 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 0),
				new PiecewiseInterpolationNode(Utils.Lerp, 20, 1),
				new PiecewiseInterpolationNode(null, 22, 1));
			
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
			
			add(mouseLayer = new MouseLayer(false));
			mouseValidRectangle = new Rectangle(LevelSelectItem.xMin, LevelSelectItem.yMin, LevelSelectItem.xMax - LevelSelectItem.xMin + 40, LevelSelectItem.yMax - LevelSelectItem.yMin + 40);
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
				dimmer.alpha = dimmer_alpha0.EvaluateAndAdvance();
				titleText.y = titleText_y01.EvaluateAndAdvance();
				promptText.y = promptText_y01.EvaluateAndAdvance();
				levelSelectText.alpha = 0;
				if (FlxG.keys.ENTER || (FlxG.mouse.justPressed() && !mouseLayer.isMouseDisabled() && FlxG.mouse.x < FlxG.width - 50 && FlxG.mouse.y > 25))
				{
					state = 1;
				}
			}
			// TITLE SCREEN OUT, LEVEL SELECT IN
			else if (state == 1)
			{
				dimmer.alpha = dimmer_alpha0.EvaluateAndAdvance();
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
				dimmer.alpha = dimmer_alpha0.EvaluateAndAdvance();
				titleText.alpha = 0;
				promptText.alpha = 0;
				levelSelectText.y = levelSelectText_y12.EvaluateAndAdvance();
				// choose yer level
				chooseLevel();
				selectedLevel = selectedSquare.y * MenuUI.levelSelectWidth + selectedSquare.x;
				if ((FlxG.keys.ENTER || (FlxG.mouse.justPressed() && !mouseLayer.isMouseDisabled() && mouseValidRectangle.contains(FlxG.mouse.x, FlxG.mouse.y))) && LevelServices.Unlocked(selectedLevel))
				{
					/*if(selectedLevel != initialLevel){
						// THIS PERSON SKIPPED A LEVEL
						logger.recordEvent(initialLevel, 8, "v2 $ $ $ $ " + initialLevel);
					}*/
					state = 3;
				}
			}
			// LEVEL SELECT OUT, FADE OUT
			else if (state == 3)
			{
				dimmer.alpha = dimmer_alpha1.EvaluateAndAdvance();
				if (dimmer_alpha1.completionCallback == null)
				{
					dimmer_alpha1.CallUponCompletion(callback);
				}
			}
		}
		
		private var selectedSquare:FlxPoint;
		private var selectedSquarePrev:FlxPoint = new FlxPoint();
		public var selectedLevel:uint;
		private var keyFramesDown:uint;
		private var prevMousePosition:FlxPoint = new FlxPoint();
		private var currMousePosition:FlxPoint = new FlxPoint();
		
		private function chooseLevel():void
		{
			FlxG.mouse.getScreenPosition(null, currMousePosition);
			var mouseMoved:Boolean = prevMousePosition.x != currMousePosition.x || prevMousePosition.y != currMousePosition.y;
			if (mouseMoved)
			{
				var r:Rectangle = levelSelectItems[selectedSquare.x][selectedSquare.y].MouseOverRectangle;
				// The mouse moved out of the current selected level number rectangle
				if (!r.contains(currMousePosition.x, currMousePosition.y))
				{
					for (var i:uint = 0; i < levelSelectWidth; i++)
					{
						for (var j:uint = 0; j < levelSelectHeight; j++)
						{
							r = levelSelectItems[i][j].MouseOverRectangle;
							if (r.contains(currMousePosition.x, currMousePosition.y))
							{
								selectedSquare.x = i;
								selectedSquare.y = j;
								AudioManager.PlaySound(Assets.sfx_option_cycle);
								break;
							}
						}
					}
				}
			}
			else
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
						AudioManager.PlaySound(Assets.sfx_option_cycle);
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
			prevMousePosition.x = currMousePosition.x;
			prevMousePosition.y = currMousePosition.y;
		}
	}

}