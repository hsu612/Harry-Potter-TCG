package harry_potter.game 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Stefano Fiumara
	 */
	
	 //may need to extend a sprite in order to accomodate for the Deck
	 //alternatively, we can handle the deck animations entirely in the Player class and forget about this.
	public class CardStack extends Sprite {
		
		protected var cards:Vector.<Card>;
		protected var numCards:int;
		
		/**
		 * Base class for all collections of Card Objects
		 */
		public function CardStack() { 
			//Max stack size is always 60 since that's the maximum number of cards a deck may have.
			cards = new Vector.<Card>(60, true);
			numCards = 0;
			
			useHandCursor = true;
			this.buttonMode = true;
		}
		
		/**
		 * Adds a card to the stack
		 * @param	_card - a reference to the Card object to be added.
		 */
		public function add(_card:Card):Boolean {
			cards[numCards] = _card;
			numCards++;
			return true;
		}
		
		/**
		 * Removes a card from the stack.
		 * @param	_card - A refence to the card that needs to be removed from the stack
		 * @return Returns true if the card was successfully removed, false otherwise.
		 */
		public function remove(_card:Card):Boolean {
			var index:int = cards.indexOf(_card);
			if (index == -1) {
				//card not found
				return false;
			}
			//I wonder if this is more efficient
			//shift everything past the index to the left
			for (var i:uint = index; i < numCards - 1; i++) {
				cards[i] = cards[i + 1];
			}
			//cards.splice(index, 1);
			numCards--;
			return true;
		}
		
		override public function toString():String {
			var result:String = "";
			//var length:int = cards.length; //loop invariant
			
			for (var i:uint = 0; i < numCards; i++) {
				if (result.search(cards[i].cardName) != -1) {
					continue;
				}
				result += cards[i].cardName;
				//find how many of this card is already in the stack
				var num_cards:int = 1; //We know at least 1 exists since it was found in our first if-statement, so start this value from 1.
				for (var k:uint = i+1; k < numCards; ++k) {
					if (cards[i].cardName == cards[k].cardName) {
						num_cards++;
					}
				}
				result += " x" + num_cards + "\n";
			}
			
			result += "Stack size: " + numCards;
			return result;
		}
		
		public function getNumCards():int {
			return numCards;
		}
		
		public function cardAt(index:uint):Card {
			return cards[index];
		}
		
		public function sort():void {
			//var length:int = cards.length; //loop invariant
			var temp:Card;
			for (var i:int = 0; i < numCards - 1; i++) {
				for (var j:int = i + 1; j < numCards; j++) {
					if (cards[i].cardName > cards[j].cardName) {
						//swap
						temp = cards[i];
						cards[i] = cards[j];
						cards[j] = temp;
					}
				}
			}
		}
	}
}