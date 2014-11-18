package uilayer 
{
	/**
	 * ...
	 * @author KJin
	 */
	public class LevelNameTranslator 
	{
		private static const rowSize:uint = 5;
		
		/*
		 *  0  1  2  3  4 ->  1  2  3  4 S1
		 *  5  6  7  8  9 ->  5  6  7  8 S2
		 * 10 11 12 13 14 ->  9 10 11 12 S3
		 * ... and so on and so forth.
		 */
		public static function Translate(levelNum:Number) : String
		{
			if (levelNum % rowSize != rowSize - 1)
			{
				return String(4 * (levelNum / rowSize) + (levelNum % rowSize) + 1);
			}
			else
			{
				return "S" + String((levelNum + 1) / rowSize);
			}
		}
	}

}