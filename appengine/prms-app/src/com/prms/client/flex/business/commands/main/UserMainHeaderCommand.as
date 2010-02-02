package com.prms.client.flex.business.commands.main {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.Constants;
    import com.prms.client.flex.business.events.main.UserMainHeaderEvent;
    import com.prms.client.flex.util.LayoutSizeUtil;
    import com.prms.client.flex.views.account.user.AccountUserBody;
    import com.prms.client.flex.views.timesheet.user.UserTimesheetMain;
    import com.prms.client.flex.views.traffic.user.UserTrafficMain;

    import mx.events.ModuleEvent;
    import mx.modules.ModuleLoader;

    /**
     *
     * @author DEV006
     */
    public class UserMainHeaderCommand implements ICommand {
        /**
         * @param event
         */
        public function execute(event:CairngormEvent):void {
            var status:String = (event as UserMainHeaderEvent).status;
            var moduleLoader:ModuleLoader = (event as UserMainHeaderEvent).moduleLoader;
            // moduleLoader.addEventListener(ModuleEvent.READY, setComponentSize);

            // メイン画面のヘッダメニュー中「勤務表」が選択された場合
            if (status == Constants.STATUS_USER_TIMESHEET) {
                moduleLoader.url = Constants.USER_WORK_TIMESHEET_MAIN_SWF;
            }
            // メイン画面のヘッダメニュー中「交通費」が選択された場合
            else if (status == Constants.STATUS_USER_TRAFFIC) {
                moduleLoader.url = Constants.USER_TRAFFIC_MAIN_SWF;
            }
            // メイン画面のヘッダメニュー中「有給」が選択された場合
            else if (status == Constants.STATUS_USER_VACATION) {
                //_document.userModuleLoader.url = Constants.USER_VACATION_LIST_SWF;
            }
            // メイン画面のヘッダメニュー中「アカウント」が選択された場合
            else if (status == Constants.STATUS_USER_ACCOUNT) {
                moduleLoader.url = Constants.ACCOUNT_USER_BODY_SWF;
            }
        }// end execute

        private function setComponentSize(event:ModuleEvent):void{
            var moduleLoader:ModuleLoader = event.target as ModuleLoader;
            if(moduleLoader.child is UserTimesheetMain){
                var timesheet:UserTimesheetMain = moduleLoader.child as UserTimesheetMain;
                timesheet.width = LayoutSizeUtil.moduleWidth();
                timesheet.height = LayoutSizeUtil.moduleHeight();
                    // 交通費
            }else if(moduleLoader.child is UserTrafficMain){
                var traffic:UserTrafficMain = moduleLoader.child as UserTrafficMain;
                traffic.width = LayoutSizeUtil.moduleWidth();
                traffic.height =  LayoutSizeUtil.moduleHeight();
                    // アカウント
            }else if(moduleLoader.child is AccountUserBody){
                var account:AccountUserBody = moduleLoader.child as AccountUserBody;
                account.width = LayoutSizeUtil.moduleWidth();
                account.height = LayoutSizeUtil.moduleWidth();
            }
        }// end setComponentSize
    }
}

