package com.chronos.air.common
{
	import mx.controls.Alert;

	[Bindable]
	public class Messages
	{
		public var type:String;
		public var id:String;
		public var body:String;

		private static const MESSAGE_TITLE:String = "CHRONOS";

		private static var instance:Messages = null;

		public static function getInstance():Messages {
			if (instance == null) {
				instance = new Messages();
			}
			return instance;
		}

		public static function showMessage(messageId:String):void {
			Alert.show(messageId, MESSAGE_TITLE);
		}
	}
}