package com.prms.client.flex.business.commands.account {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.business.delegates.AccountDelegate;
    import com.prms.client.flex.business.delegates.PrmsDelegate;
    import com.prms.client.flex.business.events.account.AccountAdminCurrentTimeEvent;
    import com.prms.client.flex.util.Message;
    import com.prms.client.flex.views.account.admin.AccountAdminList;

    import mx.formatters.DateFormatter;
    import mx.rpc.Responder;

    public class AccountAdminCurrentTimeCommand implements ICommand {

        private var adminListDoc:AccountAdminList;

        public function execute(event:CairngormEvent):void {
            adminListDoc = (event as AccountAdminCurrentTimeEvent).doc;
            var responder:Responder = new Responder(onResult_adminCurrentTime, onFault_adminCurrentTime);
            var delegate:AccountDelegate = new AccountDelegate(responder);
            delegate.accountUserInfo();
        }

        private function onResult_adminCurrentTime(event:* = null):void {

		    // デートフォーマット
		    var formatter:DateFormatter = new DateFormatter();
		    formatter.formatString = "YYYY年 MM月 DD日 ( EEEE )";
		    adminListDoc.accountListDateLabel.text = formatter.format( event.result.currentDate );

        }

        private function onFault_adminCurrentTime(event:* = null):void {
            Message.showErrorMessage(event);
        }
    }
}