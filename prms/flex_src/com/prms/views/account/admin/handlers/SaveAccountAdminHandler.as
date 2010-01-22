import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.prms.business.events.account.SaveAccountAdminEvent;
import com.prms.business.events.account.SaveAccountFormEvent;
import com.prms.vo.AccountUser;

import mx.collections.ArrayCollection;
import mx.messaging.messages.RemotingMessage;

[Bindable] private var account:AccountUser = new AccountUser();

private var accountSaveDocument:SaveAccountAdmin;

// 会社名
[Bindable]
public var companyName:ArrayCollection = new ArrayCollection(
    [ {label:"ルウガルソン", data:1},
      {label:"ルウガルソン・スイード", data:2},
      {label:"ルウガルソン・ラーニング", data:3} ]);

// 	権限
[Bindable]
public var rolesName:ArrayCollection = new ArrayCollection(
    [ {label:"USER", data:1},
      {label:"ADMIN", data:2}]);

// 	上位部署
[Bindable]
public var highDeptName:ArrayCollection = new ArrayCollection(
    [ {label:"開発部", data:1},
      {label:"SI部", data:2},
      {label:"総務部", data:3},
      {label:"営業部", data:4},
      {label:"研修所", data:5},
      {label:"企画事業推進G", data:6}]);

// 	下位部署
[Bindable]
public var rowDeptName:ArrayCollection = new ArrayCollection(
    [ {label:"開発1G", data:7},
      {label:"開発2G", data:8},
      {label:"開発3G", data:9},
      {label:"SI1部", data:10},
      {label:"SI2部", data:11},
      {label:"SI3部", data:12}]);

private function init():void
{

	accountSaveDocument = SaveAccountAdmin(document);

	registerClassAlias("flex.messaging.messages.RemotingMessage",RemotingMessage);

	// 2010.1.18 人事管理初期ページ処理前
//	var accountSaveFormObj:SaveAccountFormEvent = new SaveAccountFormEvent(account, accountSaveDocument);
//	CairngormEventDispatcher.getInstance().dispatchEvent(accountSaveFormObj);

	// コンボボックスの初期値を設定する
	account.accountAdminCompanyFlg = "01";
	account.deptCode = "07";
	account.role = "01";
}

/**
 * 会社名コンボボックスイベントコントローラ
 * @param event
 * @return
 */
private function companyNameCloseHandler(event:Event):void {

	account.accountAdminCompanyFlg = "0" + ComboBox(event.target).selectedItem.data;

}

/**
 * 上位部署コンボボックスイベントコントローラ
 * @param event
 * @return
 */
private function highDeptNameCloseHandler(event:Event):void {

//	account.accountAdminCompanyFlg = "0" + ComboBox(event.target).selectedItem.data;

}

/**
 * 下位部署コンボボックスイベントコントローラ
 * @param event
 * @return
 */
private function rowDeptNameCloseHandler(event:Event):void {

	if (ComboBox(event.target).selectedItem.data < 10)
	{
		account.deptCode = "0" + ComboBox(event.target).selectedItem.data;
	}
	else
	{
		account.deptCode = ComboBox(event.target).selectedItem.data;
	}
}

/**
 * 権限コンボボックスイベントコントローラ
 * @param event
 * @return
 */
private function roleNameCloseHandler(event:Event):void {

	// ユーザーの場合
	if (ComboBox(event.target).selectedItem.data == 1)
	{
		account.role = "01";
	}
	// 管理者の場合
	else if (ComboBox(event.target).selectedItem.data == 2)
	{
		account.role = "02";
	}
}

/**
 * ユーザーから入力された内容処理
 * @param
 * @return
 */
private function clickSaveAccountUserHandler():void
{

	// スイートの場合
	if (account.accountAdminCompanyFlg == "02")
	{
		// 開発１部の場合
		if (account.deptCode == "07")
		{
			account.deptCode = "02";
		}
		// 開発２部の場合
		else if (account.deptCode == "08")
		{
			account.deptCode = "03";
		}
	}

	// 入力値設定
	account.empNo = empNoTextInput.text;					// 社員番号
	account.firstName = userFirstNameTextInput.text;		// ユーザー名(姓)
	account.lastName = userLastNameTextInput.text;			// ユーザー名(名)
	account.hireDay = userHireDayDateField.text;			// 入社日
	account.email = userMailAddressTextInput.text;			// メール

	var saveAccountUserObj:SaveAccountAdminEvent = new SaveAccountAdminEvent(account, accountSaveDocument);
	CairngormEventDispatcher.getInstance().dispatchEvent(saveAccountUserObj);
}

/**
 * 戻る時に入力フォームを初期化して前画面に遷移
 * @param
 * @return
 */
private function clickAccountBackHandler():void
{
	// テキストボックスを初期化する
	empNoTextInput.text = "";
	userFirstNameTextInput.text = "";
	userLastNameTextInput.text = "";
	userHireDayDateField.text = "";
	userMailAddressTextInput.text = "";

	// コンボボックスを初期化する
	companyNameCombBox.selectedIndex = 0;
	highDeptNameComboBox.selectedIndex = 0;
	rowDeptNameComboBox.selectedIndex = 0;
	roleNameComboBox.selectedIndex = 0;
	account.accountAdminCompanyFlg = "01";
	account.deptCode = "07";
	account.role = "01";

	// 前画面(社員リスト)に遷移する
	parentDocument.accountAdminViewStack.selectedChild = parentDocument.accountAdminList;
}