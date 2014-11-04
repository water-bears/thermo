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
			FlxG.switchState(new MenuState(0, new Logging(700, 1, true)));
			super.update();
		}
	}

}