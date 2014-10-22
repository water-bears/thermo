package Menu 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class MenuComponent 
	{
		protected var collection:MenuComponentCollection;
		protected var sprite:FlxSprite;
		
		public function MenuComponent(sprite:FlxSprite)
		{
			this.sprite = sprite;
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
		
		public function Register(state:FlxState) : void
		{
			state.add(sprite);
		}
		
		public function Update(selected:Boolean) : void
		{
			// Implement
		}
	}

}