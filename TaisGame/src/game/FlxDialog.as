package game {
 
 
	import org.flixel.*;
 
 
	public class FlxDialog extends FlxGroup{
 
		/**
		 * Use this to tell if dialog is showing on the screen or not.
		 */
		public var showing:Boolean;
 
		/**
		 * The text field used to display the text
		 */
		private var _field:FlxText;
 
		/**
		 * Called when current page in dialog is finished (optional)
		 */
		private var _endPageCallback:Function;
 
		/**
		 * Called when dialog is finished (optional)
		 */
		private var _finishCallback:Function;
 
		/**
		 * Stores all of the text to be displayed. Each "page" is a string in the array
		 */
		private var _dialogArray:Array;
 
		/**
		 * Background rect for the text
		 */
		private var _bg:FlxSprite;
 
		private var _width:Number;
		private var _height:Number;
		private var x:Number;
		private var y:Number;
		private var _backgroundColor:uint;
 
		internal var _pageIndex:int;
		internal var _charIndex:int;
		internal var _displaying:Boolean;
		internal var _displaySpeed:Number;
		internal var _elapsed:Number;
		internal var _endPage:Boolean;
 
		public function FlxDialog(X:Number=0, Y:Number=0, Width:Number=310, Height:Number=72, displaySpeed:Number=.45, background:Boolean=true, backgroundColor:uint=0x77000000)
		{				
			x = X; 
			y = Y;			
			_width 	= Width;
			_height	= Height;
			_backgroundColor = backgroundColor;
 
			_bg = new FlxSprite()
			_bg.makeGraphic(_width, _height, _backgroundColor);
			_bg.scrollFactor.x = _bg.scrollFactor.y = 0;
 
			if(background){
				add(_bg);
			}
 
			_field = new FlxText(0, 0, _width, "");
			_field.scrollFactor.x = _field.scrollFactor.y = 0;
			add(_field);
 
			_elapsed = 0;
 
			_displaySpeed = displaySpeed;
			_bg.alpha = 0;
		}
 
		/**
		 * Call this to set the format of the text
		 */
		public function setFormat(font:String=null, Size:Number=8, Color:uint=0xffffff, Alignment:String=null, ShadowColor:uint=0):void
		{
			_field.setFormat(font, Size, Color, Alignment, ShadowColor);
		}
 
		/**
		 * Call this from your code to display some dialog
		 */
		public function showDialog(pages:Array):void
		{
			_pageIndex = 0;
			_charIndex = 0;
			_field.text = pages[0].charAt(0);
			_dialogArray = pages;
			_displaying = true;
			_bg.alpha = 1;
			showing = true;
		}
 
		/**
		 * The meat of the class. Used to display text over time as well
		 * as control which page is 'active'
		 */
		override public function update():void
		{			
			if(_displaying)
			{
				_elapsed += FlxG.elapsed;
 
				if(_elapsed > _displaySpeed)
				{
					_elapsed = 0;
					_charIndex++;
					if(_charIndex > _dialogArray[_pageIndex].length)
					{
						if(_endPageCallback!=null) _endPageCallback();
						_endPage = true;
						_displaying = false;
					}
 
					_field.text = _dialogArray[_pageIndex].substr(0, _charIndex);
				}
			}
 
			if(FlxG.keys.justPressed("X"))
			{
				if(_displaying)
				{
					_displaying = false;
					_endPage = true;
					_field.text = _dialogArray[_pageIndex];
					_elapsed = 0;
					_charIndex = 0;
				}
				else if(_endPage)
				{
					if(_pageIndex == _dialogArray.length - 1)
					{
						//we're at the end of the pages
						_pageIndex = 0;
						_field.text = "";
						_bg.alpha = 0;
						if(_finishCallback!=null) _finishCallback();
						showing = false;
					}
					else
					{
						_pageIndex++;
						_displaying = true;
					}
				}
			}
 
			super.update();
		}
 
		/**
		 * Called when the current page in dialog is completely finished
		 */
		public function set endPageCallback(val:Function):void
		{
			_endPageCallback = val;
		}
 
		/**
		 * Called when the dialog is completely finished
		 */
		public function set finishCallback(val:Function):void
		{
			_finishCallback = val;
		}
 
	}
}