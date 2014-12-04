package audio 
{
	import flash.events.Event;
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
		//private static var bgm_blank:Sound = new Assets.sfx_empty() as Sound;
		
		private static var outsideWater:SoundChannel;// :FlxSound;
		private static var insideWater:SoundChannel;// :FlxSound;
		//private static var oldOutsideWater:SoundChannel;// :FlxSound;
		//private static var oldInsideWater:SoundChannel;// :FlxSound;
		//private static var blank:SoundChannel;
		
		private static var mute:Boolean = false;
		
		public static function StartMusic(initialFade:Number): void
		{
			//
			outsideWater = bgm.play(0, int.MAX_VALUE, new SoundTransform(0));
			insideWater = bgm_underwater.play(0, int.MAX_VALUE, new SoundTransform(0));
			//blank = bgm_blank.play(0, 0, new SoundTransform(0));
			//blank.addEventListener(Event.SOUND_COMPLETE, onLoopFinish);
			SetFade(initialFade);
		}
		
		/*private static function onLoopFinish(e:Event) : void
		{
			if (oldOutsideWater != null)
			{
				oldOutsideWater.stop();
			}
			if (oldInsideWater != null)
			{
				oldInsideWater.stop();
			}
			oldOutsideWater = outsideWater;
			oldInsideWater = insideWater;
			outsideWater = bgm.play(0, 0, new SoundTransform(0));
			insideWater = bgm_underwater.play(0, 0, new SoundTransform(0));
			blank.stop();
			blank = bgm_blank.play(0, 0, new SoundTransform(0));
			blank.addEventListener(Event.SOUND_COMPLETE, onLoopFinish);
			SetFade(fade);
		}*/
		
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
			var iFade:Number = Utils.ReverseLerp(INSIDE_WATER, OUTSIDE_WATER, fade);
			/*if (oldOutsideWater != null)
			{
				oldInsideWater.soundTransform = new SoundTransform(iFade);
			}
			if (oldInsideWater != null)
			{
				oldInsideWater.soundTransform = new SoundTransform(1.0 - iFade);
			}*/
			outsideWater.soundTransform = new SoundTransform((mute ? 0 : 1) * iFade);
			insideWater.soundTransform = new SoundTransform((mute ? 0 : 1) * (1.0 - iFade));
			
		}
		
		public static function PlaySound(sound:Class, fadeTime:Number=0) : void
		{
			// This abstraction allows for muting
			if (mute)
			{
				return;
			}
			var f:FlxSound = FlxG.play(sound);
			if (fadeTime > 0)
			{
				trace(fadeTime);
				f.fadeOut(fadeTime);
			}
		}
		
		public static function GetMute() : Boolean
		{
			return mute;
		}
		
		public static function SetMute(mute:Boolean) : void
		{
			AudioManager.mute = mute;
			if (mute)
			{
				FlxG.pauseSounds();
				FlxG.sounds.kill();
				FlxG.sounds.clear();
			}
			SetFade(fade);
		}
	}
}