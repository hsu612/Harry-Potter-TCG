package harry_potter.game 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import harry_potter.assets.Global;
	/**
	 * Main class the handle the player's deck
	 * @author Fano
	 */
	public class Deck extends CardStack {
		
		//Sprite sheet for the deck stack animations, will be instantiated in main
		public static var spriteSheet:Bitmap;
		private static const SPRITE_WIDTH:uint = 57;
		private static const SPRITE_HEIGHT:uint = 76;
		
		private var gfx:Bitmap; //bitmap to hold the sprite graphics
		
		private var mainLesson:String;
		
		public function Deck() {
			super();
			
			gfx = new Bitmap(new BitmapData(SPRITE_WIDTH, SPRITE_HEIGHT));
			addChild(gfx);
			updateGraphic();
		}
		
		/**
		 * Returns a reference to the top card on the stack and removes it from the stack.
		 * @return The reference to drawn Card Object
		 */
		public function getTopCard():Card {
			var thisCard:Card = cards[numCards - 1];
			numCards--;
			updateGraphic();
			return thisCard;
		}
		
		/**
		 * Randomizes the order of all cards in the deck.
		 */
		public function shuffle():void {
			var rand:int;
			var temp:Card;
			
			for (var i:int = 0; i < numCards; i++) {
				rand = Math.random() * numCards;
				temp = cards[i];
				cards[i] = cards[rand];
				cards[rand] = temp;
			}
		}
		
		/**
		 * Attempts to add a card to the deck, if there are already too many duplicates of the card in the deck, the operation will fail
		 * @param	_card					A reference to the card that needs to be added
		 * @param	_ignoreMaxAllowed		Whether we wish to ignore the built-in maxAllowed property of each card and instead just use the default 4.
		 * @return	true if the card was successfully added, false otherwise
		 */
		public function buildDeckAdd(_card:Card, _ignoreMaxAllowed:Boolean = false):Boolean {
			//Ignore checks if it is a lesson card
			if (_card.type == "Lesson") {
				add(_card);
				updateGraphic();
				return true;
			}
			//find how many of this card is already in the deck
			var count:int = 0;
			for (var i:uint = 0; i < numCards; ++i) {
				if (_card.cardName == cards[i].cardName) {
					count++;
				}
			}
			
			//Check limits before adding it to the deck
			if(!_ignoreMaxAllowed) {
				if (count >= _card.maxAllowed) {
					return false;
				}
			} else if (count >= 4) {
				return false;
			}
			
			//else add, and return true.
			add(_card);
			updateGraphic();
			return true;
		}
		
		public function setMainLesson(_lesson:String):void {
			mainLesson = _lesson;
		}
		
		public function get _mainLesson():String {
			return this.mainLesson;
		}
		public function updateGraphic():void {
			//Check number of cards and adjust deck size here
			gfx.bitmapData.lock();
			
			//The x should be the only variable when creating the source rectangle.
			var sourceX:int = 10;
			//Determine which sprite to load based on the amount of cards left in the deck
			switch(getNumCards()) {
				case 60:
					sourceX = 0;
					break;
				case 55:
					sourceX = 1;
					break;
				case 45:
					sourceX = 2;
					break;
				case 35:
					sourceX = 3;
					break;
				case 30:
					sourceX = 4;
					break;
				case 25:
					sourceX = 5;
					break;
				case 20:
					sourceX = 6;
					break;
				case 15:
					sourceX = 7;
					break;
				case 10:
					sourceX = 8;
					break;
				case 5:
					sourceX = 9;
					break;
			}
			var rect:Rectangle = new Rectangle(sourceX*SPRITE_WIDTH, 0, SPRITE_WIDTH, SPRITE_HEIGHT);
			gfx.bitmapData.copyPixels(spriteSheet.bitmapData, rect, new Point(0, 0));
			gfx.bitmapData.unlock();
		}
	}

}