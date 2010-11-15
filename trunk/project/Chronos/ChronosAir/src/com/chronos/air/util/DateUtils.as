package com.chronos.air.util {

	import mx.formatters.DateFormatter;

	public class DateUtils {
		private static var dateFormatter:DateFormatter = new DateFormatter();

		public static function formatYYMM(date:Date):String {
			dateFormatter.formatString = "MM-DD";
			return dateFormatter.format(date).toString();
		}
	}
}