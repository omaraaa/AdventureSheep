package game 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import flash.display.*;
	import net.pixelpracht.tmx.*;
	/**
	 * ...
	 * @author Omar Abdulkarim
	 */
	public class Level extends FlxTilemap
	{
		
		private var tile1:FlxTileblock;
		private var mapCsv:String;
		private var lvls:Levels;
		[Embed(source = "/data/autotiles.png")] private var autoTiles:Class

		
		public function Level(tmx:TmxMap,type:String)//mapCSV:Class) 
		{
			super();
			lvls = new Levels();
			mapCsv = tmx.getLayer(type).toCsv(tmx.getTileSet('tiles'));
			loadMap( /*arrayToCSV(lvls.level1, 300)*/ mapCsv/*FlxTilemap.imageToCSV(mapCSV, false, 1)*/, autoTiles, 8, 8, FlxTilemap.AUTO);
			follow();
		}
		
		
		

	}

}