package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.API.FlxKongregate;
	import mochi.as3.MochiAd;
	/**
	 * ...
	 * @author Omar Abdulkarim
	 */
	public class MenuState  extends FlxState
	{
		private var Start:FlxButton;
		private var instruct:FlxButton;
		private var BG:FlxSprite;
		private var loading:FlxText;
		
		[Embed(source = "/data/bg.png")] private var bgImg:Class;
		
		
		override public function create():void
		{
			FlxG.bgColor = 0xff28C5FF;
			FlxG.mouse.show();
			loading = new FlxText(FlxG.width - 50, FlxG.height, 50, "Loading");
			loading.color = 0xff000000;
			BG = new FlxSprite(0, 0, bgImg);
			add(BG);
			
			Start = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2, "START!", play);
			add(Start);
			
			
			
			super.create();
		}
		
		override public function update():void
		{
			if (FlxG.keys.any())
			{
				FlxG.flash();

				add(loading);
				play();
			}
			super.update();
		}
		
		public function MenuState() 
		{
			
		}
		
		private function load():void
		{
			FlxKongregate.connect();
		}
		
		private function play():void
		{

			var timer:FlxTimer = new FlxTimer();
			
			FlxG.switchState(new PlayState());
		}
		
	}

}