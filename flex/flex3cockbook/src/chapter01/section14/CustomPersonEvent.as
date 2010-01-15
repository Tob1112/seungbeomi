package chapter01.section14
{
	import chapter01.section13.Person;

	import flash.events.Event;

	public class CustomPersonEvent extends Event
	{
		public var person:Person;
		public var timeChanged:String;

		public static var EVENT_ID:String = "eventId";

		public function CustomPersonEvent(type:String, personValue:Person=null, timeValue:String="") {
			super(type);
			person = personValue;
			timeChanged = timeValue;
			trace("constructor");
		}

		//이베트 클래스에서 상속된 clone메소드는 CustomPersonEvent가 스스로를 복제 할 수 있게끔 정의
		override public function clone():Event {
			trace("clone");
			return new CustomPersonEvent(type, person, timeChanged);
		}

	}
}