package com.prms {

    public class Constants {

        // ---------------------------------------------------------------------
        //	SWF FILE LOCATIONS
        // ---------------------------------------------------------------------
        public static const LOGIN_HEADER_SWF:String = "com/prms/views/login/LoginHeader.swf";
        public static const LOGIN_BODY_SWF:String = "com/prms/views/login/LoginBody.swf";

        public static const USER_WORK_TIMESHEET_MAIN_SWF:String = "com/prms/views/timesheet/user/UserTimesheetMain.swf";
        public static const ADMIN_TIMESHEET_MAIN_SWF:String = "com/prms/views/timesheet/admin/AdminTimesheetMain.swf";

        public static const ACCOUNT_ADMIN_BODY_SWF:String = "com/prms/views/account/admin/AccountAdminBody.swf";
        public static const ACCOUNT_USER_BODY_SWF:String = "com/prms/views/account/user/AccountUserBody.swf";


        // ROLE
        public static const ROLE_ADMIN:String = "ROLE_ADMIN";
        public static const ROLE_USER:String = "ROLE_USER";
        public static const USER:String = "USER";

        // 交通費
        public static const ADMIN_TRAFFIC_MAIN_SWF:String = "com/prms/views/traffic/admin/AdminTrafficMain.swf";
        public static const USER_TRAFFIC_MAIN_SWF:String = "com/prms/views/traffic/user/UserTrafficMain.swf";

        // 有給
        public static const ADMIN_VACATION_MAIN_SWF:String = "com/prms/views/vacation/admin/AdminVacationMain.swf";

        /** 定数ステータス ：A */
        public static const CONST_A:String = "A";
        /** 定数ステータス ：B */
        public static const CONST_B:String = "B";
        /** 定数ステータス ：C */
        public static const CONST_C:String = "C";
        /** 定数ステータス ：0 (type:int) */
        public static const CONST_INT_ZERO:int = 0;
        /** 定数ステータス ：1(type:int)  */
        public static const CONST_INT_ONE:int = 1;

		/** VIEWSTACK リストインデクス ：0 (type:int) */
        public static const VIEWSTACK_LIST_INDEX:int = 0;
        /** VIEWSTACK 詳細インデクス ：1 (type:int)  */
        public static const VIEWSTACK_DETAIL_INDEX:int = 1;

        /** 確定フラグ */
        /** 未確定 */
        public static const FIX_FLAG_N:String = "N";
        /** 確定 */
        public static const FIX_FLAG_Y:String = "Y";

        // prms remote object
        public static const PRMS_REMOTE_OBJECT:String = "prmsFacadeRO";

        // 会社コード
        public static const COMCODE_ROUE:String = "01";
        public static const COMCODE_ROUE_SUITE:String = "02";
        public static const COMCODE_ROUE_LEARNING:String = "03";

        // ---------------------------------------------------------------------
        //	TIMESHEET CONSTANTS
        // ---------------------------------------------------------------------

        /** 勤務表（ユーザ）画面ID */
        /** 勤務表一覧（ユーザ） */
        public static const USER_TIMESHEET_LIST:String = "userTimesheetList";
        /** 勤務表詳細（ユーザ） */
        public static const USER_TIMESHEET_DETAILS:String = "userTimesheetDetails";
        /** 勤務表一覧（管理者） */
        public static const ADMIN_TIMESHEET_LIST:String = "adminTimesheetList";
        /** 勤務表詳細（管理者） */
        public static const ADMIN_TIMESHEET_DETAILS:String = "adminTimesheetDetails";

        /** 勤務表ステータスフラグ */
        /** 定数ステータス(画面側でセット)：新規 */
        public static const STATUS_CREATION:String = "00";
        /** 定数ステータス(画面側でセット)：編集可能 */
        public static const STATUS_WRITING:String = "01";
        /** 定数ステータス(画面側でセット)：読み取り */
        public static const STATUS_READING:String = "02";

        /** 勤務表の「定時情報」、「詳細」ボタンフラグ */
        /** 「定時情報」、「詳細」の両方がクローズの状態 */
        public static const CLOSE_ALL:String ="closeAll";
        /** 「定時情報」、「詳細」の両方がオープンの状態 */
        public static const OPEN_ALL:String = "openAll";
        /** 定時情報 ： クローズ、詳細 ： オープンの状態 */
        public static const CLOSE_FIXTIME_AND_OPEN_TIMESHEETDETAIL:String = "closeFixTime_and_openTimesheetDetail";
        /** 定時情報 ： オープン、詳細 ： クローズの状態 */
        public static const OEPN_FIXTIME_AND_CLOSE_TIMESHEETDETAIL:String = "openFixTime_and_closeTimesheetDetail";
        /** 定時情報ボタンの初期確認フラグ */
        public static const INIT_FIXTIME_FLAG_ID:String = "initFixTimeFlg_flg";
        /** 詳細ボタンの初期確認フラグ */
        public static const INIT_TIMESHEET_FLAG_ID:String = "initTimesheetDetail_flg";

        /** 始業時間 */
        public static const WORK_START_TIME:String = "workStartTime";
        /** 終業時間 */
        public static const WORK_END_TIME:String = "workEndTime";
        /** お昼休み開始時間 */
        public static const LUNCH_START_TIME:String = "lunchStartTime";
        /** お昼休み終了時間 */
        public static const LUNCH_END_TIME:String = "lunchEndTime";

        /** 勤務形態コード */
        /** 通常勤務 */
        public static const WORKPATTERN_CODE_NORMAL:String = "01";
        /** 公休勤務 */
        public static const WORKPATTERN_CODE_HOLIDAY:String = "02";

        /** アラートメッセージ*/
        /** 勤務表定時情報の適用ボタン */
        public static const ALERT_MSG_FIXTIME_APPLY_BTN_NOTNULL_DATA:String = "勤務表詳細にデータを適用します。既存データが全部失います。よろしいでしょうか？";
        public static const ALERT_MSG_FIXTIME_APPLY_BTN_NOT_DATA:String = "勤務表詳細にデータを適用します。よろしいでしょうか？";

        // 勤務表ステータス
        public static const STATUS_WRITE:String = "01";	// 作成中
        public static const STATUS_WAIT_APPROVAL:String = "02";	// 承認待ち
        public static const STATUS_COMPLETE_APPROVAL:String = "03";	// 承認済
        public static const STATUS_EDIT_ADMIN:String = "04";	// 管理者編集中

        // 管理者メインメニュー選択項目
        public static const STATUS_ADMIN_WORK:String = "adminWork";				// 勤怠管理
        public static const STATUS_ADMIN_SALARY:String = "adminSalary";			// 給与管理
        public static const STATUS_ADMIN_PERSONNEL:String = "adminPersonnel";	// 人事管理

        // 管理者メイン左メニュー選択項目
        public static const STATUS_ADMIN_TIMESHEET:String = "timesheet";		// 勤務表
        public static const STATUS_ADMIN_TRAFFIC:String = "traffic";			// 交通費
        public static const STATUS_ADMIN_VACATION:String = "vacation";			// 有給
        public static const STATUS_ADMIN_SALARY1:String = "salary1";			// 給料１
        public static const STATUS_ADMIN_SALARY2:String = "salary2";			// 給料２
        public static const STATUS_ADMIN_SALARY3:String = "salary3";			// 給料３
        public static const STATUS_ADMIN_MEMBER:String = "member";				// 人事管理

        // ユーザーメインメニュー選択項目
        public static const STATUS_USER_TIMESHEET:String = "timesheet";				// 勤務表
        public static const STATUS_USER_TRANSPORTATION:String = "transportation";	// 交通費
        public static const STATUS_USER_VACATION:String = "vacation";				// 有給
        public static const STATUS_USER_ACCOUNT:String = "account";					// アカウント
    }
}

