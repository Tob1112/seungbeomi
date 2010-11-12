package com.chronos.air.model {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.chronos.Constants;
	import com.chronos.air.common.MessageId;
	import com.chronos.air.common.Messages;
	import com.chronos.air.event.DAOEvent;
	import com.chronos.air.event.ShinseiServiceEvent;
	import com.chronos.air.view.HomeView;
	import com.chronos.air.view.KinmuhyoView;
	import com.chronos.air.view.MainView;

	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class ShinseiServiceCommand implements ICommand {

			private var appModel:ApplicationModel = ApplicationModel.getInstance();
			private var kinmuhyoModel:KinmuhyoModel = KinmuhyoModel.getInstance();
			private var homeView:HomeView;
			private var mainView:MainView;
			private var kinmuhyoView:KinmuhyoView;

			public function execute(e:CairngormEvent):void {
				var responder:Responder = null;
				var delegate:ShinseiServiceDelegate = null;

				switch (e.type) {
					case ShinseiServiceEvent.LOGIN:	// ログイン
						homeView = ShinseiServiceEvent(e).view as HomeView;
						responder = new Responder(loginResultHandler, loginFaultHandler);
						delegate = new ShinseiServiceDelegate(responder);
						delegate.login(appModel.shain);
						break;
					case ShinseiServiceEvent.LOGOUT:	// ログアウト
						mainView = ShinseiServiceEvent(e).view as MainView;
						logoutHandler();
						break;
				}
			}

			// PRIVATE METHOD -----------------------------------------------------
			// ログイン成功時
			private function loginResultHandler(e:ResultEvent):void {
				mainView = MainView(homeView.parentDocument);
				var shain:Shain = Shain(e.result);

				// リータン値がある場合：勤務表リスト及び最近勤務表取得
				if (shain != null) {
					saveShain(shain);	// ユーザー情報保存
					findShinseiListAndSaikinKinmuhyo();	// 勤務表リストと勤務表リスト最新勤務表取得
					if (kinmuhyoModel.kinmuhyoAC.length > 0) {
						initialKinmuhyoViewData(mainView.kinmuhyoView);	// 勤務表画面データ設定
					} else {
						kinmuhyoModel.kinmuhyo = Kinmuhyo.createDefaultKinmuhyo();
					}

					// model 設定
					appModel.shain.shainMei = shain.shainMei;
					appModel.shain.id = "";
					appModel.shain.password = "";
					// view 設定
					mainView.mainViewStack.selectedIndex = Constants.KINMUHYO_VIEWSTACK_INDEX;
					mainView.buttonBar.enabled = true;
					mainView.logoutButton.visible = true;
					mainView.shainMeiLabel.visible = true;
					homeView.loginCanvas.visible = false;
				// リータン値がない場合：ログイン情報リセット
				} else {
					resetLoginField();
				}
			}

			/** 勤務表画面データ設定 */
			private function initialKinmuhyoViewData(kinmuhyoView:KinmuhyoView):void {
				var kinmuhyo:Kinmuhyo = Kinmuhyo(kinmuhyoModel.kinmuhyoAC.getItemAt(0));
				var nengetsu:String = kinmuhyo.nengetsu;
				var calendar:Array = nengetsu.split("-");
				var year:int = int(calendar[0]);
				var month:int = int(calendar[1]) - 1;

				kinmuhyoView.kinmuhyoDateChooser.displayedYear = year;
				kinmuhyoView.kinmuhyoDateChooser.displayedMonth = month;

				kinmuhyoView.shinseiBangoLabel.text = "申請番号：" + kinmuhyo.shinseiBango;
				kinmuhyoModel.kinmuhyo.syoteiNissu = kinmuhyo.syoteiNissu;
				kinmuhyoModel.kinmuhyo.sagyoNissu = kinmuhyo.sagyoNissu;
				kinmuhyoModel.kinmuhyo.kekkinNissu = kinmuhyo.kekkinNissu;
				kinmuhyoModel.kinmuhyo.jitsudoJikanGokei = kinmuhyo.jitsudoJikanGokei;
			}

			/** ログイン失敗時 */
			private function loginFaultHandler(e:FaultEvent):void {
				resetLoginField();
				homeView.currentState = "showError";
				homeView.errorText.text = MessageId.LOGIN_ERROR;
			}

			/** ログアウト */
			private function logoutHandler():void {
				// データ初期化
				//mainView.model.shain.refresh();
				appModel.shain.reset();
				kinmuhyoModel.kinmuhyo.reset();
				kinmuhyoModel.kinmuhyoAC.removeAll();
				kinmuhyoModel.kinmuhyoShosaiAC.removeAll();

				// 画面初期化
				mainView.homeView.idTextInput.text = "";
				mainView.homeView.passwordTextInput.text = "";
				mainView.homeView.rememberMeCheckBox.selected = false;
				mainView.kinmuhyoView.currentState = "showMenu";
				mainView.mainViewStack.selectedIndex = Constants.HOME_VIEWSTACK_INDEX;
				mainView.homeView.loginCanvas.visible = true;
				mainView.logoutButton.visible = false;
				mainView.buttonBar.enabled = false;
			}

			/** サービス失敗 */
			private function serviceFaultHandler(e:FaultEvent):void {
				Messages.showMessage(MessageId.SERVER_ACCESS_ERROR + ":" + e.message);
			}

			private function resetLoginField():void {
				appModel.shain.reset();
				homeView.idTextInput.text = "";
				homeView.passwordTextInput.text = "";
				homeView.rememberMeCheckBox.selected = false;
				homeView.idTextInput.setFocus();
			}

			/** ユーザー情報保存 */
			private function saveShain(shain:Shain):void {
				var isRememberMe:Boolean = homeView.rememberMeCheckBox.selected;
				var daoEvent:DAOEvent;

				appModel.shain.shainMei = shain.shainMei;
				appModel.shain.shainBango = shain.shainBango;

				daoEvent = new DAOEvent(DAOEvent.SAVE_SHAIN);
				daoEvent.dispatch();
			}

			/** 全申請リスト検索及び申請リストの中、最新勤務表情報取得 */
			private function findShinseiListAndSaikinKinmuhyo():void {
				var daoEvent:DAOEvent = new DAOEvent(DAOEvent.FIND_KINMUHYO_LIST);
				daoEvent.dispatch();

			}
		}

	}
