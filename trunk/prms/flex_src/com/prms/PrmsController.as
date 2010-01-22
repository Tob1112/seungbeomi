package com.prms {

    import com.adobe.cairngorm.control.FrontController;
    import com.prms.business.commands.account.AccountAdminCurrentTimeCommand;
    import com.prms.business.commands.account.AccountAdminListCommand;
    import com.prms.business.commands.account.AccountUserCommand;
    import com.prms.business.commands.account.AccountUserInfoCommand;
    import com.prms.business.commands.account.SaveAccountAdminCommand;
    import com.prms.business.commands.account.SaveAccountFormCommand;
    import com.prms.business.commands.login.LoginCommand;
    import com.prms.business.commands.main.AdminMainHeaderCommand;
    import com.prms.business.commands.main.UserMainHeaderCommand;
    import com.prms.business.commands.main.UserMainHeaderEmailCommand;
    import com.prms.business.commands.timesheet.GetCurrentTimeCommand;
    import com.prms.business.commands.timesheet.GetEmpNameCommand;
    import com.prms.business.commands.timesheet.LoadTimesheetDetailsCommand;
    import com.prms.business.commands.timesheet.LoadTimesheetListCommand;
    import com.prms.business.commands.timesheet.LoadWorkPatternCommand;
    import com.prms.business.commands.timesheet.SaveTimesheetCommand;
    import com.prms.business.commands.timesheet.WriteNewUserTimesheetCommand;
    import com.prms.business.events.account.AccountAdminCurrentTimeEvent;
    import com.prms.business.events.account.AccountAdminListEvent;
    import com.prms.business.events.account.AccountUserEvent;
    import com.prms.business.events.account.AccountUserInfoEvent;
    import com.prms.business.events.account.SaveAccountAdminEvent;
    import com.prms.business.events.account.SaveAccountFormEvent;
    import com.prms.business.events.login.LoginEvent;
    import com.prms.business.events.main.AdminMainHeaderEvent;
    import com.prms.business.events.main.UserMainHeaderEmailEvent;
    import com.prms.business.events.main.UserMainHeaderEvent;
    import com.prms.business.events.timesheet.GetCurrentTimeEvent;
    import com.prms.business.events.timesheet.GetEmpNameEvent;
    import com.prms.business.events.timesheet.LoadTimesheetDetailsEvent;
    import com.prms.business.events.timesheet.LoadTimesheetListEvent;
    import com.prms.business.events.timesheet.LoadWorkPatternEvent;
    import com.prms.business.events.timesheet.SaveTimesheetEvent;
    import com.prms.business.events.timesheet.WriteNewUserTimesheetEvent;

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
            // adminMainLeftMenu

            // ---------------------------------------------------------------------
            //	TIMESHEET
            // ---------------------------------------------------------------------
            // ユーザ勤務表初期処理
            addCommand(LoadTimesheetDetailsEvent.EVENT_ID, LoadTimesheetDetailsCommand);
            // 勤務表保存
            addCommand(SaveTimesheetEvent.EVENT_ID, SaveTimesheetCommand);
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

            //----------------------------------------------------------- TIMESHEET ADMIN
            //addCommand(TimesheetEvent, TimesheetCommand);
        }
    }
}