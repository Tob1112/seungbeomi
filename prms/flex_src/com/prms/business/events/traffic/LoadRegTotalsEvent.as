package com.prms.business.events.traffic
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.vo.Traffic;

	public class LoadRegTotalsEvent extends CairngormEvent{
		static public var EVENT_ID = "loadRegTotals";
		public var traffic:Traffic;

		public function LoadRegTotalsEvent(){
			super(EVENT_ID);
		}

	}
}