package com.icontact.model.event {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class IContactEvent extends CairngormEvent {

		public static const LOGIN:String = "login";

		public static const SYNC:String = "sync";

		// DAO events
		public static const CREATE:String = "create";
		public static const UPDATE:String = "update";
		public static const DELETE:String = "delete";

		public var view:Object;

		public function IContactEvent(type:String, view:Object=null) {
			super(type);
			this.view = view;
		}
	}
}