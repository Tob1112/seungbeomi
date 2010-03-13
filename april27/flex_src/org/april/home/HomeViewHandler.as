package org.april.home {

    import flash.events.MouseEvent;

    import mx.core.IMXMLObject;
    import mx.events.FlexEvent;

    import org.april.model.locator.EmployeeModelLocator;

    public class HomeViewHandler implements IMXMLObject {

        private var view:HomeView;

        public function initialized(document:Object, id:String):void {
            view = document as HomeView;
            view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(e:FlexEvent):void {

        }

        private function loginHandler(e:MouseEvent):void {

        }
    }
}
