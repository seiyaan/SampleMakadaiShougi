package comas {
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.display.BitmapData;

	public class Houou extends Coma {
		
		[Embed(source='Picture/Normal/houou.png')] private static var Pic11:Class;
		//[Embed(source='Picture/Nari/kinshi.png')] private static var Pic21:Class;
		[Embed(source='Picture/Nari/honou.png')] private static var Pic21:Class;
		
		public function Houou(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"鳳凰","奔王"/*"金翅"*/);
		}
		
		override protected function SetMovingRange() : void  {
			var i:int;
			if (_Nari) {
				// 金翅:縦に何マスでも行け、斜めに3マス、横に2マスまで行ける。飛び越えては行けない
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(0, i)) break;
				}
				for (i = 1; i < 19; i++) {
					if (!AddMovingRange(0, -i)) break;
				}
				
				for (i = 1; i < 3; i++) {
					if (!AddMovingRange(i, 0)) break;
				}
				for (i = 1; i < 3; i++) {
					if (!AddMovingRange(-i, 0)) break;
				}
				
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(i, i)) break;
				}
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(-i, i)) break;
				}
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(i, -i)) break;
				}
				for (i = 1; i < 4; i++) {
					if (!AddMovingRange(-i, -i)) break;
				}
			}
			else {
				// 鳳凰:縦横に1マスだけ動け、斜めに2マス先に飛び越えて移動できる[2]。
				AddMovingRange(2, 2);
				AddMovingRange(-2, 2);
				AddMovingRange(2, -2);
				AddMovingRange(-2, -2);
				
				AddMovingRange(0, 1);
				AddMovingRange(0, -1);
				AddMovingRange(1, 0);
				AddMovingRange(-1, 0);
				
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