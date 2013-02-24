package game 
{
	import flash.geom.Rectangle;
	import org.flixel.*;
	/**
	 * ...
	 * @author Omar Abdulkarim
	 */
	public class Enemy extends FlxSprite
	{
		private var _gravity:int = 200;
		private var _target:FlxObject;
		private var midX:uint;
		private var hitbox:FlxSprite;
		//private var hx1, hy1, hx2, hy2:uint;
		
		[Embed(source = "/data/enemy1.png")] private var normalEnemy:Class;
		
		public function Enemy(x:int, y:int, type:String, target:FlxObject)
		{
			_target = target;
			super(x, y);
			switch(type) 
			{
				case "Normal":
					loadGraphic(normalEnemy, true, true);
					break;
			}

			maxVelocity.y = 150;
			acceleration.y = _gravity;
			midX = x + (width / 2);
			
			/*hitbox = new FlxSprite(x, y - 50);
			hitbox.width = width;
			hitbox.height = 50;*/
			
			
		}
		
		override public function update():void
		{
			if (_target.x > this.x)
				velocity.x+= 1;
			if (_target.x < this.x)
				velocity.x -= 1;
			if (FlxG.overlap(hitbox, _target))
				destroy();
			super.update();
			//hitbox.update();
		}
		
		public function followObj(obj:FlxObject):void
		{
			if (obj.x > this.x)
				velocity.x+= 1;
			if (obj.x < this.x)
				velocity.x-= 1;
		}
		
	}

}