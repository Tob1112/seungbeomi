package com.prms.client.flex.business.commands.login {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.Constants;
    import com.prms.client.flex.business.delegates.LoginDelegate;
    import com.prms.client.flex.business.events.login.LoginEvent;
    import com.prms.client.flex.model.AccountModelLocator;
    import com.prms.client.flex.util.Message;
    import com.prms.client.flex.util.ViewStackChangeController;
    import com.prms.client.flex.views.login.LoginBody;
    import com.prms.client.flex.vo.Account;

    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    public class LoginCommand implements ICommand {
        private var _model:AccountModelLocator = AccountModelLocator.getInstance();
        private var _document:LoginBody;

        public function execute(event:CairngormEvent):void {
            _document = (event as LoginEvent).doc;
            var responder:Responder = new Responder(onResult_login, onFault_login);
            var delegate:LoginDelegate = new LoginDelegate(responder);
            delegate.login((event as LoginEvent).account);
        }

        private function onResult_login(event:ResultEvent):void {

            _model.account = Account(event.result);
            // ユーザによる画面処理（ admin / user ）
            if (_model.account.isAdmin()) {
                ViewStackChangeController.viewstackChange(_document.parentApplication, Constants.LAYOUT_ADMIN);
            } else if (_model.account.isUser()) {
                ViewStackChangeController.viewstackChange(_document.parentApplication, Constants.LAYOUT_USER);
            } else {
                _document.loginFaultEffect.end();
                _document.loginFaultEffect.play();
                _document.lblMessage.text = "サービス利用可能なユーザではありません。";
                _document.txtUserId.text = "";
                _document.txtPassword.text = "";
                _document.btnLogin.enabled = true;
            }
        }

        private function onFault_login(event:FaultEvent):void {
            var errorMessage:String = "入力したユーザーIDまたはパスワードが間違っています";
            _document.loginFaultEffect.end();
            _document.loginFaultEffect.play();
            _document.lblMessage.text = errorMessage;
            Message.showErrorMessage(event);
            _document.txtPassword.text = "";
            _document.btnLogin.enabled = true;
        }

    }
}

