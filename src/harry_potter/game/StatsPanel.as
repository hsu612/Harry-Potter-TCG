package harry_potter.game 
{
	import com.bit101.components.Label;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import harry_potter.assets.Global;
	import harry_potter.utils.LessonButton;
	
	public class StatsPanel extends Sprite {
		public static const LABEL_ACTIONS:uint = 0;
		public static const LABEL_DECK:uint = 1;
		public static const LABEL_CREATURES:uint = 2;
		public static const LABEL_LESSONS:uint = 3;
		
		private static const LESSON_GFX_OFFSET:uint = 50;
		
		private var actions_label:Label;
		private var deck_label:Label;
		private var creatures_label:Label;
		private var lessons_label:Label;
		
		private var lessonGFX:Sprite;
		
		
		public function StatsPanel() {
			actions_label = new Label(this, 187, 360, "Actions: 0");
			deck_label = new Label(this, 170, 415, "Cards in Deck: 60");
			creatures_label = new Label(this, 185, 385, "Damage: 0");
			lessons_label = new Label(this, 187, 445, "Lessons: 0");
			
			lessonGFX = new Sprite();
			//set x and y values here.
			/*
			 * TO DO: Possibly create a separate sprite sheet for this, as the scaled down sprites look ugly!
			 * */
			lessonGFX.x = 175;
			lessonGFX.y = 490;
			lessonGFX.scaleX = 0.5;
			lessonGFX.scaleY = 0.5;
			//maybe set scaleX and Y here too
			addChild(lessonGFX);
		}
		
		/**
		 * Updates a particular field in the stat panel
		 * @param	label				-A StatsPanel constant saying which field to update (e.g. StatsPanel.LABEL_DECK)
		 * @param	value				-The value to update the label to.
		 * @param	availableLessons	-If lessons are being updated, pass in the new boolean array with the available lessons.
		 */
		public function update(label:uint, value:int, availableLessons:Array = null):void {
			switch(label) {
				case LABEL_ACTIONS:
					actions_label.text = "Actions: " + value;
					break;
				case LABEL_DECK:
					deck_label.text = "Cards in Deck: " + value;
					break;
				case LABEL_CREATURES:
					creatures_label.text = "Creature Damage: " + value;
					break;
				case LABEL_LESSONS:
					lessons_label.text = "Lessons: " + value;
					break;
			}
			
			if (availableLessons != null) {
				//update the lesson icons based on the given array
				//NEED: Graphics for this part of the panel.
				updateLessonIcons(availableLessons);
			}
		}
		
		private function updateLessonIcons(_lessons:Array):void {
			//remove all images
			var temp:Sprite;
			while (lessonGFX.numChildren > 0) {
				temp = Sprite(lessonGFX.getChildAt(0));
				lessonGFX.removeChild(temp);
				temp = null;
			}
			
			for (var i:int = 0; i < _lessons.length; i++) {
				if (_lessons[i]) {
					showImage(i);
				}
			}
		}
		
		private function showImage(i:int):void {
			Global.console.print("ShowImage Called");
			var rect:Rectangle = getLessonRect(i);
			
			
			var sprite:Sprite = new Sprite();
			sprite.x = lessonGFX.numChildren * LESSON_GFX_OFFSET;
			
			var bmpdata:BitmapData = new BitmapData(rect.width, rect.height);
			bmpdata.lock();
			bmpdata.copyPixels(LessonButton.spriteSheet.bitmapData, rect, new Point());
			bmpdata.unlock();
			
			var gfx:Bitmap = new Bitmap(bmpdata);
			gfx.y = -gfx.height;
			sprite.addChild(gfx);
			lessonGFX.addChild(sprite);
		}
		
		private function hideImage(i:int):void {
			
		}
		
		private function getLessonRect(i:int):Rectangle {
			switch(i) {
				case 0: return LessonButton.FRAME_COMC;
				case 1: return LessonButton.FRAME_CHARMS;
				case 2: return LessonButton.FRAME_TRANSFIGURATION;
				case 3: return LessonButton.FRAME_POTIONS;
				case 4: return LessonButton.FRAME_QUIDDITCH;
			}
			
			return null;
		}
		
	}

}