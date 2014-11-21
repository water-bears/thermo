package io 
{
	import org.flixel.FlxSave;
	import uilayer.MenuUI;
	import uilayer.LevelServices;
	/**
	 * ...
	 * @author KJin
	 */
	public class ThermoSaves 
	{
		private static var save:FlxSave;
		InitializeSave();
		private static var levelsBeaten:uint = 0;
		private static const CURRENT_VERSION:uint = 2;
		public static const NUM_LEVELS:uint = MenuUI.levelSelectWidth * MenuUI.levelSelectHeight;
		
		private static function InitializeSave() : void
		{
			save = new FlxSave();
			var i:uint;
			save.bind("Thermo");
			if (save.data.version == null)
			{
				save.data.version = CURRENT_VERSION;
				save.data.num_levels = NUM_LEVELS;
				save.data.progress = new Vector.<Boolean>(NUM_LEVELS);
				for (i = 0; i < NUM_LEVELS; i++)
				{
					save.data.progress[i] = false;
				}
			}
			else
			{
				for (i = save.data.num_levels; i < NUM_LEVELS; i++)
				{
					save.data.progress.push(false);
				}
				save.data.num_levels = NUM_LEVELS;
				if (save.data.version == 1)
				{
					// translate all to new
					var a:Vector.<Boolean> = new Vector.<Boolean>();
					for (i = 0; i < NUM_LEVELS; i++)
					{
						a.push(save.data.progress[i]);
					}
					for (i = 0; i < NUM_LEVELS; i++)
					{
						save.data.progress[LevelServices.TranslateToNewScheme(i + 1) - 1] = a[i];
					}
					save.data.version = CURRENT_VERSION;
				}
			}
			RecalculateNumLevelsCleared();
			save.flush();
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