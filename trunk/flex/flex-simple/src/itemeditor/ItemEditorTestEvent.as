package itemeditor
{
	import flash.events.Event;

	public class ItemEditorTestEvent extends Event
	{
		public static const COMBOBOX_CLOSE = "comboboxClose";
		public var document:Object;
		public var handler:ItemEditorTestHandler;

		public function ItemEditorTestEvent(type:String, document:Object)
		{
			super(type);
			this.document = document;
			handler = new ItemEditorTestHandler(type, document);
		}

	}
}