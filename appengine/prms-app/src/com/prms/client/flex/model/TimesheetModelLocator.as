package com.prms.client.flex.model {
    import com.prms.client.flex.vo.Timesheet;

    import flash.utils.Dictionary;

    import mx.collections.ArrayCollection;

    [Bindable]
    public class TimesheetModelLocator {
        /** 年月 */
        public var yyyymm:Date;	//今月に戻るため使用（管理者）

        //TODO 任意フラグ
        /** 勤務表状態フラグ (新規01、作成中02, 読み取り専用03) */
        public var statusFlg:String;

        /** 定時情報 ArrayCollection */
        public var fixTimeAC:ArrayCollection = new ArrayCollection();

        /** 勤務表(月) ArrayCollection */
        public var timesheetAC:ArrayCollection = new ArrayCollection();

        /** 勤務表(日) ArrayCollection */
        public var timesheetDetailAC:ArrayCollection = new ArrayCollection();

        /** 勤務パータン(ComboBox) Dictionary */
        public var fixTimeNameDictionary:Dictionary = new Dictionary();

        /** 勤務パータン(ComboBox) ArrayCollection */
        public var fixTimeNameAC:ArrayCollection = new ArrayCollection();

        /** 勤務表(月) */
        public var timesheet:Timesheet = new Timesheet();

        /** 勤務表さんマーリー */
        public var timesheetSummary:Timesheet = new Timesheet();

        /** 勤務形態 */
        public var codeDetailAC:ArrayCollection = new ArrayCollection();

        /** 勤務表比較用 ArrayCollection */
        public var compareTimesheetAC:ArrayCollection = new ArrayCollection();

        /** ファイルアップロードプレビュー用ドメイン */
        public var previewTimesheet:Timesheet = new Timesheet();

        static private var _instance:TimesheetModelLocator = null;

        static public function getInstance():TimesheetModelLocator {
            if (_instance == null) {
                _instance = new TimesheetModelLocator();
            }
            return _instance;
        }
    }
}

