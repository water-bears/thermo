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
			//row 1: introduces platforming, heat, freeze, and neutral gates
			"tutorial_jump_00", //teaches platforming, door/key
			"tutorial_heat", //teaches heat
			"tutorial_freeze", //teaches freeze
			"easy_00", //compares heat and freeze
			"tutorial_neutral", //introduces neutral gate
			
			//row 2: introduces flash abilities (and trapdoor)
			"tutorial_flashheat", //introduces flash gate, flash heat (introduces spikes)
			"flashheat_2", //more flash heat depth (upside down platforming)
			"tutorial_flashfreeze", //introduces flash freeze w/ neutral gate
			"medium_03", //introduces flash freeze w/ trapdoor
			"medium_01", //explores flash heat w/ flash freeze and neutral
			
			//row 3: introduces wind, momentum, and ability reversion
			"tutorial_wind", //introduces wind
			"wind_helper2", //more wind depth
			"medium_08", //introduces momentum w/ flash heat
			"medium_04", //introduces undoing flash freeze w/ freeze
			"medium_05", //introduces undoing flash heat w/ heat
			
			//row 4: explores relations between abilities, changing abilities while using another
			"wind_test", //introduces changing state while inside bubble
			"medium_09", //introduces flash freeze w/ neutral gate & trapdoor
			"medium_07", //introduces flash freeze w/ flash heat
			"medium_06", //explores flash heat and momentum (hard)
			"hard_03", //explores flash freeze w/ flash heat, changing state in bubble
			
			//row 5: hard levels with everything
			"tutorial_momentum", //explores flash heat w/ momentum and freeze (hard)
			"hard_04", //explores trapdoor as blockade, flash freeze w/ flash heat (hard)
			"hard_00", //explores flash freeze, flash heat, trapdoor (hard)
			"hard_01", //explores flash freeze w/ heat, momentum (hard)
			"hard_02" //explores flash heat, neutral, and freeze (hard)
		);
		
		private static var S_LEVEL_NAMES:Array = new Array(
			"supa_hard_01", //unlocked after level 4 (easy_00)
			"tryna_flashheat", //unlocked after level 7 (flashheat_2)
			"supa_hard_04", //unlocked after level 9 (medium_03)
			"supa_hard_02", //unlocked after level 12 (wind_helper2)
			"hard_100" //unlocked after 20 (arbitrary to keep this level near the end)
		);
		
		public static var S_LEVEL_UNLOCKED_AFTER:Array = new Array(4, 7, 9, 12, 20);
		
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
			if (levelNum == 0)
			{
				return true;
			}
			else if (levelNum < NUM_LEVELS)
			{
				return Completed(levelNum - 1);
			}
			else
			{
				return Completed(S_LEVEL_UNLOCKED_AFTER[levelNum - NUM_LEVELS] - 1);
			}
		}
		
		public static function NextLevel(levelNum:uint) : uint
		{
			return levelNum + 1;
		}
	}

}