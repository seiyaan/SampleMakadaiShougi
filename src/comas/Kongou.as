package comas {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	// 高見先生 - 古文書によると金剛は不成
	public class Kongou extends Coma {
		[Embed(source='Picture/Normal/kongou.png')] private static var Pic11:Class;
		
		public function Kongou(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"金剛");
		}
		
		override protected function SetMovingRange() : void  {
			AddMovingRange(3, 0);
			AddMovingRange(-3, 0);
			AddMovingRange(0, 3);
			AddMovingRange(0, -3);
			
			AddMovingRange(-1, 1);
			AddMovingRange(1, 1);
			AddMovingRange(-1, -1);
			AddMovingRange(1, -1);
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
		
		// 不成なのでオーバーライド
		override protected function AvailableNariComa() : Boolean {
			return false;
		}
		
	}
}


/* 
package coma1 {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class Kongou extends Coma {
		[Embed(source='Picture/Normal/kongou.png')] private static var Pic11:Class;
		[Embed(source='Picture/Nari/kinsyou.png')] private static var Pic21:Class;
		
		public function Kongou(iX:int, iY:int, iPlayer:Player)
		{
			super(iX, iY, iPlayer,"金剛","金将");
		}
		
		override protected function SetMovingRange() : void  {
			var i:int;
			for (i = 1; i < 4; i++) {
				if (!AddMovingRange(-i, 0)) break;
			}
			for (i = 1; i < 4; i++) {
				if (!AddMovingRange(i, 0)) break;
			}
			for (i = 1; i < 4; i++) {
				if (!AddMovingRange(0, i)) break;
			}
			for (i = 1; i < 4; i++) {
				if (!AddMovingRange(0, -i)) break;
			}
			AddMovingRange(-1, 1);
			AddMovingRange(1, 1);
			AddMovingRange(-1, -1);
			AddMovingRange(1, -1);
			
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
				// 金剛：縦横に3マス、斜めに1マス動ける。飛び越えては行けない。
				
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(-i, 0)) break;
				}
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(i, 0)) break;
				}
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(0, i)) break;
				}
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(0, -i)) break;
				}
				AddMovingRange(-1, 1);
				AddMovingRange(1, 1);
				AddMovingRange(-1, -1);
				AddMovingRange(1, -1);
				
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
*/