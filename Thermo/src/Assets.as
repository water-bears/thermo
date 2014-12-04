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
		
		/* Character sprite sheet */
		[Embed(source = "../assets/character/goldenbubble.png")]
		public static var goldenBubbleSprite:Class;
		
		/* Door closed */
		[Embed(source = "../assets/tilesheets/door_vortex.png")]
		public static var doorSprite:Class;
		public static var doorSpriteX:int = 50;
		public static var doorSpriteY:int = 50;
		
		/* Door open */
		[Embed(source = "../assets/tilesheets/door1.png")]
		public static var door1Sprite:Class;
		public static var door1SpriteX:int = 128;
		public static var door1SpriteY:int = 128;
		
		/* Gate sprite sheet */
		[Embed(source = "../assets/tilesheets/gates_new.png")]
		public static var gateSprite:Class;
		public static var gateSpriteX:int = 10;
		public static var gateSpriteY:int = 40;
		
		[Embed(source = "../assets/objects/key.png")]
		public static var keySprite:Class;
		public static var keySpriteX:int = 20;
		public static var keySpriteY:int = 20;
		
		/* Ice platform sprites */
		[Embed(source = "../assets/objects/ice_platform.png")]
		public static var iceSprite:Class;
		[Embed(source = "../assets/objects/long_ice_platform.png")]
		public static var longSprite:Class;
		[Embed(source = "../assets/objects/flash_platform.png")]
		public static var flashSprite:Class;
		
		/* Other stuff */
		[Embed(source = "../assets/objects/spikes1.png")]
		public static var spikeSprite:Class;
		[Embed(source = "../assets/objects/upspikes1.png")]
		public static var upspikeSprite:Class;
		[Embed(source = "../assets/objects/leftspikes1.png")]
		public static var leftspikeSprite:Class;
		[Embed(source = "../assets/objects/rightspikes1.png")]
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
		[Embed(source = "../assets/backgrounds/bkgd4_1.png")]
		private static var red1:Class;
		[Embed(source = "../assets/backgrounds/bkgd5_1.png")]
		private static var yellow1:Class;
		[Embed(source = "../assets/backgrounds/bkgd6.png")]
		private static var purple1:Class;
		[Embed(source = "../assets/backgrounds/bkgd7.png")]
		private static var pink1:Class;
		[Embed(source = "../assets/backgrounds/bkgd9.png")]
		private static var yellow2:Class;
		[Embed(source = "../assets/backgrounds/blueclouds.jpg")]
		private static var clouds1:Class;
		[Embed(source = "../assets/backgrounds/morecloudz.jpg")]
		private static var clouds2:Class;
		[Embed(source = "../assets/backgrounds/sunsetcloud.jpg")]
		private static var sunset:Class;
		[Embed(source = "../assets/backgrounds/bkgd1.png")]
		private static var blue1:Class;
		[Embed(source = "../assets/backgrounds/nbkgd1.jpg")]
		private static var green1:Class;
		[Embed(source = "../assets/backgrounds/nbkgd2.jpg")]
		private static var orange1:Class;
		[Embed(source = "../assets/backgrounds/placeholder.png")]
		private static var b_REPLACE_ME:Class;
		[Embed(source = "../assets/backgrounds/moon1.jpg")]
		private static var moon1:Class;
		[Embed(source = "../assets/backgrounds/moon2.jpg")]
		private static var moon2:Class;
		[Embed(source = "../assets/backgrounds/moon3.jpg")]
		private static var moon3:Class;
		[Embed(source = "../assets/backgrounds/moon4.jpg")]
		private static var moon4:Class;
		[Embed(source = "../assets/backgrounds/moon5.jpg")]
		private static var moon5:Class;
		[Embed(source = "../assets/backgrounds/moon6.jpg")]
		private static var moon6:Class;
		[Embed(source = "../assets/backgrounds/moon7.jpg")]
		private static var moon7:Class;
		[Embed(source = "../assets/backgrounds/moon8.jpg")]
		private static var moon8:Class;
		[Embed(source = "../assets/backgrounds/moon9.jpg")]
		private static var moon9:Class;
		[Embed(source = "../assets/backgrounds/moon10.jpg")]
		private static var moon10:Class;
		[Embed(source = "../assets/backgrounds/bright_sunset.jpg")]
		private static var bright_sunset:Class;
		[Embed(source = "../assets/backgrounds/nbkgd6.jpg")]
		private static var last_scene:Class;
		
		[Embed(source = "../assets/ui/star.png")]
		public static var starSprite:Class;
		[Embed(source = "../assets/ui/lock.png")]
		public static var lockSprite:Class;
		[Embed(source = "../assets/ui/cursor.png")]
		public static var cursorSprite:Class;
		[Embed(source = "../assets/ui/pause.png")]
		public static var pauseSprite:Class;
		[Embed(source = "../assets/ui/mute.png")]
		public static var muteSprite:Class;
		[Embed(source = "../assets/ui/info.png")]
		public static var infoSprite:Class;
		[Embed(source = "../assets/ui/credits.png")]
		public static var creditsSprite:Class;
		
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
		[Embed(source = "../assets/sfx/bubble.mp3")]
		public static var sfx_bubble:Class;
		[Embed(source = "../assets/sfx/bubblepop.mp3")]
		public static var sfx_bubblepop:Class;
		[Embed(source = "../assets/sfx/ice.mp3")]
		public static var sfx_ice:Class;
		[Embed(source = "../assets/sfx/gate.mp3")]
		public static var sfx_gate:Class;
		[Embed(source = "../assets/sfx/heatgate.mp3")]
		public static var sfx_heatgate:Class;
		[Embed(source = "../assets/sfx/freezegate.mp3")]
		public static var sfx_freezegate:Class;
		[Embed(source = "../assets/sfx/flashgate.mp3")]
		public static var sfx_flashgate:Class;
		[Embed(source = "../assets/sfx/neutralgate.mp3")]
		public static var sfx_neutralgate:Class;
		[Embed(source = "../assets/sfx/wave.mp3")]
		public static var sfx_wave:Class;
		[Embed(source = "../assets/sfx/key.mp3")]
		public static var sfx_key:Class;
		[Embed(source = "../assets/sfx/door.mp3")]
		public static var sfx_door:Class;
		
		/**
		 * List of backgrounds in the order that they appear in the game.
		 */
		public static var b_list:Array = [
			// Row 1
			last_scene, last_scene, last_scene, last_scene, last_scene,
			
			// Row 2
			bright_sunset, bright_sunset, bright_sunset, bright_sunset, bright_sunset,
			
			// Row 3
			clouds1, clouds1, clouds1, clouds1, clouds1,
			
			// Row 4
			clouds2, clouds2, clouds2, clouds2, clouds2,
			
			// Row 5
			sunset, sunset, sunset, sunset, sunset,
			
			// Row S
			moon10, moon5, moon8, moon6, moon1
		];
		
		/* Sounds */
	}
}