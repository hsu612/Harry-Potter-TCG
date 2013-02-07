package harry_potter.events 
{
	import flash.events.Event;
	import harry_potter.game.Deck;
	
	public class StartGameEvent extends Event {
		
		public static const START_GAME:String = "start game";
		public var playerDeck:Deck;
		public var opponentDeck:Deck;
		
		public function StartGameEvent(type:String, _playerDeck:Deck, _opponentDeck:Deck, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			playerDeck = _playerDeck;
			opponentDeck = _opponentDeck;
		}
		
		override public function clone():Event {
			return new StartGameEvent(type, playerDeck, opponentDeck, bubbles, cancelable);
		}
		
		
	}

}