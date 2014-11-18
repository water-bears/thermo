package audio 
{
	import flash.media.SoundChannel;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import uilayer.Utils;
	import org.flixel.FlxSound;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author KJin
	 */
	public class AudioManager 
	{
		public static const OUTSIDE_WATER:Number = 1;
		public static const INSIDE_WATER:Number = -1;
		
		private static var fade:Number = 1;		
		private static var bgm:Sound = new Assets.sfx_bgm() as Sound;
		private static var bgm_underwater:Sound = new Assets.sfx_bgm_underwater() as Sound;
		
		private static var outsideWater:SoundChannel;// :FlxSound;
		private static var insideWater:SoundChannel;// :FlxSound;
		
		public static function StartMusic(initialFade:Number): void
		{
			//
			outsideWater = bgm.play(0, 0, new SoundTransform(0));
			//outsideWater.loadEmbedded(Assets.sfx_bgm);
			//outsideWater.volume = 0;
			//outsideWater.play();
			insideWater = bgm_underwater.play(0, 0, new SoundTransform(0));
			//insideWater.loadEmbedded(Assets.sfx_bgm_underwater);
			//insideWater.volume = 0;
			//insideWater.play();
			SetFade(initialFade);
		}
		
		public static function GetFade() : Number
		{
			return fade;
		}
		
		public static function SetFade(fade:Number) : void
		{
			if (fade > OUTSIDE_WATER)
				fade = OUTSIDE_WATER;
			if (fade < INSIDE_WATER)
				fade = INSIDE_WATER;
			AudioManager.fade = fade;
			//outsideWater.volume = Utils.ReverseLerp(INSIDE_WATER, OUTSIDE_WATER, fade);
			//insideWater.volume = Utils.ReverseLerp(OUTSIDE_WATER, INSIDE_WATER, fade);
			outsideWater.soundTransform = new SoundTransform(Utils.ReverseLerp(INSIDE_WATER, OUTSIDE_WATER, fade));
			insideWater.soundTransform = new SoundTransform(Utils.ReverseLerp(OUTSIDE_WATER, INSIDE_WATER, fade));
		}
		
		public static function PlaySound(sound:Class, fadeTime:Number=0) : void
		{
			// This abstraction allows for muting
			var f:FlxSound = FlxG.play(sound);
			if (fadeTime > 0)
			{
				trace(fadeTime);
				f.fadeOut(fadeTime);
			}
		}
	}

}