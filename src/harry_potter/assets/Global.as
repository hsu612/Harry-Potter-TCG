package harry_potter.assets 
{
	import fano.utils.Console;
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
		[Embed(source = "../../assets/menu/LessonSelect.png")] public static const LessonSelect:Class;
		
		//Library of card objects
		[Embed(source = "../game/library.xml", mimeType = "application/octet-stream")] public static const CardLibary:Class;
		
		//Sprite sheet for the cards
		[Embed(source = "../../assets/sprite_sheets/cards.png")] public static const CardsSpriteSheet:Class;
		
		//Main menu background
		[Embed(source = "../../assets/menu/background_placeholder.png")] public static const MainMenuBG:Class;
		
		//background for the gameplay screen
		[Embed(source = "../../assets/gameplay/game_background.png")] public static const GameplayBackground:Class;
		
		
		//System font
		[Embed(systemFont="Arial", 
		fontName = "fontArial", 
		mimeType = "application/x-font", 
		fontWeight="normal", 
		fontStyle="normal", 
		unicodeRange="U+0020-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E", 
		advancedAntiAliasing="true", 
		embedAsCFF="false")]
		public static const Arial:Class;
		
		//Console
		public static var console:Console;
	}

}