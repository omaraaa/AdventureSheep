package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import mochi.as3.MochiAd;
	import mochi.as3.MochiServices;
	import sitelock.SiteLock;
	[SWF(width = "640", height = "480", backgroundcolor = "#000000")]
    //[Frame(factoryClass="Preloader")]
	/**
	 * ...
	 * @author ...
	 */
	public class Main extends Sprite
	{
		private var _mochiads_game_id:String = "2331773b018994cb";
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var lock:SiteLock = new SiteLock();
			//lock.addSite("kongregate.com", false);
			//lock.allowLocalPlay(true);
			//addChild(lock);
			var game:Game = new Game();
			addChild(game);
			
		}
	}

}