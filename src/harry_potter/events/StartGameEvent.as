package harry_potter.events 
{
	import flash.events.Event;
	
	public class StartGameEvent extends Event {
		
		public static const START_GAME:String = "start game";
		public var lessons:Array;
		
		public function StartGameEvent(type:String, _lessons:Array, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			lessons = _lessons;
		}
		
		override public function clone():Event {
			return new StartGameEvent(type, lessons, bubbles, cancelable);
		}
		
		
	}

}