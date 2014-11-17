package context {
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class InitialState extends FlxState 
	{
		override public function create():void 
		{
			super.create();
		}
		
		override public function update():void 
		{
			// ****** IMPORTANT ******
			// IF YOU ARE UPLOADING THE GAME TO THE SITE, USE "FALSE" --> LOGGING MODE
			// IF YOU ARE WORKING ON A NEW THING FOR THE GAME, USE "TRUE" --> DEBUG MODE
			FlxG.switchState(new MenuState(0, 0, new Logging(700, 2, false)));
			super.update();
		}
	}

}