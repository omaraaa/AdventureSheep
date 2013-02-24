package game 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Omar Abdulkarim
	 */
	public class Coin extends FlxSprite
	{
		[Embed(source = "/data/coin.png")] private var coinImg:Class;
		[Embed(source = "/data/sound/coin.mp3")] private var coinFx:Class;
		public var cfx:FlxSound;
		public function Coin(x:uint, y:uint) 
		{
			super(x, y);
			loadGraphic(coinImg);
			cfx = new FlxSound();
			cfx.loadEmbedded(coinFx, false, true);
		}
		
		override public function update():void
		{
		}
		
	}

}