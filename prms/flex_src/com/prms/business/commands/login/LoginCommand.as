package com.prms.business.commands.login {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.business.delegates.LoginDelegate;
    import com.prms.business.delegates.PrmsDelegate;
    import com.prms.business.events.login.LoginEvent;
    import com.prms.model.LoginModelLocator;
    import com.prms.util.Message;
    import com.prms.views.login.LoginBody;
    import com.prms.vo.Account;

    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    public class LoginCommand implements ICommand {
        private var _model:LoginModelLocator = LoginModelLocator.getInstance();
        private var _document:LoginBody;

        public function execute(event:CairngormEvent):void {
            _document = (event as LoginEvent).doc;
            var responder:Responder = new Responder(onResult_login, onFault_login);
            var delegate:LoginDelegate = new LoginDelegate(responder);
            delegate.login((event as LoginEvent).account);
        }

        private function onResult_login(event:ResultEvent):void {

            _model.account = new Account();
            _model.account = Account(event.result);

            // ユーザによる画面処理（ admin / user ）
            if (_model.account.isAdmin()) {
                _document.parentApplication.indexViewStack.selectedIndex = 2;
            } else if (_model.account.isUser()) {
                _document.parentApplication.indexViewStack.selectedIndex = 1;
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

