package org.chronos.air.event {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class ApplicationEvent extends CairngormEvent {

		public static const INITIALIZE_APPLICATION:String = "applicationEvent.initializeApplication";

		public function ApplicationEvent(type:String) {
			super(type);
		}

	}
}