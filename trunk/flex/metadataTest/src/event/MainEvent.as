package event
{
	import flash.events.Event;

	public class MainEvent extends Event
	{
		public static const EVENT01:String = "event01";
		public static const EVENT02:String = "event02";

		public function MainEvent(type:String)
		{
			super(type);
			trace("MainEvent type is " + type)
		}

	}
}