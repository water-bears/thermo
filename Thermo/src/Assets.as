package {
	import flash.display.BitmapDataChannel;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/**
	 * Utility class for importing sprites and sounds
	 */
	public class Assets {
		
		/* Framerate for animations */
		public static const FRAME_RATE:int = 25;
		
		/* Sprites */
		
		/* Character sprite sheet */
		[Embed(source = "../assets/character/player.png")]
		public static var playerSprite:Class;
		public static var playerSpriteX:int = 35;
		public static var playerSpriteY:int = 42;
		
		/* Door closed */
		[Embed(source = "../assets/tilesheets/door.png")]
		public static var doorSprite:Class;
		public static var doorSpriteX:int = 128;
		public static var doorSpriteY:int = 128;
		
		/* Door open */
		[Embed(source = "../assets/tilesheets/door1.png")]
		public static var door1Sprite:Class;
		public static var door1SpriteX:int = 128;
		public static var door1SpriteY:int = 128;
		
		/* Gate sprite sheet */
		[Embed(source = "../assets/tilesheets/gates.png")]
		public static var gateSprite:Class;
		public static var gateSpriteX:int = 10;
		public static var gateSpriteY:int = 40;
		
		[Embed(source = "../assets/objects/key.png")]
		public static var keySprite:Class;
		public static var keySpriteX:int = 32;
		public static var keySpriteY:int = 32;
		
		/* Ice platform sprites */
		[Embed(source = "../assets/objects/ice_platform.png")]
		public static var iceSprite:Class;
		[Embed(source = "../assets/objects/long_ice_platform.png")]
		public static var longSprite:Class;
		[Embed(source = "../assets/objects/flash_platform.png")]
		public static var flashSprite:Class;
		
		/* Other stuff */
		[Embed(source = "../assets/objects/spikes.png")]
		public static var spikeSprite:Class;
		[Embed(source = "../assets/objects/upspikes.png")]
		public static var upspikeSprite:Class;
		[Embed(source = "../assets/objects/leftspikes.png")]
		public static var leftspikeSprite:Class;
		[Embed(source = "../assets/objects/rightspikes.png")]
		public static var rightspikeSprite:Class;
		
		[Embed(source = "../assets/objects/button.png")]
		public static var buttonSprite:Class;
		public static var buttonSpriteX:int = 32;
		public static var buttonSpriteY:int = 32;
		
		[Embed(source = "../assets/objects/trapdoor_closed.png")]
		public static var trapdoorClosedSprite:Class;
		public static var trapdoorClosedSpriteX:int = 20;
		public static var trapdoorClosedSpriteY:int = 10;
		
		[Embed(source = "../assets/objects/trapdoor_open.png")]
		public static var trapdoorOpenSprite:Class;
		public static var trapdoorOpenSpriteX:int = 10;
		public static var trapdoorOpenSpriteY:int = 20;
		
		[Embed(source = "../assets/objects/movingplatform.png")]
		public static var movingSprite:Class;
		
		/* TEMPORARY wind sprites */
		/*
		[Embed(source = "../assets/damesprites/wind_left.png")]
		public static var windleftSprite:Class;
		public static var windleftSpriteX:int = 20;
		public static var windleftSpriteY:int = 20;
		*/
		[Embed(source = "../assets/objects/bubble.png")]
		public static var bubbleSprite:Class;
		
		[Embed(source = "../assets/damesprites/wind_right.png")]
		public static var windrightSprite:Class;
		public static var windrightSpriteX:int = 20;
		public static var windrightSpriteY:int = 20;

		/* Decoration assets */
		[Embed(source = "../assets/objects/grass.png")]
		public static var grassSprite:Class;
		public static var grassSpriteX:int = 20;
		public static var grassSpriteY:int = 20;
		
		[Embed(source = "../assets/objects/tree.png")]
		public static var treeSprite:Class;
		public static var treeSpriteX:int = 120;
		public static var treeSpriteY:int = 120;
		
		[Embed(source = "../assets/objects/lava.png")]
		public static var hotLavaSprite:Class;
		// TODO add a cold lava sprite
		[Embed(source = "../assets/objects/cold_zone.png")]
		public static var coldLavaSprite:Class;
		public static var lavaSpriteX:int = 200;
		public static var lavaSpriteY:int = 20;
		
		/* Keys */
		[Embed(source = "../assets/keys/spacebar.png")]
		public static var spacebarSprite:Class;
		[Embed(source = "../assets/keys/arrows.png")]
		public static var arrowsSprite:Class;
		
		
		/* Background sprites */
		[Embed(source = "../assets/backgrounds/background.png")]
		private static var b_1:Class;
		[Embed(source = "../assets/backgrounds/bkgd4_1.png")]
		private static var b_2:Class;
		[Embed(source = "../assets/backgrounds/bkgd5_1.png")]
		private static var b_3:Class;
		[Embed(source = "../assets/backgrounds/bkgd6.png")]
		private static var b_4:Class;
		[Embed(source = "../assets/backgrounds/bkgd7.png")]
		private static var b_5:Class;
		[Embed(source = "../assets/backgrounds/bkgd9.png")]
		private static var b_6:Class;
		[Embed(source = "../assets/backgrounds/blueclouds.jpg")]
		private static var b_7:Class;
		[Embed(source = "../assets/backgrounds/morecloudz.jpg")]
		private static var b_8:Class;
		[Embed(source = "../assets/backgrounds/sunsetcloud.jpg")]
		private static var b_9:Class;
		[Embed(source = "../assets/backgrounds/bkgd1.png")]
		private static var b_10:Class;
		[Embed(source = "../assets/backgrounds/nbkgd1.jpg")]
		private static var b_11:Class;
		[Embed(source = "../assets/backgrounds/nbkgd2.jpg")]
		private static var b_12:Class;
		[Embed(source = "../assets/backgrounds/placeholder.png")]
		private static var b_REPLACE_ME:Class;
		
		/*
		 * Fonts (really just one font, I think)
		 */ 
		
		[Embed(source = "../assets/fonts/Exo2-ExtraBold.ttf", fontFamily="Default", embedAsCFF="false")]
		private static var font_primary:Class;
		public static var font_name:String = "Default";
		
		/*
		 * Sound Effects
		 */ 
		
		[Embed(source = "../assets/sfx/option_cycle.mp3")]
		public static var sfx_option_cycle:Class;
		[Embed(source = "../assets/sfx/splash.mp3")]
		public static var sfx_splash:Class;
		[Embed(source = "../assets/sfx/splash_out.mp3")]
		public static var sfx_splash_out:Class;
		[Embed(source = "../assets/sfx/thermo_wip.mp3")]
		public static var sfx_bgm:Class;
		[Embed(source = "../assets/sfx/thermo_uw.mp3")]
		public static var sfx_bgm_underwater:Class;
		
		/**
		 * List of backgrounds in the order that they appear in the game.
		 */
		public static var b_list:Array = [
			b_REPLACE_ME, b_REPLACE_ME, b_REPLACE_ME,
			b_REPLACE_ME, b_REPLACE_ME, b_REPLACE_ME,
			b_REPLACE_ME, b_REPLACE_ME, b_REPLACE_ME,
			b_REPLACE_ME, b_REPLACE_ME, b_REPLACE_ME,
			b_REPLACE_ME, b_REPLACE_ME, b_REPLACE_ME,
			b_REPLACE_ME
		];
		
		/* Sounds */
	}
}