package com.prms.business.delegates {
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.prms.Constants;
    import com.prms.vo.AccountUser;

    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.remoting.RemoteObject;

    public class AccountDelegate {
        private var _locator:ServiceLocator;
        private var _service:RemoteObject;
        private var _responder:IResponder;

        public function AccountDelegate(responder:IResponder) {
            if (_locator == null) {
                _locator = ServiceLocator.getInstance();
            }
            _service = _locator.getRemoteObject(Constants.PRMS_REMOTE_OBJECT);
            _responder = responder;
        }

        /**
         * ユーザーパスワード変更
         * @param vo アカウント
         */
        public function accountUserPasswordModify(account:AccountUser):void {
            var token:AsyncToken = _service.updateAccount(account);
            token.addResponder(_responder);
        }

        /**
         * ユーザー情報を取得
         * @param
         */
        public function accountUserInfo():void {
            var token:AsyncToken = _service.accountUserInfo();
            token.addResponder(_responder);
        }

        /**
         * 管理者→人事管理リスト
         * @param vo アカウント
         */
        public function accountAdminList(account:AccountUser):void {
            var token:AsyncToken = _service.accountAdminList(account);
            token.addResponder(_responder);
        }

        /**
         * ユーザー新規登録
         * @param vo アカウント
         */
        public function saveAccountAdmin(account:AccountUser):void {
            var token:AsyncToken = _service.saveAccountAdminUser(account);
            token.addResponder(_responder);
        }

        /**
         * 管理者人事管理初期フォーム
         * @param vo アカウント
         */
        public function saveAccountAdminForm(account:AccountUser):void {
            var token:AsyncToken = _service.saveAccountAdminUser(account);
            token.addResponder(_responder);
        }
    }
}