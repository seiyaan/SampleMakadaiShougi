package popup {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import comas.Coma;
	
	public class PopNariComa extends Sprite {
		
		private var _ParentComa:Coma;
		
		public function PopNariComa(parentComa:Coma) {
			_ParentComa = parentComa;
			
			x = -Masu.GetMasuSizeX() * 3 / 2;
			y = Masu.GetMasuSizeY() / 3;
			graphics.lineStyle(2, 0xFF0000);
			graphics.drawRect(0, 0, Masu.GetMasuSizeX() * 3, Masu.GetMasuSizeY() * 1.5);
			graphics.endFill();
			
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(6, 4, Masu.GetMasuSizeX() * 3 - 12, Masu.GetMasuSizeY() / 2 - 2);
			graphics.endFill();
			
			var tff:TextFormat = new TextFormat();
			tff.size = Masu.GetMasuSizeX() / 2 - 3;
			tff.color = 0xFF0000;
			var tf:TextField = new TextField();
			tf.defaultTextFormat = tff;
			tf.x = 0;
			tf.y = 4;
			tf.width = Masu.GetMasuSizeX() * 3;
			tf.selectable = false;
			tf.autoSize = "center";
			tf.text = "成りますか？";
			addChild(tf);
			
			addChild(new PopYes(this, 4, Masu.GetMasuSizeY() * 0.75, Masu.GetMasuSizeX() * 1.5 - 8, Masu.GetMasuSizeY() * 0.75 - 4));
			addChild(new PopNo(this, Masu.GetMasuSizeX() * 1.5 + 4, Masu.GetMasuSizeY() * 0.75, Masu.GetMasuSizeX() * 1.5 - 8, Masu.GetMasuSizeY() * 0.75 - 4));
		}
		
		public function PushNari():void {
			_ParentComa.NariComa();
			_ParentComa.CloseNariComa(this);
		}
		
		public function PushNarazu():void {
			_ParentComa.CloseNariComa(this);
		}
	}
}