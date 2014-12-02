package context
{
	import levelgen.Level;
	
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import uilayer.LevelServices;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class TransitionState extends FlxState
	{
		private var level:int;
		public var logger:Logging;
		private var currentLevel:int;
		
		public function TransitionState(level:int,logger:Logging,currentLevel:int=0)
		{
			this.level = level;
			this.logger = logger;
			this.currentLevel = currentLevel;
		}
		
		override public function update():void
		{
			if (level >= 0 && level < LevelServices.NUM_TOTAL_LEVELS)
			{
				var p:PlayState = new PlayState(logger);
				p.setLevel(new Level(level));
				p.setBackground(level);
				logger.recordLevelStart(level);
				FlxG.switchState(p);
			}
			else
			{
				FlxG.switchState(new MenuState(2, currentLevel, logger));
			}
		}
	}

}