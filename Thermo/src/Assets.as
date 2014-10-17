package {
	/**
	 * Utility class for importing sprites and sounds
	 */
	public class Assets {
		/* Sprites */
		
		/* Basic standing character sprite */
		[Embed(source = "../assets/character.png")]
		public static var player_sprite:Class;
		
		/* Bubble sprite */
		[Embed(source = "../assets/bubble.png")]
		public static var bubble_sprite:Class;
		
		/* Background sprite */
		[Embed(source = "../assets/backgrounds/background.png")]
		public static var background_sprite:Class;
		
		/* Sounds */
	}
}