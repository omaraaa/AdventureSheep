package  
{
	import game.*;
	import game.ContentManger;
	import game.Enemy;
	import game.Level;
	import game.Player;
	import game.projectile;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.API.FlxKongregate;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import net.pixelpracht.tmx.TmxMap;
	import net.pixelpracht.tmx.TmxObject;
	import net.pixelpracht.tmx.TmxObjectGroup;	
	/**
	 * ...
	 * @author Omar Abdulkarim
	*/
	public class PlayState extends FlxState
	{
		private var player:Player;
		private var level1:Level;
		private var playercamera:FlxCamera;
		private var playerPos:FlxText;
		private var map1:String;     
		private var layer1:FlxSprite;
		private var dangerColl:Level;
		private var enemy1:Enemy;
		private var rock1:projectile;
		private var exit:FlxSprite;
		private var coins:FlxGroup;
		private var score:FlxText;
		private var time:Number = 0;
		//private var tmx:TmxMap;
		private var EGroup:FlxGroup;
		public var content:ContentManger = new ContentManger();
		private var dialog:Dialog;
		private var diaTxt:String;
		
		[Embed(source = "/data/Level1.png")] private var lvl1:Class;
		[Embed(source = "/data/map01.png")] private var map_1:Class;
		[Embed(source = "/data/autotiles.png")] private var ImgTiles:Class;
		[Embed(source = "/data/cave.png")] private var exitImg:Class;
		[Embed(source = "/data/map01.tmx", mimeType = "application/octet-stream")] private var map:Class;
		[Embed(source = "/data/dialogWindow.png")] private var dialogFrame:Class;

		
		
		private function loadTmxFile():void
		{
			var loader:URLLoader = new URLLoader(); 
			loader.addEventListener(Event.COMPLETE, onTmxLoaded);
			loader.load(new URLRequest('data/map1.tmx'));
		}
		
		private function onTmxLoaded(e:Event):void
		{
			if(Levels.level == null){
				var l:FlxXML = new FlxXML();
				var xml:XML = /*l.loadEmbedded(map);*/new XML(e.target.data);
				var tmx:TmxMap = new TmxMap(xml);
				FlxG.levels[1] = tmx;
				level1 = new Level(FlxG.levels[1], 'map');
				dangerColl = new Level(FlxG.levels[1], 'danger');
				content.lvl1 = level1;
				content.lvl1Coll = dangerColl;
				loadstate(FlxG.levels[1]);
				Levels.level = tmx;
			} else {
				level1 = new Level(Levels.level, 'map');
				dangerColl = new Level(Levels.level, 'danger');
				loadstate(Levels.level);
			}
		}		
		

		
		override public function create():void
		{
			player = new Player(140, 40);
			player.play("Idle", true);
			
			FlxG.watch(player, "x","X");
			FlxG.watch(player, "y", "Y");
			FlxG.watch(player.velocity, "y", "Y");
			FlxG.watch(player, "speed", "speed");
			FlxG.watch(player, "jumpheight", "jump");
			FlxG.watch(player, "gravity", "gravity");
			FlxG.watch(FlxG, "score", "score");

			
			//playercamera = new FlxCamera(0, 480, 640, 580);
			//playercamera.zoom = 1;
			//add(playercamera);
			//FlxG.addCamera(playercamera);
			exit = new FlxSprite(130, 572);
			exit.loadGraphic(exitImg);
		
			if(content.lvl1 == null)
			loadTmxFile();

			
			//FlxG.worldBounds.width = level1.width;
			//FlxG.worldBounds.height = level1.height;
			
			layer1 = new FlxSprite(0, 0);
			layer1.loadGraphic(map_1);
			add(layer1);
			add(content.lvl1);
			add(content.lvl1Coll);
			
			EGroup = new FlxGroup();
			
			EGroup.add(new Enemy(180, 40, "Normal", player));
			//add(EGroup);
			

			//add(enemy1);
			
			rock1 = new projectile(player.x + 200, player.y - 100, ImgTiles, player);

			//add(rock1);
			
			//FlxG.camera.setBounds(0, 0, level1.width, level1.height, true);;
			FlxG.camera.zoom = 2;
			add(exit);	
			add(player);
			FlxG.flash();
			score = new FlxText(10, 5, 90, "Score: " + FlxG.score);
			score.scrollFactor.x = 0;
			score.scrollFactor.y = 0;
			add(score);
			
			dialog = new Dialog(0, FlxG.height - 60, dialogFrame);
			super.create();
			States.play = this;
		}
		
		private function spawnObject(obj:TmxObject):void
		{
			coins.add(new Coin(obj.x, obj.y));
			return;
		}
		
		private function loadstate(tmx:TmxMap):void
		{
			coins = new FlxGroup();
			var group:TmxObjectGroup = tmx.getObjectGroup("objects");
			for each(var object:TmxObject in group.objects)
				spawnObject(object);
			add(coins);
			add(dialog);
			//FlxG.watch(coins.members, "length", "coins");
		}
		
		override public function update():void
		{
			if (!dialog.showing)
			{
				time += FlxG.elapsed;
				score.text = "Score: " + FlxG.score + " \ntime: " + time.toFixed(1);;
				//FlxG.worldBounds = new FlxRect(player.x - 1000, player.y - 1000, player.x + 1000, player.y + 10000);			
				FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
				
				if (!((FlxG.camera.x <= 0) && (FlxG.camera.y <= 0)))
				{
					FlxG.camera.follow(player);
				}
		
				FlxG.collide(player, level1);
				if (FlxG.collide(player, dangerColl))
					gameOver();
				if (FlxG.collide(player, exit))
					gameWin();
				
				FlxG.collide(EGroup, level1);
				FlxG.collide(player, EGroup);
				if (coins != null){
				for (var i:Number = 0; i < coins.members.length;i++)
				{
					if (FlxG.overlap(player, coins.members[i]))
					{
						coins.members[i].cfx.play();
						coins.members[i].kill();
						FlxG.score += 10;
					}
				}
				}
				if (((FlxG.mouse.x>=player.x&&FlxG.mouse.x<=player.width) && (FlxG.mouse.y>=player.y&&FlxG.mouse.y<=player.height)) && (FlxG.mouse.pressed()))
				{
					player.color = 0xfff0f0f0;
				} else {
					player.color = 0xffffffff;
				}
				if (FlxG.keys.justPressed("F2"))
				{
					if (dialog.showing)
					{
						dialog.hide();
					} else {
						dialog.show();
					}
				}
				FlxG.scores[1] = time;
				FlxG.log(FlxG.levels[1]);
				super.update();
			} else {
				dialog.update();
				if (FlxG.keys.justPressed("F2"))
				{
					if (dialog.showing)
					{
						dialog.hide();
					} else {
						dialog.show();
					}
				}
			}
			
						
		}
		
		private function gameOver():void 
		{

			FlxG.switchState(new GameOver());
			
		}
		
		private function gameWin():void
		{
			//FlxG.score = FlxG.score / time;
			FlxG.switchState(new WinState());
		}
		
		private function resest():void
		{
			
			FlxG.resetState();
		}
		
		public function PlayState() 
		{
			
		}
		
	}

}