package com.prms.business.commands.timesheet {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.business.delegates.TimesheetDelegate;
	import com.prms.business.events.timesheet.TimesheetEvent;
	import com.prms.model.TimesheetModelLocator;
	import com.prms.util.Message;
	import com.prms.views.timesheet.admin.AdminTimesheetDetails;
	import com.prms.views.timesheet.admin.AdminTimesheetList;
	import com.prms.vo.Timesheet;

	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class TimesheetCommand implements ICommand {

		private var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
		private var documentAdminTimesheetList:AdminTimesheetList;
		private var documentAdminTimesheetDetails:AdminTimesheetDetails;
		private var vo:Timesheet;

		public function execute(event:CairngormEvent):void {

			switch (event.type) {

				case TimesheetEvent.GET_TIMESHEET_LIST_BY_COMCODE_EVENT:
					var timesheetEvent:TimesheetEvent = TimesheetEvent(event);
					this.documentAdminTimesheetList = AdminTimesheetList(timesheetEvent.param[0]);	// timesheetEvent.param[1] is AdminTimesheetList document
					var responder:Responder = new Responder(getTimesheetListByComCodeResultHandler, getTimesheetListByComCodeFaultHandler);
					var delegate:TimesheetDelegate = new TimesheetDelegate(responder);
					delegate.getTimesheetListByComCode(timesheetEvent.vo);
				break;
			}
		}

		//----------------------------------------------------------------
        // RESULT EVENT HANDLER
        //----------------------------------------------------------------
		/**
		 * 会社選択結果処理
		 * 選択した会社にて社員の勤務表リストを表示
		 * */
		private function getTimesheetListByComCodeResultHandler(event:ResultEvent):void {

		}



        //----------------------------------------------------------------
        // FAULT EVENT HANDLER
        //----------------------------------------------------------------
		/**
		 * 会社選択エラー処理
		 * */
		private function getTimesheetListByComCodeFaultHandler(event:FaultEvent):void {

			// TODO 会社選択ボタンの再表示

		}

        //----------------------------------------------------------------
        // SERVICE FAULT EVENT HANDLER
        //----------------------------------------------------------------
		private function serviceFaultHandler(event:FaultEvent):void {
			Message.showErrorMessage(event);
		}

	}
}