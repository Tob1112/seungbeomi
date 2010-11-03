package com.chronos.air.controller {

	import com.chronos.air.model.MainEvent;
	import com.chronos.air.model.MainModelLocator;
	import com.chronos.air.view.HomeView;

	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class HomeController implements IMXMLObject {

		private var view:HomeView;
		private var model:MainModelLocator = MainModelLocator.getInstance();
		private static const SHOW_ERROR_STATE:String = "showError";

		public function initialized(doc:Object, id:String):void {
			view = doc as HomeView;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompletHandler);
		}

		public function creationCompletHandler(e:FlexEvent):void {
			view.idTextInput.setFocus();
			view.loginButton.addEventListener(MouseEvent.CLICK, loginButtonClickHandler);
		}

		private function loginButtonClickHandler(e:MouseEvent):void {
			model.user.id = view.idTextInput.text;
			model.user.password = view.passwordTextInput.text;

			var event:MainEvent = new MainEvent(MainEvent.LOGIN, view);
			event.dispatch();
		}
	}
}