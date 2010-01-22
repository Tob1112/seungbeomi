package com.prms.business.events.timesheet {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.vo.Timesheet;

	public class TimesheetEvent extends CairngormEvent{

		static public var GET_TIMESHEET_LIST_BY_COMCODE_AND_YYYYMM_EVENT:String = "getTimesheetListByComcodeAndYYYYMMEvent";

		public var vo:Timesheet;
		public var param:Array;

		public function TimesheetEvent(type:String, vo:Timesheet = null, ...args) {
        	super(type);
        	this.vo = vo;

        	for(var i:int=0; i < args.length; i++) {
        		param = new Array();
				this.param[i] = args[i];
        	}
		}
	}
}