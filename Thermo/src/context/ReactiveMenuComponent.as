package context {
	import adobe.utils.CustomActions;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * Upon "selection" (either through mouseover or arrow key) this component will react as specified by the ComponentMotion array.
	 * @author KJin
	 */
	public class ReactiveMenuComponent extends MenuComponent 
	{
		private var motions:Vector.<ComponentMotion>;
		
		public function ReactiveMenuComponent(sprite:FlxSprite)
		{
			super(sprite);
			motions = new Vector.<ComponentMotion>();
		}
		
		public function AddMotion(motion:ComponentMotion) : void
		{
			motion.Initialize(this);
			motions.push(motion);
		}
		
		override public function Update(selected:Boolean):void 
		{
			// Make the selected option zoom.
			var i:uint = 0;
			if (selected)
				for (i = 0; i < motions.length; i++)
				{
					motions[i].ForwardMotion();
				}
			else
				for (i = 0; i < motions.length; i++)
				{
					motions[i].BackwardMotion();
				}
		}
	}

}