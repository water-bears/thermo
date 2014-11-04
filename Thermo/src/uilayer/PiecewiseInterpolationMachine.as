package uilayer {
	/**
	 * ...
	 * @author KJin
	 */	
	public class PiecewiseInterpolationMachine 
	{
		//n
		private var nodes:Vector.<PiecewiseInterpolationNode>;
		
		private var periodic:Boolean;
		private var time:uint;
		private var bracket:uint;
		private var completionCallback:Function;
		public var complete:Boolean;
		
		public function PiecewiseInterpolationMachine(periodic:Boolean, ... args)
		{
			this.periodic = periodic;
			this.time = 0;
			this.bracket = 0;
			completionCallback = null;
			complete = false;
			nodes = new Vector.<PiecewiseInterpolationNode>();
			for (var i:uint; i < args.length; i++)
			{
				nodes.push(args[i]);
				// The last argument MUST have a null method of interpolation
				// Correct for this here.
				if (i == args.length - 1)
				{
					nodes[i].NullifyInterpolationMethod();
				}
			}
		}
		
		public function EvaluateAndAdvance(direction:uint=1) : Number
		{
			var result:Number = Evaluate();
			Advance(direction);
			return result;
		}
		
		public function Advance(direction:uint=1) : void
		{
			//direction argument currently does nothing
			if (bracket < nodes.length - 1)
			{
				time++;
				if (time == nodes[bracket+1].t)
				{
					bracket++;
				}
			}
			else
			{
				complete = true;
			}
			if (periodic && bracket == nodes.length - 1)
			{
				time = 0;
				bracket = 0;
			}
		}
		
		public function Evaluate() : Number
		{
			if (bracket == nodes.length - 1)
			{
				if (completionCallback != null)
				{
					completionCallback();
					completionCallback = null;
				}
				return PiecewiseInterpolationNode.Evaluate(nodes[bracket]);
			}
			return PiecewiseInterpolationNode.Evaluate(nodes[bracket], nodes[bracket + 1], time);
		}
		
		public function FastForward() : void
		{
			bracket = nodes.length - 1;
			time = nodes[bracket].t;
			complete = false;
		}
		
		public function JumpToBracket(num:uint):void
		{
			bracket = num;
			if (bracket > nodes.length - 1)
			{
				bracket = nodes.length - 1;
			}
			time = nodes[bracket].t;
			complete = false;
		}
		
		public function CallUponCompletion(callback:Function):void
		{
			completionCallback = callback;
		}
	}

}