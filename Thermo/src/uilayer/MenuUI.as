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
		private var dimmer:FlxSprite;
		
		private var titleText:FlxText;
		private var promptText:FlxText;
		
		private var time:Number;
		
		private var dimmer_alpha1:PiecewiseInterpolationMachine;
		
		private var titleText_y0:PiecewiseInterpolationMachine;
		private var promptText_y0:PiecewiseInterpolationMachine;
		
		private var state:uint;
		
		public function MenuUI(initialState:uint)
		{
			super(0);
			state = initialState;
			
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
			
			titleText_y0 = Utils.CreatePeriodic(0.2 * dimensions.y, 20, 400);
			promptText_y0 = Utils.CreatePeriodic(0.7 * dimensions.y, 10, 200);
			
			// Something that helps darken the level when important UI is up
			// This should come up last so it covers everything.
			dimmer = MenuUtils.CreateSolid(new FlxPoint(dimensions.x + 1, dimensions.y), 0x000000);
			add(dimmer);
			
			dimmer.alpha = 0;
			dimmer_alpha1 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 0),
				new PiecewiseInterpolationNode(null, 20, 1));
		}
		
		override public function update():void 
		{
			super.update();
			// Adjust values depending on time.
			titleText.y = titleText_y0.EvaluateAndUpdate();
			promptText.y = promptText_y0.EvaluateAndUpdate();
			if (state == 1)
			{
				dimmer.alpha = dimmer_alpha1.EvaluateAndUpdate();
			}
		}
		
		// Calls given function when finished fading out.
		public function BeginExitSequence(callback:Function):void
		{
			state = 1;
			dimmer_alpha1.CallUponCompletion(callback);
		}
	}

}