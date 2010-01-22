package com.prms.business.delegates {

	import com.adobe.cairngorm.business.ServiceLocator;
	import com.prms.Constants;
	import com.prms.vo.Account;
	import com.prms.vo.AccountUser;
	import com.prms.vo.Timesheet;
	import com.prms.vo.Traffic;

	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;

    public class PrmsDelegate {

    	private var _locator:ServiceLocator;
    	private var _service:RemoteObject;
    	private var _responder:IResponder;

		// constructor
        public function PrmsDelegate(responder:IResponder) {
        	if (_locator == null) {
        		_locator = ServiceLocator.getInstance();
        	}
        	_service = _locator.getRemoteObject(Constants.PRMS_REMOTE_OBJECT);
        	_responder = responder;
        }

        //------------------------------------------------------------------
        // Security Delegate
        //------------------------------------------------------------------
		public function login(account:Account):void {
			trace("login - account email:" + account.email + ", passwd:" + account.passwd);
            var token:AsyncToken = _service.authenticateUser(account);
            token.addResponder(_responder);
        }

		//------------------------------------------------------------------
        // Account Delegate
        //------------------------------------------------------------------
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

		//------------------------------------------------------------------
        // Timesheet Delegate
        //------------------------------------------------------------------
		/**
         * 勤務表(月), 勤務表(日), 定時情報を取得
         * @param vo 勤務表（月）
         */
        public function getTimesheetAndChildByPk(vo:Timesheet):void{
			var token:AsyncToken = _service.getTimesheetAndChildByPk(vo);
			token.addResponder(_responder);
        }

        /**
         * 勤務表保存
         * @param vo 勤務表（月）
         */
        public function saveTimesheet(vo:Timesheet):void{
            var token:AsyncToken = _service.saveTimesheet(vo);
            token.addResponder(_responder);
        }

        /**
         * 勤務表存在確認
         * @param vo 勤務表（月）
         */
        public function existTimesheetByYYYYMM(timesheet:Timesheet):void {
        	var token:AsyncToken = _service.existTimesheetByYYYYMM(timesheet);
            token.addResponder(_responder);
        }


		/**
         * 勤務表一覧取得
         * @param vo 勤務表（月）
         */
		public function getTimesheetList():void{
			var token:AsyncToken = _service.getTimesheetList();
			token.addResponder(_responder);
		}

		/**
         * 社員名取得
         */
		public function getEmpNameBySession():void{
			var token:AsyncToken = _service.getEmpNameBySession();
			token.addResponder(_responder);
		}

		/**
		 * 勤務形態取得メソッド
		 */
		public function getWorkPattern():void {
			var token:AsyncToken = _service.getWorkPattern();
			token.addResponder(_responder);
		}

		/**
         * 現在の日付取得
         */
		public function getCurrentTime():void{
			var token:AsyncToken = _service.getCurrentTime();
			token.addResponder(_responder);
		}

		/**
         * ヘッダメニューのメールアドレス取得
         */
		public function accountUserEmail():void{
            var token:AsyncToken = _service.accountUserInfo();
            token.addResponder(_responder);
		}

		//------------------------------------------------------------------
        // Traffic Delegate
        //------------------------------------------------------------------

		/**
		 * 交通費 - 定期券一覧取得
		 */
     	public function loadRegTrainList():void{
     		var token:AsyncToken = _service.loadRegTrainList();
     		token.addResponder(_responder);
     	}

     	/**
     	 * 交通費 - 定期券、バス、その他各項目の合計金額取得
     	 * @param traffic 交通費（月）
     	 */
     	 public function loadRegTotals(traffic:Traffic):void{
     	 	var token:AsyncToken = _service.loadRegTotals(traffic);
     	 	token.addResponder(_responder);
     	 }
    }
}