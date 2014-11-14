package water 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author KJin
	 */
	public class WaterUtils 
	{		
		private static function Reverse(edgeType:uint) : uint
        {
            if (edgeType == EdgeTypes.Left)
                return EdgeTypes.Right;
            else if (edgeType == EdgeTypes.Right)
                return EdgeTypes.Left;
            else if (edgeType == EdgeTypes.Up)
                return EdgeTypes.Down;
            else if (edgeType == EdgeTypes.Down)
                return EdgeTypes.Up;
            return EdgeTypes.None;
        }

        public static function GetBorders(tiles:FlxTilemap) : Vector.<Vector.<FlxPoint>>
        {
			var fillMap:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>(tiles.widthInTiles);
            var edgeMap:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>(tiles.widthInTiles + 1);
			var i:uint, j:uint;
			for (i = 0; i <= tiles.widthInTiles; i++)
			{
				if (i < tiles.widthInTiles)
				{
					fillMap[i] = new Vector.<uint>(tiles.heightInTiles);
				}
				edgeMap[i] = new Vector.<uint>(tiles.heightInTiles + 1);
				for (j = 0; j <= tiles.heightInTiles; j++)
				{
					if (i < tiles.widthInTiles && j < tiles.heightInTiles)
					{
						fillMap[i][j] = tiles.getTile(i, j) != 0 ? 1 : 0;
					}
					edgeMap[i][j] = 0;
				}
			}
			var x:uint;
			var y:uint;
            for (x = 0; x <= tiles.widthInTiles; x++)
                for (y = 0; y <= tiles.heightInTiles; y++)
                {
                    var topLeft:uint = 0, topRight:uint = 0, bottomLeft:uint = 0, bottomRight:uint = 0;
                    if (x > 0 && y > 0) topLeft = fillMap[x - 1][y - 1];
                    if (x > 0 && y < tiles.heightInTiles) bottomLeft = fillMap[x - 1][y];
                    if (x < tiles.widthInTiles && y > 0) topRight = fillMap[x][y - 1];
                    if (x < tiles.widthInTiles && y < tiles.heightInTiles) bottomRight = fillMap[x][y];
                    var flag:uint = 0x0;
                    if (topLeft ^ bottomLeft) flag |= EdgeTypes.Left;
                    if (bottomLeft ^ bottomRight) flag |= EdgeTypes.Down;
                    if (topLeft ^ topRight) flag |= EdgeTypes.Up;
                    if (topRight ^ bottomRight) flag |= EdgeTypes.Right;
                    //if we somehow get 0xF, then either topleft/bottomright are filled, or topright/bottomleft.
                    //the 5th/6th bit is a "parity" bit.
                    if (flag == 0xF)
                        if (topLeft)
                            flag = 0x1F;
                        else
                            flag = 0x2F;
                    edgeMap[x][y] = flag;
                }
            //walk the line
            var lists:Vector.<Vector.<FlxPoint>> = new Vector.<Vector.<FlxPoint>>();
            for (x = 0; x <= tiles.widthInTiles; x++)
                for (y = 0; y <= tiles.heightInTiles; y++)
                {
                    if (edgeMap[x][y] == 0) continue;
                    var controlPoints:Vector.<FlxPoint> = new Vector.<FlxPoint>();
                    var x2:uint = x;
                    var y2:uint = y;
                    var nextDirection:uint = EdgeTypes.None;
                    while (edgeMap[x][y] != 0)
                    {
                        controlPoints.push(new FlxPoint(x2, y2));
                        if ((edgeMap[x2][y2] & ~0xF) == 0 || nextDirection == EdgeTypes.None)
                        {
                            nextDirection = EdgeTypes.None;
                            for (i = 0x1; i < 0x10; i <<= 1)
                                if ((edgeMap[x2][y2] & i) != 0)
                                    nextDirection = i;
                        }
                        else
                        {
                            if ((edgeMap[x2][y2] & 0x10) != 0) //topLeft parity
                            {
                                if (nextDirection == EdgeTypes.Left)
                                    nextDirection = EdgeTypes.Up;
                                else if (nextDirection == EdgeTypes.Up)
                                    nextDirection = EdgeTypes.Left;
                                else if (nextDirection == EdgeTypes.Right)
                                    nextDirection = EdgeTypes.Down;
                                else if (nextDirection == EdgeTypes.Down)
                                    nextDirection = EdgeTypes.Right;
                                edgeMap[x2][y2] &= ~0x10;
                            }
                            else
                            {
                                if (nextDirection == EdgeTypes.Left)
                                    nextDirection = EdgeTypes.Down;
                                else if (nextDirection == EdgeTypes.Up)
                                    nextDirection = EdgeTypes.Right;
                                else if (nextDirection == EdgeTypes.Right)
                                    nextDirection = EdgeTypes.Up;
                                else if (nextDirection == EdgeTypes.Down)
                                    nextDirection = EdgeTypes.Left;
                                edgeMap[x2][y2] &= ~0x20;
                            }
                        }
                        edgeMap[x2][y2] &= ~nextDirection;
                        if (nextDirection == EdgeTypes.Left)
                            x2 = x2 - 1;
                        else if (nextDirection == EdgeTypes.Right)
                            x2 = x2 + 1;
                        else if (nextDirection == EdgeTypes.Up)
                            y2 = y2 - 1;
                        else if (nextDirection == EdgeTypes.Down)
                            y2 = y2 + 1;
                        edgeMap[x2][y2] &= ~Reverse(nextDirection);
                    }
                    lists.push(controlPoints);
                }
            return lists;
        }
	}

}