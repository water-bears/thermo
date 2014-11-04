package uilayer {
	/**
	 * ...
	 * @author KJin
	 */
	public class PiecewiseInterpolationNode
	{
		private var method:Function;
		public var t:Number;
		private var y:Number;
		private var a1:Number;
		private var a2:Number;
		private var numArgs:uint;
		
		public function PiecewiseInterpolationNode(method:Function, t:Number, y:Number, a1:Number = Number.NaN, a2:Number = Number.NaN)
		{
			numArgs = 2;
			this.method = method;
			this.t = t;
			this.y = y;
			this.a1 = a1;
			this.a2 = a2;
			if (!isNaN(a1))
			{
				numArgs++;
				if (!isNaN(a2))
				{
					numArgs++;
				}
			}
			if (method == null)
			{
				numArgs = 0;
			}
		}
		
		public static function Evaluate(p1:PiecewiseInterpolationNode, p2:PiecewiseInterpolationNode=null, t:Number=0) : Number
		{
			if (p1.numArgs == 0)
			{
				return p1.y;
			}
			if (p1.numArgs == 2)
			{
				return p1.method(p1.y, p2.y, Utils.ReverseLerp(p1.t, p2.t, t));
			}
			if (p1.numArgs == 3)
			{
				return p1.method(p1.y, p2.y, p1.a1, Utils.ReverseLerp(p1.t, p2.t, t));
			}
			if (p1.numArgs == 4)
			{
				return p1.method(p1.y, p2.y, p1.a1, p1.a2, Utils.ReverseLerp(p1.t, p2.t, t));
			}
			return 0; //shouldn't happen
		}
		
		public function NullifyInterpolationMethod() : void
		{
			method = null;
			numArgs = 0;
		}
	}
}