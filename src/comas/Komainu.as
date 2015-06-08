package comas {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class Komainu extends Coma {
		
		[Embed(source='Picture/Normal/komainu.png')] private static var Pic11:Class;
		[Embed(source='Picture/Nari/kinsyou.png')] private static var Pic21:Class;
		
		public function Komainu(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"狛犬","金将");
		}
		
		override protected function SetMovingRange() : void  {
			if (_Nari) {
				// 金将
				AddMovingRange(1, 1);
				AddMovingRange(1, 0);
				AddMovingRange(0, 1);
				AddMovingRange(0, -1);
				AddMovingRange(-1, 1);
				AddMovingRange(-1, 0);
			}
			else {
				// 狛犬
				AddMovingRange(1, 0);
				AddMovingRange(2, 0);
				AddMovingRange(3, 0);
				
				AddMovingRange(1, 1);
				AddMovingRange(2, 2);
				AddMovingRange(3, 3);
				
				AddMovingRange(0, 1);
				AddMovingRange(0, 2);
				AddMovingRange(0, 3);
				
				AddMovingRange(1, -1);
				AddMovingRange(2, -2);
				AddMovingRange(3, -3);
				
				AddMovingRange(0, -1);
				AddMovingRange(0, -2);
				AddMovingRange(0, -3);
				
				AddMovingRange(-1, -1);
				AddMovingRange(-2, -2);
				AddMovingRange(-3, -3);

				AddMovingRange(-1, 0);
				AddMovingRange(-2, 0);
				AddMovingRange(-3, 0);

				AddMovingRange(-1, 1);
				AddMovingRange(-2, 2);
				AddMovingRange(-3, 3);
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