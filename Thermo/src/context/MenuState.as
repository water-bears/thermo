package context {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	import org.flixel.*;
	
	import uilayer.MenuUI;
	import io.ThermoSaves;
	
	public class MenuState extends FlxState {
		
		private var backgroundTile:FlxSprite;
		
		public var bubbles:BubbleBackground;
		private var initialState:uint;
		private var ui:MenuUI;
		public var logger:Logging;
		private var initialLevel:uint;
		
		public function MenuState(initialState:uint, initialLevel:uint, logger:Logging)
		{			
			this.initialState = initialState;
			this.initialLevel = initialLevel;
			this.logger = logger;
			
			logger.recordPageLoad();
			
			var dimensions:FlxPoint = new FlxPoint(FlxG.width, FlxG.height);
			
			// Create background gradient
			backgroundTile = MenuUtils.CreateVerticalGradient(dimensions, 0x0066cc, 0x003333);
			add(backgroundTile);
			
			// Initialize bubbles
			bubbles = new BubbleBackground(dimensions, 50, 8, 16);
			bubbles.Register(this);
			
			ui = new MenuUI(initialState, initialLevel, goToNextState);
			add(ui);
		}
		
		override public function update():void {
			super.update();
			bubbles.Update();
		}
		
		public function goToNextState():void {
			var p : FlxState = new TransitionState(ui.selectedLevel + 1, logger, ui.selectedLevel + 1);
			FlxG.switchState(p);
		}
	}
}