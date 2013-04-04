package harry_potter.game 
{
	import com.bit101.components.Label;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class StatsPanel extends Sprite {
		public static const LABEL_ACTIONS:uint = 0;
		public static const LABEL_DECK:uint = 1;
		public static const LABEL_CREATURES:uint = 2;
		public static const LABEL_LESSONS:uint = 3;
		
		private var actions_label:Label;
		private var deck_label:Label;
		private var creatures_label:Label;
		private var lessons_label:Label;
		
		public function StatsPanel() {
			actions_label = new Label(this, 187, 360, "Actions: 0");
			deck_label = new Label(this, 170, 415, "Cards in Deck: 60");
			creatures_label = new Label(this, 185, 385, "Damage: 0");
			lessons_label = new Label(this, 187, 445, "Lessons: 0");
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
			}
		}
		
	}

}