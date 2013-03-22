package harry_potter.game 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import harry_potter.utils.LessonTypes;
	import harry_potter.assets.Global;
	import harry_potter.utils.DeckGeneration;
	import harry_potter.game.Card;
	import caurina.transitions.Tweener;
	
	
	public class Player extends Sprite {
		//Positioning constants
		private static const DECK_X:uint = 58;
		private static const DECK_Y:uint = 433;
		
		private static const HAND_X:uint  = 176 + Card.CARD_WIDTH / 2;
		private static const HAND_Y:uint = 518 + Card.CARD_HEIGHT / 2;
		private static const HAND_SPACING:uint = 10;
		
		private static const STARTING_X:uint = 13 + Card.CARD_WIDTH / 2;
		private static const STARTING_Y:uint = 528 + Card.CARD_HEIGHT / 2;
		
		
		private var deck:Deck;
		private var hand:Hand;
		private var discard:Discard;
		
		private var starting_character:Card;
		public function Player(_deck:Deck) {
			deck = _deck;
			
			hand = new Hand();
			//Not sure if we'll do any display stuff in the hand class
			//hand.x = HAND_X;
			//hand.y = HAND_Y;
			//addChild(hand);
			
			discard = new Discard();
			
			switch(_deck._mainLesson) {
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
			//TO DO - Add main character to displayList, probably separate into different function to clean up this code
			starting_character.x = STARTING_X;
			starting_character.y = STARTING_Y;
			starting_character.flip();
			starting_character.rotate();
			addChild(starting_character);
			
			deck.shuffle();
			deck.x = DECK_X;
			deck.y = DECK_Y;
			addChild(deck);
			deck.addEventListener(MouseEvent.CLICK, draw);
			
			
			// Draw Hand
			//TO DO - Add Tweening delay, again separate into separate function.
			for (var i:int = 0; i < 7; i++) {
				draw();
			}
		}
		
		private function adjustHandSpacing():void {
			//We create a shrink value depending on the number of cards in the hand.
			var num:int = hand.getNumCards();
			var shrinkValue:Number;
			if (num < 11) {
				shrinkValue = 1;
			} else if (num >= 11 && num < 15) {
				shrinkValue = 0.7;
			} else if (num >= 15 && num < 21) {
				shrinkValue = 0.5;
			} else if (num >= 21 && num < 33) {
				shrinkValue = 0.3;
			} else if (num >= 33 && num < 50) {
				shrinkValue = 0.2;
			} else {
				shrinkValue = 0.15;
			}
			
			//Figure out the target X of the card based on the shrink value
			var targetX:int;
			for (var i:int = 0; i < hand.getNumCards(); i++) {
				targetX = HAND_X + i * ((Card.CARD_WIDTH + HAND_SPACING) * shrinkValue);
				
				Tweener.addTween(hand.cards[i], {x: targetX, y: HAND_Y, time:0.6, transition:"easeOutQuad"} );
			}
		}
		
		public function draw(e:MouseEvent = null):void {
			//Animate here, low coupling ;)
			var thisCard:Card;
			if (deck.getNumCards() > 0) {
				thisCard = deck.getTopCard();
			} else {
				Global.console.print("Deck is out of cards!");
				removeChild(deck);
				//send game over event here.
				return;
			}
			
			hand.add(thisCard);
			
			/***Animation***/
			//The card begins at the deck x and y values
			thisCard.x = DECK_X + Card.CARD_WIDTH/2;
			thisCard.y = DECK_Y + Card.CARD_HEIGHT/2;
			
			addChild(thisCard);
			
			thisCard.flip();
			
			//Adjust the hand spacing, since the above card is already added to the hand array
			//the following function will be able to tween it to the right spot.
			adjustHandSpacing();
		}
	}
}