package {
	import flash.display.Sprite;
	
	public class Player extends Sprite{
		public static const PLAYER:Player = new Player();
		public static const COM:Player = new Player();
		private static var _Player:Player = Player.PLAYER;
		
		public static function getPlayer():Player {
			return _Player;
		}
		
		public static function changePlayer(isPlayer:Player):void {
			if(isPlayer == PLAYER) _Player = Player.COM;
			else _Player = Player.PLAYER;
		}
	}
}