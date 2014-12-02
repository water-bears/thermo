package uilayer 
{
	import io.ThermoSaves;
	
	/**
	 * A class that gives various level info based
	 * on a level number.
	 * 
	 * The S levelNums pick up where the normal
	 * levelNums leave off.
	 * @author KJin
	 */
	public class LevelServices 
	{
		private static var LEVEL_NAMES:Array = new Array(
			//intro row
			"tutorial_jump_00",
			"tutorial_heat",
			"tutorial_freeze",
			"easy_00",
			//element row
			"tutorial_neutral",
			"tutorial_flashheat",
			"flashheat_2",
			"tutorial_flashfreeze",
			//flashheat row
			"medium_03",
			"medium_05",
			"tutorial_wind",
			"wind_helper2",
			//flashfreeze row
			"wind_test",
			"medium_06",
			"medium_01",
			"medium_04",
			//final row
			"tutorial_momentum",
			"hard_00",
			"hard_01",
			"hard_02",
			//adding levels
			"medium_07",
			"hard_03"
		);
		
		private static var S_LEVEL_NAMES:Array = new Array(
			"supa_hard_01",
			"tryna_flashheat",
			"supa_hard_02",
			"supa_hard_04",
			"hard_100"
		);
		
		public static const NUM_LEVELS:int = LEVEL_NAMES.length;
		public static const NUM_S_LEVELS:int = S_LEVEL_NAMES.length;
		public static const NUM_TOTAL_LEVELS:int = NUM_LEVELS + NUM_S_LEVELS;
		
		private static const rowSize:uint = 5;
		
		public static function GetHumanReadableLevelName(levelNum:uint) : String
		{
			if (levelNum < NUM_LEVELS)
			{
				return String(levelNum + 1);
			}
			else
			{
				return "S" + String(levelNum - NUM_LEVELS + 1);
			}
		}
		
		public static function GetInternalLevelName(levelNum:uint) : String
		{
			if (levelNum < NUM_LEVELS)
			{
				return LEVEL_NAMES[levelNum];
			}
			else
			{
				return S_LEVEL_NAMES[levelNum - NUM_LEVELS];
			}
		}
		
		public static function GetLevelSelectColor(levelNum:uint) : uint
		{
			if (levelNum < NUM_LEVELS)
			{
				return 0xffffff;
			}
			else
			{
				return 0xff0000;
			}
		}
		
		public static function Completed(levelNum:uint) : Boolean
		{
			return ThermoSaves.GetLevelCleared(levelNum);
		}
		
		public static function Unlocked(levelNum:uint) : Boolean
		{
			return true;
		}
		
		public static function NextLevel(levelNum:uint) : uint
		{
			return levelNum + 1;
		}
	}

}