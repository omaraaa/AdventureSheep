package game
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Omar Abdulkarim
	 */
	public class Player extends FlxSprite
	{
		
		[Embed(source="/data/player.png")] private var img:Class;
		[Embed(source="/data/sound/jumpTais.mp3")] private var jsfx:Class;
		
		private var scale1:FlxPoint;
		private var moving:Boolean;
		private var _jump:Number;
		private var jumpSfx:FlxSound;
		private var jumped:Boolean;
		private var jumping:Boolean;
		public var vel:Number;
		public var gravity:Number = 400;
		public var speed:Number = 700;
		public var jumpheight:uint = 180;
		
		public function Player(x1:int, y1:int)
		{
			super(x1, y1);
			loadGraphic(img, true, true, 20, 35, true);
			frames = 12;
			frameWidth = 20;
			frameHeight = 35;
			frame = 0;

			addAnimation("Idle", new Array(1, 0), 1, true);
			addAnimation("Walk", new Array(2, 3, 4, 5, 6, 7, 8, 9, 10, 11), 20, true);
			addAnimation("Jump", new Array(12, 13, 14, 15, 16), 7, false);
			//addAnimation("Walk", new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11), 14, true);
			//addAnimation("Idle", [12], 2, true);
			//scale = scale1;
			//offset = scale1;
			play("Idle");
			maxVelocity.x = 130;
			maxVelocity.y = 280;
			gravity = 370;
			
			drag.x = 90;
			
			jumpSfx = new FlxSound();
			jumpSfx.loadEmbedded(jsfx);
		
		}
		
		public function moveX(xx:Number):void
		{
			velocity.x += xx  * FlxG.elapsed;
		}
		
		public function moveY(yy:Number):void
		{
			velocity.y += yy  * FlxG.elapsed;
		}
		
		override public function update():void
		{
			if ((isTouching(FLOOR)))
			{
				jumping = false;
					//if (vel != NaN)
					//acceleration.y -= vel;
			}
			if ((isTouching(FLOOR)) && (FlxG.keys.pressed("SPACE") || FlxG.keys.pressed("ENTER")))
			{
				acceleration.y = -velocity.y;
				velocity.y = -jumpheight;
				
				jumpSfx.play();
				jumped = true;
				jumping = true;
			}
			if (jumped)
			{
				play("Jump", false);
				jumped = false;
			}
			if (jumping && (FlxG.keys.justReleased("SPACE") || FlxG.keys.justReleased("ENTER")))
			{
				moveY(speed + 50);
				jumping = false;
			}
			/*if((_jump >= 0) && (FlxG.keys.SPACE)) //You can also use space or any other key you want
			   {
			
			   _jump += FlxG.elapsed;
			   if(_jump > 0.36) _jump = -0.5; //You can't jump for more than 0.25 seconds
			   }
			   else _jump = -0.5;
			
			   if (_jump > 0)
			   {
			   play("Jump");
			   //if(_jump < 0.065)
			   velocity.y = -maxVelocity.y / 1.5; //This is the minimum speed of the jump
			   //else
			   //acceleration.y = 50; //The general acceleration of the jump
			   } else
			   {
			   velocity.y = 170;  //Make the character fall after the jump button is released
			 }*/ /*if (FlxG.keys.W)
			   {
			   moveY( -10);
			 }*/
			if (FlxG.keys.pressed("S"))
			{
				//velocity.x = 0;
				moveY(speed + 10);
			}
			if (FlxG.keys.pressed("A") || FlxG.keys.pressed("LEFT"))
			{
				facing = RIGHT;
				moveX(-speed);
				moving = true;
			}
			if (FlxG.keys.justReleased("A") || FlxG.keys.justReleased("LEFT"))
			{
				moving = false;
			}
			if (FlxG.keys.pressed("D") || FlxG.keys.pressed("RIGHT"))
			{
				facing = LEFT;
				moveX(speed);
				moving = true;
			}
			if (FlxG.keys.justReleased("D") || FlxG.keys.justReleased("RIGHT"))
			{
				moving = false;
			}
			if (isTouching(FlxObject.FLOOR) && (velocity.x != 0) && velocity.y == 0)
			{
				play("Walk");
			}
			if (isTouching(FlxObject.FLOOR))
			{
				_jump = 0;
			}
			if (((velocity.x == 0) && velocity.y == 0) && isTouching(FlxObject.FLOOR))
			{
				play("Idle");
				moving = false;
			}
			
			if (FlxG.keys.SHIFT)
			{
				//acceleration.y = 500;
			}
			else
			{
				acceleration.y = gravity;
			}
			if (!moving && isTouching(FlxObject.FLOOR))
			{
				velocity.x = 0;
			}
			super.update();
		}
	}

}