package {
	import comas.Coma;
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	
	[SWF(width = "1280", height="800", backgroundColor = "0xFFFFFF", frameRate="30")]
	
	public class Main extends Sprite {
		// 画面の広さ
		public static const WIDTH:Number = 1280;
		public static const HEIGHT:Number = 800;
		//とりあえずいろいろ
		private var _Maps:Vector.<Masu>;
		private var _ComaManager:ComaManager;
		// 盤＆駒
		protected var _board:Board;
		// フルスクリーンフラグ
		private var FULL_SCREEN_INTERACTIVE:Boolean = false;
		// キーフラグs
		public static var keys:Array = new Array();
		
		public function Main(fs:Boolean=true) {
			// フルスクリーンかどうか
			FULL_SCREEN_INTERACTIVE = fs;
			if( FULL_SCREEN_INTERACTIVE ) {
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
			// レンダリング品質
			stage.quality = StageQuality.BEST;
			// イベント
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			
			// ゲームスタート
			startGame();
		}
		
		// 盤表示＆駒表示：ゲームスタート
		public function startGame():void {
			_board = new Board();
			addChild(_board);
		}
		
		private function onKeyDown(e:KeyboardEvent) : void{
			keys[e.keyCode] = true;
			switch(e.keyCode) {
				case Keyboard.C:
					_board.showEnemyMovableRange(); // 敵の動ける範囲表示
					break;
				case Keyboard.F:
					fullScreen(); // フルスクリーンON/OFF
					break;
				default:
					break;
			}
		}
		
		private function onKeyUp(e:KeyboardEvent) : void{
			keys[e.keyCode] = false;
			switch(e.keyCode) {
				case Keyboard.C:
					_board.hideEnemyMovableRange(); // 敵の動ける範囲非表示
					break;
				default:
					break;
			}
		}
		
		public function fullScreen():void {
			FULL_SCREEN_INTERACTIVE = !FULL_SCREEN_INTERACTIVE;
			if(FULL_SCREEN_INTERACTIVE) stage.displayState = StageDisplayState.NORMAL;
			else stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
	}
}