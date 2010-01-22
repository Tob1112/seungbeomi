import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.prms.Constants;
import com.prms.business.events.main.AdminMainHeaderEvent;
import com.prms.vo.Main;

[Bindable]
[Embed(source="/assets/images/icon_yajirusi_D_L.PNG")]
public var closeNav:Class;

[Bindable]
[Embed(source="/assets/images/icon_yajirusi_D_R.PNG")]
public var openNav:Class;

[Bindable] public var isClosed:Boolean = false;

[Bindable] public var lastView:Number;

[Bindable] public var currentView:Number = Constants.VIEWSTACK_LIST_INDEX;

[Bindable] public var menuWidth:int;

[Bindable] public var menuWidthMini:int;

private var adminMainDocument:AdminMainLayout;

// 初期ローダ判定フラグ
private var firstPageFlg:Boolean = false;

// ヘッダメニューの初期値を指定する。
[Bindable] public var selectedHeaderMenuItem:String = Constants.STATUS_ADMIN_WORK;

/**
 *
 */
private function init():void {
    adminMainDocument = AdminMainLayout(document);

    // ヘッダメニュー横サイズ
    menuWidth = flash.system.Capabilities.screenResolutionX / 7;
    // ヘッダメニュー横サイズ
    menuWidthMini = flash.system.Capabilities.screenResolutionX / 15;

    adminModuleLoader.url = Constants.ADMIN_TIMESHEET_MAIN_SWF;
}

// 左メニューナビゲーション
public function discloseNav():void {

    if (isClosed == false) {
		navStack.visible = false;
		lastView = navStack.selectedIndex;
		navStack.selectedIndex = 1;

		/**
		 * 初期ローダ時には「miniNav」がロードされる前なので、
		 * 処理しない(初期ロードの判定がないと「null参照」エラーになる)
		 */
		// 初期ではない場合
		if (firstPageFlg == true) {

			// miniメニューを表示する
			// 勤務表
			if (selectedHeaderMenuItem == Constants.STATUS_ADMIN_WORK) {
				miniNav.miniWork.visible = true;
				miniNav.miniSalary.visible = false;
				miniNav.miniPersonnel.visible = false;
			}
			// 給料
			else if (selectedHeaderMenuItem == Constants.STATUS_ADMIN_SALARY) {
				miniNav.miniWork.visible = false;
				miniNav.miniSalary.visible = true;
				miniNav.miniPersonnel.visible = false;
			}
			// 人事管理
			else if (selectedHeaderMenuItem == Constants.STATUS_ADMIN_PERSONNEL) {
				miniNav.miniWork.visible = false;
				miniNav.miniSalary.visible = false;
				miniNav.miniPersonnel.visible = true;
			}
		}

		shrink.end();
		shrink.play();
		isClosed = true;
		firstPageFlg = true;

    } else {
		navStack.visible =  false;
		navStack.selectedIndex = lastView;
		grow.end();
		grow.play();
		isClosed = false;
    }
}

public function clickAdminHeaderMenuHandler(args:String):void {
    var adminMain:Main = new Main();

	selectedHeaderMenuItem = args;

    adminMain.adminMain = args;

    var eventAdminObj:AdminMainHeaderEvent = new AdminMainHeaderEvent(adminMain, adminMainDocument);
    CairngormEventDispatcher.getInstance().dispatchEvent(eventAdminObj);
}