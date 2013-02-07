package harry_potter 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	import harry_potter.game.Card;
	
	import harry_potter.assets.Global;
	import harry_potter.game.Deck;
	import harry_potter.utils.LessonTypes;
	import harry_potter.utils.DeckGeneration;
	
	public class Gameplay extends Sprite {

		private var deck:Deck;
		private var opponentDeck:Deck;
		
		public function Gameplay(_lessons:Array) {
			
			/* TO DO:
				* Create decks in MainMenu class so that a loading graphic may be displayed while the decks are being generated.
				* Gameplay class should be instantiated with both decks already created and passed through as parameters (or later perhaps as part of a Player object).
				* Begin coding graphics for the deck class
			 */
			//Background image
			var bg:Bitmap = new Global.GameplayBackground();
			addChild(bg);
			
			//Begin deck generation, count how long it takes
			var startT:int = getTimer();
			
			deck = DeckGeneration.CreateDeck(_lessons);
			opponentDeck = DeckGeneration.CreateOpponentDeck(_lessons);
			
			var endT:int = getTimer() - startT;
			
			// **TEMP** Print stats of deck generation
			Global.console.print("Player's Deck:");
			Global.console.print(deck.toString());
			Global.console.print("\nOpponent's Deck:");
			Global.console.print(opponentDeck.toString());
			Global.console.print("\nDecks generated in: " + endT + " ms.");
			Global.console.toggle();
		}
		
		
	}
}
