package {
	/**
	 * Utility class for importing sprites and sounds
	 */
	public class Assets {
		/* Sprites */
		
		/* Basic standing character sprite */
		[Embed(source = "../assets/character/character.png")]
		public static var playerSprite:Class;
		
		/* Ice platform sprites */
		[Embed(source = "../assets/objects/ice_platform.png")]
		public static var iceSprite:Class;
		[Embed(source = "../assets/objects/flash_platform.png")]
		public static var flashSprite:Class;
		
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