package game 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author ...
	 */
	public class Dialog extends FlxGroup
	{
		
		public var text:FlxText;
		
		public var frame:FlxSprite;
		
		public var showing:Boolean;
		
		public var xPos:Number;
		public var yPos:Number;
		private var i:int = 0;
		private var time:Number = 0;
		
		public var frameImage:Class;
		
		public var dialog:String;
		
		public function Dialog(x:Number, y:Number, frameImg:Class) 
		{
			xPos = x;
			yPos = y;
			frameImage = frameImg;
			
			frame = new FlxSprite(xPos, yPos, frameImage);
			frame.scrollFactor.y = 0;
			frame.scrollFactor.x = 0;
			add(frame);
			
			text = new FlxText(x + 10, y + 5, 300);
			text.scrollFactor.y = 0;
			text.scrollFactor.x = 0;
			add(text);
			
			dialog = "THIS GAME IS AWESOME WOWOWOWOWOWOWO!!!!111!!!!one11!!1";
			//text.text = dialog.charAt(0);
		}
		
		override public function update():void
		{
			if (showing)
			{
				frame.y = yPos;
				text.y = yPos +5;


				time += FlxG.elapsed;
				if (time >= 0.01)
				{
					i += 1;
					text.text += dialog.charAt(i - 1);;
					time = 0;
				}
			} else {
				frame.y = FlxG.height;
				text.y = FlxG.height;
				text.text = "";
				time = 0;
				i = 0;
			}
			
			super.update();
		}
		
		public function show():void
		{
			showing = true;
		}
		
		public function hide():void
		{
			showing = false;
		}
		
	}

}