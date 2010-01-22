package com.prms.business.delegates {
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.prms.Constants;
    import com.prms.vo.FixTime;
    import com.prms.vo.Timesheet;

    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.remoting.RemoteObject;

    public class TimesheetDelegate {
        private var _locator:ServiceLocator = ServiceLocator.getInstance();
        private var _service:RemoteObject;
        private var _responder:IResponder;

        public function TimesheetDelegate(responder:IResponder) {

            if (_locator == null) {
                _locator = ServiceLocator.getInstance();
            }

            //_service = _locator.getRemoteObject("timesheetServiceRO");
            _service = _locator.getRemoteObject(Constants.PRMS_REMOTE_OBJECT);
            _responder = responder;
        }

        public function getFixTimeList(fixTimeVO:FixTime):void {
            var token:AsyncToken = _service.getFixTimeList(fixTimeVO);
            token.addResponder(_responder);
        }

        /**
         * 勤務表(月), 勤務表(日), 定時情報を取得
         * @param vo 勤務表（月）
         */
        public function getTimesheetAndChildByPk(vo:Timesheet):void {
            var token:AsyncToken = _service.getTimesheetAndChildByPk(vo);
            token.addResponder(_responder);
        }

        /**
         * 勤務表保存
         * @param vo 勤務表（月）
         */
        public function saveTimesheet(vo:Timesheet):void {
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
        public function getTimesheetList():void {
            var token:AsyncToken = _service.getTimesheetList();
            token.addResponder(_responder);
        }

        /**
         * 勤務表一覧取得 - admin
         * @param vo 勤務表
         */
        public function getTimesheetListByComCodeAndYYYYMM (vo:Timesheet):void {
            var token:AsyncToken = _service.getTimesheetListByComCodeAndYYYYMM(vo);
            token.addResponder(_responder);
        }

        /**
         * 社員名取得
         */
        public function getEmpNameBySession():void {
            var token:AsyncToken = _service.getEmpNameBySession();
            token.addResponder(_responder);
        }

        /**
         * 勤務形態取得
         */
        public function getWorkPattern():void {
            var token:AsyncToken = _service.getWorkPattern();
            token.addResponder(_responder);
        }

        /**
         * 現在の日付取得
         */
        public function getCurrentTime():void {
            var token:AsyncToken = _service.getCurrentTime();
            token.addResponder(_responder);
        }

		/**
		 * 勤務表詳細表示
		 */
        public function getTimesheetDetail(vo:Timesheet):void {
        	var token:AsyncToken = _service.getTimesheetDetail(vo);
            token.addResponder(_responder);
        }
    }
}

