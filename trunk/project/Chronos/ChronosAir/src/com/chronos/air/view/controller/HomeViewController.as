package com.chronos.air.view.controller {

	import com.chronos.air.common.MessageId;
	import com.chronos.air.common.Messages;
	import com.chronos.air.event.DAOEvent;
	import com.chronos.air.event.ShinseiServiceEvent;
	import com.chronos.air.model.MainModel;
	import com.chronos.air.view.HomeView;

	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class HomeViewController implements IMXMLObject {

		private var view:HomeView;
		private var model:MainModel = MainModel.getInstance();
		private static const SHOW_ERROR_STATE:String = "showError";

		public function initialized(doc:Object, id:String):void {
			view = doc as HomeView;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompletHandler);
		}

		public function creationCompletHandler(e:FlexEvent):void {
			view.idTextInput.setFocus();
			view.loginButton.addEventListener(MouseEvent.CLICK, loginButtonClickHandler);
			view.rememberMeCheckBox.addEventListener(MouseEvent.CLICK, rememberMeHandler);
		}

		private function loginButtonClickHandler(e:MouseEvent):void {
			var isRememberMe:Boolean = view.rememberMeCheckBox.selected;
			var event:ShinseiServiceEvent;

			model.user.id = view.idTextInput.text;
			model.user.password = view.passwordTextInput.text;
			model.user.rememberMe = view.rememberMeCheckBox.selected;

			// ログイン
			event = new ShinseiServiceEvent(ShinseiServiceEvent.LOGIN, view);
			event.dispatch();
		}

		private function rememberMeHandler(e:MouseEvent):void {
			if (e.currentTarget.selected == true) {
				Messages.showMessage(MessageId.SECURITY_MESSAGE);
			}
		}
	}
}