package context {
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
		
		public function ListMenu(X:Number = 0, Y:Number = 0, scale:Number = 1) {
			super(X, Y);
			this.scale = new FlxPoint(scale, scale);
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
				if (keyFramesDown % 10 == 0) {
					if (selectedID >= menuYVals.length - 1)
						selectedID = 0;
					else
						selectedID++;
				}
				keyDown = true;
			}
			
			if (FlxG.keys.UP) {
				if (keyFramesDown % 10 == 0) {
					if (selectedID == 0)
						selectedID = menuYVals.length - 1;
					else
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
				var localPosition : FlxPoint = menuItems[i].GetLocalPosition();
				var localScale : FlxPoint = menuItems[i].GetLocalScale();
				sprite.x = X + localPosition.x;
				sprite.y = Y + localPosition.y + this.height;
				sprite.scale.x = scale.x * localScale.x;
				sprite.scale.y = scale.y * localScale.y;
				menuYVals[i] = this.height;
				this.width = Math.max(this.width, sprite.width * sprite.scale.x); 
				this.height += sprite.height * sprite.scale.y + localPosition.y;
			}
			cursor.y = Y + menuYVals[selectedID];
		}
	}
}