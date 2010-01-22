package com.prms.business.commands.account {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.business.delegates.AccountDelegate;
    import com.prms.business.delegates.PrmsDelegate;
    import com.prms.business.events.account.AccountUserInfoEvent;
    import com.prms.util.Message;
    import com.prms.views.account.user.AccountUserBody;

    import mx.formatters.DateFormatter;
    import mx.rpc.Responder;

    public class AccountUserInfoCommand implements ICommand {

        private var infoDoc:AccountUserBody;

        public function execute(event:CairngormEvent):void {
            infoDoc = (event as AccountUserInfoEvent).doc;
            var responder:Responder = new Responder(onResult_userInfo, onFault_userInfo);
            var delegate:AccountDelegate = new AccountDelegate(responder);
            delegate.accountUserInfo();
        }

        private function onResult_userInfo(event:* = null):void {

		    // デートフォーマット
		    var formatter:DateFormatter = new DateFormatter();
		    formatter.formatString = "YYYY年 MM月 DD日 ( EEEE )";
		    infoDoc.accountUserBodyDateLabel.text = formatter.format( event.result.currentDate );

            infoDoc.accountUserBodyEmpNoLabel.text = "社員番号：" + event.result.empNo;
            infoDoc.accountUserBodyUserNameLabel.text = "名前：" + event.result.lastName + "  " + event.result.firstName;
        }

        private function onFault_userInfo(event:* = null):void {
            Message.showErrorMessage(event);
        }
    }
}