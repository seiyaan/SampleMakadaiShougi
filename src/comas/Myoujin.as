package comas {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;

	public class Myoujin extends Coma {
		
		[Embed(source='Picture/Normal/nekomata.png')] private static var Pic11:Class;
		[Embed(source='Picture/Nari/honmyou.png')] private static var Pic21:Class;
		
		public function Myoujin(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"猫叉","奔猫");
		}
		
		override protected function SetMovingRange() : void  {
			var i:int;
			if (_Nari) {
				// 奔猫:角行と同じ。
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
			}
			else {
				// 猫刄:斜めに1マス動ける。
				AddMovingRange(1, 1);
				AddMovingRange(-1, 1);
				AddMovingRange(1, -1);
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