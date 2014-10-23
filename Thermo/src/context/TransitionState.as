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
<<<<<<< HEAD
		public static const numLevels:uint = 3;
=======
		private var numLevels:uint = 10;
>>>>>>> 42d33957bea1b4f99baedc7003f99896dce08fe4
		
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