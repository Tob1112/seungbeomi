package com.icontact.model.dao
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.icontact.model.domain.Contact;

	public class IContactDaoEvent extends CairngormEvent
	{
		public static const OPEN_DATABASE:String = "openDatabase";
		public static const SAVE_CONTACT:String = "saveContact";
		public static const DELETE_CONTACT:String = "deleteContact";
		public static const GET_MAX_SEQUENCE:String = "getMaxSequence";
		public static const AUTO_COMPLETE:String = "autoComplete";

		public var contact:Contact;
		public var view:Object;

		public function IContactDaoEvent(type:String, view:Object=null, contact:Contact=null):void
		{
			super(type);
			this.view = view;
			this.contact = contact;
		}

	}
}