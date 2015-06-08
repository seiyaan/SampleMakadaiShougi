package comas {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;

	public class Ou extends Coma {
		
		[Embed(source='Picture/Normal/ousyou.png')] private static var Pic11:Class;
		[Embed(source='Picture/Nari/jizaitennou.png')] private static var Pic21:Class;
		
		public function Ou(id:int, iX:int, iY:int, iPlayer:Player)
		{
			super(id,iX, iY, iPlayer,"王将","自在天王");
		}
		
		override protected function SetMovingRange() : void  {
			if (_Nari) {
				// 自在王
				
				var cArray:Vector.<Pos> = new Vector.<Pos>();
				
				for each (var c:Coma in _ComaManager.GetComas() ) {
					
					var breakFlag : Boolean = false;
					if( c.GetComaName() == "自在天王" ) breakFlag = true ;
					
						if(c.GetPlayer() != this.GetPlayer()) {
							if( !breakFlag ){
								for each(var p:Pos in c.getMovingRange()){
									cArray.push(p);
								}
							}
						}
					
					var pp:Pos = new Pos(c.GetPosX(),c.GetPosY());
					cArray.push(pp);
				}
				
				for(var i:int = 0 ; i<19 ; i++){
					for(var j:int = 0 ; j<19 ; j++){
						var flag:Boolean = true;
						
						for each(var p2:Pos in cArray){
							if(p2.posX == i && p2.posY == j) flag = false;
						}
						
						if( flag ) {
							AddMovingRange2(i,j);
						}
					}
				}
			}
			else {
				// 王将
				AddMovingRange(1,1);
				AddMovingRange(1,0);
				AddMovingRange(1,-1);
				AddMovingRange(0, 1);
				AddMovingRange(0, -1);
				AddMovingRange(-1, 1);
				AddMovingRange(-1, 0);
				AddMovingRange(-1, -1);
			}
		}
		
		override protected function Remove() : void {
			_ComaManager.RemoveComa(this);
			_ComaManager.FinishedGame(_Player);
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