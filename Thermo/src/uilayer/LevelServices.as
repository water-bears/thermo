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
		
		public static function TranslateFromOldScheme(levelNum:uint) : uint
		{
			var realLevelNum:Number = levelNum - 1;
			if (realLevelNum < ThermoSaves.NUM_LEVELS - rowSize)
			{
				realLevelNum += uint(realLevelNum / (rowSize - 1));
			}
			else
			{
				realLevelNum = (realLevelNum - ThermoSaves.NUM_LEVELS + rowSize + 1) * 5 - 1;
			}
			return realLevelNum + 1;
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
			if (levelNum == 0) return true;
			return ThermoSaves.GetLevelCleared(levelNum);
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