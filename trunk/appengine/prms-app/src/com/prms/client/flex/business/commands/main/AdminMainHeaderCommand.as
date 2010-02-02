package com.prms.client.flex.business.commands.main {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.Constants;
    import com.prms.client.flex.business.events.main.AdminMainHeaderEvent;
    import com.prms.client.flex.model.UserMainHeaderModelLocator;
    import com.prms.client.flex.views.main.admin.AdminMainLayout;
    import com.prms.client.flex.vo.Main;

    public class AdminMainHeaderCommand implements ICommand {
        private var model:UserMainHeaderModelLocator = UserMainHeaderModelLocator.getInstance();
        private var document:AdminMainLayout;

        public function execute(event:CairngormEvent):void {
            document = (event as AdminMainHeaderEvent).doc;
            var adminMain:Main = (event as AdminMainHeaderEvent).adminMain;

            model.adminMain = adminMain.adminMain as String;

			// メニューコントロール
            // 勤怠管理
            if (model.adminMain == Constants.STATUS_ADMIN_WORK) {

				document.treeNav.work.visible = true;
				document.treeNav.salary.visible = false;
				document.treeNav.personnel.visible = false;

				// miniメニューが呼ばれた場合
				if (document.isClosed == true) {
					document.miniNav.miniWork.visible = true;
					document.miniNav.miniSalary.visible = false;
					document.miniNav.miniPersonnel.visible = false;
				}

				document.adminModuleLoader.url = Constants.ADMIN_TIMESHEET_MAIN_SWF;
            }
            // 給与管理
            else if (model.adminMain == Constants.STATUS_ADMIN_SALARY) {

				document.treeNav.work.visible = false;
				document.treeNav.salary.visible = true;
				document.treeNav.personnel.visible = false;

				if (document.isClosed == true) {
					document.miniNav.miniWork.visible = false;
					document.miniNav.miniSalary.visible = true;
					document.miniNav.miniPersonnel.visible = false;
				}
            }
            // 人事管理
            else if (model.adminMain == Constants.STATUS_ADMIN_PERSONNEL) {

				document.treeNav.work.visible = false;
				document.treeNav.salary.visible = false;
				document.treeNav.personnel.visible = true;

				if (document.isClosed == true) {
					document.miniNav.miniWork.visible = false;
					document.miniNav.miniSalary.visible = false;
					document.miniNav.miniPersonnel.visible = true;
				}

                document.adminModuleLoader.url = Constants.ACCOUNT_ADMIN_BODY_SWF;
            }
        }
    }
}