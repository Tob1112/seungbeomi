package org.april.authentication {

	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	import org.april.model.locator.AuthorizationDataModelLocator;

	public class AuthenticationFormHandler implements IMXMLObject{

		private var view:AuthenticationForm;
		private var model:AuthorizationDataModelLocator = AuthorizationDataModelLocator.getInstance();

		public function initialized(document:Object, id:String):void {
			view = document as AuthenticationForm;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}

		private function creationCompleteHandler(e:FlexEvent):void {
			view.loginButton.addEventListener(MouseEvent.CLICK, clickLoginButtonHandler);
			//IFocusManagerComponent(view.userName).setFocus();
		}

		private function clickLoginButtonHandler(e:MouseEvent):void {
			view.loginButton.enabled = false;
			model.authorizationData.username = view.username.text;
			model.authorizationData.password = view.password.text;

			var authenticationEvent:AuthenticationEvent = new AuthenticationEvent(AuthenticationEvent.AUTHENTICATE_USER, view);
			authenticationEvent.dispatch();

		}
	}
}