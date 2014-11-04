package context
{
	import levelgen.Level;
	
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class TransitionState extends FlxState
	{
		private var level:uint;
		public static const numLevels:uint =  Level.NUM_LEVELS;
		public var logger:Logging;
		private var currentLevel:uint;
		
		public function TransitionState(level:uint,logger:Logging,currentLevel:uint=0)
		{
			this.level = level;
			this.logger = logger;
			this.currentLevel = currentLevel;
		}
		
		override public function update():void
		{
			if (level > 0 && level <= numLevels)
			{
				var p:PlayState = new PlayState(logger);
				p.setLevel(new Level(level));
				p.setBackground(level);
				logger.recordLevelStart(level);
				FlxG.switchState(p);
			}
			else
			{
				FlxG.switchState(new MenuState(2, currentLevel - 1, logger));
			}
		}
	}

}