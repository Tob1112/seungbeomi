package chapter01.section12 {

	import flash.events.Event;

	import mx.containers.Canvas;

	public class CodeBehindComponent extends Canvas {

		public function CodeBehindComponent() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageListener);
		}

		//MXML파일에서 상속을 받아 메소드에 접근해야하므로 protected로 선언
		public function addedToStageListener(e:Event):void {
			trace("addedToStageListener");
		}

		public function clickHandler(e:Event):void {
			trace("clickHandler " + e.target);
		}

	}
}