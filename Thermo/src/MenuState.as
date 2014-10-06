// ActionScript file

package {
	import flash.display.Graphics;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	import org.flixel.*;
	
	public class MenuState extends FlxState {
		
		public var backgroundTile:FlxSprite;
		
		override public function create():void {
			FlxG.bgColor = 0xff000033;
			
			backgroundTile = new FlxSprite();
			backgroundTile.makeGraphic(320, 240, 0xffffffff);
			createVerticalGradient(backgroundTile, 0x0066cc, 0x003333);
			add(backgroundTile);
		}
		
		override public function update():void {
			
		}
		
		public function createVerticalGradient(Sprite:FlxSprite, TopColor:uint, BottomColor:uint): void
		{
			var gfx:Graphics = FlxG.flashGfx;
			gfx.clear();
			
			var colors:Array = new Array(TopColor, BottomColor);
			var alphas:Array = new Array(1, 1);
			var ratios:Array = new Array(0x00, 0xff);
			var matr:Matrix = new Matrix();
			matr.createGradientBox(Sprite.frameWidth, Sprite.frameHeight, Math.PI / 2);
			gfx.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matr);
			gfx.drawRect(0, 0, Sprite.frameWidth, Sprite.frameHeight);
			
			Sprite.pixels.draw(FlxG.flashGfxSprite);
			Sprite.dirty = true;
		}
	}
	
}