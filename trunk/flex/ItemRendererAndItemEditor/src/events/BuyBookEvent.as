package events
{
	import flash.events.Event;

	public class BuyBookEvent extends Event
	{
		public static const BUY_BOOK:String = "buyBook";
		
		public function BuyBookEvent(type:String = BUY_BOOK, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var bookData:Object;
		
	}
}