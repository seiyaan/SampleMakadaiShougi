package comas {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;

	public class Banja extends Coma {
		
		[Embed(source='Picture/Normal/banja.png')] private static var Pic11:Class;
		[Embed(source='Picture/Nari/honja.png')] private static var Pic21:Class;
		
		public function Banja(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"蟠蛇","奔蛇");
		}
		
		override protected function SetMovingRange() : void  {
			var i:int;
			if (_Nari) {
				// 奔蛇:縦と斜め下に何マスでも動ける。飛び越えては行けない。
				
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(0, i)) break;
				}
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(i, -i)) break;
				}
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(0, -i)) break;
				}
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(-i, -i)) break;
				}
			}
			else {
				// 蟠蛇:縦と斜め下に1マス動ける。
				AddMovingRange(0, 1);
				AddMovingRange(1, -1);
				AddMovingRange(0, -1);
				AddMovingRange(-1, -1);
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