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
		
		public static const FRAME_COMC:Rectangle = new Rectangle(0, 0, 46, 65);
		public static const FRAME_CHARMS:Rectangle = new Rectangle(47, 0, 41, 65);
		public static const FRAME_TRANSFIGURATION:Rectangle = new Rectangle(87, 0, 50, 65);
		public static const FRAME_POTIONS:Rectangle = new Rectangle(137, 0, 46, 65);
		public static const FRAME_QUIDDITCH:Rectangle = new Rectangle(184, 0, 40, 65);
		
		public static var spriteSheet:Bitmap;
		
		public var lessonType:String;
		public var selected:Boolean;
		
		private var gfx:Bitmap;
		
		public function LessonButton(_x:Number, _y:Number, _lessonType:String) {
			init(_x, _y, _lessonType);
		}
		
		private function init(_x:Number, _y:Number, _lessonType:String):void {
			x = _x;
			y = _y;
			
			lessonType = _lessonType;
			
			//set to true when the button is clicked.
			selected = false;
			
			//create a local rectangle to hold the x y width and height of the needed graphic
			var tempRect:Rectangle;
			
			//assign the appropriate values to our rectangle
			switch(lessonType) {
				case LessonTypes.CARE_OF_MAGICAL_CREATURES:
					tempRect = FRAME_COMC;
					break;
				case LessonTypes.CHARMS:
					tempRect = FRAME_CHARMS;
					break;
				case LessonTypes.TRANSFIGURATION:
					tempRect = FRAME_TRANSFIGURATION;
					break;
				case LessonTypes.POTIONS:
					tempRect = FRAME_POTIONS;
					break;
				case LessonTypes.QUIDDITCH:
					tempRect = FRAME_QUIDDITCH;
					break;
				default:
					trace("invalid parameter to LessonButton");
			}
			
			//create a new bitmapdata ("canvas") object with the width and height of our rectangle
			var tempBMD:BitmapData = new BitmapData(tempRect.width, tempRect.height);
			
			//copy the pixels from our rectangle into this canvas
			tempBMD.lock();
			tempBMD.copyPixels(spriteSheet.bitmapData, tempRect, new Point(0, 0));
			tempBMD.unlock();
			
			//create our bitmap object to be added to the stage
			gfx = new Bitmap(tempBMD);
			
			//set the y as the height so the images are all aligned along the bottom of the image
			gfx.y = -gfx.height;
			addChild(gfx);
			
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
			//Global.setTTAutoSize(true);
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