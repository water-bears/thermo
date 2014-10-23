package context
{
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import levelgen.Level;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class TransitionState extends FlxState
	{
		private var level:uint;
		public static const numLevels:uint = 10;
		
		public function TransitionState(level:uint)
		{
			this.level = level;
		}
		
		override public function update():void
		{
			if (level > 0 && level <= numLevels)
			{
				var p:PlayState = new PlayState();
				p.setLevel(new Level(level));
				p.setBackground(level);
				FlxG.switchState(p);
			}
			else
			{
				FlxG.switchState(new LevelSelectState());
			}
		}
	}

}