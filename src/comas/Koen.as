package comas {
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.display.BitmapData;

	public class Koen extends Coma {
		
		[Embed(source='Picture/Normal/koen.png')] private static var Pic11:Class;
		[Embed(source='Picture/Nari/sanbo.png')] private static var Pic21:Class;
		
		public function Koen(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"古猿","山母");
		}
		
		override protected function SetMovingRange() : void  {
			var i:int;
			if (_Nari) {
				// 山母:後ろと斜めに何マスでも動け、前に1マス動ける。飛び越えては行けない[2]。
				
				AddMovingRange(0, 1);
				
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(-i, i)) break;
				}
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(i, i)) break;
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
				// 古猿:斜めと後ろに1マス動ける[1]。
				AddMovingRange(-1, 1);
				AddMovingRange(1, 1);
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