package uilayer {
	import Logging;
	
	import context.MenuUtils;
	
	import levelgen.Level;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import context.MenuUtils;
	import Logging;
	import audio.AudioManager;
	
	import flash.utils.getTimer;
	
	/*
	 * A class that represents the pause menu and other ui components during a level.
	 */
	public class LevelUI extends FlxGroup
	{
		private var dimmer:FlxSprite;
		private var levelText:FlxText;
		private var pauseTitleText:FlxText;
		private var pauseSubtitleText:FlxText;
		private var pauseOptions:Vector.<FlxText> = new Vector.<FlxText>();
		private var callbacks:Vector.<Function> = new Vector.<Function>();
		
		private var time:Number;
		
		private var dimmer_alpha0:PiecewiseInterpolationMachine;
		private var dimmer_alpha1:PiecewiseInterpolationMachine;
		private var dimmer_alpha2:PiecewiseInterpolationMachine;
		private var levelText_alpha0:PiecewiseInterpolationMachine;
		private var levelText_y0:PiecewiseInterpolationMachine;
		private var pauseTitleText_alpha2:PiecewiseInterpolationMachine;
		private var pauseTitleText_y2:PiecewiseInterpolationMachine;
		private var pauseOptions_alpha2:PiecewiseInterpolationMachine;
		private var pauseOptions_y2:PiecewiseInterpolationMachine;
		
		private var state:uint;
		private var selectedPauseOption:uint = 0;
		public var AllowPause:Boolean = false;
		private var Paused:Boolean = false;
		
		public var logger:Logging;
		public var level:Level;
		
		private var mouseLayer:MouseLayer;
		private var framesSincePause:uint = 0;
		
		public function LevelUI(level:Level, logger:Logging)
		{
			super(0);
			this.logger = logger;
			this.level = level;
			
			var dimensions:FlxPoint = new FlxPoint(FlxG.width, FlxG.height);
			
			// Something that helps darken the level when important UI is up.
			// The dimensions are screwed up because ActionScript's primitive drawing
			// methods are atrocious.
			// 
			dimmer = MenuUtils.CreateSolid(new FlxPoint(dimensions.x + 1, dimensions.y), 0x000000);
			//add(dimmer);
			
			// Level Intro Text
			levelText = new FlxText(0, 0, FlxG.width, "Level " + LevelServices.GetHumanReadableLevelName(level.levelNum));
			levelText.setFormat(Assets.font_name, 80, LevelServices.GetLevelSelectColor(level.levelNum), "center", 0x000000);

			
			pauseTitleText = new FlxText(0, 0, FlxG.width, "Paused");
			pauseTitleText.setFormat(Assets.font_name, 80, 0xffffff, "center", 0x000000);
			//add(pauseTitleText);
			
			pauseSubtitleText = new FlxText(0, 0, FlxG.width, "Level " + LevelServices.GetHumanReadableLevelName(level.levelNum));
			pauseSubtitleText.setFormat(Assets.font_name, 30, LevelServices.GetLevelSelectColor(level.levelNum), "center", 0x000000);
			//add(pauseSubtitleText);
			
			pauseOptions.push(new FlxText(0, 0, FlxG.width, "Resume"));
			pauseOptions.push(new FlxText(0, 0, FlxG.width, "Restart"));
			pauseOptions.push(new FlxText(0, 0, FlxG.width, "Level Select"));
			
			for (var i:uint = 0; i < 3; i++)
			{
				pauseOptions[i].setFormat(Assets.font_name, 15, 0xffffff, "center", 0x000000);
				//add(pauseOptions[i]);
				callbacks.push(null);
			}
			
			state = 0;
			
			dimmer_alpha0 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 1),
				new PiecewiseInterpolationNode(Utils.Lerp, 30, 1),
				new PiecewiseInterpolationNode(null, 60, 0));
			dimmer_alpha1 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 0),
				new PiecewiseInterpolationNode(Utils.Lerp, 20, 1),
				new PiecewiseInterpolationNode(null, 21, 1));
			dimmer_alpha2 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 0),
				new PiecewiseInterpolationNode(null, 30, 0.25));
			levelText_alpha0 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 1),
				new PiecewiseInterpolationNode(Utils.Lerp, 30, 1),
				new PiecewiseInterpolationNode(Utils.Lerp, 50, 1),
				new PiecewiseInterpolationNode(null, 80, 0));
			levelText_y0 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.ConcaveSine, 0, 0.25 * FlxG.height),
				new PiecewiseInterpolationNode(Utils.Lerp, 20, 0.30 * FlxG.height),
				new PiecewiseInterpolationNode(Utils.ConvexSine, 50, 0.32 * FlxG.height),
				new PiecewiseInterpolationNode(null, 80, 0.4 * FlxG.height));
			pauseTitleText_alpha2 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 0),
				new PiecewiseInterpolationNode(Utils.Lerp, 10, 0),
				new PiecewiseInterpolationNode(null, 50, 1));
			pauseTitleText_y2 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.ConvexSine, 0, 0.05 * FlxG.height),
				new PiecewiseInterpolationNode(Utils.ConcaveSine, 10, 0.1 * FlxG.height),
				new PiecewiseInterpolationNode(null, 30, 0.15 * FlxG.height));
			pauseOptions_alpha2 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 0),
				new PiecewiseInterpolationNode(Utils.Lerp, 10, 0),
				new PiecewiseInterpolationNode(null, 50, 1));
			pauseOptions_y2 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.SmoothStep, 0, 0.5 * FlxG.height),
				new PiecewiseInterpolationNode(null, 30, 0.45 * FlxG.height));
			
			mouseLayer = new MouseLayer(true);
			add(mouseLayer);
			mouseLayer.SetTogglePauseCallback(TogglePause);
			mouseLayer.visible = false;
		}
		
		override public function draw():void 
		{
			super.draw();
			if (dimmer.alpha > 0)
			{
				dimmer.draw();
			}
			if (levelText.alpha > 0)
			{
				levelText.draw();
			}
			if (pauseTitleText.alpha > 0)
			{
				pauseTitleText.draw();
			}
			if (pauseSubtitleText.alpha > 0)
			{
				pauseSubtitleText.draw();
			}
			for (var i:uint = 0; i < 3; i++)
			{
				if (pauseOptions[i].alpha > 0)
				{
					pauseOptions[i].draw();
				}
			}
			if (mouseLayer.alpha > 0)
			{
				mouseLayer.draw();
			}
		}
		
		public function SetSelectCallback(index:uint, f:Function):void
		{
			callbacks[index] = f;
		}
		
		override public function update():void
		{
			super.update();
			var i:uint;
			// Set pausing and stuff
			if (AllowPause && (FlxG.keys.justPressed("ESCAPE") || FlxG.keys.R))
			{
				TogglePause();
			}
			
			if (state == 0)
			{
				// Adjust values depending on time.
				dimmer.alpha = dimmer_alpha0.EvaluateAndAdvance();
				if (dimmer_alpha0.complete)
				{
					AllowPause = true;
				}
				pauseTitleText.alpha = 0;
				pauseSubtitleText.alpha = 0;
				for (i = 0; i < pauseOptions.length; i++)
				{
					pauseOptions[i].alpha = 0;
				}
				levelText.alpha = levelText_alpha0.EvaluateAndAdvance();
				levelText.y = levelText_y0.EvaluateAndAdvance();
				if (FlxG.keys.SPACE || FlxG.keys.ENTER || (FlxG.mouse.justPressed() && !mouseLayer.isMouseDisabled())) {
					FastForward();
				}
			}
			if (state == 1)
			{
				dimmer.alpha = dimmer_alpha1.EvaluateAndAdvance();
				PauseFadeOut(3);
			}
			if (state == 2)
			{
				// If the mouse is moving, get where the mouse is and select
				// an option based on that.
				if (mouseLayer.liveMouse)
				{
					for (i = 0; i < pauseOptions.length; i++)
					{
						if (pauseOptions[i].overlapsPoint(mouseLayer.mousePosition))
						{
							selectedPauseOption = i;
							break;
						}
					}
				}
				if (FlxG.keys.justPressed("UP"))
				{
					if (selectedPauseOption == 0)
					{
						selectedPauseOption = pauseOptions.length - 1;
					}
					else
					{
						selectedPauseOption--;
					}
					AudioManager.PlaySound(Assets.sfx_option_cycle);
				}
				if (FlxG.keys.justPressed("DOWN"))
				{
					if (selectedPauseOption == pauseOptions.length - 1)
					{
						selectedPauseOption = 0;
					}
					else
					{
						selectedPauseOption++;
					}
					AudioManager.PlaySound(Assets.sfx_option_cycle);
				}
				if (FlxG.keys.justPressed("ENTER") || (FlxG.mouse.justPressed() && framesSincePause > 0 && !mouseLayer.isMouseDisabled()))
				{
					if (callbacks[selectedPauseOption] != null)
					{
						if(selectedPauseOption == 1){
							//reset
							logger.recordEvent(level.levelNum, 5, "v2 $ $ $" + getTimer().toString()+ "$");
							logger.recordLevelEnd();
						}
						else if(selectedPauseOption == 2){
							// levelselect 
							logger.recordEvent(level.levelNum, 6, "v2 $ $ $" + getTimer().toString()+ "$");
							logger.recordLevelEnd();
						}
						BeginExitSequence(callbacks[selectedPauseOption]);
					}
					else
					{
						TogglePause();
					}
				}
				// set which pause option is red and which are not
				for (i = 0; i < pauseOptions.length; i++)
				{
					if (i == selectedPauseOption)
					{
						pauseOptions[i].color = 0xff0000;
						pauseOptions[i].size = Utils.Lerp(pauseOptions[i].size, 20, 0.2);
					}
					else
					{
						pauseOptions[i].color = 0xffffff;
						pauseOptions[i].size = Utils.Lerp(pauseOptions[i].size, 15, 0.2);
					}
				}
				dimmer.alpha = dimmer_alpha2.EvaluateAndAdvance();
				PauseFadeIn();
			}
			if (state == 3)
			{
				dimmer.alpha = dimmer_alpha2.EvaluateAndAdvance(-1);
				PauseFadeOut(1);
				if (pauseTitleText_alpha2.complete)
				{
					state = 0;
				}
			}
			framesSincePause = 1; // doesn't matter if it's above 1
		}
		
		private function PauseFadeIn() : void
		{
			pauseSubtitleText.alpha = pauseTitleText_alpha2.Evaluate();
			pauseSubtitleText.y = pauseTitleText_y2.Evaluate() + 85;
			pauseTitleText.alpha = pauseTitleText_alpha2.EvaluateAndAdvance();
			pauseTitleText.y = pauseTitleText_y2.EvaluateAndAdvance();
			for (var i:uint = 0; i < pauseOptions.length; i++)
			{
				pauseOptions[i].alpha = pauseOptions_alpha2.Evaluate();
				pauseOptions[i].y = pauseOptions_y2.Evaluate() + 0.1 * FlxG.height * i;
			}
			pauseOptions_alpha2.Advance();
			pauseOptions_y2.Advance();
		}
		
		private function PauseFadeOut(speed:int) : void
		{
			pauseSubtitleText.alpha = pauseTitleText_alpha2.Evaluate();
			pauseSubtitleText.y = pauseTitleText_y2.Evaluate() + 85;
			pauseTitleText.alpha = pauseTitleText_alpha2.EvaluateAndAdvance(-speed);
			pauseTitleText.y = pauseTitleText_y2.EvaluateAndAdvance(-speed);
			for (var i:uint = 0; i < pauseOptions.length; i++)
			{
				pauseOptions[i].alpha = pauseOptions_alpha2.Evaluate();
				pauseOptions[i].y = pauseOptions_y2.Evaluate() + 0.1 * FlxG.height * i;
			}
			pauseOptions_alpha2.Advance(-speed);
			pauseOptions_y2.Advance(-speed);
		}
		
		public function FastForward():void
		{
			dimmer_alpha0.FastForward();
			levelText_alpha0.FastForward();
			levelText_y0.FastForward();
		}
		
		// Calls given function when finished fading out.
		public function BeginExitSequence(callback:Function):void
		{
			state = 1;
			AllowPause = false;
			dimmer_alpha1.CallUponCompletion(callback);
		}
		
		// Call when pausing
		public function TogglePause():void
		{
			Paused = !Paused;
			if (Paused)
			{
				state = 2;
				mouseLayer.AutoFade = false;
			}
			else
			{
				state = 3;
				mouseLayer.AutoFade = true;
			}
			framesSincePause = 0;
		}
		
		public function IsPaused():Boolean
		{
			return Paused || mouseLayer.isMouseDisabled();
		}
	}

}