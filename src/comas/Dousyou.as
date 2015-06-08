package comas {
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.display.BitmapData;

	public class Dousyou extends Coma {
		
		[Embed(source='Picture/Normal/dousyou.png')] private static var Pic11:Class;
		[Embed(source='Picture/Nari/hondou.png')] private static var Pic21:Class;
		
		public function Dousyou(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"銅将","奔銅");
		}
		
		override protected function SetMovingRange() : void  {
			var i:int;
			if (_Nari) {
				// 奔銅:縦と斜め前に何マスでも動ける。飛び越えては行けない。
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(i, i)) break;
				}
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(0, i)) break;
				}
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(-i, i)) break;
				}
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(0, -i)) break;
				}
			}
			else {
				// 銅将:縦と斜め前に1マス動ける。
				AddMovingRange(1, 1);
				AddMovingRange(0, 1);
				AddMovingRange(-1, 1);
				AddMovingRange(0, -1);
			}
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
		
		override protected function Nari():void {
			if (_Player == Player.PLAYER) {
				_ComaPicture = new Pic21() as Bitmap;
			}
			else {
				var bmp:BitmapData = new BitmapData(_SizeX,_SizeY,true,0);
				var img:Bitmap = new Bitmap(bmp);
				
				var pic:Bitmap = new Pic21() as Bitmap;
				var mat:Matrix = new Matrix();
				mat.rotate(Math.PI / 180 * 180);
				mat.translate(_SizeX+1,_SizeY+1);
				bmp.draw(pic,mat);
				
				_ComaPicture = img;
			}
		} 
	}
}