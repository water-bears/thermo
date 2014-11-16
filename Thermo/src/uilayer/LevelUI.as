package uilayer {
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import context.MenuUtils;
	import Logging;
	
	public class LevelUI extends FlxGroup
	{
		private var dimmer:FlxSprite;
		private var levelText:FlxText;
		private var pauseTitleText:FlxText;
		private var pauseOptionResumeText:FlxText;
		private var pauseOptionRestartText:FlxText;
		private var pauseOptionLevelSelectText:FlxText;
		
		private var time:Number;
		
		private var dimmer_alpha0:PiecewiseInterpolationMachine;
		private var dimmer_alpha1:PiecewiseInterpolationMachine;
		private var dimmer_alpha2:PiecewiseInterpolationMachine;
		private var levelText_alpha0:PiecewiseInterpolationMachine;
		private var levelText_y0:PiecewiseInterpolationMachine;
		private var pauseTitleText_alpha2:PiecewiseInterpolationMachine;
		private var pauseTitleText_y2:PiecewiseInterpolationMachine;
		private var pauseOptionsText_alpha2:PiecewiseInterpolationMachine;
		private var pauseOptionResumeText_y2:PiecewiseInterpolationMachine;
		private var pauseOptionRestartText_y2:PiecewiseInterpolationMachine;
		private var pauseOptionLevelSelectText_y2:PiecewiseInterpolationMachine;
		
		private var state:uint;
		public var AllowPause:Boolean = false;
		public var Paused:Boolean = false;
		
		public function LevelUI(levelNum:uint)
		{
			super(0);
			
			var dimensions:FlxPoint = new FlxPoint(FlxG.width, FlxG.height);
			
			// Something that helps darken the level when important UI is up.
			// The dimensions are screwed up because ActionScript's primitive drawing
			// methods are atrocious.
			// 
			dimmer = MenuUtils.CreateSolid(new FlxPoint(dimensions.x + 1, dimensions.y), 0x000000);
			add(dimmer);
			
			// Level Intro Text
			levelText = new FlxText(0, 0, FlxG.width, "Level " + levelNum);
			levelText.setFormat(Assets.font_name, 80, 0xffffff, "center", 0x000000);
			add(levelText);
			
			pauseTitleText = new FlxText(0, 0, FlxG.width, "Paused");
			pauseTitleText.setFormat(Assets.font_name, 80, 0xffffff, "center", 0x000000);
			add(pauseTitleText);
			
			pauseOptionResumeText = new FlxText(0, 0, FlxG.width, "Resume");
			pauseOptionResumeText.setFormat(Assets.font_name, 40, 0xffffff, "center", 0x000000);
			add(pauseOptionResumeText);
			
			pauseOptionRestartText = new FlxText(0, 0, FlxG.width, "Restart");
			pauseOptionRestartText.setFormat(Assets.font_name, 40, 0xffffff, "center", 0x000000);
			add(pauseOptionRestartText);
			
			pauseOptionLevelSelectText = new FlxText(0, 0, FlxG.width, "Level Select");
			pauseOptionLevelSelectText.setFormat(Assets.font_name, 40, 0xffffff, "center", 0x000000);
			add(pauseOptionLevelSelectText);
			
			state = 0;
			
			dimmer_alpha0 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 1),
				new PiecewiseInterpolationNode(Utils.Lerp, 50, 1),
				new PiecewiseInterpolationNode(null, 150, 0));
			dimmer_alpha1 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 0),
				new PiecewiseInterpolationNode(null, 20, 1));
			dimmer_alpha2 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 0),
				new PiecewiseInterpolationNode(null, 30, 0.25));
			levelText_alpha0 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 1),
				new PiecewiseInterpolationNode(Utils.Lerp, 30, 1),
				new PiecewiseInterpolationNode(Utils.Lerp, 100, 1),
				new PiecewiseInterpolationNode(null, 150, 0));
			levelText_y0 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.ConcaveSine, 0, 0.25 * FlxG.height),
				new PiecewiseInterpolationNode(Utils.Lerp, 30, 0.30 * FlxG.height),
				new PiecewiseInterpolationNode(Utils.ConvexSine, 100, 0.32 * FlxG.height),
				new PiecewiseInterpolationNode(null, 150, 0.4 * FlxG.height));
			pauseTitleText_alpha2 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 0),
				new PiecewiseInterpolationNode(Utils.Lerp, 10, 0),
				new PiecewiseInterpolationNode(null, 30, 1));
			pauseTitleText_y2 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.ConvexSine, 0, 0.2 * FlxG.height),
				new PiecewiseInterpolationNode(Utils.ConcaveSine, 10, 0.25 * FlxG.height),
				new PiecewiseInterpolationNode(null, 30, 0.30 * FlxG.height));
			pauseOptionsText_alpha2 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 0),
				new PiecewiseInterpolationNode(Utils.Lerp, 20, 0),
				new PiecewiseInterpolationNode(null, 30, 1));
			pauseOptionResumeText_y2 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.ConvexSine, 0, 0.15 * FlxG.height),
				new PiecewiseInterpolationNode(null, 30, 0.32 * FlxG.height));
			pauseOptionRestartText_y2 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.ConvexSine, 0, 0.15 * FlxG.height),
				new PiecewiseInterpolationNode(null, 30, 0.34 * FlxG.height));
			pauseOptionLevelSelectText_y2 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.ConvexSine, 0, 0.15 * FlxG.height),
				new PiecewiseInterpolationNode(null, 30, 0.36 * FlxG.height));
		}
		
		override public function update():void
		{
			super.update();
			if (state == 0)
			{
				// Adjust values depending on time.
				dimmer.alpha = dimmer_alpha0.EvaluateAndAdvance();
				if (dimmer_alpha0.complete)
				{
					AllowPause = true;
				}
				pauseTitleText.alpha = 0;
				pauseOptionResumeText.alpha = 0;
				pauseOptionRestartText.alpha = 0;
				pauseOptionLevelSelectText.alpha = 0;
			}
			if (state == 1)
			{
				dimmer.alpha = dimmer_alpha1.EvaluateAndAdvance();
			}
			if (state == 2)
			{
				dimmer.alpha = dimmer_alpha2.EvaluateAndAdvance();
				pauseTitleText.alpha = pauseTitleText_alpha2.EvaluateAndAdvance();
				pauseTitleText.y = pauseTitleText_y2.EvaluateAndAdvance();
				pauseOptionResumeText.alpha = pauseOptionsText_alpha2.Evaluate();
				pauseOptionRestartText.alpha = pauseOptionsText_alpha2.Evaluate();
				pauseOptionLevelSelectText.alpha = pauseOptionsText_alpha2.EvaluateAndAdvance();
				pauseOptionResumeText.y = pauseOptionResumeText_y2.EvaluateAndAdvance();
				pauseOptionRestartText.y = pauseOptionRestartText_y2.EvaluateAndAdvance();
				pauseOptionLevelSelectText.y = pauseOptionLevelSelectText_y2.EvaluateAndAdvance();
			}
			if (state == 3)
			{
				dimmer.alpha = dimmer_alpha2.EvaluateAndAdvance(-1);
				pauseTitleText.alpha = pauseTitleText_alpha2.EvaluateAndAdvance(-1);
				pauseTitleText.y = pauseTitleText_y2.EvaluateAndAdvance(-1);
				pauseOptionResumeText.alpha = pauseOptionsText_alpha2.Evaluate();
				pauseOptionRestartText.alpha = pauseOptionsText_alpha2.Evaluate();
				pauseOptionLevelSelectText.alpha = pauseOptionsText_alpha2.EvaluateAndAdvance(-1);
				pauseOptionResumeText.y = pauseOptionResumeText_y2.EvaluateAndAdvance(-1);
				pauseOptionRestartText.y = pauseOptionRestartText_y2.EvaluateAndAdvance(-1);
				pauseOptionLevelSelectText.y = pauseOptionLevelSelectText_y2.EvaluateAndAdvance(-1);
				if (dimmer_alpha2.complete)
				{
					//dimmer_alpha2.Rewind();
					//dimmer_alpha3.Rewind();
					state = 0;
				}
			}
			levelText.alpha = levelText_alpha0.EvaluateAndAdvance();
			levelText.y = levelText_y0.EvaluateAndAdvance();
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
			}
			else
			{
				state = 3;
			}
		}
	}

}