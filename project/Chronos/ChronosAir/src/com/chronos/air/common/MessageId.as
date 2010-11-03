package com.chronos.air.common
{
	import mx.resources.ResourceBundle;

	public class MessageId
	{
		[ResourceBundle("messages")]
		private static var messages:ResourceBundle;

		//public static const SERVER_ACCESS_ERROR:String = getMessage("error.server.access");
		//public static const SYSTEM_ERROR:String = getMessage("error.system");
		public static const SERVER_ACCESS_ERROR:String = "サーバーアクセスにエラーが発生しました。";
		public static const SYSTEM_ERROR:String = "システムエラーが発生しました。";

		private static function getMessage(messageKey:String):String {
			return messages.getString(messageKey);
		}

	}
}