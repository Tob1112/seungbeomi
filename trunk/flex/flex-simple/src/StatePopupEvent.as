package
{
	import flash.events.Event;

	public class StatePopupEvent extends Event
	{
		public static const POPUP_TO_MAIN:String = "popupToMain";

		public function StatePopupEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
            super(type, bubbles, cancelable);
		}

	}
}