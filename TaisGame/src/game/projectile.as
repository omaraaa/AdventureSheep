package game 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Omar Abdulkarim
	 */
	public class projectile extends FlxSprite
	{
		
		private var imgClass:Class;
		private var target:FlxObject;
		
		public function projectile(x:uint, y:uint, img:Class, trgt:FlxObject)
		{
			target = trgt;
			imgClass = img;
			super(x, y, imgClass);
		}
		
		override public function update():void
		{
			if (target.y == this.y)
			{
				acceleration.y = 20;
			}
			super.update();
		}
		
	}

}