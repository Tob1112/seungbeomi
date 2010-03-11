package org.april27.employee {

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

    public class EmployeeViewHandler implements IMXMLObject {

        private var view:EmployeeView;

        public function initialized(document:Object, id:String):void {
            view = document as EmployeeView;
            view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(e:FlexEvent):void {
        }

    }
}