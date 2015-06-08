package comas {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class Kougyou extends Coma {
		
		[Embed(source='Picture/Normal/kougyou.png')] private static var Pic11:Class;
		[Embed(source='Picture/Nari/kinsyou.png')] private static var Pic21:Class;
		
		public function Kougyou(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"鉤行","金将");
		}
		
		override protected function SetMovingRange() : void  {
			var i:int;
			if (_Nari) {
				// 金将
				_MoveCountLimit = 1;	// 1度だけ動かせる駒に修正
				
				AddMovingRange(1, 1);
				AddMovingRange(1, 0);
				AddMovingRange(0, 1);
				AddMovingRange(0, -1);
				AddMovingRange(-1, 1);
				AddMovingRange(-1, 0);
			}
			else {
				// 鉤行:縦横に何マスでも動け、途中で左右どちらにでも90度曲がってさらに何マスでも動ける。曲がらなくてもよい。飛び越えては行けない。
				// 飛車の動きを1回又は2回できるということである。
				
				_MoveCountLimit = 2;	// 2度動かせる駒です
				
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(0, i)) break;
				}
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(0, -i)) break;
				}
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(i, 0)) break;
				}
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(-i, 0)) break;
				}
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