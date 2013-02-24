package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.API.FlxKongregate;
	/**
	 * ...
	 * @author Omar Abdulkarim
	 */
	public class GameOver extends FlxState 
	{
		[Embed(source = "/data/sound/lose.mp3")] private var losesound:Class;
		private var lSound:FlxSound;
		private var resetButton:FlxButton;
		private var lose:FlxSprite;
		[Embed(source = "/data/lose.png")] private var loseImg:Class;		
		override public function create():void
		{
			
			lose = new FlxSprite(0, 0, loseImg);
			add(lose);			
			resetButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 60, "Play again?", replay);
			add(resetButton);
			var name:String = FlxKongregate.getUserName;
			var text:FlxText = new FlxText(FlxG.width / 2 - 20, FlxG.height / 2, 100, name, false);
			text.text = "Score: " + FlxG.score+ "\nTime:" + FlxG.scores[1].toFixed(1);
			add(text);			
			lSound = new FlxSound();
			lSound.loadEmbedded(losesound);
			lSound.play();
			//FlxKongregate.submitStats("Score", FlxG.score);
			FlxG.score = 0;
			super.create();
		}
		
		override public function update():void
		{
			if (FlxG.keys.R)
			{
				replay();
			}
			super.update();
		}
		
		public function replay():void
		{
			FlxG.flash();
			lSound.stop();
			FlxG.switchState(new PlayState());
		}
		
		public function GameOver() 
		{

			super();
		}
		
	}

}