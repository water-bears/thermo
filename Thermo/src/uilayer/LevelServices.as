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
		
		/*
		 *  0  1  2  3  4 ->  1  2  3  4 S1
		 *  5  6  7  8  9 ->  5  6  7  8 S2
		 * 10 11 12 13 14 ->  9 10 11 12 S3
		 * ... and so on and so forth.
		 */
		public static function Translate(levelNum:uint) : String
		{
			if (levelNum % rowSize != rowSize - 1)
			{
				return String((rowSize - 1) * uint(levelNum / rowSize) + (levelNum % rowSize) + 1);
			}
			else
			{
				return "S" + String((levelNum + 1) / rowSize);
			}
		}
		
		public static function GetColor(levelNum:uint) : uint
		{
			if (levelNum % rowSize != rowSize - 1)
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
			else if (levelNum % rowSize == 0)
			{
				return ThermoSaves.GetLevelCleared(levelNum + 1 - 2);
			}
			else
			{
				return ThermoSaves.GetLevelCleared(levelNum + 1 - 1);
			}
		}
		
		public static function NextLevel(levelNum:uint) : uint
		{
			if ((levelNum - 1) % rowSize >= rowSize - 2)
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