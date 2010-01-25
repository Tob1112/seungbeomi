package com.prms.business.commands.timesheet
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.business.delegates.TimesheetDelegate;
	import com.prms.business.events.timesheet.CompareTimesheetEvent;
	import com.prms.model.TimesheetModelLocator;
	import com.prms.util.Message;
	import com.prms.views.timesheet.admin.AdminTimesheetList;

	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class CompareTimesheetCommand implements ICommand
	{
		private var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
		private var doc:AdminTimesheetList;

		public function execute(event:CairngormEvent):void {
			trace("CompareTimesheetCommand");
			var cursor:IViewCursor = this.model.compareTimesheetAC.createCursor();
			while (!cursor.afterLast) {
				trace ("## " + cursor.current.empNo + " - " + cursor.current.comCode + " - " + cursor.current.yyyymm);
				cursor.moveNext();
			}

			this.doc = CompareTimesheetEvent(event).doc;
			var responder:Responder = new Responder(compareTimesheetResultHandler, serviceFaultHandler);
	        var delegate:TimesheetDelegate = new TimesheetDelegate(responder);
		    delegate.compareTimesheet(model.compareTimesheetAC);
		}

		private function compareTimesheetResultHandler(event:ResultEvent):void {
			// サーバーから値を取得
			this.model.compareTimesheetAC = event.result as ArrayCollection;

			//画面コントーロル
			this.doc.datagridTimesheetList.visible = false;
        	this.doc.datagridTimesheetList.width = 0;
        	this.doc.datagridTimesheetList.height = 0;
			this.doc.compareTimesheetHDividedBox.visible = true;
			this.doc.compareTimesheetHDividedBox.percentWidth = 100;
			this.doc.compareTimesheetHDividedBox.percentHeight = 100;
			this.doc.buttonCompareAndBackToList.label = "back to list";
			this.doc.buttonCompareAndBackToList.enabled = true;
    		this.doc.buttonResetDataGridCompareTimesheet.enabled = true;
		}

		private function serviceFaultHandler(event:FaultEvent):void {
			Message.showErrorMessage(event);
		}
	}
}