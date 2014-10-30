package context {
	import flash.display.Graphics;
	import flash.display.GradientType;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	import org.flixel.*;

	public class MenuUtils {
		public static function CreateVerticalGradient(Dimensions:FlxPoint, TopColor:uint, BottomColor:uint): FlxSprite {
			var Sprite:FlxSprite = new FlxSprite();
			Sprite.makeGraphic(Dimensions.x, Dimensions.y, 0xffffffff);
			
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
			
			return Sprite;
		}
		
		public static function CreateSolid(Dimensions:FlxPoint, Color:uint): FlxSprite {
			var Sprite:FlxSprite = new FlxSprite();
			Sprite.makeGraphic(Dimensions.x, Dimensions.y, 0xffffffff);
			
			var gfx:Graphics = FlxG.flashGfx;
			gfx.clear();
			
			gfx.beginFill(Color, 1);
			gfx.drawRect(0, 0, Sprite.frameWidth, Sprite.frameHeight);
			gfx.endFill();
			
			Sprite.pixels.draw(FlxG.flashGfxSprite);
			Sprite.dirty = true;
			
			return Sprite;
		}
		
		public static function CreateBubble(Size:Number): FlxSprite {
			var Sprite:FlxSprite = new FlxSprite();
			Sprite.makeGraphic(Size, Size, 0x00ffffff);
			
			var gfx:Graphics = FlxG.flashGfx;
			gfx.clear();
			
			var colors:Array = new Array(0xccccff, 0xffffff);
			var alphas:Array = new Array(1, 1);
			var ratios:Array = new Array(0x00, 0xff);
			var matr:Matrix = new Matrix();
			matr.createGradientBox(Sprite.frameWidth, Sprite.frameHeight, Math.PI / 2);
			gfx.beginGradientFill(GradientType.RADIAL, colors, alphas, ratios, matr);
			gfx.drawCircle(Sprite.frameWidth / 2, Sprite.frameHeight / 2, Sprite.frameWidth / 2 - 2);
			
			Sprite.pixels.draw(FlxG.flashGfxSprite);
			Sprite.dirty = true;
			
			return Sprite;
		}
	}
}