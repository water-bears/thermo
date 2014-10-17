package {
	/**
	 * Utility class for importing sprites and sounds
	 */
	public class Assets {
		/* Sprites */
		
		/* Basic standing character sprite */
		[Embed(source = "../assets/character.png")]
		public static var playerSprite:Class;
		
		/* Bubble sprite */
		[Embed(source = "../assets/bubble.png")]
		public static var bubbleSprite:Class;
		
		/* Background sprite */
		[Embed(source = "../assets/backgrounds/background.png")]
		public static var backgroundSprite:Class;
		
		/* Sounds */
	}
}