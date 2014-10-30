package context {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	import org.flixel.*;
	
	public class MenuState extends FlxState {
		
		private var backgroundTile:FlxSprite;
		
		public var bubbles:BubbleBackground;
		private var ui:MenuUI;
		
		override public function create():void {
			
			var dimensions:FlxPoint = new FlxPoint(FlxG.width, FlxG.height);
			
			// Create background gradient
			backgroundTile = MenuUtils.CreateVerticalGradient(dimensions, 0x0066cc, 0x003333);
			add(backgroundTile);
			
			// Initialize bubbles
			bubbles = new BubbleBackground(dimensions, 50, 8, 16);
			bubbles.Register(this);
			
			ui = new MenuUI(0);
			add(ui);
		}
		
		override public function update():void {
			super.update();
			bubbles.Update();
			if (FlxG.keys.ENTER) {
				ui.BeginExitSequence(goToNextState);
			}
		}
		
		public function goToNextState():void {
			var p : PlayState = new PlayState();
			FlxG.switchState(p);
		}
	}
}