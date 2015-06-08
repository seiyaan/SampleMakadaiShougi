package comas {
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.display.BitmapData;

	public class Suizou extends Coma {

		[Embed(source='Picture/Normal/suizou.png')] private static var Pic11:Class;
		[Embed(source='Picture/Nari/ouji.png')] private static var Pic21:Class;
		
		public function Suizou(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"膵象","王子");
		}
		
		override protected function SetMovingRange() : void  {
			if (_Nari) {
				// 王子:王将と同じ
				AddMovingRange(1,1);
				AddMovingRange(1,0);
				AddMovingRange(1,-1);
				AddMovingRange(0, 1);
				AddMovingRange(0, -1);
				AddMovingRange(-1, 1);
				AddMovingRange(-1, 0);
				AddMovingRange(-1, -1);
			}
			else {
				// 酔象:真後ろ以外の方向に1マス動ける
				AddMovingRange(1,1);
				AddMovingRange(1,0);
				AddMovingRange(1,-1);
				AddMovingRange(0, 1);
				AddMovingRange(-1, 1);
				AddMovingRange(-1, 0);
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