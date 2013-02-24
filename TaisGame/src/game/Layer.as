package game 
{
	
	import org.flixel.*;
	/**
	 * ...
	 * @author Omar Abdulkarim
	 */
	public class Layer extends FlxTilemap 
	{
		
		public function Layer(_img:Class) 
		{
			super();
			loadMap(imageToCSV(_img), ImgAuto , 0, 0, AUTO);
		}
		
	}

}