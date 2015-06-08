package comas {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class Ryuuma extends Coma {
		
		[Embed(source='Picture/Normal/ryuuma.png')] private static var Pic11:Class;
		
		public function Ryuuma(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"竜馬");
		}
		
		override protected function SetMovingRange() : void  {
			var i:int;
				/// 竜馬：斜めに何マスでも動け、縦横に1マス動ける。飛び越えては行けない。
			　for (i = 1; i < 19; i++) {
				　if (!AddMovingRange(i, i)) break;
			　}
			　for (i = 1; i < 19; i++) {
				　if (!AddMovingRange(i, -i)) break;
			　}
			　for (i = 1; i < 19; i++) {
				　if (!AddMovingRange(-i, i)) break;
			　}
			　for (i = 1; i < 19; i++) {
				　if (!AddMovingRange(-i, -i)) break;
			　}
				AddMovingRange(-1, 0);
				AddMovingRange(1, 0);
				AddMovingRange(0, 1);
				AddMovingRange(0, -1);
		}
		
		override protected function SetPicture():void {
			if (_Player == Player.PLAYER) {
				_ComaPicture = new Pic11() as Bitmap;
			}
			else {
				var bmp:BitmapData = new BitmapData(_SizeX,_SizeY,true,0);
				var img:Bitmap = new Bitmap(bmp);
				
				var pic:Bitmap = new Pic11() as Bitmap;
				var mat:Matrix = new Matrix();
				mat.rotate(Math.PI / 180 * 180);
				mat.translate(_SizeX+1,_SizeY+1);
				bmp.draw(pic,mat);
				
				_ComaPicture = img;
			}
		} 
		
		override protected function AvailableNariComa() : Boolean {
			return false;
		}
		
	}
}