package context {
	import Logging;
	
	import levelgen.Level;
	
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class InitialState extends FlxState 
	{
		public var logger:Logging;
		override public function create():void 
		{
			super.create();
			logger = new Logging(700, 2, true);
			logger.recordPageLoad();
			var x:Number = Math.random();
			x = Math.round(x);
			var AB:Number = logger.recordABTestValue(x);
			Level.ab = AB;
		}
		
		override public function update():void 
		{
			// ****** IMPORTANT ******
			// IF YOU ARE UPLOADING THE GAME TO THE SITE, USE "FALSE" --> LOGGING MODE
			// IF YOU ARE WORKING ON A NEW THING FOR THE GAME, USE "TRUE" --> DEBUG MODE
			FlxG.switchState(new MenuState(0, 0, logger));
			super.update();
		}
	}

}