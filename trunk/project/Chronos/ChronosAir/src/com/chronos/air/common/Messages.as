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
		private static const ERROR_MESSAGE_TITLE:String = "CHRONOS エラー";

		private static var instance:Messages = null;

		public static function getInstance():Messages {
			if (instance == null) {
				instance = new Messages();
			}
			return instance;
		}

		public static function showMessage(message:String):void {
			Alert.show(message, MESSAGE_TITLE);
		}

		public static function showError(message:String, e:Error=null):void {
			if (e != null) {
				message = message + "\n原因：" + e.message;
			}
			Alert.show(message, ERROR_MESSAGE_TITLE);
		}

	}
}