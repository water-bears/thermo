package  
{
	/**
	 * ...
	 * @author KJin
	 */
	public class PiecewiseInterpolationMachine 
	{
		//n
		private var ts:Array;
		//n
		private var ys:Array;
		//n-1
		private var methods:Array;
		
		private var time:uint;
		private var bracket:uint;
		private var completionCallback:Function;
		
		public function PiecewiseInterpolationMachine(ts:Array, ys:Array, methods:Array)
		{
			this.ts = ts;
			this.ys = ys;
			this.methods = methods;
			this.time = 0;
			this.bracket = 0;
			completionCallback = null;
		}
		
		public function UpdateAndEvaluate() : Number
		{
			if (bracket == ts.length - 1)
			{
				if (completionCallback != null)
				{
					completionCallback();
					completionCallback = null;
				}
				return ys[bracket];
			}
			var result:Number = methods[bracket](ys[bracket], ys[bracket+1], Utils.ReverseLerp(ts[bracket], ts[bracket + 1], time));
			time++;
			if (time == ts[bracket+1])
			{
				bracket++;
			}
			return result;
		}
		
		public function FastForward() : void
		{
			bracket = ts.length - 1;
			time = ts[bracket];
		}
		
		public function JumpToBracket(num:uint) : void
		{
			bracket = num;
			if (bracket > ts.length - 1)
			{
				bracket = ts.length - 1;
			}
			time = ts[bracket];
		}
		
		public function CallUponCompletion(callback:Function) : void
		{
			completionCallback = callback;
		}
	}

}