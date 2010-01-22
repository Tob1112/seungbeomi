package com.prms.business.commands.account {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.business.delegates.AccountDelegate;
    import com.prms.business.delegates.PrmsDelegate;
    import com.prms.business.events.account.AccountAdminListEvent;
    import com.prms.model.AccountModelLocator;
    import com.prms.util.Message;
    import com.prms.views.account.admin.AccountAdminList;
    import com.prms.Constants;

    import mx.rpc.Responder;

    /**
     * 管理者→人事管理の社員リスト
     */
    public class AccountAdminListCommand implements ICommand {
        private var document:AccountAdminList;
        private var model:AccountModelLocator = AccountModelLocator.getInstance();
        private var userName:Array;

        public function execute(event:CairngormEvent):void {
            document = (event as AccountAdminListEvent).accountListDoc;
            var responder:Responder = new Responder(onResult_adminList, onFault_adminList);
            var delegate:AccountDelegate = new AccountDelegate(responder);
            delegate.accountAdminList((event as AccountAdminListEvent).account);
        }

        // 成功
        private function onResult_adminList(event:* = null):void {
            // 前のデータカウント
            var beforeData:int = Constants.CONST_INT_ZERO;
            // 後のデータカウント
            var afterData:int = Constants.CONST_INT_ZERO;
            // 初期データ判定 且つ 最後データ判定
            var indexFlg:int = Constants.CONST_INT_ZERO;

            // 削除データ判定フラグ
            // 「0」無し
            // 「1」有り
            var delFlg:int = Constants.CONST_INT_ZERO;

            // 取得したデータを「ModelLocator」に格納する
            model.accountAdminAC = event.result;

            // データ架空処理
            // 処理１：社員の名前を合わせる「姓+名」
            // 処理２：管理者の場合「admin」のデータのみ画面に表示する
            for (var i:int = 0; i < event.result.length; i++) {

                // 最初は前のデータがないため処理しない
                // 最初ではない場合現在のデータより前のデータを検出する
                if (indexFlg != Constants.CONST_INT_ZERO) {
                    // 前のデータ検出
                    beforeData = i - 1;
                }

                // 後のデータを検出する
                if (event.result.length > afterData) {
                    // 現在のデータの次のデータを検出する
                    afterData = i + 1;

                    // resultのデータ数とafterDataのカウントが同じであれば最後のでーたなので、
                    // -1する
                    if (event.result.length  ==  afterData) {
                        afterData = afterData - 1;
                    }
                }

                // 名前を架空する。
                // DBから取得したユーザーの姓と名を合わせて画面に表示する
                model.accountAdminAC[i].accountUserName = event.result[i].lastName + "  " + event.result[i].firstName;

                // 重複ユーザー処理
                // 管理者の場合権限が「admin」と「user」があるため、権限「user」は削除して画面に表示する
                if (indexFlg != Constants.CONST_INT_ZERO) {

                    if (model.accountAdminAC[i].empNo == model.accountAdminAC[beforeData].empNo
                    	|| model.accountAdminAC[i].empNo == model.accountAdminAC[afterData].empNo
                    	&& model.accountAdminAC[i].role == Constants.USER
                    	&& event.result.length != indexFlg) {
                        // データ削除adminのuser
                        model.accountAdminAC.removeItemAt(i);

                        // データが一件消されたため、カウントを合わせる
                        i = i - 1;
                        afterData = afterData - 1;
                        beforeData = beforeData - 1;

                        // 削除データ判定フラグを立てる
                        delFlg = Constants.CONST_INT_ONE;
                    }
                }

                // データが削除されてない場合
                if (delFlg  ==  Constants.CONST_INT_ZERO) {
                    // 最初実行フラグを「１」に設定して初期実行ではないことを意味する。
                    indexFlg = event.result.length;
                }
                // データが削除された場合
                else {
                    indexFlg = event.result.length;
                    // 削除データ判定フラグを「0」に設定する
                    delFlg  ==  Constants.CONST_INT_ZERO;
                }


            } // end for
            // 画面にデータを表示する
            document.accountAdminBodyEmployeeListDataGrid.dataProvider = model.accountAdminAC;
        }

        // 失敗
        private function onFault_adminList(event:* = null):void {
            //Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
            Message.showErrorMessage(event);
        }
    }
}