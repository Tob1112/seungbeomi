package org.flora.view.events {

	import flash.events.Event;

	public class LeafStateChangeEvent extends Event{

		// LEAF STATES
		public static var MINIMIZE:String = "minimize";
		public static var RESTORE:String = "restore";
		public static var MENU_EXPAND:String = "menu_expand";

		public function LeafStateChangeEvent(type:String) {
			super(type);

			trace("LeafStateChangeEvent type : " + type);
		}
	}
}