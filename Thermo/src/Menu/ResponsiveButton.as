package Menu 
{
	import org.flixel.FlxSprite;
	
	/**
	 * Upon "selection" (either through mouseover or arrow key) this button will react as specified by the ActionResponse field.
	 * @author KJin
	 */
	public class ResponsiveButton extends FlxSprite 
	{
		
		public function ResponsiveButton(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			
		}
		
	}

}