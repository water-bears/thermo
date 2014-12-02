package uilayer 
{
	import io.ThermoSaves;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class LevelServices 
	{
		private static const rowSize:uint = 5;
		
		public static function Translate(levelNum:uint) : String
		{
			if (levelNum < ThermoSaves.NUM_LEVELS - rowSize)
			{
				return String(levelNum + 1);
			}
			else
			{
				return "S" + String(levelNum % rowSize + 1);
			}
		}
		
		public static function TranslateToOldScheme(levelNum:uint) : uint
		{
			var realLevelNum:Number = levelNum - 1;
			if (realLevelNum < 25 - rowSize)
			{
				realLevelNum += uint(realLevelNum / (rowSize - 1));
			}
			else
			{
				realLevelNum = (realLevelNum - 25 + rowSize + 1) * 5 - 1;
			}
			return realLevelNum + 1;
		}
		
		// To preserve save files
		public static function TranslateToNewScheme(levelNum:uint) : uint
		{
			var realLevelNum:Number = levelNum;
			if (realLevelNum % 5 == 0)
			{
				realLevelNum = uint(realLevelNum / 5) + 25 - rowSize;
			}
			else
			{
				realLevelNum = realLevelNum - uint(realLevelNum / 5);
			}
			trace(levelNum, realLevelNum);
			return realLevelNum;
		}
		
		public static function GetColor(levelNum:uint) : uint
		{
			if (levelNum < ThermoSaves.NUM_LEVELS - rowSize)
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
			return ThermoSaves.GetLevelCleared(levelNum + 1);
		}
		
		public static function Unlocked(levelNum:uint) : Boolean
		{
			/*
			if (levelNum == 0) return true;
			if (levelNum < 20)
			{
				return ThermoSaves.GetLevelCleared(levelNum);
			}
			else
			{
				return ThermoSaves.GetLevelCleared((levelNum - 19) * 4);
			}*/
			return true;
		}
		
		public static function NextLevel(levelNum:uint) : uint
		{
			if (levelNum == ThermoSaves.NUM_LEVELS - 1)
			{
				return 0;
			}
			else
			{
				return levelNum + 1;
			}
		}
	}

}