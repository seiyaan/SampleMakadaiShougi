package {
	import flash.display.Sprite;
	
	public class Masu extends Sprite {
		
		private static var _MasuSizeX:Number;
		private static var _MasuSizeY:Number;
		private static var _MarginX:Number;
		private static var _MarginY:Number;
		private var posX:int;
		private var posY:int;
		
		public function Masu(iX:int, iY:int)
		{
			posX = iX;
			posY = iY;
			x = iX * _MasuSizeX + _MarginX;
			y = iY * _MasuSizeY + _MarginY;
			graphics.lineStyle(2, 0x000000);
			graphics.drawRect(0, 0, _MasuSizeX, _MasuSizeY);
			graphics.endFill();
		}
		
		public function GetPosX() : int {
			return posX;
		}
		
		public function GetPosY() : int {
			return posY;
		}
		
		public static function SetMasuSize(MasuSizeX:Number, MasuSizeY:Number) : void {
			_MasuSizeX = MasuSizeX;
			_MasuSizeY = MasuSizeY;
		}
		
		public static function SetMargin(MarginX:Number, MarginY:Number) : void {
			_MarginX = MarginX;
			_MarginY = MarginY;
		}
		
		public static function GetMasuSizeX() : Number {
			return _MasuSizeX;
		}
		
		public static function GetMasuSizeY() : Number {
			return _MasuSizeY;
		}
		
		public static function GetMarginX() : Number {
			return _MarginX;
		}
		
		public static function GetMarginY() : Number {
			return _MarginY;
		}
	}
}