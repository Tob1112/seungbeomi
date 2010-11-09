package com.chronos.air.util {

	import mx.resources.ResourceBundle;

	public class Logger {


		private static const PRINT_LOG_KEY:String = "pring.log";
		private static var level:String;

		[ResourceBundle("ApplicationResources")]
		private static var resource:ResourceBundle;

		public static function log(message:String):void {
			var isPrintLog:String = resource.getString(PRINT_LOG_KEY).toLowerCase();
			var log:String = message;

			if (isPrintLog == "true") {
				log = message.replace(/\t/g,"").replace(/\n/g, " ");
				trace("[DEBUG] " + log);
			}
		}
	}
}