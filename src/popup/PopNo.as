package popup {
	import flash.events.MouseEvent;

	public class PopNo extends PopYes {
		public function PopNo(parent:PopNariComa, iX:Number, iY:Number, iW:Number, iH:Number)
		{
			super(parent, iX, iY, iW, iH);
		}
		
		override protected function onMouseUp(e:MouseEvent) : void {
			_Parent.PushNarazu();
		}
		
		override protected function SetText() : void {
			tf.text = "NO";
		}
	}
}