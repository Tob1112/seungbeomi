package org.chronos.air.common
{
	import mx.resources.ResourceBundle;

	public class MessageId
	{
		[ResourceBundle("messages")]
		private static var messages:ResourceBundle;

		//public static const SERVER_ACCESS_ERROR:String = getMessage("error.server.access");
		//public static const SYSTEM_ERROR:String = getMessage("error.system");
		public static const SERVER_ACCESS_ERROR:String 			= "サーバーアクセスにエラーが発生しました。";
		public static const SYSTEM_ERROR:String 				= "システムエラーが発生しました。";
		public static const SQL_ERROR:String					= "SQLエラーが発生しました。";
		public static const LOGIN_ERROR:String 					= "サーバー側に問題がありまして、\n接続ができません。";
		public static const OVER_DATA_FOUND_ERROR:String 		= "複数のデータが検索されました。";
		public static const NOT_FOUND_OPERATION_ERROR:String 	= "操作に過ちがありますので、再度確認してください。";
		public static const DO_NOT_ARCHIVE_ERROR:String 		= "ファイル圧縮に失敗しました。";

		public static const SAVE_SUCCESS:String 				= "正常に保存されました。";
		public static const UPDATE_SUCCESS:String 				= "正常に更新されました。";

		public static const SECURITY_MESSAGE:String 		= "TODO : セキュリティーメッセージ表示！！";

		private static function getMessage(messageKey:String):String {
			return messages.getString(messageKey);
		}

	}
}