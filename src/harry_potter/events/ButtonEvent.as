package harry_potter.events 
{
	import flash.events.Event;
	import harry_potter.utils.LessonButton;
	
	public class ButtonEvent extends Event {
		
		public static const LESSON_BTN:String = "Lesson button clicked";
		public var buttonRef:LessonButton;
		
		public function ButtonEvent(type:String, _buttonRef:LessonButton, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			buttonRef = _buttonRef;
		}
		
		override public function clone():Event {
			return new ButtonEvent(type, buttonRef, bubbles, cancelable);
		}
		
		
	}

}