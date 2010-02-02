package com.prms.client.flex.util {
    import com.prms.client.flex.Constants;
    import com.prms.client.flex.views.timesheet.admin.AdminTimesheetMain;
    import com.prms.client.flex.views.timesheet.user.UserTimesheetMain;
    import com.prms.client.flex.views.traffic.user.UserTrafficMain;

    import mx.containers.ViewStack;
    import mx.controls.Alert;

    /**
     * Viewstack画面遷移
     * @author developer002
     */
    public class ViewStackChangeController {
        /**
         * Viewstack画面遷移
         * @param parent UserTimesheetMain
         * @param childId Viewstackの子画面
         * @param recurse falseの場合このコンポーネントは作成されますが、子は作成されません
         */
        public static function viewstackChange(parent:*, childId:String):void {

            switch (childId) {
                case Constants.LAYOUT_LOGIN: // ログイン画面
                    parent = index(parent);
                    parent.userLayout = null;
                    parent.adminLayout = null;
                    createViewStactChild(parent.viewStack, Constants.VIEWSTACK_LOGIN);
                    parent.viewStack.selectedChild = parent.loginLayout;
                    break;
                case Constants.LAYOUT_USER: // ユーザレイアウト
                    parent = index(parent);
                    parent.loginLayout = null;
                    parent.adminLayout = null;
                    createViewStactChild(parent.viewStack, Constants.VIEWSTACK_USER);
                    parent.viewStack.selectedChild = parent.userLayout;
                    break;
                case Constants.LAYOUT_ADMIN: // 管理者レイアウト
                    parent = index(parent);
                    parent.loginLayout = null;
                    parent.userLayout = null;
                    createViewStactChild(parent.viewStack, Constants.VIEWSTACK_ADMIN);
                    parent.viewStack.selectedChild = parent.adminLayout;
                    break;
                case Constants.USER_TIMESHEET_LIST:	// ユーザー勤務表のリスト画面
                    parent = UserTimesheetMain(parent);
                    parent.userTimesheetDetails = null;
                    createViewStactChild(parent.userTimesheetMainViewStack,Constants.VIEWSTACK_LIST_INDEX);
                    parent.userTimesheetMainViewStack.selectedChild = parent.userTimesheetList;
                    break;
                case Constants.USER_TIMESHEET_DETAILS:	// ユーザー勤務表の詳細画面
                    parent = UserTimesheetMain(parent);
                    parent.userTimesheetList = null;
                    createViewStactChild(parent.userTimesheetMainViewStack,Constants.VIEWSTACK_DETAIL_INDEX);
                    parent.userTimesheetMainViewStack.selectedChild = parent.userTimesheetDetails;
                    break;
                case Constants.ADMIN_TIMESHEET_LIST:	// 管理者勤務表のリスト画面
                    parent = AdminTimesheetMain(parent);
                    parent.adminTimesheetDetails = null;
                    createViewStactChild(parent.adminTimesheetMainViewStack,Constants.VIEWSTACK_LIST_INDEX);
                    parent.adminTimesheetMainViewStack.selectedChild = parent.adminTimesheetList;
                    break;
                case Constants.ADMIN_TIMESHEET_DETAILS:	// 管理者勤務表の詳細画面
                    parent = AdminTimesheetMain(parent);
                    parent.adminTimesheetList = null;
                    createViewStactChild(parent.adminTimesheetMainViewStack,Constants.VIEWSTACK_DETAIL_INDEX);
                    parent.adminTimesheetMainViewStack.selectedChild = parent.adminTimesheetDetails;
                    break;
                case Constants.USER_TRAFFIC_TOTALS:	// 交通費ユーザー合計画面
                    parent = UserTrafficMain(parent);
                    parent.userTrafficList = null;
                    createViewStactChild(parent.trafficViewStack, Constants.CONST_INT_ONE);
                    parent.trafficViewStack.selectedChild = parent.userTrafficTotals;
                    break;
                case Constants.USER_TRAFFIC_DETAILS:	// 交通費ユーザー詳細画面
                    parent = UserTrafficMain(parent);
                    parent.userTrafficList = null;
                    parent.userTrafficTotals = null;
                    createViewStactChild(parent.trafficViewStack, Constants.CONST_INT_TWO);
                    parent.trafficViewStack.selectedChild = parent.userTrafficDetails;
                    break;
//        		case Constants.USER_TRAFFIC_IRREGULAR:	// 交通費ユーザー通勤分非定期
//        			parent = UserTrafficMain(parent);
//	                parent.userTrafficList = null;
//	                parent.userTrafficTotals = null;
//	                createViewStactChild(parent.trafficViewStack, Constants.CONST_INT_THREE);
//	                parent.trafficViewStack.selectedChild = parent.userTrafficIrregCommutation;
//        		break;
                default :
                    Alert.show("TimesheetViewStackController.changeViewstack() is fail!!!", "PRMS ERROR");
            }
        }

        /**
         * 子ビュースタックを生成
         * @param viewStack ビュースタック
         * @param index 子画面のindex番号
         *
         */
        private static function createViewStactChild(viewStack:ViewStack, index:int):void {
            viewStack.createComponentFromDescriptor(viewStack.childDescriptors[index], true);
            viewStack.validateNow();
        }
    }
}

