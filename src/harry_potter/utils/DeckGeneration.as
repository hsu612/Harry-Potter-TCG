package harry_potter.utils 
{
	import harry_potter.game.Deck;
	import harry_potter.game.Card;
	import harry_potter.assets.Global;
	
	public class DeckGeneration {
		
		public static function CreateDeck(_lessons:Array):Deck {
			var result:Deck = new Deck();
			//Add different amount of lessons based on whether 2 or 3 were chosen
			switch(_lessons.length) {
				case 2:
					addLesson(result, _lessons[0], 16, 15);
					addLesson(result, _lessons[1], 14, 15);
					break;
				case 3:
					addLesson(result, _lessons[0], 15);
					addLesson(result, _lessons[1], 8);
					addLesson(result, _lessons[2], 7);
					break;
				default:
					throw new Error("Some weird stuff happened and the deck wasn't made! _lessons.length = " + _lessons.length);
			}
			
			return result;
		}
		
		public static function CreateOpponentDeck(_lessons:Array):Deck {
			var result:Deck = new Deck();
			//first determine the lesson types that the AI will use
			//For now, the AI will always use 3 types of lessons in its deck, that may change later.
			
			var firstType:uint;
			var secondType:uint;
			var thirdType:uint;
			
			//If the player chose creatures as their main type, then the AI will use creatures as well, otherwise it will not and it will also be different from the player's main type.
			if (_lessons[0] == LessonTypes.CARE_OF_MAGICAL_CREATURES) {
				firstType = LessonTypes.CARE_OF_MAGICAL_CREATURES;
			} 
			else {
				firstType = LessonTypes.getRandomType([_lessons[0], LessonTypes.CARE_OF_MAGICAL_CREATURES]);
			}
			
			//Make sure the second and third types are different
			secondType = LessonTypes.getRandomType([firstType, _lessons[1]]);
			thirdType = LessonTypes.getRandomType([firstType, secondType]);
			
			addLesson(result, firstType, 14);
			addLesson(result, secondType, 8);
			addLesson(result, thirdType, 8);
			
			return result;
		}
		
		/**
		 * Adds a set of lessons and their respective cards to the specified deck.
		 * @param	_deck		A reference to the deck that you wish to insert cards into.
		 * @param	type		The type of lesson to insert (i.e. LessonTypes.CHARMS)
		 * @param	num_lessons	The number of lessons to insert
		 * @param	num_cards	How many cards of the given type should be added (default: 10)
		 */
		private static function addLesson(_deck:Deck, type:uint, num_lessons:uint, num_cards:uint = 10):void {
			var startingName:String;
			var lessonName:String;
			var tagName:String;
			//Set the three variables in the switch case depending on the type of lesson the player has chosen.
			//this is simply to avoid having to copy/paste the algorithm 5 times inside a switch statement.
			switch(type) {
				case LessonTypes.CARE_OF_MAGICAL_CREATURES:
					startingName = "Ron, Youngest Brother";
					lessonName = "Care of Magical Creatures";
					tagName = "COMC";
					break;
				case LessonTypes.CHARMS:
					startingName = "The Famous Harry Potter";
					lessonName = "Charms";
					tagName = lessonName;
					break;
				case LessonTypes.TRANSFIGURATION:
					startingName = "Hermione Granger";
					lessonName = "Transfigurations";
					tagName = lessonName;
					break;
				case LessonTypes.POTIONS:
					startingName = "Draco Malfoy, Slytherin";
					lessonName = "Potions";
					tagName = lessonName;
					break;
				case LessonTypes.QUIDDITCH:
					startingName = "Oliver Wood";
					lessonName = "Quidditch";
					tagName = lessonName;
					break;
				default:
					throw new Error("Invalid parameter to addLesson");
			}
			
			//Add starting character
			var starting:Card = new Card(startingName);
			_deck.setStarting(starting);
			//Add number of lessons
			for (var i:uint = 0; i < num_lessons; ++i) {
				var lesson:Card = new Card(lessonName);
				_deck.add(lesson);
			}
			//Make array of non-lesson cards to add, use tag name to identify elegible cards.
			var listFromXML:XMLList = Card.library.Card.(tag == tagName);
			/**
			 * TEMPORARY - If no cards are found with the appropriate tagname, listFromXML won't initialize correctly, just exit here.
			 */
			if (listFromXML == null) {
				Global.console.print("addLesson exited early! oh shit!");
				return;
			}
			//Pick cards to add at random from array
			for (var k:uint = 0; k < num_cards; ++k) {
				var index:int = Math.random() * listFromXML.length();
				if (!_deck.add(new Card(listFromXML[index].@title))) {
					k--; //if the card failed to add, reduce k and try again.
				}
			}
		}
		
		
	}

}