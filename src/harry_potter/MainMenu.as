package harry_potter 
{
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import fano.utils.ToolTip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import harry_potter.events.StartGameEvent;
	
	import harry_potter.assets.Global;
	import harry_potter.utils.MenuCharacterDisplay;
	import harry_potter.utils.LessonButton;
	import harry_potter.utils.LessonTypes;
	import harry_potter.utils.MessageWindow;
	import harry_potter.events.ButtonIDEvent;
	import harry_potter.game.Card;
	
	/**
	 * ...
	 * @author Stefano Fiumara
	 */
	public class MainMenu extends Sprite {
		
		private static const BUTTON_X_OFFSET:int = 260;
		private static const BUTTON_X_SPACING:int = 65;
		private static const BUTTON_Y_OFFSET:int = 395;
		
		private static const SELECTION_LABEL_X:int = 248;
		private static const SELECTION_LABEL_Y:int = 425;
		
		private static const STARTING_LABEL_X:int = 248;
		private static const STARTING_LABEL_Y:int = 480;
		
		private static const MAIN_LESSON_X:int = 373;
		private static const MAIN_LESSON_SPACING_X:int = 65;
		private static const MAIN_LESSON_Y:int = 455;
		
		private static const MAIN_CHARACTER_DISPLAY_X:int = 425;
		private static const MAIN_CHARACTER_DISPLAY_Y:int = 469;
		
		//holds references to our lesson buttons
		private var LessonButtons:Array;
		
		private var selectedLessons:Array;
		
		//Simple class to display starting character based on main lesson
		private var mainCharDisplay:MenuCharacterDisplay;
		
		//references for our imported graphics
		private var background:Bitmap;
		private var logo:Bitmap;
		private var lessonLabel:Bitmap;
		private var startingLabel:Bitmap;
		
		//we'll use a minimal comp for the begin button for now.
		private var beginBtn:PushButton;
		
		public function MainMenu() {
			init();
		}
		
		private function init():void {
			background = new Global.MainMenuBG();
			addChild(background);
			//For simplicity we've made the logo and instructions in a png file
			logo = new Global.Logo();
			addChild(logo);
			
			//add labels here
			lessonLabel = new Global.MainLessonLabel();
			lessonLabel.x = SELECTION_LABEL_X;
			lessonLabel.y = SELECTION_LABEL_Y;
			addChild(lessonLabel);
			
			startingLabel = new Global.StartingLabel();
			startingLabel.x = STARTING_LABEL_X;
			startingLabel.y = STARTING_LABEL_Y;
			addChild(startingLabel);
			
			//Add the lesson buttons
			LessonButtons = new Array();
			for (var i:int = 0; i < 5; i++) {
				var nextBtn:LessonButton = new LessonButton(this, BUTTON_X_OFFSET + (i * BUTTON_X_SPACING), BUTTON_Y_OFFSET, i);
				nextBtn.addEventListener(ButtonIDEvent.LESSON_BTN, buttonClicked);
				LessonButtons.push(nextBtn);
				addChild(nextBtn);
			}
			
			selectedLessons = new Array();
			
			//Add the starting character display
			mainCharDisplay = new MenuCharacterDisplay(this);
			mainCharDisplay.x = MAIN_CHARACTER_DISPLAY_X;
			mainCharDisplay.y = MAIN_CHARACTER_DISPLAY_Y;
			addChild(mainCharDisplay);
			
			//begin button placeholder
			beginBtn = new PushButton(this, 350, 550, "Begin Game", startGame);
			
		}
		
		private function startGame(e:MouseEvent):void {
			//here we would build the randomized deck by parsing the card library xml and creating proper deck structures
			//we'll then fire off our custom START_GAME event and pass in the deck and starting character references to the main class
			//the main class will delete the reference to the main menu and add an instance of the Gameplay screen class to the stage
			//and pass control to it until we hear the GAME_OVER event.
			
			// TODO
			/*
			 * Finish writing library.xml
			 * Begin work on random deck generation
			 * Implement gameplay (lessons first, like before)
			 * 
			 */
			
			//Tell main that start game was clicked, make sure the player has chosen enough lessons and that the deck was generated successfully! 
			//(or maybe generate the deck in the gameplay class!)
			if (selectedLessons.length >= 2) {
				//TO DO: send the selectedLessons array to the gameplay class
				dispatchEvent(new StartGameEvent(StartGameEvent.START_GAME, selectedLessons));
			} else {
				new MessageWindow(this, "Hold on!", "Please choose at least 2 lessons before starting, single type decks \nare easily countered!");
			}
		}
		
		private function buttonClicked(e:ButtonIDEvent):void {
			var btn:LessonButton = e.buttonRef;
			
			if (!btn.selected) {
				if(selectedLessons.length >= 3) {
					Global.console.print("You have already selected 3 lesson types!");
					//TO DO: Print an actual error message to the user?
					return;
				}

				btn.selected = true;
				selectedLessons.push(btn.lessonType);
				
				//check if this is the main lesson being selected
				if (selectedLessons.length > 1) {
					//if it isn't, add the regular glowFilter
					btn.filters = [new GlowFilter(0xFFFF00)];
				}
				else {
					//otherwise, add a special GlowFilter and show the proper main character
					btn.filters = [new GlowFilter(0xFFFFFF, 1, 9, 9, 3)];
					mainCharDisplay.switchChar(btn.lessonType);
				}
				
				//set x and y values
				btn.x = MAIN_LESSON_X + ((selectedLessons.length - 1) * MAIN_LESSON_SPACING_X);
				btn.y = MAIN_LESSON_Y;
			} 
			else {
				btn.selected = false;
				btn.filters = [];
				
				//remove the lesson from the selected list
				var numLessons:int = selectedLessons.length - 1;
				for (var i:int = numLessons; i >= 0; i--) {
					if (selectedLessons[i] == btn.lessonType) {
						//set the x and y back to normal coordinates
						btn.x = BUTTON_X_OFFSET + (btn.lessonType * BUTTON_X_SPACING);
						btn.y = BUTTON_Y_OFFSET;
						selectedLessons.splice(i, 1);
					}
				}
				
				//use a for loop to move both buttons if there are more than 1
				var otherLessons:int = selectedLessons.length;
				for (var j:int = 0; j < otherLessons; j++) {
					var newBtn:LessonButton = LessonButtons[selectedLessons[j]];
					//adjust the glow filter for the new main lesson
					if (j == 0) {
						newBtn.filters = [new GlowFilter(0xFFFFFF, 1, 9, 9, 3)];
						mainCharDisplay.switchChar(newBtn.lessonType);
					}
					newBtn.x = MAIN_LESSON_X + (j * MAIN_LESSON_SPACING_X);
				}
				
				//if no lessons are left selected, switch the char display back to cardback
				if (otherLessons == 0) {
					mainCharDisplay.switchChar(MenuCharacterDisplay.CARDBACK);
				}
			}
		}
	}
}