import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.prms.business.events.account.AccountAdminCurrentTimeEvent;
import com.prms.business.events.account.AccountAdminListEvent;
import com.prms.vo.AccountUser;

[Bindable] private var account:AccountUser;

private var adminListDocument:AccountAdminList;

private function init():void {
    adminListDocument = AccountAdminList(document);

	// 現在日付表示
	var accountAdminInitObj:AccountAdminCurrentTimeEvent = new AccountAdminCurrentTimeEvent(adminListDocument);
    CairngormEventDispatcher.getInstance().dispatchEvent(accountAdminInitObj);

}

/**
 * 会社選択ハンドラー
 * @param args 選択された会社コード
 * @return
 */
private function clickButtonCompanySelectHandler(args:String):void {

    // 会社が選択されてない場合(初期画面)はメッセージを出す。
    accountAdminBodyCompanySelectedMessageText.visible = false;
    // 会社が選択された場合は該当会社の社員一覧を出す。
    accountAdminBodyEmployeeListHBox.visible = true;

    var account:AccountUser = new AccountUser();

    // パラメータを格納する
    account.accountAdminCompanyFlg = args;

    var accountAdminObj:AccountAdminListEvent = new AccountAdminListEvent(account, adminListDocument);
    CairngormEventDispatcher.getInstance().dispatchEvent(accountAdminObj);

}


// DataGrid行番号処理
private function dispRowNum(cItem:Object, i_column:DataGridColumn):String {
    // datagridのitem数を取得する
    var index:int = accountAdminBodyEmployeeListDataGrid.dataProvider.getItemIndex(cItem) + 1;
    // indexリターンする
    return String(index);
}

/**
 * 社員新規登録画面を呼び出す。
 * @param
 * @return
 */
private function clickButtonNewAccountHandler():void {
    parentDocument.accountAdminViewStack.selectedChild = parentDocument.saveAccountAdmin;
}