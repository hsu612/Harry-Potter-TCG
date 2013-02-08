package harry_potter 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import harry_potter.game.Card;
	
	import harry_potter.assets.Global;
	import harry_potter.game.Deck;
	import harry_potter.utils.LessonTypes;
	import harry_potter.utils.DeckGeneration;
	
	public class Gameplay extends Sprite {
		private static const DECK_X:uint = 58;
		private static const DECK_Y:uint = 433;
		
		private var deck:Deck;
		private var opponentDeck:Deck;
		
		public function Gameplay(_playerDeck:Deck, _opponentDeck:Deck) {
			
			/* TO DO:
				* Begin coding graphics for the deck class
			 */
			//Background image
			var bg:Bitmap = new Global.GameplayBackground();
			addChild(bg);
			
			deck = _playerDeck;
			opponentDeck = _opponentDeck;
			
			deck.x = DECK_X;
			deck.y = DECK_Y;
			addChild(deck);
		}
	}
}
