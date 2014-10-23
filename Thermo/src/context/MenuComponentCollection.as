package context {
	import org.flixel.FlxPoint;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author KJin
	 */
	public class MenuComponentCollection 
	{
		protected var menuItems:Vector.<MenuComponent>;
		protected var selectedID:uint;
		protected var isActive:Boolean;
		protected var X:Number;
		protected var Y:Number;
		protected var scale:FlxPoint;
		protected var width:Number;
		protected var height:Number;
		
		public function MenuComponentCollection(X:Number=0, Y:Number=0) 
		{
			menuItems = new Vector.<MenuComponent>();
			selectedID = 0;
			isActive = false;
			this.X = X;
			this.Y = Y;
			scale = new FlxPoint(1, 1);
			width = 0;
			height = 0;
		}
		
		public function AddComponent(component:MenuComponent) : void
		{
			component.SetCollection(this, menuItems.length);
			menuItems.push(component);
		}
		
		public function Register(state:FlxState) : void
		{
			for (var i:uint = 0; i < menuItems.length; i++)
			{
				menuItems[i].Register(state);
			}
		}
		
		// Do NOT override
		public function Update() : void
		{
			Preprocess();
			for (var i:uint = 0; i < menuItems.length; i++)
			{
				menuItems[i].Update(i == selectedID);
			}
			Postprocess();
		}
		
		public function GetSelectedId() : uint
		{
			return selectedID;
		}
		
		public function SetIsActive(isActive:Boolean) : void
		{
			this.isActive = isActive;
		}
		
		public function GetNumComponents() : uint
		{
			return menuItems.length;
		}
		
		public function Preprocess() : void
		{
			// Implement in child functions
		}
		
		public function Postprocess() : void
		{
			// Implement in child functions
		}
	}

}