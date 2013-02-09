package harry_potter.game 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import harry_potter.utils.LessonTypes;
	import harry_potter.assets.Global;
	import harry_potter.utils.DeckGeneration;
	
	public class Player extends Sprite {
		//Positioning constants
		private static const DECK_X:uint = 58;
		private static const DECK_Y:uint = 433;
		
		private var deck:Deck;
		private var hand:Hand;
		private var discard:Discard;
		
		private var starting_character:Card;
		public function Player(_deck:Deck) {
			deck = _deck;
			hand = new Hand();
			discard = new Discard();
			
			switch(_deck.mainLesson) {
				case LessonTypes.CARE_OF_MAGICAL_CREATURES:
					starting_character = new Card(DeckGeneration.CHARACTER_CREATURES);
					break;
				case LessonTypes.CHARMS:
					starting_character = new Card(DeckGeneration.CHARACTER_CHARMS);
					break;
				case LessonTypes.TRANSFIGURATION:
					starting_character = new Card(DeckGeneration.CHARACTER_TRANSFIGURATIONS);
					break;
				case LessonTypes.POTIONS:
					starting_character = new Card(DeckGeneration.CHARACTER_POTIONS);
					break;
				case LessonTypes.QUIDDITCH:
					starting_character = new Card(DeckGeneration.CHARACTER_QUIDDITCH);
					break;
				default:
					throw new Error("Invalid type at deck.mainLesson!");
			}
			
			deck.shuffle();
			deck.x = DECK_X;
			deck.y = DECK_Y;
			addChild(deck);
			deck.addEventListener(MouseEvent.CLICK, draw);
			
			for (var i:int = 0; i < 7; i++) {
				draw();
			}
			
			Global.console.print("\nHand:\n" + hand.toString());
		}
		
		
		public function draw(e:MouseEvent = null):void {
			//Animate the hand in the overwritten add function?
			hand.add(deck.getTopCard());
		}
	}
}