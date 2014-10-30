package {
	
	import context.MenuState;
	
	import org.flixel.*;
	import Logging;
	[SWF(width="1024", height="768", backgroundColor="#000000")]
	//[SWF(width="2560", height="1920", backgroundColor="#000000")]
	
	public class Thermo extends FlxGame {
		public var log:Logging = new Logging(700, 1.0, true);
		public static const WIDTH:int = 1024;
		public static const HEIGHT:int = 768;
		
		public function Thermo() {
			super(WIDTH, HEIGHT, MenuState, 1);
			log.recordPageLoad();
			
			// Optional debug tools
			// FlxG.debug = true;
			// FlxG.visualDebug = true;
		}
	}
}