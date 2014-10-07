// ActionScript file

package {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import mx.core.FlexSprite;
	
	import org.flixel.*;
	
	public class ListMenu extends FlxGroup {
		//public var menuItems:Vector.<FlxSprite>;
		private var menuYVals:Vector.<uint>;
		private var currentItem:uint;
		private var menuActive:Boolean;
		private var keyFramesDown:uint;
		
		private var cursor:FlxSprite;
		
		private var X:Number;
		private var Y:Number;
		private var width:Number;
		private var height:Number;
		
		public function ListMenu(X:Number = 0, Y:Number = 0) {
			this.X = X;
			this.Y = Y;
			this.width = this.height = 0;
			//menuItems = new Vector.<FlxSprite>();
			menuYVals = new Vector.<uint>();
			currentItem = 0;
			keyFramesDown = 0;
			menuActive = false;
			
			cursor = new FlxSprite(X - 10, Y);
			super.add(cursor);
		}
		
		override public function add(Object:FlxBasic):FlxBasic 
		{
			if (Object is FlxSprite)
			{
				var Sprite:FlxSprite = FlxSprite(Object);
				Sprite.x = X;
				Sprite.y = Y + this.height;
				menuYVals.push(this.height);
				//menuItems.push(Sprite);
				this.width = Math.max(this.width, Sprite.width * Sprite.scale.x);
				this.height += Sprite.height * Sprite.scale.y;
				return super.add(Object);
			}
			else
			{
				throw new ArgumentError("You may only add FlxSprites to a ListMenu.");
			}
		}
		
		public function setActive(active:Boolean): void {
			menuActive = active;
		}
		
		public function getSelectedIndex(): uint {
			return currentItem;
		}
		
		override public function update():void {
			if (menuActive)
			{
				var keyDown:Boolean = false;
				if (FlxG.keys.DOWN)
				{
					if (currentItem < menuYVals.length - 1 && keyFramesDown % 10 == 0)
					{
						currentItem++;
					}
					keyDown = true;
				}
				if (FlxG.keys.UP)
				{
					if (currentItem > 0 && keyFramesDown % 10 == 0)
					{
						currentItem--;
					}
					keyDown = true;
				}
				if (keyDown)
				{
					keyFramesDown++;
				}
				else
				{
					keyFramesDown = 0;
				}
				cursor.y = Y + menuYVals[currentItem];
			}
		}
	}
	
}