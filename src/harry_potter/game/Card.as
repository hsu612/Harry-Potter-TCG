package harry_potter.game 
{
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import harry_potter.assets.Global;
	import flash.filters.GlowFilter;
	import fano.utils.ToolTip;
	import harry_potter.utils.LessonTypes;
	
	
	/**
	 * ...
	 * @author Stefano Fiumara
	 */
	public class Card extends Sprite {
		/*CLASS VARIABLES*/
		//static variable to hold cardback bitmapdata, which will be used by every instance of Card. Instantiated and loaded in Main.as
		public static var cardBack:BitmapData;
		//card library variables
		public static var library:XML;
		//reference to sprite sheet
		public static var spriteSheet:Bitmap;
		
		//card size
		public static var CARD_WIDTH:uint = 48;
		public static var CARD_HEIGHT:uint = 67;
		
		/*CARD VARIABLES*/
		private var gfx:Bitmap; //Bitmap to hold our card graphic.
		private var gfxData:BitmapData; //Bitmap data reference for this card's graphic.
		
		public var cardName:String; //The title of the card
		public var description:String; //Card description
		public var type:String; //Card type (Creature, Lesson, Spell, etc.)
		public var faceUp:Boolean; //Whether the card is face up or face down.
		public var horizontal:Boolean; //Whether the card is horizontally oriented or not
		public var maxAllowed:uint; //The amount of cards of this of this type allowed in one deck
		
		/*TYPE-SPECIFIC VARIABLES*/
		public var lesson_provides:Array; // [<LESSON_TYPE>, <LESSON_AMOUNT>] i.e. [LessonTypes.CHARMS, 1] for a charms lesson.
		public var lessons_required:Array; // [<LESSON_TYPE>, <LESSON_AMOUNT>] i.e. [LessonTypes.CHARMS, 5], depicting the type of 
										   // lesson required for this card and the amount of total lessons needed to play the card.
		
		//For creatures
		public var damagePerTurn:int;
		public var health:int;
		public var damageWhenPlayed:int;
		public var lessonsToDiscardWhenPlayed:int;
		
		
		
		/**
		 * Creates a basic card object, we may derive from this class later if needed.
		 * @param	_name 		The formal title of the card to be loaded
		 */
		public function Card(_name:String) {
			cardName = _name;
			init();
		}
		
		private function init():void {
			horizontal = false; //all start out this way
			faceUp = false; //start face down
			
			//hand cursor
			useHandCursor = true;
			buttonMode = true;
			
			//get card info from xml
			var xmlData:XMLList = library.Card.(@title == cardName);
			
			//Should only have 1 match
			if (xmlData.length() != 1) {
				throw new Error("Could not find card name OR more than one card name was found (check library.xml)");
			}
			
			//graphics
			var cardX:int = int(xmlData.GFXPosition.x) - 1;
			var cardY:int = int(xmlData.GFXPosition.y) - 1;
			cardX *= CARD_WIDTH; //width of card
			cardY *= CARD_HEIGHT; //height of card
			var sourceRect:Rectangle = new Rectangle(cardX, cardY, CARD_WIDTH, CARD_HEIGHT);
			
			gfxData = new BitmapData(CARD_WIDTH, CARD_HEIGHT);
			gfxData.copyPixels(spriteSheet.bitmapData, sourceRect, new Point(0, 0));
			
			gfx = new Bitmap(cardBack.clone());
			//center the x and y of the bitmap on the container for easy rotation and flipping.
			gfx.x -= gfx.width / 2;
			gfx.y -= gfx.height / 2;
			addChild(gfx);
			
			//Filling the attributes from the XML
			description = String(xmlData.description);
			type = String(xmlData.type);
			maxAllowed = uint(xmlData.maxAllowedInDeck);
			
			//Should we have CardTypes enum? i.e. CardTypes.LESSON, CardTypes.SPELL, etc.?
			switch(type) {
				case "Lesson":
					lesson_provides = new Array(cardName, 1); //cardName also corresponds to lessonType for lessons, every lesson only provides 1 (unless wand shop is played).
					break;
				case "Creature":
					lessons_required = new Array(LessonTypes.CARE_OF_MAGICAL_CREATURES, int(xmlData.numRequiredLessons));
					if (xmlData.lessonsToDiscardWhenPlayed.length() != 0) lessonsToDiscardWhenPlayed = int(xmlData.lessonsToDiscardWhenPlayed);
					damagePerTurn = int(xmlData.damage);
					health = int(xmlData.health);
					damageWhenPlayed = int(xmlData.damageDealtWhenPlayed);
					break;
			}
			
			//Tooltips!
			addEventListener(MouseEvent.MOUSE_OVER, showToolTip);
			addEventListener(MouseEvent.MOUSE_OUT, hideToolTip);
		}
		
		private function showToolTip(e:MouseEvent):void {
			if(faceUp) {
				Global.tooltip.show(this, cardName, description);
				if(this.hasEventListener(MouseEvent.CLICK)) {
					this.filters = [new GlowFilter(0xffffff)];
				}
			}
		}
		private function hideToolTip(e:MouseEvent):void {
			Global.tooltip.hide();
			this.filters = [];
		}
		/**
		 * Switches the bitmapdata of the card face with the bitmapdata of the card back.
		 * @param	e MouseEvent object for testing purposes, can remove this later
		 */
		public function flip(e:MouseEvent = null):void {
			Tweener.addTween(this, { scaleX: 0, time: 0.1, onComplete: switchGFX, transition: "linear" } );
			Tweener.addTween(this, { scaleX: 1, time: 0.1, delay: 0.15, transition: "linear" } );
		}
		
		//Helper for flip function.
		private function switchGFX():void {
			//Here we swap the bitmap graphics mid-tween so it seems like a seamless transition.
			gfx.bitmapData.lock();
			if (faceUp) {
				gfx.bitmapData.copyPixels(cardBack, new Rectangle(0, 0, 48, 67), new Point(0, 0));
			} else {
				gfx.bitmapData.copyPixels(gfxData, new Rectangle(0, 0, 48, 67), new Point(0, 0));
			}
			gfx.bitmapData.unlock();
			
			faceUp = !faceUp;
		}
		
		/**
		 * Rotates the card from the horizontal position to the vertical position.
		 * @param	e MouseEvent object for testing purposes, can be removed later
		 */
		public function rotate(e:MouseEvent = null):void {
			var targetRotation:int;
			
			(horizontal) ? targetRotation = 0 : targetRotation = 90;
			
			Tweener.addTween(this, { rotation: targetRotation, time: 0.2 } );
			horizontal = !horizontal;
		}
	}
}