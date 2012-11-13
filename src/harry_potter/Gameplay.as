package harry_potter 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import harry_potter.assets.Global;
	
	public class Gameplay extends Sprite {

		public function Gameplay() {
			//Background image
			var bg:Bitmap = new Global.GameplayBackground();
			addChild(bg);
		}
		
	}

}