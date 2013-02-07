package harry_potter.game 
{
	import harry_potter.assets.Global;
	/**
	 * Main class the handle the player's deck
	 * @author Fano
	 */
	public class Deck extends CardStack {
		
		public var startingChar:Card;
		
		public function Deck() {
			//animate here.
			super();
		}
		
		/**
		 * Returns a reference to the top card on the stack and removes it from the stack.
		 * @return The reference to drawn Card Object
		 */
		public function draw():Card {
			return cards.pop();
		}
		
		/**
		 * Randomizes the order of all cards in the deck.
		 */
		public function shuffle():void {
			//create a new temporary vector
			var newCardList:Vector.<Card> = new Vector.<Card>();
			//loop through the current cards vector and remove a card from a random index, insert into new vector
			while(cards.length > 0) {
				var r:int = Math.floor(Math.random()*cards.length);
				newCardList.push(cards[r]);
				cards.splice(r,1);
			}
			
			//set the new vector to be the new cards vector.
			cards = new Vector.<Card>(); //create new object
			cards = newCardList.concat(); //concatinate the new elements
		}
		
		/**
		 * Attempts to add a card to the deck, if there are already too many duplicates of the card in the deck, the operation will fail
		 * @param	_card
		 * @return	true if the card was successfully added, false otherwise
		 */
		override public function add(_card:Card):Boolean {
			//Ignore checks if it is a lesson card
			if (_card.type == "Lesson") {
				cards.push(_card);
				return true;
			}
			//find how many of this card is already in the deck
			var num_cards:int = 0;
			for (var i:uint = 0; i < cards.length; ++i) {
				if (_card.cardName == cards[i].cardName) {
					num_cards++;
				}
			}
			//if that is >= card.maxAllowed, return false
			if (num_cards >= _card.maxAllowed) {
				return false;
			}
			//else add, and return true.
			cards.push(_card);
			return true;
		}
		
		public function setStarting(_char:Card):Boolean {
			if (startingChar != null) {
				startingChar = _char;
				return true;
			}
			
			return false;
		}
	}

}