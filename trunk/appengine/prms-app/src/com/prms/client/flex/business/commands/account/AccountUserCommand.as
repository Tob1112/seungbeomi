package com.prms.client.flex.business.commands.account {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.business.delegates.AccountDelegate;
    import com.prms.client.flex.business.delegates.PrmsDelegate;
    import com.prms.client.flex.business.events.account.AccountUserEvent;
    import com.prms.client.flex.model.AccountModelLocator;
    import com.prms.client.flex.util.Message;
    import com.prms.client.flex.views.account.user.AccountUserBody;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import mx.controls.Alert;
    import mx.rpc.Responder;

    /**
     * ユーザーのパスワードを変更する
     */
    public class AccountUserCommand implements ICommand {
        private var model:AccountModelLocator = AccountModelLocator.getInstance();
        private var msgTimer:Timer;
        private var document:AccountUserBody;

        public function execute(event:CairngormEvent):void {
            document = (event as AccountUserEvent).doc;
            var responder:Responder = new Responder(onResult_user, onFault_user);
            var delegate:AccountDelegate = new AccountDelegate(responder);
            delegate.accountUserPasswordModify((event as AccountUserEvent).account);
        }

        // 成功
        private function onResult_user(event:* = null):void {
            if (event.result == true) {
                // タイマーの時間を指定
                msgTimer = new Timer(2000);
                // タイマーイベント登録
                msgTimer.addEventListener(TimerEvent.TIMER, timerEventHandler);
                // メッセージを表示する
                document.parentDocument.headerMessageHBox.visible = true;
                // タイマースタート
                msgTimer.start();
            } else {
                // ユーザーが入力した現在パスワードが間違った場合
                Alert.show("入力されたパスワードは正しくありません。現在のパスワードを再入力してください。");
            }
        }

        // 失敗
        private function onFault_user(event:* = null):void {
            Message.showErrorMessage(event);
        }

        /**
         * 成功した時出した成功メッセージを終了する。
         * @param TimerEvent
         * @return
         */
        private function timerEventHandler(evt:TimerEvent):void {
            // タイマーストップ
            msgTimer.stop();
            // メッセージ隠す
            document.parentDocument.headerMessageHBox.visible = false;
        }
    }
}