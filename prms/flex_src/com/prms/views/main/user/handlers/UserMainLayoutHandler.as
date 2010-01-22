import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.prms.Constants;
import com.prms.business.events.main.UserMainHeaderEmailEvent;
import com.prms.business.events.main.UserMainHeaderEvent;
import com.prms.vo.Main;

[Bindable] private var menuWidth:int;
[Bindable] private var main:Main;
[Bindable] private var contentWidth:Number = 0;
[Bindable] private var contentHeight:Number = 0;

private var userMainDocument:UserMainLayout;

private function sizeSet():void {
    contentWidth = flash.system.Capabilities.screenResolutionX - 30;
    contentHeight = flash.system.Capabilities.screenResolutionY - 320;
}

/**
 *
 */
private function init():void {
    userMainDocument = UserMainLayout(document);

    // ヘッダメニュー横サイズ
    menuWidth = flash.system.Capabilities.screenResolutionX;

	// ヘッダユーザーメールアドレス取得
	var eventObj:UserMainHeaderEmailEvent = new UserMainHeaderEmailEvent(userMainDocument);
    CairngormEventDispatcher.getInstance().dispatchEvent(eventObj);

	// 初期モージュル
    userModuleLoader.url = Constants.USER_WORK_TIMESHEET_MAIN_SWF;

}

/**
 *
 * @param args
 */
private function clickHeaderMenuHandler(args:String):void {

    var main:Main = new Main();

    main.main = args;

	// メニュー変換
    var eventObj:UserMainHeaderEvent = new UserMainHeaderEvent(main, userMainDocument);
    CairngormEventDispatcher.getInstance().dispatchEvent(eventObj);
}