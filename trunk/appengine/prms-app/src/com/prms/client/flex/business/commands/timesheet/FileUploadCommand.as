package com.prms.client.flex.business.commands.timesheet {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.business.delegates.TimesheetDelegate;
	import com.prms.client.flex.business.events.timesheet.FileUploadEvent;
	import com.prms.client.flex.model.TimesheetModelLocator;
	import com.prms.client.flex.util.FileLoadWindow;
	import com.prms.client.flex.util.Message;
	import com.prms.client.flex.vo.Timesheet;

	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class FileUploadCommand implements ICommand {

		private var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
		private var popup:FileLoadWindow;
		private var vo:Timesheet;

		public function execute(event:CairngormEvent):void {
			popup = FileUploadEvent(event).popup;
			vo = FileUploadEvent(event).vo;

			var responder:Responder = new Responder(fileUploadResultHandler, serviceFaultHandler);
	        var delegate:TimesheetDelegate = new TimesheetDelegate(responder);
		    delegate.fileUpload(vo);
		}

		private function fileUploadResultHandler(event:ResultEvent):void {
			var vo:Timesheet = event.result as Timesheet;
			model.previewTimesheet = vo;
			popup.currentState = "previewUpload";
			PopUpManager.centerPopUp(popup);
			CursorManager.removeBusyCursor();
		}

		private function serviceFaultHandler(event:FaultEvent):void {
			Message.showErrorMessage(event);
			CursorManager.removeBusyCursor();
		}

	}
}