package com.prms.client.flex.business.commands.timesheet {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.Constants;
    import com.prms.client.flex.business.delegates.TimesheetDelegate;
    import com.prms.client.flex.business.events.timesheet.LoadTimesheetDetailsEvent;
    import com.prms.client.flex.model.AccountModelLocator;
    import com.prms.client.flex.model.TimesheetModelLocator;
    import com.prms.client.flex.util.CalendarUtil;
    import com.prms.client.flex.util.Message;
    import com.prms.client.flex.util.ViewStackChangeController;
    import com.prms.client.flex.views.timesheet.admin.AdminTimesheetList;
    import com.prms.client.flex.vo.FixTime;
    import com.prms.client.flex.vo.Timesheet;
    import com.prms.client.flex.vo.TimesheetDetail;

    import mx.collections.IViewCursor;
    import mx.controls.Alert;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    /**
     * 勤務表ロード時の処理
     * @author developer002
     */
    public class LoadTimesheetDetailsCommand implements ICommand {
        private var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
        private var _accountModel:AccountModelLocator = AccountModelLocator.getInstance();
        private var doc:AdminTimesheetList;
        private var vo:Timesheet;
        private var statusFlg:String = null;
        private var dayOfWkArray:Array = new Array("日", "月", "火", "水", "木", "金", "土");

        public function execute(event:CairngormEvent):void {
            var responder:Responder = new Responder(loadTimesheetDetailResultHandler, serviceFaultHandler);
            var delegate:TimesheetDelegate = new TimesheetDelegate(responder);

            if (_accountModel.account.isAdmin()) {	//管理者
                doc = LoadTimesheetDetailsEvent(event).doc;
                delegate.getTimesheetDetail(LoadTimesheetDetailsEvent(event).vo);
            } else if (_accountModel.account.isUser()) {	//ユーザー
                var loadEvent:LoadTimesheetDetailsEvent = LoadTimesheetDetailsEvent(event);
                var timesheet:Timesheet = loadEvent.vo;
                statusFlg = loadEvent.statusFlg;
                // 新規作成
                if (statusFlg == Constants.STATUS_CREATION) {
                    // 定時情報作成
                    makeFixTimeData(timesheet);
                    // 勤務表(日)を作成
                    makeTimesheetDetailData(timesheet);
                } else { // 編集可能, 読み取り専用
                    delegate.getTimesheetAndChildByPk(timesheet); // delegateのメソッドを呼び出す
                }
            }
        }

        /**
         * 勤務表(月), 勤務表(日), 定時情報の取得が成功の場合
         * @param event
         */
        private function loadTimesheetDetailResultHandler(event:ResultEvent):void {

            // 初期化
            initValue();
            var resultTimesheet:Timesheet = event.result as Timesheet;

            if (resultTimesheet != null) {
                model.timesheet = resultTimesheet;
                model.fixTimeAC = resultTimesheet.fixTimeList;

                // TODO 定時情報
                if (model.fixTimeAC != null) {
                    for (var i:int = 0; i < model.fixTimeAC.length; i++) {
                        var fixTime:FixTime = model.fixTimeAC.getItemAt(i) as FixTime;
                        if (!isNullCheckOfFixTime(fixTime)) {
                            if (fixTime.fixTimeName == Constants.CONST_A) {
                                model.fixTimeNameDictionary[Constants.CONST_A] = model.fixTimeAC.getItemAt(i);
                            } else if (fixTime.fixTimeName == Constants.CONST_B) {
                                model.fixTimeNameDictionary[Constants.CONST_B] = model.fixTimeAC.getItemAt(i);
                            } else if (fixTime.fixTimeName == Constants.CONST_C) {
                                model.fixTimeNameDictionary[Constants.CONST_C] = model.fixTimeAC.getItemAt(i);
                            }
                        }
                    }
                }
                // 勤務表(日)
                if (resultTimesheet.timesheetDetailList != null) {
                    var cursor:IViewCursor = resultTimesheet.timesheetDetailList.createCursor();
                    while (!cursor.afterLast) {
                        var dd:TimesheetDetail = cursor.current as TimesheetDetail;
                        dd.breakTimeTotal = breakTimeFormatter(dd.breakTimeTotal);
                        model.timesheetDetailAC.addItem(dd);
                        cursor.moveNext();
                    }
                }
            } else { //TODO この場合、どうすれば??? ?????????????????????
                trace("クラス名：「UserTimesheetDetailsLoadCommand」 / メソッド名：「loadTimesheetDetailResultHandler」");
            }


            if (_accountModel.account.isAdmin()) {
                // 管理者勤務表詳細画面を表示
                ViewStackChangeController.viewstackChange(doc.parentDocument, Constants.ADMIN_TIMESHEET_DETAILS);

                // 現在の日付を表示
                var currentYear:Number = resultTimesheet.currentDate.getFullYear();
                var currentMonth:Number = resultTimesheet.currentDate.getMonth() + 1;
                var currentDayOfMonth:Number = resultTimesheet.currentDate.getDate();
                var currentDayOfWeek:String = dayOfWkArray[new Date(currentYear, currentMonth -1, currentDayOfMonth).day];

                model.timesheet.currentDateTypeIsString = currentYear + "年 " + currentMonth + "月 " + currentDayOfMonth + "日 （ " + currentDayOfWeek + " ）";
            }
        }

        /**
         * 休憩時間合計Formatting処理 (処理前：1.5 → 処理後：0130)
         * @param breakTimeTotal 休憩時間合計
         * @return formatting value
         */
        private function breakTimeFormatter(breakTimeTotal:String):String {
            var formatValue:String = null;
            if (breakTimeTotal == null) {
                return null;
            }

            var hour:String = "";
            var minute:String = "";
            var returnValue:String = "";

            var time:Array = breakTimeTotal.split(".");

            hour = time[0];

            if (time.length == 2) {	//分が存在する
                minute = String(int(Number("0." + time[1]) * 60));
            } else if (time.length == 1) { //分が存在しない
                minute = "00";
            } else {
                Alert.show("休憩時間が無効な値です。", "PRMS ERROR");
            }

            returnValue = hour + minute;

            return (returnValue.length == 3 ) ? (returnValue = "0" + returnValue) : returnValue;
        }

        /**
         * 勤務表(月), 勤務表(日), 定時情報の取得がの失敗の場合
         * @param event
         */
        private function serviceFaultHandler(event:FaultEvent):void {
            //mx.controls.Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
            Message.showErrorMessage(event);
        }

        /**
         * 定時情報作成
         * @param timesheet 勤務表(月)
         */
        private function makeFixTimeData(timesheet:Timesheet):void {

            var fixVO:FixTime = null;
            if (model.fixTimeAC != null) {
                model.fixTimeAC.removeAll();
            }
            var currentFix:FixTime = null;
            var fixTimeNameArray:Array = new Array(Constants.CONST_A, Constants.CONST_B, Constants.CONST_C)
            for each (var item:String in fixTimeNameArray) {
                fixVO = createFixTimeVO(timesheet, item);
                model.fixTimeAC.addItem(fixVO);
            }
        }


        /**
         * 勤務表(日)を作成
         * @param timesheet 勤務表(月)
         */
        private function makeTimesheetDetailData(timesheet:Timesheet):void {
            var ddVO:TimesheetDetail = null;
            if (model.timesheetDetailAC != null) {
                model.timesheetDetailAC.removeAll();
            }
            var cal:CalendarUtil = new CalendarUtil(2010,1);//delete
            //var cal:CalendarUtil = new CalendarUtil(timesheet.yyyymm.fullYear, timesheet.yyyymm.month);
            for (var day:Number = 1; day <=  cal.lastDay; day++) {
                ddVO = createTimesheetDetail(timesheet, new Date(cal.year, cal.month, day));
                model.timesheetDetailAC.addItem(ddVO);
            }
        }

        /**
         * 各データの初期化処理
         */
        private function initValue():void {
            // 勤務表（月）
            if (model.timesheet != null) {
                model.timesheet = new Timesheet();
            }
            // 定時情報 ArrayCollection
            if (model.fixTimeAC != null) {
                model.fixTimeAC.removeAll();
            }
            // 勤務表(日) ArrayCollection
            if (model.timesheetDetailAC != null) {
                model.timesheetDetailAC.removeAll();
            }
            // 定時情報(ComboBox)
            if (model.fixTimeNameAC != null) {
                model.fixTimeNameAC.removeAll();
            }
        }

        /**
         * 定時情報Entityのヌルチェックを行う
         * @param vo 定時情報
         * @return Boolean
         */
        private function isNullCheckOfFixTime(vo:FixTime):Boolean {
            var flg:Boolean = false;
            if (vo.timeUnit == null && vo.workStartTime == null && vo.workEndTime == null && vo.lunchStartTime == null && vo.lunchEndTime == null) {
                flg = true;
            }
            return flg;
        }

        /**
         * 勤務表(日)
         * @param timesheet 勤務表(月)
         * @return 勤務表(日)Entity
         */
        private function createTimesheetDetail(timesheet:Timesheet, yyyymmdd:Date):TimesheetDetail {
            var vo:TimesheetDetail = new TimesheetDetail();
            // 会社コード
            vo.comCode = timesheet.comCode;
            // 社員番号
            vo.empNo = timesheet.empNo;
            // 年月
            vo.yyyymm = timesheet.yyyymm;
            // 年月日
            vo.yyyymmdd = yyyymmdd;
            return vo;
        }


        /**
         * 定時情報
         * @param timesheet 勤務表(月)
         * @param fixTimeName 定時名称 ex)A, B, C
         * @return 定時情報Entity
         */
        private function createFixTimeVO(timesheet:Timesheet, fixTimeName:String):FixTime {
            var vo:FixTime = new FixTime();
            // 会社コード
            vo.comCode = timesheet.comCode;
            // 社員番号
            vo.empNo = timesheet.empNo;
            // 年月
            vo.yyyymm = timesheet.yyyymm;
            // 定時名称
            vo.fixTimeName = fixTimeName;
            return vo;
        }
    }
}

