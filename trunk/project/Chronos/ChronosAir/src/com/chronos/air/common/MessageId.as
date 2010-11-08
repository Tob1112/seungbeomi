package com.chronos.air.common
{
	import mx.resources.ResourceBundle;

	public class MessageId
	{
		[ResourceBundle("messages")]
		private static var messages:ResourceBundle;

		//public static const SERVER_ACCESS_ERROR:String = getMessage("error.server.access");
		//public static const SYSTEM_ERROR:String = getMessage("error.system");
		public static const SERVER_ACCESS_ERROR:String 		= "サーバーアクセスにエラーが発生しました。";
		public static const SYSTEM_ERROR:String 			= "システムエラーが発生しました。";
		public static const SQL_ERROR:String				= "SQLエラーが発生しました。";
		public static const LOGIN_ERROR:String 				= "入力したidまたはパスワードが\n間違っています。";
		public static const OVER_DATA_FOUND_ERROR:String 	= "複数のデータが検索されました。";
		public static const NOT_FOUND_OPERATION_ERROR:String 	= "操作に過ちがありますので、再度確認してください。";

		public static const SECURITY_MESSAGE:String 		= "TODO : セキュリティーメッセージ表示！！";

		private static function getMessage(messageKey:String):String {
			return messages.getString(messageKey);
		}

	}
}