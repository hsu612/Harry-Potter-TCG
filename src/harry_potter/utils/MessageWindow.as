package harry_potter.utils 
{
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Window;
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class MessageWindow extends Sprite 
	{
		private var _parent:Sprite;
		
		/**
		 * Creates an instance of a message window and adds it to the display list of the given sprite.
		 * @param	_parent A reference to the parent sprite where this instance will be added
		 * @param	title The title of the window
		 * @param	message The message to be displayed
		 */
		public function MessageWindow(_parent:Sprite, title:String, message:String) {
			//Darken screen
			var bg:BitmapData = new BitmapData(800, 600, false, 0x111111);
			var bgBitmap:Bitmap = new Bitmap(bg);
			bgBitmap.alpha = .8;
			addChild(bgBitmap);
			
			//add window, text, and the OK button.
			var window:Window = new Window(this, 250, 200, title);
			window.setSize(300, 200);
			
			window.draggable = false;
			
			var text:Label = new Label(window, 5, 5, message);
			
			var btn:PushButton = new PushButton(window, 100, 150, "OK", removeSelf);
			
			
			this._parent = _parent;
			this._parent.addChild(this);
		}
		
		private function removeSelf(e:Event):void {
			_parent.removeChild(this);
			delete this;
		}
		
	}

}