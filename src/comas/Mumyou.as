package comas {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;

	public class Mumyou extends Coma {
		
		[Embed(source='Picture/Normal/mumyou.png')] private static var Pic11:Class;
		[Embed(source='Picture/Nari/housei.png')] private static var Pic21:Class;
		
		public function Mumyou(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"無明","法性");
		}
		
		override protected function SetMovingRange() : void  {
			var i:int , j:int;
			
			if (_Nari) {
				// 法性:獅子の動きに加え、全方向に何マスでも動ける。このとき飛び越えては行けない[2]。
				for (i = -2; i < 3; i++) {
					for(j = -2; j < 3; j++){
						AddMovingRange(i, j);
					}
				}
				
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
					if (!AddMovingRange(i, 0)) break;
				}
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(-i, 0)) break;
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
				// 無明:斜め前、右、斜め左後ろに1マス動ける[1]。
				AddMovingRange(1, 1);
				AddMovingRange(-1, 1);
				AddMovingRange(1, 0);
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