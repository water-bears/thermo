package {
	import context.MenuState;
	import org.flixel.*;
	
	
	[SWF(width="1024", height="768", backgroundColor="#000000")]
	//[SWF(width="2560", height="1920", backgroundColor="#000000")]
	
	public class Thermo extends FlxGame {
		public static const WIDTH = 1024;
		public static const HEIGHT = 768;
		
		public function Thermo() {
			super(WIDTH, HEIGHT, MenuState, 1);
			
			// Optional debug tools
			// FlxG.debug = true;
			// FlxG.visualDebug = true;
		}
	}
}