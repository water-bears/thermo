package Menu {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import org.flixel.FlxSprite;
	
	import org.flixel.*;
	
	public class ListMenu extends MenuComponentCollection {
		private var menuYVals:Vector.<uint>;
		private var keyFramesDown:uint;
		
		private var cursor:FlxSprite;
		
		public function ListMenu(X:Number = 0, Y:Number = 0) {
			super(X, Y);
			menuYVals = new Vector.<uint>();
			keyFramesDown = 0;
			
			cursor = new FlxSprite(X - 10, Y);
		}
		
		override public function Register(state:FlxState):void 
		{
			super.Register(state);
			state.add(cursor);
		}
		
		public override function Preprocess() : void
		{
			var keyDown:Boolean = false;
			if (FlxG.keys.DOWN) {
				if (selectedID < menuYVals.length - 1 && keyFramesDown % 10 == 0) {
					selectedID++;
				}
				keyDown = true;
			}
			
			if (FlxG.keys.UP) {
				if (selectedID > 0 && keyFramesDown % 10 == 0) {
					selectedID--;
				}
				keyDown = true;
			}
			
			if (keyDown) {
				keyFramesDown++;
			} else {
				keyFramesDown = 0;
			}
		}
		
		public override function Postprocess() : void
		{
			this.width = this.height = 0;
			while (menuItems.length > menuYVals.length)
			{
				menuYVals.push(0);
			}
			for (var i:uint = 0; i < this.menuItems.length; i++)
			{
				var sprite : FlxSprite = menuItems[i].GetSprite();
				sprite.x = X;
				sprite.y = Y + this.height;
				menuYVals[i] = this.height;
				this.width = Math.max(this.width, sprite.width * sprite.scale.x);
				this.height += sprite.height * sprite.scale.y;
			}
			cursor.y = Y + menuYVals[selectedID];
		}
	}
}