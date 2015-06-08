package {
	import comas.*;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;

	public class ComaManager extends Sprite {
		[Embed(source="pic/win.png")] private static const PicWin:Class;
		[Embed(source="pic/lose.png")] private static const PicLose:Class;
		
		private var _Coma:Vector.<Coma> = new Vector.<Coma>();
		private var _IsFinishedGame:Boolean = false;
		
		private var _MoveCount:int = 0;		// 1ターンで駒が何回動くか
		private var _MovingNow:Coma = null;	// Comaクラスの一時的なTemp
		private var _NariMode:NariMode;
		
		private var _Maro:Maro = new Maro();	// 麻呂
		
		public function ComaManager() {
			Coma.SetComaController(this);
			SetAllComas();
			ResetMovableRangeAll();
			ResetMovableTurnAll(Player.COM);
			SetNariMode(NariMode.IN_ENEMY_FIELD);		// 0:敵陣地へ入った時,1:敵の駒を取った時
			addChild(_Maro);	// 左右の麻呂を表示
		}
		
		// リムーブ処理
		public function RemoveComa(iComa:Coma) : void {
			removeChild(iComa);
			_Coma.splice(_Coma.indexOf(iComa), 1);
			iComa = null;
		}
		
		public function CheckHitComa(iComa:Coma) : Coma {
			for each (var c:Coma in _Coma) 
			{
				if (c != iComa && c.GetPosX() == iComa.GetPosX() && c.GetPosY() == iComa.GetPosY()) return c;
			}
			return null;
		}
		
		public function ExistComaPlayer(iX:int, iY:int) : Player {
			for each (var c:Coma in _Coma) {
				if (c.GetPosX() == iX && c.GetPosY() == iY) return c.GetPlayer();
			}
			return null;
		}
		
		public function ResetMovableRangeAll() : void {
			for each (var c:Coma in _Coma) 
			{
				c.ResetMovableRange();
			}
		}
		
		
		// ターンを切り替えます
		public function ResetMovableTurnAll(iPlayer:Player) : void {
			for each (var c:Coma in _Coma) {
				c.ResetMovableTurn(iPlayer);
			}
			Player.changePlayer(iPlayer);
			_Maro.ChangeMaro();
		}
		
		// ゲーム終了、勝ち負け判定
		public function FinishedGame(iPlayer:Player) : void {
			_IsFinishedGame = true;
			Coma.SetFinishedGame();
			
			var image:Bitmap;
			
			if (iPlayer == Player.PLAYER) {
				image = new PicLose() as Bitmap;
			}
			else {
				image = new PicWin() as Bitmap;
			}
			
			addChild(image);
			image.x = Main.WIDTH/2 - image.width/2;
			image.y = Main.HEIGHT/2 - image.height/2;
			image.alpha = 1.0;
			
		}
		
		public function IsFinishedGame() : Boolean {
			return _IsFinishedGame;
		}
		
		public function AddMoveCount():void {
			_MoveCount++;
		}
		
		public function ResetMoveCount():void {
			_MoveCount = 0;
		}
		
		public function GetMoveCount():int {
			return _MoveCount;
		}
		
		public function GetNariMode() :NariMode {
			return _NariMode;
		}
		
		public function GetComas() :Vector.<Coma> {
			return _Coma;
		}
		
		public function GetMovingNow():Coma {
			return _MovingNow;
		}
		
		public function SetMovingNow(coma:Coma):void {
			_MovingNow = coma;
		}
		
		private function SetNariMode(mode:NariMode) :void {
			_NariMode = mode;
		}
		
		////// 駒の動き
		//// 7段目 --------------------------------------------------------
		// 仲人
		private function SetChunin(id:int):void { 
			addChild(_Coma[_Coma.push(new Chuunin(id, 5, 6, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Chuunin(id, 13, 6, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Chuunin(id, 5, 12, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Chuunin(id, 13, 12, Player.PLAYER)) - 1]);
		}
		
		//// 6段目 --------------------------------------------------------
		// 歩
		private function SetFu(id:int):void {
			var fu:Fu;
			for (var i:int = 0; i < 19; i++) {
				addChild(_Coma[_Coma.push(new Fu(id, i, 5, Player.COM)) - 1]);
			}
			for (var j:int = 0; j < 19; j++) {
				addChild(_Coma[_Coma.push(new Fu(id, j, 13, Player.PLAYER)) - 1]);
			}
		}
		
		//// 5段目 --------------------------------------------------------
		// 飛車
		private function SetHisha(id:int):void {
			addChild(_Coma[_Coma.push(new Hisya(id, 0, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Hisya(id, 18, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Hisya(id, 0, 14, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Hisya(id, 18, 14, Player.PLAYER)) - 1]);
		}
		
		//左車
		private function SetSasha(id:int):void {
			addChild(_Coma[_Coma.push(new Sasya(id, 17, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Sasya(id, 1, 14, Player.PLAYER)) - 1]);
		}
		
		// 右車
		private function SetUsha(id:int):void {
			addChild(_Coma[_Coma.push(new Usya(id, 1, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Usya(id, 17, 14, Player.PLAYER)) - 1]);
		}
		
		// 横行
		private function SetOugyou(id:int):void {
			addChild(_Coma[_Coma.push(new Ougyou(id, 16, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Ougyou(id, 2, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Ougyou(id, 16, 14, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Ougyou(id, 2, 14, Player.PLAYER)) - 1]);
		}
		
		// 横飛
		private function SetOuhi(id:int):void {
			addChild(_Coma[_Coma.push(new Ouhi(id, 15, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Ouhi(id, 3, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Ouhi(id, 15, 14, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Ouhi(id, 3, 14, Player.PLAYER)) - 1]);
		}
		
		// 竪行
		private function SetShugyou(id:int):void {
			addChild(_Coma[_Coma.push(new Syugyou(id, 14, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Syugyou(id, 4, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Syugyou(id, 14, 14, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Syugyou(id, 4, 14, Player.PLAYER)) - 1]);
		}
		
		// 角行
		private function SetKaku(id:int):void{
			addChild(_Coma[_Coma.push(new Kakugyou(id, 5, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Kakugyou(id, 13, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Kakugyou(id, 5, 14, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Kakugyou(id, 13, 14, Player.PLAYER)) - 1]);
		}
		
		// 竜馬
		private function SetRyuma(id:int):void {
			addChild(_Coma[_Coma.push(new Ryuuma(id, 12, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Ryuuma(id, 6, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Ryuuma(id, 12, 14, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Ryuuma(id, 6, 14, Player.PLAYER)) - 1]);
		}
		
		// 龍王
		private function SetRyuou(id:int):void {
			addChild(_Coma[_Coma.push(new Ryuuou(id, 11, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Ryuuou(id, 7, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Ryuuou(id, 11, 14, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Ryuuou(id, 7, 14, Player.PLAYER)) - 1]);
		}
		
		// 摩羯
		private function SetMakatu(id:int):void {
			addChild(_Coma[_Coma.push(new Makatu(id, 10, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Makatu(id, 8, 14, Player.PLAYER)) - 1]);
		}
		
		// 奔王
		private function SetHonnou(id:int):void {
			addChild(_Coma[_Coma.push(new Honnou(id, 9, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Honnou(id, 9, 14, Player.PLAYER)) - 1]);
		}
		
		// 鉤行
		private function SetKougyou(id:int):void {
			addChild(_Coma[_Coma.push(new Kougyou(id, 8, 4, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Kougyou(id, 10, 14, Player.PLAYER)) - 1]);
		}
		
		//// 4段目 --------------------------------------------------------
		// 驢馬
		private function SetRoba(id:int):void {
			addChild(_Coma[_Coma.push(new Roba(id, 0, 3, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Roba(id, 18, 3, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Roba(id, 0, 15, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Roba(id, 18, 15, Player.PLAYER)) - 1]);
		}
		
		// 桂馬
		private function SetKeima(id:int):void {
			addChild(_Coma[_Coma.push(new Keima(id, 2, 3, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Keima(id, 16, 3, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Keima(id, 2, 15, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Keima(id, 16, 15, Player.PLAYER)) - 1]);
		}
		
		// 猛牛
		private function SetMougyuu(id:int):void {
			addChild(_Coma[_Coma.push(new Mougyuu(id, 4, 3, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Mougyuu(id, 14, 3, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Mougyuu(id, 4, 15, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Mougyuu(id, 14, 15, Player.PLAYER)) - 1]);
		}
		
		// 飛龍
		private function SetHiryuu(id:int):void {
			addChild(_Coma[_Coma.push(new Hiryuu(id, 6, 3, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Hiryuu(id, 12, 3, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Hiryuu(id, 6, 15, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Hiryuu(id, 12, 15, Player.PLAYER)) - 1]);
		}
		
		// 羅刹
		private function SetRasetu(id:int):void {
			addChild(_Coma[_Coma.push(new Rasetsu(id, 11, 3, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Rasetsu(id, 7, 15, Player.PLAYER)) - 1]);
		}
		
		// 力士
		private function SetRikishi(id:int):void {
			addChild(_Coma[_Coma.push(new Rikishi(id, 10, 3, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Rikishi(id, 8, 15, Player.PLAYER)) - 1]);
		}
		
		// 狛犬
		private function SetKomainu(id:int):void {
			addChild(_Coma[_Coma.push(new Komainu(id, 9, 3, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Komainu(id, 9, 15, Player.PLAYER)) - 1]);
		}
		
		// 金剛
		private function SetKonngou(id:int):void {
			addChild(_Coma[_Coma.push(new Kongou(id, 8, 3, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Kongou(id, 10, 15, Player.PLAYER)) - 1]);
		}
		
		// 夜叉
		private function SetYasha(id:int):void {
			addChild(_Coma[_Coma.push(new Yasya(id, 7, 3, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Yasya(id, 11, 15, Player.PLAYER)) - 1]);
		}
		
		//// 3段目 --------------------------------------------------------
		// 老鼠
		private function SetRouso(id:int):void {
			addChild(_Coma[_Coma.push(new Rouso(id, 1, 2, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Rouso(id, 17, 2, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Rouso(id, 1, 16, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Rouso(id, 17, 16, Player.PLAYER)) - 1]);
		}
		
		// 嗔猪
		private function SetShincho(id:int):void {
			addChild(_Coma[_Coma.push(new Shincho(id, 3, 2, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Shincho(id, 15, 2, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Shincho(id, 3, 16, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Shincho(id, 15, 16, Player.PLAYER)) - 1]);
		}
		
		// 盲熊
		private function SetMouyuu(id:int):void {
			addChild(_Coma[_Coma.push(new Mouyuu(id, 5, 2, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Mouyuu(id, 13, 2, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Mouyuu(id, 5, 16, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Mouyuu(id, 13, 16, Player.PLAYER)) - 1]);
		}
		
		// 悪狼
		private function SetAkurou(id:int):void {
			addChild(_Coma[_Coma.push(new Akurou(id, 7, 2, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Akurou(id, 11, 2, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Akurou(id, 7, 16, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Akurou(id, 11, 16, Player.PLAYER)) - 1]);
		}
		
		// 麒麟
		private function SetKirin(id:int):void {
			addChild(_Coma[_Coma.push(new Kirin(id, 10, 2, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Kirin(id, 8, 16, Player.PLAYER)) - 1]);
		}
		
		// 獅子
		private function SetShishi(id:int):void {
			addChild(_Coma[_Coma.push(new Shishi(id, 9, 2, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Shishi(id, 9, 16, Player.PLAYER)) - 1]);
		}
		
		// 鳳凰
		private function SetHouou(id:int):void {
			addChild(_Coma[_Coma.push(new Houou(id, 8, 2, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Houou(id, 10, 16, Player.PLAYER)) - 1]);
		}
		
		//// 2段目 --------------------------------------------------------
		// 反車
		private function SetHensha(id:int):void {
			addChild(_Coma[_Coma.push(new Hensya(id, 0, 1, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Hensya(id, 18, 1, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Hensya(id, 0, 17, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Hensya(id, 18, 17, Player.PLAYER)) - 1]);
		}
		
		// 猫刄
		private function SetMyoujin(id:int):void {
			addChild(_Coma[_Coma.push(new Myoujin(id, 2, 1, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Myoujin(id, 16, 1, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Myoujin(id, 2, 17, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Myoujin(id, 16, 17, Player.PLAYER)) - 1]);
		}
		
		// 淮鶏
		private function SetWaikei(id:int):void {
			addChild(_Coma[_Coma.push(new Waikei(id, 14, 1, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Waikei(id, 4, 17, Player.PLAYER)) - 1]);
		}
		
		// 蟠蛇
		private function SetBanja(id:int):void {
			addChild(_Coma[_Coma.push(new Banja(id, 12, 1, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Banja(id, 6, 17, Player.PLAYER)) - 1]);
		}
		
		// 猛豹
		private function SetMouhyou(id:int):void {
			addChild(_Coma[_Coma.push(new Mouhyou(id, 7, 1, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Mouhyou(id, 11, 1, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Mouhyou(id, 7, 17, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Mouhyou(id, 11, 17, Player.PLAYER)) - 1]);
		}
		
		// 盲虎
		private function SetMouko(id:int):void {
			addChild(_Coma[_Coma.push(new Mouko(id, 8, 1, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Mouko(id, 10, 1, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Mouko(id, 8, 17, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Mouko(id, 10, 17, Player.PLAYER)) - 1]);
		}
		
		// 酔象
		private function SetSuizou(id:int):void {
			addChild(_Coma[_Coma.push(new Suizou(id, 9, 1, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Suizou(id, 9, 17, Player.PLAYER)) - 1]);
		}
		
		// 臥龍
		private function SetGaryuu(id:int):void {
			addChild(_Coma[_Coma.push(new Garyuu(id, 6, 1, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Garyuu(id, 12, 17, Player.PLAYER)) - 1]);
		}
		
		// 古猿
		private function SetKoen(id:int):void {
			addChild(_Coma[_Coma.push(new Koen(id, 4, 1, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Koen(id, 14, 17, Player.PLAYER)) - 1]);
		}
		
		//// 1段目 --------------------------------------------------------
		// 香車
		private function SetKasha(id:int):void {
			addChild(_Coma[_Coma.push(new Kyousya(id, 0, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Kyousya(id, 18, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Kyousya(id, 0, 18, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Kyousya(id, 18, 18, Player.PLAYER)) - 1]);
		}
		
		// 土将
		private function SetDoshou(id:int):void {
			addChild(_Coma[_Coma.push(new Dosyou(id, 1, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Dosyou(id, 17, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Dosyou(id, 1, 18, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Dosyou(id, 17, 18, Player.PLAYER)) - 1]);
		}
		
		// 石将
		private function SetSekishou(id:int):void {
			addChild(_Coma[_Coma.push(new Sekishou(id, 2, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Sekishou(id, 16, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Sekishou(id, 2, 18, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Sekishou(id, 16, 18, Player.PLAYER)) - 1]);
		}
		
		// 瓦将
		private function SetGashou(id:int):void {
			addChild(_Coma[_Coma.push(new Gasyou(id, 3, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Gasyou(id, 15, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Gasyou(id, 3, 18, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Gasyou(id, 15, 18, Player.PLAYER)) - 1]);
		}
		
		// 鉄将
		private function SetTetsushou(id:int):void {
			addChild(_Coma[_Coma.push(new Tetsusyou(id, 4, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Tetsusyou(id, 14, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Tetsusyou(id, 4, 18, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Tetsusyou(id, 14, 18, Player.PLAYER)) - 1]);
		}
		
		// 銅将
		private function SetDoushou(id:int):void {
			addChild(_Coma[_Coma.push(new Dousyou(id, 5, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Dousyou(id, 13, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Dousyou(id, 5, 18, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Dousyou(id, 13, 18, Player.PLAYER)) - 1]);
		}
		
		// 銀将
		private function SetGin(id:int):void {
			addChild(_Coma[_Coma.push(new Ginsyou(id, 6, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Ginsyou(id, 12, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Ginsyou(id, 6, 18, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Ginsyou(id, 12, 18, Player.PLAYER)) - 1]);
		}
		
		// 金将
		private function SetKin(id:int):void {
			addChild(_Coma[_Coma.push(new Kinsyou(id, 7, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Kinsyou(id, 11, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Kinsyou(id, 7, 18, Player.PLAYER)) - 1]);
			addChild(_Coma[_Coma.push(new Kinsyou(id, 11, 18, Player.PLAYER)) - 1]);
		}
		
		// 提婆
		private function SetDaiba(id:int):void {
			addChild(_Coma[_Coma.push(new Daiba(id, 10, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Daiba(id, 8, 18, Player.PLAYER)) - 1]);
		}
		
		// 無明 	
		private function SetMumyou(id:int):void {
			addChild(_Coma[_Coma.push(new Mumyou(id, 8, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Mumyou(id, 10, 18, Player.PLAYER)) - 1]);
		}
		
		// 王将
		private function SetTaishou(id:int):void {
			addChild(_Coma[_Coma.push(new Ou(id, 9, 0, Player.COM)) - 1]);
			addChild(_Coma[_Coma.push(new Ou(id, 9, 18, Player.PLAYER)) - 1]);
		}
		
		// 全ての駒を配置させます
		private function SetAllComas():void {
			
			// 7段目
			SetChunin(1);
			
			// 6段目
			SetFu(2);
			
			// 5段目
			SetHisha(3);
			SetSasha(4);
			SetUsha(5);
			SetOugyou(6);
			SetOuhi(7);
			SetShugyou(8);
			SetKaku(9);
			SetRyuma(10);
			SetRyuou(11);
			SetMakatu(12);
			SetHonnou(13);
			SetKougyou(14);
			
			// 4段目
			SetRoba(15);
			SetKeima(16);		// 古文書
			SetMougyuu(17);
			SetHiryuu(18);	// 古文書
			SetRasetu(19);	// 古文書？
			SetRikishi(20);	// 古文書
			SetKomainu(21);	// 古文書
			SetKonngou(22);	// 古文書
			SetYasha(23);		// 古文書
			
			// 3段目
			SetRouso(24);
			SetShincho(25);
			SetMouyuu(26);
			SetAkurou(27);
			SetKirin(28);
			SetShishi(29);
			SetHouou(39);
			
			// 2段目
			SetHensha(31);
			SetMyoujin(32);
			SetWaikei(33);
			SetBanja(34);
			SetMouhyou(35);
			SetMouko(36);
			SetSuizou(37);
			SetGaryuu(38);
			SetKoen(39);
			
			// 1段目
			SetKasha(40);
			SetDoshou(41);
			SetSekishou(42);
			SetGashou(43);
			SetDoushou(44);
			SetTetsushou(45);
			SetGin(46);
			SetKin(47);
			SetDaiba(48);
			SetMumyou(49);
			SetTaishou(50);
		}
	}
}