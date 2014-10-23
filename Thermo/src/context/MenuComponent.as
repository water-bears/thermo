package context {
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	/**
	 * A member of a MenuComponentCollection.
	 * @author KJin
	 */
	public class MenuComponent 
	{
		protected var collection:MenuComponentCollection;
		protected var sprite:FlxSprite;
		
		protected var localPosition:FlxPoint;
		protected var localScale:FlxPoint;
		
		public function MenuComponent(sprite:FlxSprite)
		{
			this.sprite = sprite;
			localPosition = new FlxPoint(0, 0);
			localScale = new FlxPoint(1, 1);
		}
		
		/*
		 * Should only be called from MenuComponentCollection.
		 */
		public function SetCollection(collection:MenuComponentCollection, id:uint) : void
		{
			this.collection = collection;
		}
		
		public function GetSprite() : FlxSprite
		{
			return sprite;
		}
		
		public function GetLocalPosition() : FlxPoint
		{
			return localPosition;
		}
		
		public function GetLocalScale() : FlxPoint
		{
			return localScale;
		}
		
		/*
		 * Should only be called from MenuComponentCollection. This method is called when the MenuComponentCollection is finalized.
		 */
		public function Register(state:FlxState) : void
		{
			state.add(sprite);
		}
		
		/*
		 * This method should be overridden in child classes if they have update logic.
		 */
		public function Update(selected:Boolean) : void
		{
			// Implement
		}
	}

}