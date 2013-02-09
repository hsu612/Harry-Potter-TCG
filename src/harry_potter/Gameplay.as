package harry_potter 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import harry_potter.game.Card;
	import harry_potter.game.Player;
	
	import harry_potter.assets.Global;
	import harry_potter.game.Deck;
	import harry_potter.utils.LessonTypes;
	import harry_potter.utils.DeckGeneration;
	
	import caurina.transitions.Tweener;
	
	public class Gameplay extends Sprite {
		
		private var player:Player;
		private var opponentDeck:Deck;
		
		public function Gameplay(_playerDeck:Deck, _opponentDeck:Deck) {
			
			/* TO DO:
				* Begin coding graphics for the deck class
			 */
			//Background image
			var bg:Bitmap = new Global.GameplayBackground();
			addChild(bg);
			
			player = new Player(_playerDeck);
			addChild(player);
			/*
			 * Test Code Below
			 */
			var player2:Player = new Player(_opponentDeck);
			
			player2.x = 800;
			player2.y = 600;
			player2.rotation = 180;
			addChild(player2);			
			
		}
	}
}
