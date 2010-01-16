package chapter02.section02
{
	import mx.controls.Button;
	import mx.controls.ToggleButtonBar;

	public class CustomToggleButtonBar extends ToggleButtonBar
	{
		private var dataReset:Boolean = false;

		public function CustomToggleButtonBar()
		{
			super();
		}

		override public function set dataProvider(value:Object):void {
			trace("dataProvider " + value[0].mode);
			super.dataProvider = value;
			this.dataReset = true;
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			trace("updateDisplayList");
			super.updateDisplayList(unscaledWidth, unscaledHeight);

			if (this.dataReset) {
				if (selectedIndex != -1) {
					var child:Button;
					child = Button(getChildAt(selectedIndex));
					if (child) {
						trace("child - " + child);
						child.selected = false;
						this.dataReset = false;
					}
				}
			}
		}

	}
}