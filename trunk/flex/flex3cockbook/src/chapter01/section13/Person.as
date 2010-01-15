package chapter01.section13
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	// 모든 객체는 해당 속성이 변경될때 이벤트를 디스패치하고 그 속성위에  Bindable메타데이터 태그를 넣으면 바인딩 가능 속성을 정의할수 있다.
	public class Person extends EventDispatcher
	{
		public static var NAME_CHANGE:String = "nameChange";
		private var _name:String;

		public function Person() {
			trace("create person");
		}

		[Bindable(event=nameChange)]
		public function get name():String {
			trace("get name");
			return _name;
		}

		public function set name(value:String):void {
			trace("set name : " + value);
			_name = value;
			dispatchEvent(new Event(NAME_CHANGE));
		}
	}
}