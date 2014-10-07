package {
	
	import org.flixel.*;
	[SWF(width="1280", height="960", backgroundColor="#000000")]
	
	public class Thermo extends FlxGame
	{
		public function Thermo()
		{
			super(640, 480, PlayState, 2);
			
			// Optional debug tools
			// FlxG.debug = true;
			// FlxG.visualDebug = true;
		}
	}
}