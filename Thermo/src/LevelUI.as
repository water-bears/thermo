package  
{
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
	public class LevelUI extends FlxGroup 
	{
		private var dimmer:FlxSprite;
		private var levelText:FlxText;
		
		private var time:Number;
		
		private var dimmer_alpha0:PiecewiseInterpolationMachine;
		private var dimmer_alpha1:PiecewiseInterpolationMachine;
		private var levelText_alpha0:PiecewiseInterpolationMachine;
		private var levelText_y0:PiecewiseInterpolationMachine;	
		
		private var state:uint;
		
		public function LevelUI(levelNum:uint) 
		{
			super(0);
			
			var dimensions:FlxPoint = new FlxPoint(FlxG.width, FlxG.height);
			
			// Something that helps darken the level when important UI is up
			dimmer = MenuUtils.CreateSolid(dimensions, 0x000000);
			add(dimmer);
			
			// Level Intro Text
			levelText = new FlxText(462, 0, 100, "Level " + levelNum);
			levelText.alignment = "center";
			levelText.scale.x = levelText.scale.y = 5;
			add(levelText);
			
			state = 0;
			
			dimmer_alpha0 = new PiecewiseInterpolationMachine([0, 50, 150], [1, 1, 0], [Utils.Lerp, Utils.Lerp]);
			dimmer_alpha1 = new PiecewiseInterpolationMachine([0, 20], [0, 1], [Utils.Lerp]);
			levelText_alpha0 = new PiecewiseInterpolationMachine([0, 30, 100, 150], [0, 1, 1, 0], [Utils.Lerp, Utils.Lerp, Utils.Lerp]);
			levelText_y0 = new PiecewiseInterpolationMachine([0, 30, 100, 150], [175, 200, 210, 300], [Utils.SmoothStep, Utils.Lerp, Utils.SmoothStep]);
		}
		
		override public function update():void 
		{
			super.update();
			// Adjust values depending on time.
			dimmer.alpha = dimmer_alpha0.UpdateAndEvaluate();
			if (state == 1)
			{
				dimmer.alpha = dimmer_alpha1.UpdateAndEvaluate();
			}
			levelText.alpha = levelText_alpha0.UpdateAndEvaluate();
			levelText.y = levelText_y0.UpdateAndEvaluate();
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
			dimmer_alpha1.CallUponCompletion(callback);
		}
	}

}