package com.prms.client.flex.business.commands.timesheet
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.business.delegates.TimesheetDelegate;
	import com.prms.client.flex.business.events.timesheet.GetTimesheetSummaryEvent;
	import com.prms.client.flex.model.TimesheetModelLocator;
	import com.prms.client.flex.util.Message;
	import com.prms.client.flex.views.timesheet.admin.AdminTimesheetList;
	import com.prms.client.flex.vo.Timesheet;

	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class GetTimesheetSummaryCommand implements ICommand
	{
		private var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
		private var vo:Timesheet;
		private var view:AdminTimesheetList;
		private var isShowTimesheetSummary:Boolean;

		public function execute(event:CairngormEvent):void {
			view = GetTimesheetSummaryEvent(event).doc;
			var responder:Responder = new Responder(getTimesheetSummaryResultHandler, serviceFaultHandler);
            var delegate:TimesheetDelegate = new TimesheetDelegate(responder);
            delegate.getTimesheetSummary(GetTimesheetSummaryEvent(event).vo);
		}

		private function getTimesheetSummaryResultHandler(event:ResultEvent):void {
			trace("-- isShowTimesheetSummary : " + isShowTimesheetSummary);
			model.timesheetSummary = Timesheet(event.result);
			this.isShowTimesheetSummary = view.adminTimesheetListsHandler.isShowTimesheetSummary;
			if (!isShowTimesheetSummary) {
				trace("<<< isShowTimesheetSummary : " + isShowTimesheetSummary);
				view.currentState = "expandVboxExtendTimesheet";
				view.adminTimesheetListsHandler.isShowTimesheetSummary = true;
				view.adminTimesheetListsHandler.isTimesheetSummary();
			}
		}

		private function serviceFaultHandler(event:FaultEvent):void {
			Message.showErrorMessage(event);
		}
	}
}