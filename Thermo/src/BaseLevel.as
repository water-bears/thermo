package {
	import org.flixel.*;
	public class BaseLevel {
		public var layerGroup1Ground:FlxTilemap;
		public var layerGroup1Water:FlxTilemap;
		public var layerGroup1FreezeGates:FlxTilemap;
		public var layerGroup1HeatGates:FlxTilemap;
		public var layerGroup1FlashGates:FlxTilemap;
		public var layerGroup1Door:FlxTilemap;
		public var layerGroup1Key:FlxTilemap;
		
		//Player Start Position
		public var start_x:Number = 2;
		public var start_y:Number = 2;
		
		public var masterLayer:FlxGroup = new FlxGroup;

		public var mainLayer:FlxTilemap;

		public var boundsMinX:int;
		public var boundsMinY:int;
		public var boundsMaxX:int;
		public var boundsMaxY:int;

		public function BaseLevel() { }
/*
		public function addSpriteToLayer(type:Class, group:FlxGroup, x:Number, y:Number, angle:Number, flipped:Boolean, onAddCallback:Function = null):FlxSprite {
			var obj:FlxSprite = new type(x, y);
			obj.x += obj.offset.x;
			obj.y += obj.offset.y;
			obj.angle = angle;
			// Only override the facing value if the class didn't change it from the default.
			if( obj.facing == FlxSprite.RIGHT )
				obj.facing = flipped ? FlxSprite.LEFT : FlxSprite.RIGHT;
			group.add(obj,true);
			if(onAddCallback != null)
				onAddCallback(obj, group);
			return obj;
		}
		*/
	}
}