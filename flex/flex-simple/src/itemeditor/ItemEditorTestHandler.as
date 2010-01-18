package itemeditor
{
	import mx.controls.ComboBox;

	public class ItemEditorTestHandler
	{
		public var document:Object;
		public var empNo:String;

		public function ItemEditorTestHandler(type:String, document:Object)
		{
			this.document = document;
			switch(type) {
				case ItemEditorTestEvent.COMBOBOX_CLOSE:
					changeValue();
					break;
			}
		}

		private function changeValue():void {
			empNo = ComboBox(document).selectedItem['data'];
			trace("empNo - " + empNo);


		}

	}
}