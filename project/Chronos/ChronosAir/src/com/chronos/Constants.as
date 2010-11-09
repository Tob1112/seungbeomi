package com.chronos
{
	import flash.filesystem.File;

	public class Constants
	{
		public static const SERVICE_REMOTE_OBJECT:String = "chronosRO";

		public static const YEAR_JP:String = "年";
		public static const MONTH_JP:String = "月";
		public static const DATE_JP:String = "日";

		private static const PROJECT_NAME:String = "CHRONOS";
    	private static const SYSTEM_DIRECTORY_NAME:String = "SYSTEM";
    	private static const DATABASE_NAME:String = "chronos.db";

    	public static const HOME_VIEWSTACK_INDEX:int = 0;
		public static const KINMUHYO_VIEWSTACK_INDEX:int = 1;

    	public static const SYSTEM_DIRECTORY_PATH:String = PROJECT_NAME + File.separator + SYSTEM_DIRECTORY_NAME;
    	public static const DATABASE_FILE_PATH:String = SYSTEM_DIRECTORY_PATH + File.separator + DATABASE_NAME;

		public static const JIKOKU_KAISHI_JIKAN:String = "08:00";
		public static const JIKOKU_KANKAKU:Number = 0.25;


	}
}