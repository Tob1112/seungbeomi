package org.april27.employee {

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	import org.april27.authentication.AuthenticationForm;
	import org.april27.model.locator.AuthorizationDataModelLocator;

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
				view.employeeVBox.visible = false;
				view.addChild(new AuthenticationForm());
        	} else {
				view.employeeVBox.visible = true;
        	}
        }

    }
}