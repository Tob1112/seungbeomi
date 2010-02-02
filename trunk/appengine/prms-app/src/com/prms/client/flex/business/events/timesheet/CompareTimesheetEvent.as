package com.prms.client.flex.business.events.timesheet
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.views.timesheet.admin.AdminTimesheetList;

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