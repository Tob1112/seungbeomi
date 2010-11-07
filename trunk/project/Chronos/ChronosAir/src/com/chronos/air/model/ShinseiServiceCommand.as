package com.chronos.air.model {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.chronos.Constants;
	import com.chronos.air.common.MessageId;
	import com.chronos.air.common.Messages;
	import com.chronos.air.event.DAOEvent;
	import com.chronos.air.event.ShinseiServiceEvent;
	import com.chronos.air.view.HomeView;
	import com.chronos.air.view.MainView;

	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class ShinseiServiceCommand implements ICommand {

			private var mainModel:MainModel = MainModel.getInstance();
			private var homeView:HomeView;
			private var mainView:MainView;

			public function execute(e:CairngormEvent):void {
				var responder:Responder = null;
				var delegate:ShinseiServiceDelegate = null;

				switch (e.type) {
					case ShinseiServiceEvent.LOGIN:	// ログイン
						homeView = ShinseiServiceEvent(e).view as HomeView;
						responder = new Responder(loginResultHandler, loginFaultHandler);
						delegate = new ShinseiServiceDelegate(responder);
						delegate.login(mainModel.user);
						break;
					case ShinseiServiceEvent.LOGOUT:	// ログアウト
						mainView = ShinseiServiceEvent(e).view as MainView;
						logoutHandler();
						//responder = new Responder(logoutResultHandler, serviceFaultHandler);
						//delegate = new ShinseiServiceDelegate(responder);
						//delegate.logout();
						break;
				}
			}

			// PRIVATE METHOD -----------------------------------------------------

			private function loginResultHandler(e:ResultEvent):void {
				var isRememberMe:Boolean = homeView.rememberMeCheckBox.selected;
				var daoEvent:DAOEvent;

				var name:String = e.result.toString();
				// リータン値がある場合
				if (name != null) {
					// remember me チェックした場合、ユーザー情報をDBに保存
					if (isRememberMe) {
						daoEvent = new DAOEvent(DAOEvent.SAVE_USER);
						daoEvent.dispatch();
					} else {
						daoEvent = new DAOEvent(DAOEvent.REMOVE_USER);
						daoEvent.dispatch();
					}

					// model 設定
					homeView.parentDocument.model.user.name = name;
					mainModel.user.id = "";
					mainModel.user.password = "";
					// view 設定
					homeView.parentDocument.mainViewStack.selectedIndex = Constants.KINMUHYO_VIEWSTACK_INDEX;
					homeView.parentDocument.buttonBar.enabled = true;
					homeView.parentDocument.logoutButton.visible = true;
					homeView.parentDocument.nameLabel.visible = true;
					homeView.loginCanvas.visible = false;
				// リータン値がない場合
				} else {
					resetLoginField();
				}
			}

			/** ログイン失敗時 */
			private function loginFaultHandler(e:FaultEvent):void {
				resetLoginField();
				homeView.currentState = "showError";
				homeView.errorText.text = MessageId.LOGIN_ERROR;
			}

			/** ログアウト */
			private function logoutHandler():void {
				mainView.mainViewStack.selectedIndex = Constants.HOME_VIEWSTACK_INDEX;
				mainView.homeView.loginCanvas.visible = true;
				mainView.logoutButton.visible = false;
				mainView.buttonBar.enabled = false;
				// TODO データ初期化
				mainView.model.user.name = "";
				mainView.homeView.idTextInput.text = "";
				mainView.homeView.passwordTextInput.text = "";
				mainView.homeView.rememberMeCheckBox.selected = false;


			}
			/*
			private function logoutResultHandler(e:ResultEvent):void {
				resetLoginField();
			}
			*/

			/** サービス失敗 */
			private function serviceFaultHandler(e:FaultEvent):void {
				Messages.showMessage(MessageId.SERVER_ACCESS_ERROR + ":" + e.message);
			}

			private function resetLoginField():void {
				mainModel.user.reset();
				homeView.idTextInput.text = "";
				homeView.passwordTextInput.text = "";
				homeView.rememberMeCheckBox.selected = false;
				homeView.idTextInput.setFocus();
			}


		}

	}
