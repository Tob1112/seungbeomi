package com.prms.business.events.timesheet
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.views.timesheet.admin.AdminTimesheetList;

	public class CompareTimesheetEvent extends CairngormEvent
	{
		public static var EVENT_ID:String = "compareTimesheetEvent";

		public var doc:AdminTimesheetList;

		public function CompareTimesheetEvent(doc:AdminTimesheetList):void
		{
			super(EVENT_ID);
			this.doc = doc;
		}

	}
}