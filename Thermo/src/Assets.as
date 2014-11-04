package {
	/**
	 * Utility class for importing sprites and sounds
	 */
	public class Assets {
		
		/* Framerate for animations */
		public static const FRAME_RATE:int = 10;
		
		/* Sprites */
		
		/* Character sprite sheet */
		[Embed(source = "../assets/character/character.png")]
		public static var playerSprite:Class;
		public static var playerSpriteX:int = 23;
		public static var playerSpriteY:int = 28;
		
		/* Door and key sprite sheet */
		[Embed(source = "../assets/tilesheets/door.png")]
		public static var doorSprite:Class;
		public static var doorSpriteX:int = 32;
		public static var doorSpriteY:int = 32;
		
		/* Gate sprite sheet */
		[Embed(source = "../assets/tilesheets/gates.png")]
		public static var gateSprite:Class;
		public static var gateSpriteX:int = 16;
		public static var gateSpriteY:int = 64;
		
		[Embed(source = "../assets/tilesheets/door.png")]
		public static var exitSprite:Class;
		public static var exitSpriteX:int = 32;
		public static var exitSpriteY:int = 32;
		
		/* Ice platform sprites */
		[Embed(source = "../assets/objects/ice_platform.png")]
		public static var iceSprite:Class;
		[Embed(source = "../assets/objects/flash_platform.png")]
		public static var flashSprite:Class;
		
		/* Other stuff */
		[Embed(source = "../assets/objects/spike.png")]
		public static var spikeSprite:Class;
		
		[Embed(source = "../assets/objects/button.png")]
		public static var buttonSprite:Class;
		public static var buttonSpriteX:int = 32;
		public static var buttonSpriteY:int = 32;
		
		[Embed(source = "../assets/objects/trapdoor.png")]
		public static var trapdoorSprite:Class;
		public static var trapdoorSpriteX:int = 32;
		public static var trapdoorSpriteY:int = 32;
		
		[Embed(source = "../assets/objects/movingplatform.png")]
		public static var movingSprite:Class;
		
		
		/* Background sprites */
		[Embed(source = "../assets/backgrounds/background.png")]
		private static var b_1:Class;
		[Embed(source = "../assets/backgrounds/bkgd3.png")]
		private static var b_3:Class;
		[Embed(source = "../assets/backgrounds/bkgd4.png")]
		private static var b_4:Class;
		[Embed(source = "../assets/backgrounds/bkgd5.png")]
		private static var b_5:Class;
		
		public static var b_list:Array = [b_1, b_1, b_3, b_4, b_5];
		
		/* Sounds */
	}
}