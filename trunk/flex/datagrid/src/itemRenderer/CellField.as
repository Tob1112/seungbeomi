package itemRenderer
{
	import mx.controls.TextInput;
	import mx.controls.dataGridClasses.DataGridListData;

	public class CellField extends TextInput
	{
		public function CellField()
		{
			super();
			height = 60;
			width = 80;
			setStyle("borderStyle","none");
			editable = false;
		}

		override public function set data(value:Object):void {
			super.data = value;
			if(value != null) {
				text = value[DataGridListData(listData).dataField];
				if (Number(text) > 100) {
					setStyle("backgroundColor", 0xFF0000);
				} else {
					// text = "";
				}
				super.invalidateDisplayList();
			}
		}
	}
}