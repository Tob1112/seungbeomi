package com.prms.business.commands.main {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.Constants;
    import com.prms.business.events.main.UserMainHeaderEvent;
    import com.prms.model.UserMainHeaderModelLocator;
    import com.prms.views.main.user.UserMainLayout;
    import com.prms.vo.Main;

    /**
     *
     * @author DEV006
     */
    public class UserMainHeaderCommand implements ICommand {
        private var model:UserMainHeaderModelLocator = UserMainHeaderModelLocator.getInstance();
        private var document:UserMainLayout;

        /**
         *
         * @param event
         *
         */
        public function execute(event:CairngormEvent):void {
            document = (event as UserMainHeaderEvent).doc;
            var main:Main = (event as UserMainHeaderEvent).main;

            // ユーザーデータをModelLocatorへ格納
            model.main = main.main as String;

            // メイン画面のヘッダメニュー中「勤務表」が選択された場合
            if (model.main == Constants.STATUS_USER_TIMESHEET) {
                document.userModuleLoader.url = Constants.USER_WORK_TIMESHEET_MAIN_SWF;
            }
            // メイン画面のヘッダメニュー中「交通費」が選択された場合
            else if (model.main == Constants.STATUS_USER_TRANSPORTATION) {
                document.userModuleLoader.url = Constants.USER_TRAFFIC_MAIN_SWF;
            }
            // メイン画面のヘッダメニュー中「有給」が選択された場合
            else if (model.main == Constants.STATUS_USER_VACATION) {
                //_document.userModuleLoader.url = Constants.USER_VACATION_LIST_SWF;
            }
            // メイン画面のヘッダメニュー中「アカウント」が選択された場合
            else if (model.main == Constants.STATUS_USER_ACCOUNT) {
                document.userModuleLoader.url = Constants.ACCOUNT_USER_BODY_SWF;
            }
        }
    }
}