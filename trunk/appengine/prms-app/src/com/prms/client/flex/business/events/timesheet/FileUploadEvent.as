package com.prms.client.flex.business.events.timesheet
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.util.FileLoadWindow;
	import com.prms.client.flex.views.timesheet.user.UserTimesheetDetails;
	import com.prms.client.flex.vo.Timesheet;

	public class FileUploadEvent extends CairngormEvent
	{
		public static const EVENT_ID:String = "fileUploadEvent";
		public var popup:FileLoadWindow;
		public var vo:Timesheet;

		public function FileUploadEvent(popup:FileLoadWindow, vo:Timesheet)
		{
			super(EVENT_ID);
			this.popup = popup;
			this.vo = vo;
		}
	}
}