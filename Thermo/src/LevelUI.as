package {
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import context.MenuUtils;
	
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
			
			// Something that helps darken the level when important UI is up.
			// The dimensions are screwed up because ActionScript's primitive drawing
			// methods are atrocious.
			// 
			dimmer = MenuUtils.CreateSolid(new FlxPoint(dimensions.x + 1, dimensions.y), 0x000000);
			add(dimmer);
			
			// Level Intro Text
			levelText = new FlxText(0, 0, FlxG.width, "Level " + levelNum);
			levelText.alignment = "center";
			levelText.scale.x = levelText.scale.y = 5;
			add(levelText);
			
			state = 0;
			
			dimmer_alpha0 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 1),
				new PiecewiseInterpolationNode(Utils.Lerp, 50, 1),
				new PiecewiseInterpolationNode(null, 150, 0));
			dimmer_alpha1 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 0),
				new PiecewiseInterpolationNode(null, 20, 1));
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
		}
		
		override public function update():void
		{
			super.update();
			// Adjust values depending on time.
			dimmer.alpha = dimmer_alpha0.EvaluateAndUpdate();
			if (state == 1)
			{
				dimmer.alpha = dimmer_alpha1.EvaluateAndUpdate();
			}
			levelText.alpha = levelText_alpha0.EvaluateAndUpdate();
			levelText.y = levelText_y0.EvaluateAndUpdate();
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