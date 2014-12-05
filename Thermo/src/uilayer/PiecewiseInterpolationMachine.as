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
		public var completionCallback:Function;
		public var complete:Boolean;
		private var prevDirection:int;
		// Believe it or not this might speed things up
		private var cachedValue:Number = 0;
		private var cachedValid:Boolean = false;
		
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
			prevDirection = 0;
		}
		
		public function Rewind() : void
		{
			this.time = 0;
			this.bracket = 0;
			complete = false;
		}
		
		public function FastForward() : void
		{
			bracket = nodes.length - 1;
			time = nodes[bracket].t;
			complete = false;
		}
		
		public function EvaluateAndAdvance(direction:int=1) : Number
		{
			var result:Number = Evaluate();
			if (periodic || !complete || direction != prevDirection)
			{
				Advance(direction);
			}
			return result;
		}
		
		public function Advance(direction:int=1) : void
		{
			var i:uint;
			if (direction > 0)
			{
				for (i = 0; i < direction; i++)
				{
					if (time < nodes[nodes.length - 1].t)
					{
						time++;
						if (time == nodes[bracket+1].t)
						{
							bracket++;
						}
						complete = false;
					}
					else
					{
						complete = true;
					}
					if (periodic && time == nodes[nodes.length - 1].t)
					{
						time = 0;
						bracket = 0;
					}
				}
			}
			else
			{
				for (i = 0; i < -direction; i++)
				{
					if (time > 0)
					{
						time--;
						if (time == nodes[bracket].t - 1)
						{
							bracket--;
						}
						complete = false;
					}
					else
					{
						complete = true;
					}
					if (periodic && time == 0)
					{
						time = nodes[bracket].t;
						bracket = 0;
					}
				}
			}
			prevDirection = direction;
		}
		
		public function Evaluate() : Number
		{
			if (!cachedValid)
			{
				if (bracket == nodes.length - 1)
				{
					if (completionCallback != null)
					{
						completionCallback();
						completionCallback = null;
					}
					cachedValue = PiecewiseInterpolationNode.Evaluate(nodes[bracket]);
				}
				else
				{
					cachedValue = PiecewiseInterpolationNode.Evaluate(nodes[bracket], nodes[bracket + 1], time);
				}
			}
			cachedValid = complete;
			return cachedValue;
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