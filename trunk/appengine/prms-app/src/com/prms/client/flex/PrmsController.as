package com.prms.client.flex {

    import com.adobe.cairngorm.control.FrontController;
    import com.prms.client.flex.business.commands.account.AccountAdminCurrentTimeCommand;
    import com.prms.client.flex.business.commands.account.AccountAdminListCommand;
    import com.prms.client.flex.business.commands.account.AccountUserCommand;
    import com.prms.client.flex.business.commands.account.AccountUserInfoCommand;
    import com.prms.client.flex.business.commands.account.SaveAccountAdminCommand;
    import com.prms.client.flex.business.commands.account.SaveAccountFormCommand;
    import com.prms.client.flex.business.commands.login.LoginCommand;
    import com.prms.client.flex.business.commands.main.AdminMainHeaderCommand;
    import com.prms.client.flex.business.commands.main.UserMainHeaderCommand;
    import com.prms.client.flex.business.commands.main.UserMainHeaderEmailCommand;
    import com.prms.client.flex.business.commands.timesheet.CompareTimesheetCommand;
    import com.prms.client.flex.business.commands.timesheet.FileUploadCommand;
    import com.prms.client.flex.business.commands.timesheet.GetCurrentTimeCommand;
    import com.prms.client.flex.business.commands.timesheet.GetEmpNameCommand;
    import com.prms.client.flex.business.commands.timesheet.GetTimesheetSummaryCommand;
    import com.prms.client.flex.business.commands.timesheet.LoadTimesheetDetailsCommand;
    import com.prms.client.flex.business.commands.timesheet.LoadTimesheetListCommand;
    import com.prms.client.flex.business.commands.timesheet.LoadWorkPatternCommand;
    import com.prms.client.flex.business.commands.timesheet.SaveTimesheetCommand;
    import com.prms.client.flex.business.commands.timesheet.WriteNewUserTimesheetCommand;
    import com.prms.client.flex.business.commands.traffic.LoadRegOtherListCommand;
    import com.prms.client.flex.business.commands.traffic.LoadRegTotalsCommand;
    import com.prms.client.flex.business.commands.traffic.LoadRegTrainListCommand;
    import com.prms.client.flex.business.commands.traffic.TrafficCurrentDateCommand;
    import com.prms.client.flex.business.commands.traffic.TrafficIrregAffairsCommand;
    import com.prms.client.flex.business.commands.traffic.TrafficNewWriteCommand;
    import com.prms.client.flex.business.commands.traffic.TrafficTotalCommand;
    import com.prms.client.flex.business.commands.traffic.TrafficUserListCommand;
    import com.prms.client.flex.business.events.account.AccountAdminCurrentTimeEvent;
    import com.prms.client.flex.business.events.account.AccountAdminListEvent;
    import com.prms.client.flex.business.events.account.AccountUserEvent;
    import com.prms.client.flex.business.events.account.AccountUserInfoEvent;
    import com.prms.client.flex.business.events.account.SaveAccountAdminEvent;
    import com.prms.client.flex.business.events.account.SaveAccountFormEvent;
    import com.prms.client.flex.business.events.login.LoginEvent;
    import com.prms.client.flex.business.events.main.AdminMainHeaderEvent;
    import com.prms.client.flex.business.events.main.UserMainHeaderEmailEvent;
    import com.prms.client.flex.business.events.main.UserMainHeaderEvent;
    import com.prms.client.flex.business.events.timesheet.CompareTimesheetEvent;
    import com.prms.client.flex.business.events.timesheet.FileUploadEvent;
    import com.prms.client.flex.business.events.timesheet.GetCurrentTimeEvent;
    import com.prms.client.flex.business.events.timesheet.GetEmpNameEvent;
    import com.prms.client.flex.business.events.timesheet.GetTimesheetSummaryEvent;
    import com.prms.client.flex.business.events.timesheet.LoadTimesheetDetailsEvent;
    import com.prms.client.flex.business.events.timesheet.LoadTimesheetListEvent;
    import com.prms.client.flex.business.events.timesheet.LoadWorkPatternEvent;
    import com.prms.client.flex.business.events.timesheet.SaveTimesheetEvent;
    import com.prms.client.flex.business.events.timesheet.WriteNewUserTimesheetEvent;
    import com.prms.client.flex.business.events.traffic.LoadRegOtherListEvent;
    import com.prms.client.flex.business.events.traffic.LoadRegTotalsEvent;
    import com.prms.client.flex.business.events.traffic.LoadRegTrainListEvent;
    import com.prms.client.flex.business.events.traffic.TrafficCurrentDateEvent;
    import com.prms.client.flex.business.events.traffic.TrafficIrregAffairsEvent;
    import com.prms.client.flex.business.events.traffic.TrafficNewWriteEvent;
    import com.prms.client.flex.business.events.traffic.TrafficTotalEvent;
    import com.prms.client.flex.business.events.traffic.TrafficUserListEvent;

    public class PrmsController extends FrontController {

        public function PrmsController() {
            super();

            // ---------------------------------------------------------------------
            //	ACCOUNT
            // ---------------------------------------------------------------------
            // ユーザーパスワード変更
            addCommand(AccountUserEvent.EVENT_ID, AccountUserCommand);
            // ユーザー情報取得
            addCommand(AccountUserInfoEvent.EVENT_ID, AccountUserInfoCommand);
            // 社員リスト(管理者)
            addCommand(AccountAdminListEvent.EVENT_ID, AccountAdminListCommand);
            // 社員登録(管理者)
            addCommand(SaveAccountAdminEvent.EVENT_ID, SaveAccountAdminCommand);
			// 人事管理現在日付(管理者)
            addCommand(AccountAdminCurrentTimeEvent.EVENT_ID, AccountAdminCurrentTimeCommand);
            // 人事管理社員登録画面(初期)
            addCommand(SaveAccountFormEvent.EVENT_ID, SaveAccountFormCommand);

            // ---------------------------------------------------------------------
            //	LOGIN
            // ---------------------------------------------------------------------
            addCommand(LoginEvent.EVENT_ID, LoginCommand);

            // ---------------------------------------------------------------------
            //	MAIN
            // ---------------------------------------------------------------------
            // userMainHeader
            addCommand(UserMainHeaderEvent.EVENT_ID, UserMainHeaderCommand);
			// userMainHeaderEmail
			addCommand(UserMainHeaderEmailEvent.USER_MAIN_EMAIL_EVENT, UserMainHeaderEmailCommand);
            // adminMainHeader
            addCommand(AdminMainHeaderEvent.EVENT_ID, AdminMainHeaderCommand);


            // ---------------------------------------------------------------------
            //	TIMESHEET
            // ---------------------------------------------------------------------
            // ユーザ勤務表初期処理
            addCommand(LoadTimesheetDetailsEvent.EVENT_ID, LoadTimesheetDetailsCommand);
            // 勤務表保存
            addCommand(SaveTimesheetEvent.SAVE_TIMESHEET_EVENT, SaveTimesheetCommand);
            // 勤務表一覧新規作成ボタン
            addCommand(WriteNewUserTimesheetEvent.EVENT_ID, WriteNewUserTimesheetCommand);
            // 勤務表一覧取得
            addCommand(LoadTimesheetListEvent.EVENT_ID, LoadTimesheetListCommand);
            // 社員名取得
            addCommand(GetEmpNameEvent.EVENT_ID, GetEmpNameCommand);
            // 勤務形態取得
            addCommand(LoadWorkPatternEvent.EVENT_ID, LoadWorkPatternCommand);
            // 現在の日付取得
            addCommand(GetCurrentTimeEvent.EVENT_ID, GetCurrentTimeCommand);
            // 勤務表比較
            addCommand(CompareTimesheetEvent.EVENT_ID, CompareTimesheetCommand);
            // 勤務表アップロード
            addCommand(FileUploadEvent.EVENT_ID, FileUploadCommand);
            // ファイルアップロードをDBに反映
            addCommand(SaveTimesheetEvent.SAVE_UPLOAD_TIMESHEET_EVENT, SaveTimesheetCommand);

            //----------------------------------------------------------- TIMESHEET ADMIN
            addCommand(GetTimesheetSummaryEvent.EVENT_ID, GetTimesheetSummaryCommand);

            // ---------------------------------------------------------------------
            //	TRAFFIC
            // ---------------------------------------------------------------------
            addCommand(LoadRegTrainListEvent.EVENT_ID, LoadRegTrainListCommand);
            addCommand(LoadRegTotalsEvent.EVENT_ID, LoadRegTotalsCommand);
			// ユーザー交通費リスト
			addCommand(TrafficUserListEvent.EVENT_ID, TrafficUserListCommand);
			// 現在日付取得
			addCommand(TrafficCurrentDateEvent.EVENT_ID, TrafficCurrentDateCommand);
			addCommand(LoadRegOtherListEvent.EVENT_ID, LoadRegOtherListCommand);
			// 交通費合計データを取得
			addCommand(TrafficTotalEvent.EVENT_ID, TrafficTotalCommand);
			// 交通費新規作成処理
			addCommand(TrafficNewWriteEvent.EVENT_ID, TrafficNewWriteCommand);
			// 交通費非定期業務分合計
			addCommand(TrafficIrregAffairsEvent.EVENT_ID, TrafficIrregAffairsCommand);
        }
    }
}