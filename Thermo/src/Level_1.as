//Code generated with DAME. http://www.dambots.com

package 
{
	import org.flixel.*;
	public class Level_1 extends BaseLevel
	{
		//Embedded media...
		[Embed(source="../assets/1/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] public var CSV_Group1Ground:Class;
		[Embed(source="../assets/groundpaint.png")] public var Img_Group1Ground:Class;
		[Embed(source="../assets/1/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] public var CSV_Group1Water:Class;
		[Embed(source="../assets/waterflash.png")] public var Img_Group1Water:Class;
		[Embed(source="../assets/1/mapCSV_Group1_FreezeGates.csv", mimeType="application/octet-stream")] public var CSV_Group1FreezeGates:Class;
		[Embed(source="../assets/gatesflash.png")] public var Img_Group1FreezeGates:Class;
		[Embed(source="../assets/1/mapCSV_Group1_HeatGates.csv", mimeType="application/octet-stream")] public var CSV_Group1HeatGates:Class;
		[Embed(source="../assets/gatesflash.png")] public var Img_Group1HeatGates:Class;
		[Embed(source="../assets/1/mapCSV_Group1_FlashGates.csv", mimeType="application/octet-stream")] public var CSV_Group1FlashGates:Class;
		[Embed(source="../assets/gatesflash.png")] public var Img_Group1FlashGates:Class;
		[Embed(source="../assets/1/mapCSV_Group1_Door.csv", mimeType="application/octet-stream")] public var CSV_Group1Door:Class;
		[Embed(source="../assets/doorflash.png")] public var Img_Group1Door:Class;
		[Embed(source="../assets/1/mapCSV_Group1_Key.csv", mimeType="application/octet-stream")] public var CSV_Group1Key:Class;
		[Embed(source="../assets/doorflash.png")] public var Img_Group1Key:Class;

		//Sprites

		public function Level_1(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerGroup1Ground = new FlxTilemap;
			layerGroup1Ground.loadMap( new CSV_Group1Ground, Img_Group1Ground, 32,32, FlxTilemap.OFF, 0, 1, 1 );
			layerGroup1Ground.x = 0.000000;
			layerGroup1Ground.y = 0.000000;
			layerGroup1Ground.scrollFactor.x = 1.000000;
			layerGroup1Ground.scrollFactor.y = 1.000000;
			layerGroup1Water = new FlxTilemap;
			layerGroup1Water.loadMap( new CSV_Group1Water, Img_Group1Water, 32,32, FlxTilemap.OFF, 0, 1, 1 );
			layerGroup1Water.x = 0.000000;
			layerGroup1Water.y = 0.000000;
			layerGroup1Water.scrollFactor.x = 1.000000;
			layerGroup1Water.scrollFactor.y = 1.000000;
			layerGroup1FreezeGates = new FlxTilemap;
			layerGroup1FreezeGates.loadMap( new CSV_Group1FreezeGates, Img_Group1FreezeGates, 16,16, FlxTilemap.OFF, 0, 1, 1 );
			layerGroup1FreezeGates.x = 0.000000;
			layerGroup1FreezeGates.y = 0.000000;
			layerGroup1FreezeGates.scrollFactor.x = 1.000000;
			layerGroup1FreezeGates.scrollFactor.y = 1.000000;
			layerGroup1HeatGates = new FlxTilemap;
			layerGroup1HeatGates.loadMap( new CSV_Group1HeatGates, Img_Group1HeatGates, 16,16, FlxTilemap.OFF, 0, 1, 1 );
			layerGroup1HeatGates.x = 0.000000;
			layerGroup1HeatGates.y = 0.000000;
			layerGroup1HeatGates.scrollFactor.x = 1.000000;
			layerGroup1HeatGates.scrollFactor.y = 1.000000;
			layerGroup1FlashGates = new FlxTilemap;
			layerGroup1FlashGates.loadMap( new CSV_Group1FlashGates, Img_Group1FlashGates, 16,16, FlxTilemap.OFF, 0, 1, 1 );
			layerGroup1FlashGates.x = 0.000000;
			layerGroup1FlashGates.y = 0.000000;
			layerGroup1FlashGates.scrollFactor.x = 1.000000;
			layerGroup1FlashGates.scrollFactor.y = 1.000000;
			layerGroup1Door = new FlxTilemap;
			layerGroup1Door.loadMap( new CSV_Group1Door, Img_Group1Door, 32,32, FlxTilemap.OFF, 0, 1, 1 );
			layerGroup1Door.x = 0.000000;
			layerGroup1Door.y = 0.000000;
			layerGroup1Door.scrollFactor.x = 1.000000;
			layerGroup1Door.scrollFactor.y = 1.000000;
			layerGroup1Key = new FlxTilemap;
			layerGroup1Key.loadMap( new CSV_Group1Key, Img_Group1Key, 32,32, FlxTilemap.OFF, 0, 1, 1 );
			layerGroup1Key.x = 0.000000;
			layerGroup1Key.y = 0.000000;
			layerGroup1Key.scrollFactor.x = 1.000000;
			layerGroup1Key.scrollFactor.y = 1.000000;

			//Add layers to the master group in correct order.
			masterLayer.add(layerGroup1Ground);
			masterLayer.add(layerGroup1Water);
			masterLayer.add(layerGroup1FreezeGates);
			masterLayer.add(layerGroup1HeatGates);
			masterLayer.add(layerGroup1FlashGates);
			masterLayer.add(layerGroup1Door);
			masterLayer.add(layerGroup1Key);


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
