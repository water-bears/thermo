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
		public static const numLevels:uint = 9;
		public var logger:Logging;
		
		public function TransitionState(level:uint,logger:Logging)
		{
			this.level = level;
			if(logger != null){
				this.logger = logger;
			}
		}
		
		override public function update():void
		{
			if (level > 0 && level <= numLevels)
			{
				var p:PlayState = new PlayState(logger);
				p.setLevel(new Level(level));
				p.setBackground(level);
				if(logger != null){
					logger.recordLevelStart(level);
				}
				FlxG.switchState(p);
			}
			else
			{
				FlxG.switchState(new LevelSelectState(logger));
			}
		}
	}

}