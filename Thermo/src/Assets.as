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
		
		/* Door and key sprite sheet */
		[Embed(source = "../assets/tilesheets/door.png")]
		public static var doorSprite:Class;
		
		/* Gate sprite sheet */
		[Embed(source = "../assets/tilesheets/gates.png")]
		public static var gateSprite:Class;
		[Embed(source = "../assets/tilesheets/door.png")]
		public static var exitSprite:Class;
		
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
		[Embed(source = "../assets/objects/door.png")]
		public static var doorSprite:Class;
		
		
		/* Background sprites */
		[Embed(source = "../assets/backgrounds/background.png")]
		private static var b_1:Class;
		[Embed(source = "../assets/backgrounds/bkdg2.png")]
		private static var b_2:Class;
		[Embed(source = "../assets/backgrounds/bkgd3.png")]
		private static var b_3:Class;
		[Embed(source = "../assets/backgrounds/bkgd4.png")]
		private static var b_4:Class;
		[Embed(source = "../assets/backgrounds/bkgd5.png")]
		private static var b_5:Class;
		
		public static var b_list:Array = [b_1, b_2, b_3, b_4, b_5];
		
		/* Sounds */
	}
}