package com.prms.client.flex.business.commands.timesheet
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.business.delegates.TimesheetDelegate;
	import com.prms.client.flex.business.events.timesheet.CompareTimesheetEvent;
	import com.prms.client.flex.model.TimesheetModelLocator;
	import com.prms.client.flex.util.Message;
	import com.prms.client.flex.views.timesheet.admin.AdminTimesheetList;

	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class CompareTimesheetCommand implements ICommand
	{
		private var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
		private var view:AdminTimesheetList;

		public function execute(event:CairngormEvent):void {
			view = CompareTimesheetEvent(event).doc;
			var responder:Responder = new Responder(compareTimesheetResultHandler, serviceFaultHandler);
	        var delegate:TimesheetDelegate = new TimesheetDelegate(responder);
		    delegate.compareTimesheet(model.compareTimesheetAC);
		}

		private function compareTimesheetResultHandler(event:ResultEvent):void {
			// サーバーから値を取得
			this.model.compareTimesheetAC = event.result as ArrayCollection;

			//画面コントーロル
			view.adminTimesheetListsHandler.afterCompareTimesheet();
			//view.adminTimesheetListsHandler.isCompare = true;
		}

		private function serviceFaultHandler(event:FaultEvent):void {
			Message.showErrorMessage(event);
		}
	}
}