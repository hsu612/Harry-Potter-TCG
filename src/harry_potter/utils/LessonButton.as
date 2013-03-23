package harry_potter.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import harry_potter.assets.Global;
	import harry_potter.events.ButtonEvent;
	
	
	public class LessonButton extends Sprite {
		
		public var lessonType:String;
		public var selected:Boolean;
		
		private var buttonGfx:Bitmap;
		private var _parent:Sprite;
		
		public function LessonButton(_parent:Sprite, _x:Number, _y:Number, _lessonType:String) {
			x = _x;
			y = _y;
			
			lessonType = _lessonType;
			
			this._parent = _parent;
			//set to true when the button is clicked.
			selected = false;
			
			//create a local rectangle to hold the x y width and height of the needed graphic
			var tempRect:Rectangle = new Rectangle();
			
			//create a reference to our sprite sheet
			var gfxBMD:BitmapData = new Global.LessonSelect().bitmapData; //Maybe this should be a static member of the class
			
			//assign the appropriate values to our rectangle
			switch(lessonType) {
				case LessonTypes.CARE_OF_MAGICAL_CREATURES:
					tempRect.x = 0;
					tempRect.width = 38;
					tempRect.height = 38;
					break;
				case LessonTypes.CHARMS:
					tempRect.x = 39;
					tempRect.width = 36;
					tempRect.height = 38;
					break;
				case LessonTypes.TRANSFIGURATION:
					tempRect.x = 76;
					tempRect.width = 45;
					tempRect.height = 32;
					break;
				case LessonTypes.POTIONS:
					tempRect.x = 122;
					tempRect.width = 38;
					tempRect.height = 38;
					break;
				case LessonTypes.QUIDDITCH:
					tempRect.x = 161;
					tempRect.width = 29;
					tempRect.height = 47;
					break;
				default:
					trace("invalid parameter to LessonButton");
			}
			
			//create a new bitmapdata ("canvas") object with the width and height of our rectangle
			var tempBMD:BitmapData = new BitmapData(tempRect.width, tempRect.height);
			
			//copy the pixels from our rectangle into this canvas
			tempBMD.lock();
			tempBMD.copyPixels(gfxBMD, tempRect, new Point(0, 0));
			tempBMD.unlock();
			
			//create our bitmap object to be added to the stage
			buttonGfx = new Bitmap(tempBMD);
			
			//set the y as the height so the images are all aligned along the bottom of the image
			buttonGfx.y = -buttonGfx.height;
			addChild(buttonGfx);
			
			buttonMode = true;
			useHandCursor = true;
			
			addEventListener(MouseEvent.CLICK, sendID);
			addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}
		
		private function sendID(e:MouseEvent):void {
			//send an event to MainMenu.as saying that this button has been clicked.
			dispatchEvent(new ButtonEvent(ButtonEvent.LESSON_BTN, this, true));
		}
		
		private function mouseOver(e:MouseEvent):void {
			if (!selected) {
				this.filters = [new GlowFilter(0xff3f3f)];
			}
			Global.setTTAutoSize(true);
			Global.tooltip.show(this, lessonType);
		}
		
		private function mouseOut(e:MouseEvent):void {
			if (!selected) {
				this.filters = [];
			}
			Global.tooltip.hide();
		}
	}
}