package {
	import comas.Coma;
	import flash.display.*;
	import flash.events.*;
	
	public class Board extends Sprite {
		[Embed(source="pic/background.jpg")] private static const P1:Class;
		private static var bgImg:Bitmap = new P1() as Bitmap;
		
		private var _Maps:Vector.<Masu>;
		private var _ComaManager:ComaManager;
		
		public function Board() {
			background();
			
			Masu.SetMasuSize(40, 40);
			Masu.SetMargin(260 , 20);
			Coma.SetMasuSize(Masu.GetMasuSizeX(), Masu.GetMasuSizeY());
			Coma.SetMargin(Masu.GetMarginX(),  Masu.GetMarginY());
			Pos.SetMasuSize(Masu.GetMasuSizeX(), Masu.GetMasuSizeY());
			Pos.SetMargin(Masu.GetMarginX(),  Masu.GetMarginY());
			
			SetBan();
			_ComaManager = new ComaManager();
			addChild(_ComaManager);
		}
		// 盤（マス）を表示
		private function SetBan() : void {
			_Maps = new Vector.<Masu>();
			for (var i:int = 0; i < 19; i++) {
				for (var j:int = 0; j < 19; j++) {
					addChild(_Maps[_Maps.push(new Masu(i, j)) - 1]);
				}
			}
		}
		// 背景表示
		private function background() :void {
			addChild(bgImg);
			bgImg.width = Main.WIDTH;
			bgImg.height = Main.HEIGHT;
		}
		
		public function showEnemyMovableRange():void {
			for each (var c:Coma in _ComaManager.GetComas()) {
				if(c.GetComaName() == "自在天王") continue;
				for each(var p:Pos in c.getMovingRange()){
					if(!c.GetMovableTurn()) {
						p.SetColor(0x00FFFF);
						p.visible = true;
					}
				}
			}
		}
		
		public function hideEnemyMovableRange():void {
			for each (var c:Coma in _ComaManager.GetComas()) {
				for each(var p:Pos in c.getMovingRange()){
					p.visible = false;
				}
			}
		}
	}
}