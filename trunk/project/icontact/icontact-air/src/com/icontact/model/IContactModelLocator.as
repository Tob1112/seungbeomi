package com.icontact.model {

	import com.icontact.Constants;
	import com.icontact.model.domain.Contact;
	import com.icontact.model.domain.User;
	import com.icontact.model.event.IContactEvent;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import mx.collections.ArrayCollection;

	[Bindable]
	public class IContactModelLocator {

		public var sequence:int;
		public var user:User = new User();
		public var contact:Contact = new Contact();
		public var contactAC:ArrayCollection = new ArrayCollection();
		public var autocompleteText:String;
		public static var syncTimer:Timer = new Timer(Constants.SYNC_TIME);

		private static var instance:IContactModelLocator = null;

		public static function getInstance():IContactModelLocator {
			if (instance == null) {
				instance = new IContactModelLocator();
				syncTimer.addEventListener(TimerEvent.TIMER, syncHandler);
			}
			return instance;
		}

		private static function syncHandler(e:TimerEvent):void {
			trace(e.target.currentCount + " second");

			var icontactEvent:IContactEvent = new IContactEvent(IContactEvent.SYNC);
			icontactEvent.dispatch();
		}
	}
}