package context {
	import Logging;
	
	import flash.sensors.Accelerometer;
	
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
			// ****** IMPORTANT ******
			// IF YOU ARE UPLOADING THE GAME TO THE SITE, USE "FALSE" --> LOGGING MODE
			// IF YOU ARE WORKING ON A NEW THING FOR THE GAME, USE "TRUE" --> DEBUG MODE
			logger = new Logging(700, 3, true);
			logger.recordPageLoad();
			//var x:Number = Math.random();
			//x = Math.round(x) + 1;
			//var AB:Number = logger.recordABTestValue(x);
			//Level.ab = AB;
			
			// Enable mouse
			FlxG.mouse.show(Assets.cursorSprite, 1);
		}
		
		override public function update():void 
		{
			FlxG.switchState(new MenuState(0, 0, logger));
			super.update();
		}
	}

}