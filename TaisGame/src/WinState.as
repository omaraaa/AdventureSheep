package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.API.FlxKongregate;
	/**
	 * ...
	 * @author Omar Abdulkarim
	 */
	public class WinState extends FlxState
	{
		[Embed(source = "/data/sound/win.mp3")] private var winsound:Class;
		private var wSound:FlxSound;
		private var resetButton:FlxButton;
		private var win:FlxSprite;
		[Embed(source = "/data/win.png")] private var winImg:Class;		
		override public function create():void
		{
			win = new FlxSprite(0, 0, winImg);
			add(win);
			resetButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 80, "Play again?", restart);
			add(resetButton);
			var name:String = FlxKongregate.getUserName;
			var text:FlxText = new FlxText(FlxG.width / 2 - 20, FlxG.height / 2, 100, name, false);
			text.text = "Score: " + FlxG.score + "\nTime:" + FlxG.scores[1].toFixed(1);
			add(text);
			wSound = new FlxSound();
			wSound.loadEmbedded(winsound);
			wSound.play();
			FlxKongregate.submitStats("Score", FlxG.score);
			FlxKongregate.submitStats("Time", FlxG.scores[1].toFixed(1));
			FlxG.score = 0;
			super.create();
		}
		
		override public function update():void
		{
			if (FlxG.keys.R)
			{
				restart();
			}
			super.update();
		}
		
		private function restart():void
		{
			FlxG.flash();
			wSound.stop();
			FlxG.switchState(new PlayState());
		}
		
		public function WinState() 
		{

			super();
		}
		
	}

}