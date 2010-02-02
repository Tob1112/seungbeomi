package com.prms.client.flex.business.events.timesheet
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.views.timesheet.admin.AdminTimesheetList;
	import com.prms.client.flex.vo.Timesheet;

	public class GetTimesheetSummaryEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "getTimesheetSummaryEvent";
		public var vo:Timesheet;
		public var doc:AdminTimesheetList;

		public function GetTimesheetSummaryEvent(vo:Timesheet, doc:AdminTimesheetList)
		{
			super(EVENT_ID);
			this.vo = vo;
			this.doc = doc;
		}
	}
}