package {
	import context.MenuState;
	import org.flixel.*;
	[SWF(width="1024", height="768", backgroundColor="#000000")]
	
	public class Thermo extends FlxGame {
		public function Thermo() {
			super(1024, 768, MenuState, 1);
			
			// Optional debug tools
			// FlxG.debug = true;
			// FlxG.visualDebug = true;
		}
	}
}