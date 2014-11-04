package context {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	import org.flixel.*;
	
	import uilayer.MenuUI;
	
	public class MenuState extends FlxState {
		
		private var backgroundTile:FlxSprite;
		
		public var bubbles:BubbleBackground;
		private var initialState:uint;
		private var ui:MenuUI;
		public var logger:Logging;
		
		public function MenuState(initialState:uint, logger:Logging)
		{
			this.initialState = initialState;
			this.logger = logger;
			
			logger.recordPageLoad();
			
			var dimensions:FlxPoint = new FlxPoint(FlxG.width, FlxG.height);
			
			// Create background gradient
			backgroundTile = MenuUtils.CreateVerticalGradient(dimensions, 0x0066cc, 0x003333);
			add(backgroundTile);
			
			// Initialize bubbles
			bubbles = new BubbleBackground(dimensions, 50, 8, 16);
			bubbles.Register(this);
			
			ui = new MenuUI(initialState, goToNextState);
			add(ui);
		}
		
		override public function update():void {
			super.update();
			bubbles.Update();
		}
		
		public function goToNextState():void {
			var p : FlxState = new TransitionState(ui.selectedLevel + 1, logger);
			FlxG.switchState(p);
		}
	}
}