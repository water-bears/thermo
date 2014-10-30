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
		public static const numLevels:uint = 8;
		public var logger:Logging;
		
		public function TransitionState(level:uint,logger:Logging)
		{
			this.level = level;
			this.logger = logger;
		}
		
		override public function update():void
		{
			if (level > 0 && level <= numLevels)
			{
				var p:PlayState = new PlayState();
				p.setLevel(new Level(level));
				p.setBackground(level);
				logger.recordLevelStart(level);
				FlxG.switchState(p);
			}
			else
			{
				FlxG.switchState(new LevelSelectState());
				logger.recordLevelStart(0);
			}
		}
	}

}