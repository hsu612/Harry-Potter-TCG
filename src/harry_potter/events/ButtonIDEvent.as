package harry_potter.events 
{
	import flash.events.Event;
	import harry_potter.utils.LessonButton;
	
	public class ButtonIDEvent extends Event {
		
		public static const LESSON_BTN:String = "Lesson button clicked";
		public var buttonRef:LessonButton;
		
		public function ButtonIDEvent(type:String, _buttonRef:LessonButton, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			buttonRef = _buttonRef;
		}
		
		override public function clone():Event {
			return new ButtonIDEvent(type, buttonRef, bubbles, cancelable);
		}
		
		
	}

}