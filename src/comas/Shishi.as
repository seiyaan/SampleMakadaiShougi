package comas {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	// 高見先生 - 古文書によると金剛は不成
	public class Shishi extends Coma {
		
		[Embed(source='Picture/Normal/shishi.png')] private static var Pic11:Class;
		//[Embed(source='Picture/Nari/hunjin.png')] private static var Pic21:Class;
		
		public function Shishi(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"師子"/*,"奮迅"*/);
		}
		
		override protected function SetMovingRange() : void  {
			var i:int, j:int;
			
			_MoveCountLimit = 2;	// 2度動かせる駒です
			
			AddMovingRange(1,1);
			AddMovingRange(1,0);
			AddMovingRange(1,-1);
			AddMovingRange(0, 1);
			AddMovingRange(0, -1);
			AddMovingRange(-1, 1);
			AddMovingRange(-1, 0);
			AddMovingRange(-1, -1);
			
			/*
			if (_Nari) {
				// 奮迅:獅子の動きに加え、全ての方向に3マスまで動くことも出来る。このとき飛び越えては行けない[1]。
				// ルール要確認
				
				_MoveCountLimit = 2;
				
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(i, i)) break;
				}
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(i, -i)) break;
				}
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(-i, i)) break;
				}
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(-i, -i)) break;
				}
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(0, i)) break;
				}
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(0, -i)) break;
				}
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(i, 0)) break;
				}
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(-i, 0)) break;
				}
			}
			else {
				// 獅子:1手で王将の動きが2回までできる。
				
				_MoveCountLimit = 2;	// 2度動かせる駒です
				
				AddMovingRange(1,1);
				AddMovingRange(1,0);
				AddMovingRange(1,-1);
				AddMovingRange(0, 1);
				AddMovingRange(0, -1);
				AddMovingRange(-1, 1);
				AddMovingRange(-1, 0);
				AddMovingRange(-1, -1);
			}
			*/
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
		
		/*
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
		*/
		
	}
}