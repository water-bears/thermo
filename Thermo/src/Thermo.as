package {
	
	import context.MenuState;
	
	import org.flixel.*;
	import Logging;
	[SWF(width="1024", height="768", backgroundColor="#000000")]
	//[SWF(width="2560", height="1920", backgroundColor="#000000")]
	
	public class Thermo extends FlxGame {
		public var log:Logging = new Logging(700, 1.0, true);
		
		public function Thermo() {
			super(1024, 768, MenuState, 1);
			log.recordPageLoad();
			
			// Optional debug tools
			// FlxG.debug = true;
			// FlxG.visualDebug = true;
		}
	}
}