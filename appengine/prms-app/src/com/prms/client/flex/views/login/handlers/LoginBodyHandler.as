package com.prms.client.flex.views.login.handlers {
    import com.prms.client.flex.business.events.login.LoginEvent;
    import com.prms.client.flex.views.login.LoginBody;
    import com.prms.client.flex.vo.Account;

    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.core.IMXMLObject;
    import mx.events.FlexEvent;
    import mx.validators.Validator;


    public class LoginBodyHandler implements IMXMLObject {

        private var _document:LoginBody;


        public function initialized(document:Object, id:String):void {
            _document = LoginBody(document);
            _document.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(event:Event):void {
            _document.txtUserId.addEventListener(FlexEvent.ENTER, login);
            _document.txtPassword.addEventListener(FlexEvent.ENTER, login);
            _document.btnLogin.addEventListener(MouseEvent.CLICK, login);
        }

        private function login(event:*):void {

            if (_document.txtUserId.text == "" || _document.txtPassword.text == "") {
                _document.lblMessage.text = "ユーザＩＤまたパスワードは必須です。";
                _document.loginFaultEffect.end();
                _document.loginFaultEffect.play();
                Validator.validateAll(_document.validators);
                return;
            }

            _document.btnLogin.enabled = false;
            var account:Account = new Account();
            account.email = _document.txtUserId.text;
            account.passwd = _document.txtPassword.text;
            var loginEvent:LoginEvent = new LoginEvent(account, _document);
            loginEvent.dispatch();
        }
    }
}

