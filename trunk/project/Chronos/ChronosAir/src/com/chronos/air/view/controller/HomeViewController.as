package com.chronos.air.view.controller {

	import com.chronos.air.common.MessageId;
	import com.chronos.air.common.Messages;
	import com.chronos.air.event.ShinseiServiceEvent;
	import com.chronos.air.model.ApplicationModel;
	import com.chronos.air.util.Logger;
	import com.chronos.air.view.HomeView;
	import com.hurlant.crypto.Crypto;
	import com.hurlant.crypto.hash.IHash;
	import com.hurlant.util.Hex;

	import flash.events.MouseEvent;
	import flash.utils.ByteArray;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	import mx.managers.CursorManager;
	import mx.validators.Validator;

	public class HomeViewController implements IMXMLObject {

		private var view:HomeView;
		private var model:ApplicationModel = ApplicationModel.getInstance();
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

		//----------------------------------------------------------------------------------------------

		private function loginButtonClickHandler(e:MouseEvent):void {
			CursorManager.setBusyCursor();

			// 妥当性チェック
			view.validators.forEach(function(item:Object, index:int, array:Array):void {
				item.enabled = true;
			});

			var validatorResult:Array = Validator.validateAll(view.validators);
			if (validatorResult.length > 0) {
				return;
			}

			var isRememberMe:Boolean = view.rememberMeCheckBox.selected;
			var event:ShinseiServiceEvent;
			var pw:String = view.passwordTextInput.text

			model.shain.id = view.idTextInput.text;
			// パスワードmd5暗号化
			//model.shain.password = encryptPasswordMd5(pw);
			model.shain.password = pw;
			model.shain.rememberMe = view.rememberMeCheckBox.selected;


			// ログイン
			event = new ShinseiServiceEvent(ShinseiServiceEvent.LOGIN, view);
			event.dispatch();
		}

		private function rememberMeHandler(e:MouseEvent):void {
			if (e.currentTarget.selected == true) {
				Messages.showMessage(MessageId.SECURITY_MESSAGE);
			}
		}

		/** パスワードをmd5を使用し変更 */
		private function encryptPasswordMd5(pw:String):String {
			var result:String;
			var hash:IHash = Crypto.getHash("md5");
			var pwba:ByteArray = hash.hash(Hex.toArray(Hex.fromString(pw)));
			result = Hex.fromArray(pwba);
			Logger.log("pw : " + result);
			return result;
		}
	}
}