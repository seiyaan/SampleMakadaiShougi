package popup {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class PopYes extends Sprite {
		
		protected var _Parent:PopNariComa;
		protected var tf:TextField;
		private var tff:TextFormat;
		private var sp:Sprite = new Sprite();
		
		public function PopYes(parent:PopNariComa, iX:Number, iY:Number, iW:Number, iH:Number) {
			addChild(sp);
			_Parent = parent;
			
			x = iX;
			y = iY;
			
			sp.graphics.lineStyle(2, 0xFFFF00);
			sp.graphics.beginFill(0xCCFFFFFF);
			sp.graphics.drawRect(0, 0, iW, iH);
			sp.graphics.endFill();
			
			tff = new TextFormat();
			tff.size = iH;
			tff.color = 0xFF0000;
			tf = new TextField();
			tf.defaultTextFormat = tff;
			tf.x = 0;
			tf.y = 2;
			tf.width = iW;
			tf.selectable = false;
			tf.autoSize = "center";
			SetText();
			addChild(tf);
			
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMosueOut);
		}
		
		private function onMosueOut(e:MouseEvent):void {
			var ct:ColorTransform = new ColorTransform();
			ct.color = 0xFFFFFF;
			sp.transform.colorTransform = ct;
		}
		
		private function onMouseOver(e:MouseEvent):void {
			var ct:ColorTransform = new ColorTransform();
			ct.color = 0xFFFF00;
			sp.transform.colorTransform = ct;
		}
		
		protected function onMouseUp(e:MouseEvent) : void {
			_Parent.PushNari();
		}
		
		protected function SetText() : void {
			tf.text = "YES";
		}
	}
}