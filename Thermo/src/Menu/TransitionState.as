package Menu 
{
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class TransitionState extends FlxState 
	{		
		override public function create():void {
			var numLevels:uint = 3;
		}
		
		override public function update():void 
		{
			FlxG.switchState(new LevelSelectState());
		}
	}

}