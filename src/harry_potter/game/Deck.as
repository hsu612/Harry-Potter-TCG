package harry_potter.game 
{
	/**
	 * Main class the handle the player's deck
	 * @author Fano
	 */
	public class Deck extends CardStack {
		
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
	}

}