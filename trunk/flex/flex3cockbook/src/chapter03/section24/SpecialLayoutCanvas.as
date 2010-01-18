package chapter03.section24
{
	import flash.events.MouseEvent;

	import mx.containers.Canvas;
	import mx.controls.Label;
	import mx.core.UIComponent;

	public class SpecialLayoutCanvas extends Canvas //implements IConstraintLayout
	{
		private var titlelable:Label;
		private var selectedlabel:Label;
		private var _isSelected:Boolean = false;

		public function SpecialLayoutCanvas()
		{
			super();
			titlelable = new Label();
			addChild(titlelable);
			titlelable.text = "label";
			this.addEventListener(MouseEvent.MOUSE_DOWN, setIsSeclected);
			minHeight = 45;
			minWidth = 80;
			selectedlabel = new Label();
			//addChild(selectedlabel);
			selectedlabel.text = "selected";
		}

		private function setIsSeclected(e:MouseEvent):void {
			_isSelected ? isSelected = false : isSelected = true;
		}

		public function set isSelected(value:Boolean):void {
			_isSelected = value;
			if(isSelected) {
				addChild(selectedlabel);
				selectedlabel.y = 30;
			} else {
				try {
					removeChild(selectedlabel);
				} catch (err:Error) {
					if (parent != null) {
						(parent as UIComponent).invalidateDisplayList();
					}
				}
			}
		}
		public function get isSelected():Boolean {
			return _isSelected;
		}
	}
}