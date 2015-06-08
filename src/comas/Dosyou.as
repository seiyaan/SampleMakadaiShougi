package comas {
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.display.BitmapData;

	public class Dosyou extends Coma {
		
		[Embed(source='Picture/Normal/dosyou.png')] private static var Pic11:Class;
		[Embed(source='Picture/Nari/hondo.png')] private static var Pic21:Class;
		
		public function Dosyou(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"土将","奔土");
		}
		
		override protected function SetMovingRange() : void  {
			var i:int;
			if (_Nari) {
				// 奔銅:前と後ろに何マスでも動ける。飛び越えては行けない。
				// 誤りである可能性がある
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(0, i)) break;
				}
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(0, -i)) break;
				}
			}
			else {
				// 土将:前と後ろに1マス動ける。仲人と同じ動きになる。
				// 誤りである可能性がある
				AddMovingRange(0, 1);
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