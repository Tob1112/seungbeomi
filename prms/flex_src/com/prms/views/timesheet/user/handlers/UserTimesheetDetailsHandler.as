package com.prms.views.timesheet.user.handlers {
    import com.prms.Constants;
    import com.prms.business.events.timesheet.GetEmpNameEvent;
    import com.prms.business.events.timesheet.LoadTimesheetDetailsEvent;
    import com.prms.business.events.timesheet.LoadWorkPatternEvent;
    import com.prms.business.events.timesheet.SaveTimesheetEvent;
    import com.prms.model.TimesheetModelLocator;
    import com.prms.util.ViewStackChangeController;
    import com.prms.views.timesheet.user.UserTimesheetDetails;
    import com.prms.views.timesheet.user.UserTimesheetMain;
    import com.prms.vo.Timesheet;

    import flash.events.MouseEvent;
    import flash.system.Capabilities;
    import flash.utils.Dictionary;

    import mx.collections.ArrayCollection;
    import mx.controls.Alert;
    import mx.core.IMXMLObject;
    import mx.events.CloseEvent;
    import mx.events.FlexEvent;

    public class UserTimesheetDetailsHandler implements IMXMLObject {

        private var initFixTimeFlg:Boolean;
        private var openFixTimeFlg:Boolean;
        private var initTimesheetDetailFlg:Boolean;
        private var openTimesheetDetailFlg:Boolean;
        private var document:UserTimesheetDetails;
        /** 勤務表状態フラグ (新規00、作成中01,  読み取り専用02) */
        private var statusFlg:String;
        /** 勤務表（月） */
        private var timesheet:Timesheet;

        [Bindable]
        public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
        [Bindable]
        public var buttonHeight:Number = 0;

        /**
         *  @param document The MXML document that created this object.
         *  @param id The identifier used by <code>document</code> to refer
         */
        public function initialized(document:Object, id:String):void {
            this.document = document as UserTimesheetDetails;
            this.document.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
            buttonHeight = flash.system.Capabilities.screenResolutionY * 0.001;
        }

        /**
         *
         * @param event FlexEvent
         */
        private function creationCompleteHandler(event:FlexEvent):void {
            // 1. 初期値セット
            setInitValues();
            // 2. 各リスナーを登録
            addEventListenerProcess();
            // 3. 初期処理
            setLoadProcess();
        }

        /**
         * 初期処理
         */
        private function setLoadProcess():void {
            var event:LoadTimesheetDetailsEvent = new LoadTimesheetDetailsEvent(getTimesheet(), getStatusFlg());
            event.dispatch();
            // 勤務形態取得
            var loadWorkPatternEvent:LoadWorkPatternEvent = new LoadWorkPatternEvent();
            loadWorkPatternEvent.dispatch();
            // 社員名取得
            var getEmpNameEvent:GetEmpNameEvent = new GetEmpNameEvent(timesheet);
            getEmpNameEvent.dispatch();
        }

        /**
         *  選択した勤務表の日付を画面に表示する。
         */
        public function setLabelValue():void {
            var year:Number = model.timesheet.yyyymm.getFullYear();
            var month:Number = model.timesheet.yyyymm.getMonth() + 1;
            this.document.titleLabel.text = "勤務表作成(" + year.toString() + "年" + month.toString() + "月)";
            this.document.todayDateLabel.text = model.timesheet.currentDateTypeIsString;
        }

        /**
         * 保存ボタンクリック
         * @param event
         */
        private function clickSaveButtonHandler(event:MouseEvent):void {
            var vo:Timesheet = getTimesheet();
            // 保存ボタンを押下した時、「勤務表(月)Entity」の「ステータスコード」は01(作成中)をセットする。
            vo.statusCode = Constants.STATUS_WRITING;
            vo.empNo = model.timesheet.empNo;
            vo.empName = model.timesheet.empName;
            vo.lastName = model.timesheet.lastName;
            vo.firstName = model.timesheet.firstName;
            vo.codeDetailName = model.timesheet.codeDetailName;
            model.timesheet = vo;
            model.timesheet.fixTimeList = model.fixTimeAC;
            model.timesheet.timesheetDetailList = model.timesheetDetailAC;
            var saveTimesheetEvent:SaveTimesheetEvent = new SaveTimesheetEvent(model.timesheet);
            saveTimesheetEvent.dispatch();
        }

        /**
         * 戻るボタンがクリックされた時
         * @param event
         */
        private function clickBackButtonHandler(event:MouseEvent):void {
            if ((model.fixTimeAC != null) || (model.timesheetDetailAC != null)) {
                Alert.show("勤務表一覧画面に移動します。\n 勤務表詳細のデータを保存しましたか？", "", Alert.YES | Alert.CANCEL, null, clickBackButtonValueYes);
            }
        }


        private function clickBackButtonValueYes(event:CloseEvent):void {
            if (event.detail == Alert.YES) {
                model.timesheet = new Timesheet();
                model.fixTimeNameAC = new ArrayCollection();
                model.fixTimeNameDictionary = new Dictionary();
                model.fixTimeAC = new ArrayCollection();
                model.timesheetDetailAC = new ArrayCollection();
                // 勤務表一覧画面に移動
                ViewStackChangeController.viewstackChange(UserTimesheetMain(this.document.parentDocument), Constants.USER_TIMESHEET_LIST);
            }
        }

        /**
         * 定時情報ボタンクリック
         * @param event MouseEvent
         */
        private function clickFixTimeLinkButtonHandler(event:MouseEvent):void {
            checkInitFlg(Constants.INIT_FIXTIME_FLAG_ID, initFixTimeFlg);

            if (!openFixTimeFlg) {
                openFixTimeFlg = true;
                if (!initTimesheetDetailFlg) {
                    this.document.currentState = openTimesheetDetailFlg ? Constants.CLOSE_ALL : Constants.CLOSE_FIXTIME_AND_OPEN_TIMESHEETDETAIL;
                } else {
                    this.document.currentState = Constants.CLOSE_FIXTIME_AND_OPEN_TIMESHEETDETAIL;
                }
            } else if (openFixTimeFlg) {
                openFixTimeFlg = false;
                if (!initTimesheetDetailFlg) {
                    this.document.currentState = openTimesheetDetailFlg ? Constants.OEPN_FIXTIME_AND_CLOSE_TIMESHEETDETAIL : Constants.OPEN_ALL;
                } else {
                    this.document.currentState = Constants.OPEN_ALL;
                }
            }
        }

        /**
         * 詳細クリック時
         * @param event MouseEvent
         */
        private function clickTimesheetDetailLinkButtonHandler(event:MouseEvent):void {
            checkInitFlg(Constants.INIT_TIMESHEET_FLAG_ID, initTimesheetDetailFlg);

            if (!openTimesheetDetailFlg) {
                openTimesheetDetailFlg = true;
                if (!initFixTimeFlg) {
                    this.document.currentState = openFixTimeFlg ? Constants.CLOSE_ALL : Constants.OEPN_FIXTIME_AND_CLOSE_TIMESHEETDETAIL;
                } else {
                    this.document.currentState = Constants.OEPN_FIXTIME_AND_CLOSE_TIMESHEETDETAIL;
                }
            } else if (openTimesheetDetailFlg) {
                openTimesheetDetailFlg = false;
                if (!initFixTimeFlg) {
                    this.document.currentState = openFixTimeFlg ? Constants.CLOSE_FIXTIME_AND_OPEN_TIMESHEETDETAIL : Constants.OPEN_ALL;
                } else {
                    this.document.currentState = Constants.OPEN_ALL;
                }
            }
        }

        /**
         * 初期フラグをFalseにセット
         * @param id 定時情報 また 詳細
         * @param initFlg 初期フラグ
         */
        private function checkInitFlg(id:String, initFlg:Boolean):void {
            if (initFlg) {
                if (id == Constants.INIT_FIXTIME_FLAG_ID) {
                    initFixTimeFlg = false;
                    openFixTimeFlg = false;

                } else if (id == Constants.INIT_TIMESHEET_FLAG_ID) {
                    initTimesheetDetailFlg = false;
                    openTimesheetDetailFlg = false;
                }
            }
        }

        /**
         * 初期値をセット
         */
        private function setInitValues():void {
            initFixTimeFlg = true;
            openFixTimeFlg = true;
            initTimesheetDetailFlg = true;
            openTimesheetDetailFlg = true;
            this.document.currentState = Constants.OPEN_ALL;

            // TODO providerValue初期化
            model.fixTimeAC = new ArrayCollection();
            model.fixTimeNameAC = new ArrayCollection();
            model.fixTimeNameDictionary = new Dictionary();
            model.timesheetDetailAC = new ArrayCollection();
            // TODO  一覧画面がmodelにセットしたデータを取得するように.... NULLチェックもするように...
            setStatusFlg(model.statusFlg);
            setTimesheet(model.timesheet);
            // Label
            setLabelValue();

            if (getStatusFlg() == Constants.STATUS_READING) {
                this.document.saveButton.enabled = false;
                this.document.submitButton.enabled = false;
            }
        }

        /**
         * 各リスナーを登録
         */
        private function addEventListenerProcess():void {
            // 定時情報ボタンリスナー
            this.document.fixTimeLinkButton.addEventListener(MouseEvent.CLICK, clickFixTimeLinkButtonHandler);
            // 詳細ボタンリスナー
            this.document.timesheetDetailLinkButton.addEventListener(MouseEvent.CLICK, clickTimesheetDetailLinkButtonHandler);
            // 保存ボタンリスナー
            this.document.saveButton.addEventListener(MouseEvent.CLICK, clickSaveButtonHandler);
            // 戻るボタンリスナー
            this.document.backButton.addEventListener(MouseEvent.CLICK, clickBackButtonHandler);
        }


        /**
         * 勤務表（月）をセット
         * @param comCode 会社コード
         * @param empNo 社員番号
         * @param yyyymm 年月
         */
        private function setTimesheet(mm:Timesheet):void {
            var vo:Timesheet = new Timesheet();
            // 会社コード
            vo.comCode = mm.comCode;
            // 社員コード
            vo.empNo = mm.empNo;
            // 社員名（名）
            vo.firstName = mm.firstName;
            // 社員名（姓）
            vo.lastName = mm.lastName;
            // 現在の日付（画面）
            vo.currentDateTypeIsString = mm.currentDateTypeIsString;
            // 年月
            vo.yyyymm = mm.yyyymm;
            // ステータスコード
            vo.statusCode = mm.statusCode;
            // 確定フラグ
            vo.fixFlag = mm.fixFlag;
            // 勤務表コードネーム
            // サーバから取得するため、削除
            // vo.codeDetailName = mm.codeDetailName
            // 新規作成の場合
            if (getStatusFlg() == Constants.STATUS_CREATION) {
                // 定時情報を初期化する
                vo.fixTimeList = new ArrayCollection();
                // 勤務表(日)を初期化する。
                vo.timesheetDetailList = new ArrayCollection();
                // 確定フラグ → 未確定
                vo.fixFlag = Constants.FIX_FLAG_N;
                // 勤務表コードネーム
                vo.codeDetailName = "新規作成";
            }
            this.timesheet = vo;
        }

        private function getTimesheet():Timesheet {
            return this.timesheet;
        }

        private function setStatusFlg(statusFlg:String):void {
            this.statusFlg = statusFlg;
        }

        private function getStatusFlg():String {
            return statusFlg;
        }
    }
}

