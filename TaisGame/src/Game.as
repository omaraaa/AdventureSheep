package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.API.FlxKongregate;
	import Game.*;

	/**
	 * ...
	 * @author Omar Abdulkarim
	 */
	public class Game extends FlxGame
	{
		
		public function Game() 
		{
			
			super(320, 240, MenuState, 2, 60, 60);
			forceDebugger = true;
			useHandCursor = true;
		}
		
	}

}