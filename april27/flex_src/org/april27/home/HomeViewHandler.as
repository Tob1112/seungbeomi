package org.april27.home {

    import flash.events.MouseEvent;

    import mx.core.IMXMLObject;
    import mx.events.FlexEvent;

    import org.april27.model.locator.EmployeeModelLocator;

    //import mx.managers.IFocusManagerComponent;
    import mx.managers.IFocusManagerComponent;

    public class HomeViewHandler implements IMXMLObject {

        private var view:HomeView;
        private var model:EmployeeModelLocator = EmployeeModelLocator.getInstance();

        public function initialized(document:Object, id:String):void {
            view = document as HomeView;
            view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(e:FlexEvent):void {
            view.loginButton.addEventListener(MouseEvent.CLICK, loginHandler);

            IFocusManagerComponent(view.userName).setFocus();
        }

        private function loginHandler(e:MouseEvent):void {
            view.loginButton.enabled = false;

            model.employee.empName = view.userName.text;
            model.employee.password = view.password.text;

            var homeEvent:HomeEvent = new HomeEvent(HomeEvent.AUTHENTICATE_USER, view);
            homeEvent.dispatch();
        }
    }
}
