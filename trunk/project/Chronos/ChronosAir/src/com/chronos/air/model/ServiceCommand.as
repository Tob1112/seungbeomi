package com.chronos.air.model {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.chronos.Constants;
	import com.chronos.air.common.MessageId;
	import com.chronos.air.common.Messages;
	import com.chronos.air.view.HomeView;
	import com.chronos.air.view.MainView;

	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class ServiceCommand implements ICommand {

			private var model:MainModel = MainModel.getInstance();
			private var homeView:HomeView;
			private var mainView:MainView;

			public function execute(e:CairngormEvent):void {
				var responder:Responder = null;
				var delegate:ServiceDelegate = null;

				switch (e.type) {
				case ServiceEvent.LOGIN:
					homeView = ServiceEvent(e).view as HomeView;
					responder = new Responder(loginResultHandler, loginFaultHandler);
					break;
				case ServiceEvent.LOGOUT:
					mainView = ServiceEvent(e).view as MainView;
					responder = new Responder(logoutResultHandler, serviceFaultHandler);
					delegate = new ServiceDelegate(responder);
					delegate.logout();
					break;
				}
			}

			// PRIVATE METHOD -----------------------------------------------------

			private function loginResultHandler(e:ResultEvent):void {
				//Messages.showMessage(e.result.toString());

				var name:String = e.result.toString();
				if (name != null) {
					// model 設定
					homeView.parentDocument.model.user.name = name;
					model.user.id = "";
					model.user.password = "";
					// view 設定
					homeView.parentDocument.mainViewStack.selectedIndex = Constants.KINMUHYO_VIEWSTACK_INDEX;
					homeView.parentDocument.buttonBar.enabled = true;
					homeView.parentDocument.logoutButton.visible = true;
					homeView.parentDocument.nameLabel.visible = true;
					homeView.loginCanvas.visible = false;
				} else {

				}
				resetLoginField();
			}

			private function loginFaultHandler(e:FaultEvent):void {
				resetLoginField();
			}

			private function logoutResultHandler(e:ResultEvent):void {

			}

			private function serviceFaultHandler(e:FaultEvent):void {
				Messages.showMessage(MessageId.SERVER_ACCESS_ERROR + ":" + e.message);
			}

			private function resetLoginField():void {
				model.user = null;
				homeView.idTextInput.text = "";
				homeView.passwordTextInput.text = "";
				homeView.rememberMeCheckBox.selected = false;
				homeView.idTextInput.setFocus();
			}


		}

	}
