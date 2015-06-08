package {
	import flash.display.Sprite;

	public class Pos extends Sprite {
		
		private static var _MasuSizeX:Number;
		private static var _MasuSizeY:Number;
		private static var _MarginX:Number;
		private static var _MarginY:Number;
		protected static var _PaddingX:Number = 2;
		protected static var _PaddingY:Number = 2;
		public var posX:int;
		public var posY:int;
		private var color:uint = 0xFFFF00;
		
		public function Pos(iX:int, iY:int)
		{
			posX = iX;
			posY = iY;
			x = posX * _MasuSizeX + _MarginX;
			y = posY * _MasuSizeY + _MarginY;
			
			graphics.beginFill(color, 0.5);	// 動けるマスに着色
			graphics.drawRect(_PaddingX, _PaddingY, _MasuSizeX - _PaddingX * 2, _MasuSizeY - _PaddingY * 2);
			graphics.endFill();
			visible = false;
		}
		
		public function SetColor(color:uint):void
		{
			this.color = color;
			
			graphics.clear();
			graphics.beginFill(color, 0.5);	// 動けるマスに着色
			graphics.drawRect(_PaddingX, _PaddingY, _MasuSizeX - _PaddingX * 2, _MasuSizeY - _PaddingY * 2);
			graphics.endFill();
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