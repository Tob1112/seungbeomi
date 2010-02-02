package com.prms.client.flex.business.events.traffic
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.vo.Traffic;

	public class LoadRegTotalsEvent extends CairngormEvent{
		static public var EVENT_ID:String = "loadRegTotals";
		public var traffic:Traffic;

		public function LoadRegTotalsEvent(traffic:Traffic):void{
			super(EVENT_ID);
			this.traffic = traffic;
		}
	}
}