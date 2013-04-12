package harry_potter.assets 
{
	import fano.utils.Console;
	import fano.utils.ToolTip;
	/**
	 * ...
	 * @author Stefano Fiumara
	 */
	public class Global {
		//Main menu elements
		[Embed(source = "../../assets/menu/main_logo.png")] public static const Logo:Class;
		[Embed(source = "../../assets/menu/main_lesson_label.png")] public static const MainLessonLabel:Class;
		[Embed(source = "../../assets/menu/starting_label.png")] public static const StartingLabel:Class;
		
		//Starting characters sprite sheet
		[Embed(source = "../../assets/menu/StartingChars.png")] public static const StartingChars:Class;
		
		//Lesson buttons sprite sheet
		[Embed(source = "../../assets/menu/LessonSelect2.png")] public static const LessonSelect:Class;
		
		//Available Lessons sprite sheet
		[Embed(source = "../../assets/gameplay/AvailableLessons.png")] public static const AvailableLessons:Class;
		//Sprite sheet for the cards
		[Embed(source = "../../assets/sprite_sheets/cards.png")] public static const CardsSpriteSheet:Class;
			
		//Sprites for the deck graphics
		[Embed(source = "../../assets/deck/deck.png")] public static const DeckSpriteSheet:Class;
		
		//Main menu background
		[Embed(source = "../../assets/menu/background_placeholder.png")] public static const MainMenuBG:Class;
		
		//background for the gameplay screen
		[Embed(source = "../../assets/gameplay/game_background.png")] public static const GameplayBackground:Class;
		
		//XML Library of card objects
		[Embed(source = "../game/library.xml", mimeType = "application/octet-stream")] public static const CardLibary:Class;
		
		//Console
		public static var console:Console;
		public static var tooltip:ToolTip;
		
	}

}