package harry_potter.utils 
{
	
	public class LessonTypes {
		public static const CARE_OF_MAGICAL_CREATURES:uint = 0;
		public static const CHARMS:uint = 1;
		public static const TRANSFIGURATION:uint = 2;
		public static const POTIONS:uint = 3;
		public static const QUIDDITCH:uint = 4;
		
		/**
		 * Returns a random lesson type, used for AI Deck generation.
		 * @param	exclude	An array of invalid lesson types that may NOT be returned, i.e. [LessonTypes.CHARMS, LessonTypes.POTIONS]
		 * @return	A uint value corresponding to a valid lesson type
		 */
		public static function getRandomType(exclude:Array = null):uint {
			//Just return any value if no exceptions are specified
			if (exclude == null) {
				return uint(Math.random() * 5);
			}
			
			var result:uint = Math.random() * 5;
			var found:Boolean = false;
			var needNew:Boolean;
			
			while (!found) {
				needNew = false;
				for (var i:uint = 0; i < exclude.length; i++) {
					if (result == exclude[i]) {
						result = Math.random() * 5;
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
	}

}