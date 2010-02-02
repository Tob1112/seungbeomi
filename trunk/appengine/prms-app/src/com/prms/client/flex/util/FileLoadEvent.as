package com.prms.client.flex.util
{
	import flash.events.Event;

	public class FileLoadEvent extends Event
	{
		public static const FILE_UPLOAD_EVENT:String = "fileUploadEvent";
		public static const FILE_SAVE_EVENT:String = "fileSaveEvemt";
		public static const FILE_DOWNLOAD_EVENT:String = "fileDownloadEvent";
		public var fileName:String;

		public function FileLoadEvent(type:String, fileName:String = null)
		{
			super(type);
			this.fileName = fileName;
		}
	}
}