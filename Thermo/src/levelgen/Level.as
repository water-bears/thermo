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
		public var neutralGates:FlxGroup = new FlxGroup;
		
		public var exits:FlxGroup = new FlxGroup;
		public var keys:FlxGroup = new FlxGroup;
		
		public var spikes:FlxGroup = new FlxGroup;
		public var movingplatforms:FlxGroup = new FlxGroup;
		
		public var trapdoor:Trapdoor;
		public var button:Button;
		
		public var frontSprites:FlxGroup = new FlxGroup;
		public var backSprites:FlxGroup = new FlxGroup;
		
		public var levelNum:uint;
		
		private const fileLocation:String = "levels/"
		
		/**
		 * Map of level names, in game order.
		 * Note, the strings do not need to be numbers (We just happen to use numbers a lot).
		 * The name of the level corresponds to the name of the .dam file.
		 */
		private static var LEVEL_MAP:Array = new Array(
			"jump_tutorial",
			"1",
			"2",
			"3",
			"4",
			"5",
			"6",
			"7",
			"8",
			"9",
			"medium_00"
		);
		
		/**
		 * Number of levels in the game
		 */
		public static var NUM_LEVELS:uint = LEVEL_MAP.length;
		
		/**
		 * Helper function gets the name of the level that corresponds
		 * to the given index, based on the LEVEL_MAP
		 */
		private static function levelName(levelNum:uint):String
		{
			if (levelNum < 1 || levelNum > NUM_LEVELS)
				return levelNum.toString();
			else
				return LEVEL_MAP[levelNum - 1];
		}
		
		public function Level(levelNum:uint) 
		{
			this.levelNum = levelNum;
			var file:String = fileLocation + levelName(levelNum) + "/" + "Level_" + levelName(levelNum) + ".xml";
			var xmlFile:XML = new XML(AS3Embed.GetTextAsset(file));
			
			//if we can't find the xml file, just use level 1
			if (AS3Embed.GetTextAsset(file) == "error")
			{
				levelNum = 1;
				file = fileLocation + levelName(levelNum) + "/" + "Level_" + levelName(levelNum) + ".xml";
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
				
				//for iterating over properties (later)
				var numProps:int;
				var xmlProp:XMLList;
				var propNum:int;
				var proptype:String;
				
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
					sprite.setOriginToCorner();
					
					sprite.angle = xmlSprite[spriteNum].@angle;
					sprite.scale.x = xmlSprite[spriteNum].@xScale;
					sprite.scale.y = xmlSprite[spriteNum].@yScale;
					sprite.scrollFactor.x = xmlLayer[layerNum].@xScroll;
					sprite.scrollFactor.y = xmlLayer[layerNum].@yScroll;
					
					var asset:Class = AS3Embed.GetArtAsset(xmlSpriteClass.@file);
					sprite.loadGraphic(asset, true, false, xmlSpriteClass.@width, xmlSpriteClass.@height);
					
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
						
					case "NeutralGate":
						neutralGates.add(new Gate(sprite, Gate.NEUTRAL));
						break;
						
					case "Key":
						sprite.loadGraphic(doorAsset, false, false, xmlSpriteClass.@width, xmlSpriteClass.@height);
						sprite.frame = 2;
						var gravity:Boolean = false;
						
						numProps = xmlSprite[spriteNum].prop.length();
						xmlProp = xmlSprite[spriteNum].prop;
						for (propNum = 0; propNum < numProps; propNum++)
						{
							proptype = xmlProp[propNum].@name;
							switch(proptype)
							{
							case "gravity":
								gravity = xmlProp[propNum].@value;
								break;
							default:
								break;
							}
							
						}
						
						keys.add(new Key(xmlSprite[spriteNum].@x, xmlSprite[spriteNum].@y, gravity));
						break;
						
					case "Exit":
						//sprite.loadGraphic(doorAsset, false, false, xmlSpriteClass.@width, xmlSpriteClass.@height);
						//sprite.frame = 1;
						exits.add(new Door(sprite));
						break;
						
					case "Spikes":
						var spike:Spike = new Spike(sprite);
						spikes.add(spike);
						break;
					
					case "MovingPlatform":
						var startPos:int = sprite.y;
						var endPos:int = sprite.y + 96;
						var direction:int = 4;
						
						numProps = xmlSprite[spriteNum].prop.length();
						xmlProp = xmlSprite[spriteNum].prop;
						for (propNum = 0; propNum < numProps; propNum++)
						{
							proptype = xmlProp[propNum].@name;
							switch(proptype)
							{
							case "startPos":
								startPos = xmlProp[propNum].@value;
								break;
							case "endPos":
								endPos = xmlProp[propNum].@value;
								break;
							case "direction":
								direction = xmlProp[propNum].@value;
								break;
							default:
								break;
							}
							
						}
						
						var movingplatform:MovingPlatform = new MovingPlatform(sprite, startPos, endPos, direction);
						movingplatforms.add(movingplatform);
						break;				
						
					case "Button":
						button = new Button(xmlSprite[spriteNum].@x, xmlSprite[spriteNum].@y, trapdoor);
						break;
						
					case "Trapdoor":
						trapdoor = new Trapdoor(xmlSprite[spriteNum].@x, xmlSprite[spriteNum].@y);
						break;
							
					default:
						var frontorback:String = xmlLayer[layerNum].@name;
						switch(frontorback)
						{
						case "Front":
							frontSprites.add(sprite);
						default:
							backSprites.add(sprite);
						}					
					}
				}
			}
			
			//done parsing the file!
		}
		
		
	}

}