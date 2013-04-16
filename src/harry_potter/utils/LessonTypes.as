package harry_potter.utils 
{
	
	public class LessonTypes {
		public static const CARE_OF_MAGICAL_CREATURES:String = "Care of Magical Creatures";
		public static const CHARMS:String = "Charms";
		public static const TRANSFIGURATION:String = "Transfigurations";
		public static const POTIONS:String = "Potions";
		public static const QUIDDITCH:String = "Quidditch";
		
		/**
		 * Returns a random lesson type, used for AI Deck generation.
		 * @param	exclude	An array of invalid lesson types that may NOT be returned, i.e. [LessonTypes.CHARMS, LessonTypes.POTIONS]
		 * @return	A value corresponding to a valid lesson type
		 */
		public static function getRandomType(exclude:Array = null):String {
			//Just return any value if no exceptions are specified
			if (exclude == null) {
				return convertToString(Math.random() * 5);
			}
			
			var result:String = convertToString(Math.random() * 5);
			var found:Boolean = false;
			var needNew:Boolean;
			
			while (!found) {
				needNew = false;
				for (var i:uint = 0; i < exclude.length; i++) {
					if (result == exclude[i]) {
						result = convertToString(Math.random() * 5);
						needNew = true;
						break;
					}
				}
				
				if (!needNew) {
					found = true;
				}
				
			}
			
			return result;
		}
		
		public static function convertToString(id:uint):String {
			switch(id) {
				case 0:
					return CARE_OF_MAGICAL_CREATURES;
				case 1:
					return CHARMS;
				case 2:
					return TRANSFIGURATION;
				case 3:
					return POTIONS;
				case 4:
					return QUIDDITCH;
			}
			
			return "";
		}
		
		public static function convertToID(str:String):uint {
			switch(str) {
				case CARE_OF_MAGICAL_CREATURES:
					return 0;
				case CHARMS:
					return 1;
				case TRANSFIGURATION:
					return 2;
				case POTIONS:
					return 3;
				case QUIDDITCH:
					return 4;
			}
			
			return 99;
		}
	}

}