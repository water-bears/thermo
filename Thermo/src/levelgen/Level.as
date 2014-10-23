package levelgen {
	import flash.events.Event;
	import org.flixel.*;

	public class Level 
	{
		[Embed(source = "../../assets/tilesheets/ground.png")] private static var groundAsset:Class;
		[Embed(source = "../../assets/tilesheets/water.png")] private static var waterAsset:Class;
		[Embed(source = "../../assets/tilesheets/door.png")] private static var doorAsset:Class;
		[Embed(source = "../../assets/tilesheets/gates.png")] private static var gatesAsset:Class;		
		
		public var background:FlxSprite = null;
		
		public var player:FlxSprite;
		
		public var ground:FlxTilemap = new FlxTilemap;
		public var water:FlxTilemap = new FlxTilemap;
		
		public var freezeGates:FlxGroup = new FlxGroup;
		public var heatGates:FlxGroup = new FlxGroup;
		public var flashGates:FlxGroup = new FlxGroup;
		
		public var exits:FlxGroup = new FlxGroup;
		public var keys:FlxGroup = new FlxGroup;
		
		public var spikes:FlxGroup = new FlxGroup;
		public var door:Door;
		public var button:Button;
		
		public var otherSprites:FlxGroup = new FlxGroup;
		
		public var levelNum:uint;
		
		private const fileLocation:String = "levels/"
		
		public function Level(levelNum:uint) 
		{
			this.levelNum = levelNum;
			var file:String = fileLocation + String(levelNum) + "/" + "Level_" + String(levelNum) + ".xml";
			var xmlFile:XML = new XML(AS3Embed.GetTextAsset(file));
			
			//if we can't find the xml file, just use level 1
			if (AS3Embed.GetTextAsset(file) == "error")
			{
				levelNum = 1;
				file = fileLocation + String(levelNum) + "/" + "Level_" + String(levelNum) + ".xml";
				xmlFile = new XML(AS3Embed.GetTextAsset(file));
			}
			
			var numLayers:int = xmlFile.layer.length()
			var xmlLayer:XMLList = xmlFile.layer;
			
			var numClasses:int = xmlFile.spriteclasses.length();
			var xmlClass:XMLList = xmlFile.spriteclasses;
			var classMap:Object = new Object();
			
			//iterate over all spriteclasses sections (there should only be one)
			for (var classNum:int = 0; classNum < numClasses; classNum++)
			{
				//iterate over all classes
				for (var i:int = 0; i < xmlClass[classNum].clas.length(); i++)
				{
					//save the portion of the xml document that needs to be used by sprites
					classMap[xmlClass[classNum].clas[i].@name] = xmlClass[classNum].clas[i]
				}
			}
			
			//iterate over all layers
			for (var layerNum:int = 0; layerNum < numLayers; layerNum++)
			{
				var numMaps:int = xmlLayer[layerNum].map.length();
				var xmlMap:XMLList = xmlLayer[layerNum].map;
				
				var numSprites:int = xmlLayer[layerNum].sprite.length();
				var xmlSprite:XMLList = xmlLayer[layerNum].sprite;
				
				//iterate over all maps
				for (var mapNum:int = 0; mapNum < numMaps; mapNum++)
				{
					var csv:String = AS3Embed.GetTextAsset(xmlMap[mapNum].@csv);
					if (csv == null)
					{
						continue;
					}
				
					var tilemap:FlxTilemap = new FlxTilemap;
					tilemap.x = xmlMap[mapNum].@x
					tilemap.y = xmlMap[mapNum].@y
					tilemap.scrollFactor.x = xmlLayer[layerNum].@xScroll;
					tilemap.scrollFactor.y = xmlLayer[layerNum].@yScroll;

					var tiletype:String = xmlLayer[layerNum].@name;
					switch(tiletype)
					{
					case "Ground":
						tilemap.loadMap(csv, groundAsset, xmlMap[mapNum].@tileWidth, xmlMap[mapNum].@tileHeight, FlxTilemap.OFF, 0, xmlMap[mapNum].@drawIdx, xmlMap[mapNum].@collIdx);
						ground = tilemap;
						break;
					case "Water":
						tilemap.loadMap(csv, waterAsset, xmlMap[mapNum].@tileWidth, xmlMap[mapNum].@tileHeight, FlxTilemap.OFF, 0, xmlMap[mapNum].@drawIdx, xmlMap[mapNum].@collIdx);
						water = tilemap;
						break;
					}
				}
				
				//iterate over all sprites
				for (var spriteNum:int = 0; spriteNum < numSprites; spriteNum++)
				{
					var xmlSpriteClass:XML = classMap[xmlSprite[spriteNum].@clas]
					
					var sprite:FlxSprite = new FlxSprite(xmlSprite[spriteNum].@x, xmlSprite[spriteNum].@y);
					
					sprite.angle = xmlSprite[spriteNum].@angle;
					sprite.scale.x = xmlSprite[spriteNum].@xScale;
					sprite.scale.y = xmlSprite[spriteNum].@yScale;
					sprite.scrollFactor.x = xmlLayer[layerNum].@xScroll;
					sprite.scrollFactor.y = xmlLayer[layerNum].@yScroll;
					
					var spritetype:String = xmlSprite[spriteNum].@name;
					switch(spritetype)
					{
					case "Player":
						player = sprite; //this is just to get the player's x y location
						break;
						
					case "HeatGate":
						//sprite.loadGraphic(gatesAsset, false, false, xmlSpriteClass.@width, xmlSpriteClass.@height);
						//sprite.frame = 2;
						heatGates.add(new Gate(sprite, Gate.HEAT));
						break;
						
					case "FreezeGate":
						//sprite.loadGraphic(gatesAsset, false, false, xmlSpriteClass.@width, xmlSpriteClass.@height);
						//sprite.frame = 1;
						freezeGates.add(new Gate(sprite, Gate.FREEZE));
						break;
						
					case "FlashGate":
						//sprite.loadGraphic(gatesAsset, false, false, xmlSpriteClass.@width, xmlSpriteClass.@height);
						//sprite.frame = 3;
						flashGates.add(new Gate(sprite, Gate.FLASH));
						break;
						
					case "Key":
						sprite.loadGraphic(doorAsset, false, false, xmlSpriteClass.@width, xmlSpriteClass.@height);
						sprite.frame = 2;
						keys.add(sprite);
						break;
						
					case "Exit":
						sprite.loadGraphic(doorAsset, false, false, xmlSpriteClass.@width, xmlSpriteClass.@height);
						sprite.frame = 1;
						exits.add(sprite);
						break;
						
					case "Spike":
						var spike:Spike = new Spike(xmlSprite[spriteNum].@x, xmlSprite[spriteNum].@y, int((xmlSprite[spriteNum].@angle / 360)*4));
						break;
					/*
					case "MovingPlatform":
						var movingplatform:MovingPlatform = new MovingPlatform(x, y, startPos, endpos, direction);
						break;
						*/
						
					case "Button":
						var button:Button = new Button(xmlSprite[spriteNum].@x, xmlSprite[spriteNum].@y, door);
						break;
						
					case "Door":
						var door:Door = new Door(xmlSprite[spriteNum].@x, xmlSprite[spriteNum].@y);
						break;
						
						
					default:
						otherSprites.add(sprite);						
					}
				}
			}
			
			//done parsing the file!
		}
		
		
	}

}