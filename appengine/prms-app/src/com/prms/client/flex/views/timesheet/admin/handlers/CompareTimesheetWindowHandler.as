package com.prms.client.flex.views.timesheet.admin.handlers
{
	import com.prms.client.flex.model.TimesheetModelLocator;
	import com.prms.client.flex.client.flex.views.timesheet.admin.CompareTimesheetWindow;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;

	public class CompareTimesheetWindowHandler implements IMXMLObject
	{
		private var view:CompareTimesheetWindow;
		[Bindable] public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();

		public function initialized(doc:Object, id:String):void {
			view = doc as CompareTimesheetWindow;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			view.addEventListener(CloseEvent.CLOSE, closeWindowHandler);
		}

		private function creationCompleteHandler(event:Event):void {
			view.closeCompareTimesheetButton.addEventListener(MouseEvent.CLICK, closeWindowHandler);

			//view.compareTimesheetDataGrid.dataProvider = model.compareTimesheetAC;
		}

		private function closeWindowHandler(event:*):void {
			PopUpManager.removePopUp(view);
		}
	}
}