package harry_potter 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import harry_potter.assets.Global;
	
	public class Gameplay extends Sprite {

		public function Gameplay(_lessons:Array) {
			
			//Background image
			/* TO DO:
			 * Add a loading graphic while randomizing the deck, then add the gameplay background and begin the game.
			 */
			var bg:Bitmap = new Global.GameplayBackground();
			addChild(bg);
		}
		
	}

}