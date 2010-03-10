package org.april27.security {

	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	import mx.managers.IFocusManagerComponent;

	import org.april27.model.locator.AuthorizationDataModelLocator;

	public class AuthenticationFormHandler implements IMXMLObject{

		private var view:AuthenticationForm;
		private var model:AuthorizationDataModelLocator;

		public function initialized(document:Object, id:String):void {
			view = document as AuthenticationForm;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}

		private function creationCompleteHandler(e:FlexEvent):void {
			view.loginButton.addEventListener(MouseEvent.CLICK, clickLoginButtonHandler);
			IFocusManagerComponent(view.userName).setFocus();
		}

		private function clickLoginButtonHandler(e:MouseEvent):void {
			view.loginButton.enabled = false;

		}
	}
}