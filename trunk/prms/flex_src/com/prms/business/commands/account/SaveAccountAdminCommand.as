package com.prms.business.commands.account {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.business.delegates.AccountDelegate;
    import com.prms.business.delegates.PrmsDelegate;
    import com.prms.business.events.account.SaveAccountAdminEvent;
    import com.prms.model.AccountModelLocator;
    import com.prms.util.Message;
    import com.prms.views.account.admin.SaveAccountAdmin;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import mx.controls.Alert;
    import mx.rpc.Responder;

    /**
     * 新規ユーザーを登録する
     */
    public class SaveAccountAdminCommand implements ICommand {
        private var document:SaveAccountAdmin;
        private var model:AccountModelLocator = AccountModelLocator.getInstance();
        private var saveMsgTimer:Timer;

        public function execute(event:CairngormEvent):void {
            document = (event as SaveAccountAdminEvent).saveAccountDoc;
            var responder:Responder = new Responder(onResult_saveAdmin, onFault_saveAdmin);
            var delegate:AccountDelegate = new AccountDelegate(responder);
            delegate.saveAccountAdmin((event as SaveAccountAdminEvent).account);
        }

        private function onResult_saveAdmin(event:* = null):void {
            var message:Message = event.result;

            // ユーザー登録に成功下場合
            if (message.msgType == "I") {
                // タイマーの時間を指定
                saveMsgTimer = new Timer(2000);
                // タイマーイベント登録
                saveMsgTimer.addEventListener(TimerEvent.TIMER, timerEventHandler);
                // メッセージを表示する
                document.parentDocument.parentDocument.headerMessageHBox.visible = true;
                // タイマースタート
                saveMsgTimer.start();
            }
            // ユーザー登録の際妥当性エラーが発生した場合
            else if (message.msgType == "E") {
                mx.controls.Alert.show(message.msgBody, "ERROR : " + message.msgType + "-" + message.msgId);
            }
            // ユーザー登録の際妥当性アラートが発生した場合
            else if (message.msgType == "A") {
                mx.controls.Alert.show(message.msgBody, "ALERT : " + message.msgType + "-" + message.msgId);
            }
        }

        // 失敗
        private function onFault_saveAdmin(event:* = null):void {
            //Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
            Message.showErrorMessage(event);
        }

        /**
         * 成功した時出した成功メッセージを終了する。
         * @param TimerEvent
         * @return
         */
        private function timerEventHandler(evt:TimerEvent):void {
            // タイマーストップ
            saveMsgTimer.stop();
            // メッセージ隠す
            document.parentDocument.parentDocument.headerMessageHBox.visible = false;
        }
    }
}