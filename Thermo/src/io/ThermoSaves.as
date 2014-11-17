package io 
{
	import org.flixel.FlxSave;
	import uilayer.MenuUI;
	/**
	 * ...
	 * @author KJin
	 */
	public class ThermoSaves 
	{
		private static var save:FlxSave;
		InitializeSave();
		private static var levelsBeaten:uint = 0;
		private static const CURRENT_VERSION:uint = 1;
		public static const NUM_LEVELS:uint = MenuUI.levelSelectWidth * MenuUI.levelSelectHeight;
		
		private static function InitializeSave() : void
		{
			save = new FlxSave();
			var i:uint;
			save.bind("Thermo");
			if (save.data.version == null)
			{
				save.data.version = CURRENT_VERSION;
				save.data.progress = new Vector.<Boolean>(NUM_LEVELS);
				for (i = 0; i < NUM_LEVELS; i++)
				{
					save.data.progress[i] = false;
				}
			}
			RecalculateNumLevelsCleared();
		}
		
		private static function RecalculateNumLevelsCleared() : void
		{
			var i:uint;
			levelsBeaten = 0;
			for (i = 0; i < NUM_LEVELS; i++)
			{
				if (save.data.progress[i])
				{
					levelsBeaten++;
				}
			}
		}
		
		public static function MarkLevelAsCleared(levelNum:uint) : void
		{
			save.data.progress[levelNum - 1] = true;
			RecalculateNumLevelsCleared();
			save.flush();
		}
		
		public static function GetLevelCleared(levelNum:uint) : Boolean
		{
			return save.data.progress[levelNum - 1];
		}
		
		public static function GetNumLevelsCleared() : uint
		{
			return levelsBeaten;
		}
	}

}