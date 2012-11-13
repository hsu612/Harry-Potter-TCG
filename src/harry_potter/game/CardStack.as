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
			//we should probably not use this class directly and instead derive the classes Deck, Hand, etc. from it, but there's no harm in creating a proper constructor.
			cards = new Vector.<Card>;
		}
		
		/**
		 * Adds a card to the stack
		 * @param	_card - a reference to the Card object to be added.
		 */
		public function add(_card:Card) {
			cards.push(_card);
		}
		
		/**
		 * Removes a card from the stack.
		 * @param	_card - A refence to the card that needs to be removed from the stack
		 * @return Returns true if the card was successfully removed, false otherwise.
		 */
		public function remove(_card:Card):Boolean {
			var index = cards.indexOf(_card);
			if (index == -1) {
				//card not found
				return false;
			}
			
			cards.splice(index, 1);
			return true;
		}
		
	}

}