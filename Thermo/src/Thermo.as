package {
	
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#000000")]
	
	public class Thermo extends FlxGame
	{
		public function Thermo()
		{
			super(640, 480, MenuState, 1);
			
			// Optional debug tools
			// FlxG.debug = true;
			// FlxG.visualDebug = true;
		}
	}
}