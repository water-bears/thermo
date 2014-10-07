//Code generated with DAME. http://www.dambots.com

package 
{
	import org.flixel.*;
	public class Level_Test3 extends BaseLevel
	{
		//Embedded media...
		[Embed(source="../assets/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] public var CSV_Group1Ground:Class;
		[Embed(source="../assets/groundpaint.png")] public var Img_Group1Ground:Class;
		[Embed(source="../assets/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] public var CSV_Group1Water:Class;
		[Embed(source="../assets/waterflash.png")] public var Img_Group1Water:Class;

		//Tilemaps
		public var layerGroup1Ground:FlxTilemap;
		public var layerGroup1Water:FlxTilemap;

		//Sprites


		public function Level_Test3(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerGroup1Ground = new FlxTilemap;
			layerGroup1Ground.loadMap( new CSV_Group1Ground, Img_Group1Ground, 32,32, FlxTilemap.OFF, 0, 1, 1 );
			layerGroup1Ground.x = 0.000000;
			layerGroup1Ground.y = 0.000000;
			layerGroup1Ground.scrollFactor.x = 1.000000;
			layerGroup1Ground.scrollFactor.y = 1.000000;
			layerGroup1Water = new FlxTilemap;
			layerGroup1Water.loadMap( new CSV_Group1Water, Img_Group1Water, 32,32, FlxTilemap.OFF, 0, 1, 16 );
			layerGroup1Water.x = 0.000000;
			layerGroup1Water.y = 0.000000;
			layerGroup1Water.scrollFactor.x = 1.000000;
			layerGroup1Water.scrollFactor.y = 1.000000;

			//Add layers to the master group in correct order.
			masterLayer.add(layerGroup1Ground);
			masterLayer.add(layerGroup1Water);


			if ( addToStage )
			{
				FlxG.state.add(masterLayer);
			}

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 640;
			boundsMaxY = 320;

		}


	}
}
