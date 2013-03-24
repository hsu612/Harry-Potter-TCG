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
		
		/**
		 * Base class for all collections of Card Objects
		 */
		public function CardStack() { 
			cards = new Vector.<Card>;
			
			useHandCursor = true;
			this.buttonMode = true;
		}
		
		/**
		 * Adds a card to the stack
		 * @param	_card - a reference to the Card object to be added.
		 */
		public function add(_card:Card):Boolean {
			cards.push(_card);
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
			
			cards.splice(index, 1);
			return true;
		}
		
		override public function toString():String {
			var result:String = "";
			for (var i:uint = 0; i < cards.length; i++) {
				if (result.search(cards[i].cardName) != -1) {
					continue;
				}
				result += cards[i].cardName;
				//find how many of this card is already in the stack
				var num_cards:int = 1; //We know at least 1 exists since it was found in our first if-statement, so start this value from 1.
				for (var k:uint = i+1; k < cards.length; ++k) {
					if (cards[i].cardName == cards[k].cardName) {
						num_cards++;
					}
				}
				result += " x" + num_cards + "\n";
			}
			
			result += "Stack size: " + getNumCards();
			return result;
		}
		
		public function getNumCards():int {
			return cards.length;
		}
		
		public function cardAt(index:uint):Card {
			return cards[index];
		}
	}
}