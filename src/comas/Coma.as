package comas {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.ui.*;
	
	import popup.*;
	
	public class Coma extends Sprite {
		[Embed(source='Picture/empty.png')] protected static var Pic11:Class;
		public var _Id:int = 0;	//ID
		
		protected static var _ComaManager:ComaManager;
		protected static var _SizeX:Number;
		protected static var _SizeY:Number;
		protected static var _MarginX:Number;
		protected static var _MarginY:Number;
		protected static var _IsFinishedGame:Boolean = false;
		
		protected var _NameNormal:String;
		protected var _NameNari:String;
		
		protected var _PosX:int;
		protected var _PosY:int;
		private var _BeforePosX:int;
		private var _BeforePosY:int;
		
		protected var _ComaPicture:Bitmap;
		protected var _Player:Player;
		protected var _Nari:Boolean = false;
		protected var _MoveCountLimit:int = 1; // 1ターンに動かせる回数の制限
		protected var _MovableTurn:Boolean = false;	// 動かせる状態フラグ
		protected var _TurnEndFlag:Boolean; // 駒移動時のターンエンドフラグ
		protected var _MovableRange:Vector.<Pos> = new Vector.<Pos>();
		
		protected var _MovingNow:Boolean = false;
		protected var _WaitingNari:Boolean = false;
		
		public function Coma(id:int, posX:int , posY:int, iPlayer:Player , text:String="歩兵", nariText:String="成らず") {
			_Id = id;
			_Player = iPlayer;
			_NameNormal = text;
			_NameNari = nariText;
			
			_PosX = posX;
			_PosY = posY;
			_BeforePosX = _PosX;
			_BeforePosY = _PosY;
			SetDraw();
			
			SetPicture();
			SetPictureProperty();
			addChild(_ComaPicture);
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseOut(e:MouseEvent) : void {
			if (_IsFinishedGame) return;
			
			for each (var p:Pos in _MovableRange) {
				p.visible = false;
			}
		}
		
		private function onMouseOver(e:MouseEvent) : void {
			if (_IsFinishedGame) return;
			if (!_MovableTurn) return;
			
			for each (var p:Pos in _MovableRange) {
				p.SetColor(0xFF0000); // 動かせる場所の色を変える
				
				// 現在移動中の駒が存在する状況で、他の駒を選択したとき動かせない色にする
				if(_ComaManager.GetMoveCount() > 0 && _ComaManager.GetMovingNow() != this) p.SetColor(0x0000FF);
				p.visible = true;
			}
		}
		
		private function onMouseMoveSocket(e:MouseEvent):void {
			if (!_MovingNow) return;
			x = e.localX;
			y = e.localY;
		}
		
		private function onMouseUpSocket(e:MouseEvent):void {
			if (!_MovingNow) return;
			x = e.localX;
			y = e.localY;
			SetPos(Player.COM);
			SetDraw();
			_MovingNow = false;
		}
		
		private function onMouseUp(e:MouseEvent) : void {
			if (!Main.keys[Keyboard.SHIFT] && (!_MovableTurn || _IsFinishedGame)) return;
			
			stopDrag();
			SetPos(Player.PLAYER);
			SetDraw();
		}
		
		private function onMouseDownSocket(e:MouseEvent):void {
			if (_MovingNow) return;
			if (x-_SizeX/2 > e.localX || e.localX > x+_SizeX/2 || y-_SizeY/2 > e.localY || e.localY > y+_SizeY/2) return;
			_ComaManager.setChildIndex(this, _ComaManager.numChildren - 1);
			_MovingNow = true;
		}
		
		private function onMouseDown(e:MouseEvent) : void {
			if (Main.keys[Keyboard.R]) { // デバッグモード「R」キー
				this.Remove(); // クリックするとその駒を消す
				return;
			}
			
			if (!_MovableTurn || _IsFinishedGame) return; // 自分のターン外か、ゲームが終了している場合
			var temp:Coma = _ComaManager.GetMovingNow(); // 現在のターン内で既に動いている駒
			if(temp != null && temp != this) return; // 1ターンに2回以上動かせる駒が、1回目に動かした駒と違うならば動かせない。
			
			_ComaManager.setChildIndex(this, _ComaManager.numChildren - 1); // 最前面へ
			startDrag();
		}
		
		private function CheckMovable(iX:int, iY:int) : Boolean {
			for each (var p:Pos in _MovableRange) {
				if (iX == p.posX && iY == p.posY) return true;
			}
			return false;
		}
		
		private function SetPos(setter:Player) : void {
			var xx:Number = x;
			var yy:Number = y;
			var aX:int = (xx - _MarginX)/_SizeX;
			var aY:int = (yy - _MarginY)/_SizeY;
			
			if (!Main.keys[Keyboard.SHIFT] && !CheckMovable(aX, aY)) return; // 通常モード & 動ける範囲外
			
			_BeforePosX = _PosX;
			_BeforePosY = _PosY;
			_PosX = aX;
			_PosY = aY;
			
			trace("Set:", _PosX, _PosY);
			
			if(!Main.keys[Keyboard.SHIFT]) SetNomal(setter); // 正常時
			else SetDebug(); // シフトキーデバッグモード
		}
		
		private function SetNomal(setter:Player):void {
			_ComaManager.AddMoveCount(); // 1ターンに動いた回数を増やす
			var aComa:Coma = _ComaManager.CheckHitComa(this);
			_TurnEndFlag = false;
			
			if (aComa != null){ // 移動先に駒があったら
				aComa.Remove(); // 駒を削除
				if(_ComaManager.GetNariMode() == NariMode.IN_ENEMY_FIELD) _TurnEndFlag = true;　// 敵の陣地へ入って成るモードの時、コマをとったら２回動かせる駒でも強制的にターン終了
			}
			
			if (_ComaManager.IsFinishedGame()) { // ゲーム終了フラグが立っていたら
				_ComaManager.ResetMovableTurnAll(null); // ターン終了
				return;
			}
			
			if (CheckNari(aComa)) NariComa(); // 成り処理
			
			if (_ComaManager.GetMoveCount() >= _MoveCountLimit || _TurnEndFlag) { // 1ターンに動かせる回数以上になった、もしくは成った場合
				_ComaManager.ResetMovableTurnAll(_Player); // 相手のターンに切り替える
				_ComaManager.ResetMoveCount(); // 1ターンに動かした回数をリセット
				_ComaManager.SetMovingNow(null); // 移動中駒をクリア
			}
			else {
				_ComaManager.SetMovingNow(this); // 移動中駒にこの駒をセット
			}
			
			_ComaManager.ResetMovableRangeAll(); // 全駒の動ける位置をリセット
		}
		
		private function SetDebug():void {
			var aComa:Coma = _ComaManager.CheckHitComa(this);
			if (aComa != null) { // 移動先に駒があったら
				aComa.Remove(); // 駒を削除
			}
			
			if (CheckNari(aComa)) NariComa(); // 成り処理
			_ComaManager.ResetMovableRangeAll();// 全駒の動ける位置をリセット
		}
		
		private function SetDraw() : void {
			x = _PosX * _SizeX + _SizeX / 2 + _MarginX;
			y = _PosY * _SizeY + _SizeY / 2 + _MarginY;
		}
		
		private function SetPictureProperty() : void {
			_ComaPicture.width = _SizeX;
			_ComaPicture.height = _SizeY;
			_ComaPicture.x = -_SizeX / 2;
			_ComaPicture.y = -_SizeY / 2;
		}
		
		protected function CheckNari(aComa:Coma):Boolean {
			if (_Nari || !AvailableNariComa()) return false;
			if　(_ComaManager.GetNariMode() == NariMode.IN_ENEMY_FIELD)　{　// 敵の陣地へ入った時に成るモードの場合
				var AvailableNariPos:Boolean = (_Player == Player.PLAYER && (_PosY < 6 || _BeforePosY < 6)) || (_Player == Player.COM && (_PosY > 12 || _BeforePosY > 12));
				if　(AvailableNariPos){
					return true;
				}
			}
			else if　(_ComaManager.GetNariMode() == NariMode.BREAK_ENEMY)　{　// 敵の駒を取った時に成るモードの場合
				if　(aComa != null) {
					return true;
				}
			}
			return false;
		}
		
		public function NariComa() : void {
			removeChild(_ComaPicture);
			_Nari = true;
			Nari();
			SetPictureProperty();
			addChild(_ComaPicture);
			if　(this._MoveCountLimit == 1) _TurnEndFlag = true; // もし成った後、動かせる回数が1回の駒に成った場合、ターン終了
		}
		
		private function NariComaSocket(e:Event) : void {
			if (!_WaitingNari) return;
			removeChild(_ComaPicture);
			_Nari = true;
			Nari();
			SetPictureProperty();
			addChild(_ComaPicture);
		}
		
		public function FinishWaitNariComa(e:Event) : void {
			if (!_WaitingNari) return;
			_WaitingNari = false;
			_ComaManager.ResetMovableRangeAll();
			_ComaManager.ResetMovableTurnAll(_Player);
		}
		
		/*
		private function PopUpNariComa() : void {
			
			var aPopNariComa:PopNariComa = new PopNariComa(this);
			addChild(aPopNariComa);
			_ComaManager.ResetMovableAll(null);
		}
		*/
		/*
		public function CloseNariComa(closeComa:PopNariComa) : void {
			removeChild(closeComa);
			_ComaManager.ResetMovingRangeAll();
			_ComaManager.ResetMovableAll(_Player);
		}
		*/
		/*
		public function ShowNariComa() : void {
			removeChild(_ComaPicture);
			SetPicture();
			SetPictureProperty();
			addChild(_ComaPicture);
		}
		*/
		
		public function GetPosX() : int {
			return _PosX;
		}
		
		public function GetPosY() : int {
			return _PosY;
		}
		
		public function GetPlayer() : Player {
			return _Player;
		}
		
		public static function SetComaController(iGameController:ComaManager) : void {
			_ComaManager = iGameController;
		}
		
		public static function SetMasuSize(MasuSizeX:Number, MasuSizeY:Number) : void {
			_SizeX = MasuSizeX;
			_SizeY = MasuSizeY;
		}
		
		public static function SetMargin(MarginX:Number, MarginY:Number) : void {
			_MarginX = MarginX;
			_MarginY = MarginY;
		}
		
		public static function SetFinishedGame() : void {
			_IsFinishedGame = true;
		}
		
		public function ResetMovableTurn(iPlayer:Player) : void {
			if (_Player == iPlayer || iPlayer == null) _MovableTurn = false;
			else _MovableTurn = true;
		}
		
		public function ResetMovableRange() : void {
			for each (var r:Pos in _MovableRange) {
				_ComaManager.removeChild(r);
			}
			_MovableRange = new Vector.<Pos>();
			SetMovingRange();
			for each (var a:Pos in _MovableRange) {
				_ComaManager.addChild(a);
			}
		}
		
		protected function SetMovingRange() : void {
			// Do Nothing
		}
		
		protected function AddMovingRange(iX:int, iY:int) : Boolean {
			var aSubX:int;
			var aSubY:int;
			var aIsOutOfMaps:Boolean;
			var aExistComaPlayer:Player;
			
			aSubX = _PosX + iX;
			if (_Player == Player.PLAYER) aSubY = _PosY - iY;
			else aSubY = _PosY + iY;
			
			aIsOutOfMaps = aSubX < 0 || aSubY < 0 || aSubX > 18 || aSubY > 18;
			
			if (aIsOutOfMaps) return false;
			
			aExistComaPlayer = _ComaManager.ExistComaPlayer(aSubX, aSubY);
			
			if (aExistComaPlayer != null) {
				if (_Player == aExistComaPlayer) {
					return false;
				}
				else {
					_MovableRange.push(new Pos(aSubX, aSubY));
					return false;
				}
			}
			
			_MovableRange.push(new Pos(aSubX, aSubY));
			return true;
		}
		
		protected function AddMovingRange2(iX:int, iY:int) : Boolean {
			var aSubX:int;
			var aSubY:int;
			var aIsOutOfMaps:Boolean;
			var aExistComaPlayer:Player;
			
			aSubX = iX;
			if (_Player == Player.PLAYER) aSubY = iY;
			else aSubY = iY;
			
			aIsOutOfMaps = aSubX < 0 || aSubY < 0 || aSubX > 18 || aSubY > 18;
			
			if (aIsOutOfMaps) return false;
			
			aExistComaPlayer = _ComaManager.ExistComaPlayer(aSubX, aSubY);
			
			if (aExistComaPlayer != null) {
				if (_Player == aExistComaPlayer) {
					return false;
				}
				else {
					_MovableRange.push(new Pos(aSubX, aSubY));
					return false;
				}
			}
			
			_MovableRange.push(new Pos(aSubX, aSubY));
			return true;
		}
		
		
		
		protected function SetPicture() : void {
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
		
		public function GetPicture() : Bitmap {
			return _ComaPicture;
		}
		
		public function GetMovableTurn() : Boolean {
			return _MovableTurn;
		}
		
		public function GetComaName() :String {
			var text:String;
			if( _Nari ){
				text = _NameNari;
			}
			else {
				text = _NameNormal;
			}
			return text;
		}
		
		protected function Nari() : void {
			// Do Nothing
		}
		
		protected function SubMochiComa() : void {
			// Do Nothing
		}
		
		protected function AvailableNariComa() : Boolean {
			return true;
		}
		
		public function getMovingRange() :Vector.<Pos>{
			return _MovableRange;
		}
		
		protected function Remove() :void {
			this.x = -9999;
			this.y = -9999;
			_PosX = -99;
			_PosY = -99;
			_ComaManager.RemoveComa(this);
		}
	}
}