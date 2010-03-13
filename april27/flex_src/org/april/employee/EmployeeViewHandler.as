package org.april.employee {

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	import org.april.authentication.AuthenticationForm;
	import org.april.model.locator.AuthorizationDataModelLocator;

    public class EmployeeViewHandler implements IMXMLObject {

        private var view:EmployeeView;
        private var model:AuthorizationDataModelLocator = AuthorizationDataModelLocator.getInstance();

        public function initialized(document:Object, id:String):void {
            view = document as EmployeeView;
            view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(e:FlexEvent):void {
        	initComponent();
        }

        public function initComponent():void {
        	if (!model.authorizationData.isAuthorized()) {
				view.employeeView.visible = false;
				view.addChild(new AuthenticationForm());
        	} else {
				view.employeeView.visible = true;
        	}
        }

    }
}