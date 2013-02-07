package harry_potter
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import fano.utils.Console;
	import harry_potter.game.Card;
	import harry_potter.assets.Global;
	import harry_potter.events.StartGameEvent;
	
	import com.bit101.components.Style;
	
	
	public class Main extends Sprite {
		//const used for simple custom event, may make into a full custom event later if needed
		public static const END_GAME:String = "end game";
		
		//instances of each screen.
		private var mainMenu:MainMenu;
		private var gameplay:Gameplay;
		
		public var gameLayer:Sprite;
		public var consoleLayer:Sprite;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//Solid color background
			setApplicationBackGround(800, 600, 0x555555);
			
			Style.setStyle(Style.DARK); //Style for the bit101 components
			
			//Load the card library
			var ba:ByteArray = (new Global.CardLibary()) as ByteArray;
			var s:String = ba.readUTFBytes(ba.length);
			Card.library = new XML(s);
			Card.spriteSheet = new Global.CardsSpriteSheet();
			
			//Load the cardback
			Card.cardBack = new BitmapData(48,67);
			Card.cardBack.copyPixels(Card.spriteSheet.bitmapData, new Rectangle(0, 0, 48, 67), new Point(0, 0));
			
			//initialize the layer sprites
			gameLayer = new Sprite();
			consoleLayer = new Sprite();
			//Game layer is on the bottom, console layer is on top so that nothing overlaps it when it is enabled
			addChild(gameLayer);
			addChild(consoleLayer);
			
			//Start at the main menu
			mainMenu = new MainMenu();
			
			gameLayer.addChild(mainMenu);
			mainMenu.addEventListener(StartGameEvent.START_GAME, startGame);
			
			//console, add after menu so it's on top of everything
			Global.console = new Console(this, 0, 0, 400);
			consoleLayer.addChild(Global.console);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, Global.console.toggle);
		}
		
		private function startGame(e:StartGameEvent):void {
			gameLayer.removeChild(mainMenu);
			mainMenu = null; //Remove reference to main menu so that it gets cleaned up by GC
			
			gameplay = new Gameplay(e.lessons);
			gameLayer.addChild(gameplay);
			//gameplay.addEventListener(END_GAME, gameEnd);
			
		}
		/**
		 * Sets the background of the application using a bitmap **USE ONLY ONCE**
		 * @param	width			Width of the application
		 * @param	height			Height of the application
		 * @param	color			Color of the background (0xRRGGBB)
		 */
		private function setApplicationBackGround(width:Number, height:Number, color:uint = 0x000000):void {
			var appBackBitmapData:BitmapData = new BitmapData(width, height, false, color);
			var appBackBitmap:Bitmap = new Bitmap(appBackBitmapData);
			addChild(appBackBitmap);
		}
	}
}