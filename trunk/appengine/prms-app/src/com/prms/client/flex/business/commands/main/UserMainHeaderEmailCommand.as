package com.prms.client.flex.business.commands.main {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.business.delegates.AccountDelegate;
    import com.prms.client.flex.business.delegates.PrmsDelegate;
    import com.prms.client.flex.business.events.main.UserMainHeaderEmailEvent;
    import com.prms.client.flex.util.Message;
    import com.prms.client.flex.views.main.user.UserMainLayout;

    import mx.rpc.Responder;

    /**
     *
     * @author DEV006
     */
    public class UserMainHeaderEmailCommand implements ICommand {

        private var infoDoc:UserMainLayout;

        public function execute(event:CairngormEvent):void {
            infoDoc = (event as UserMainHeaderEmailEvent).doc;
            var responder:Responder = new Responder(onResult_userEmail, onFault_userEmail);
            var delegate:PrmsDelegate = new PrmsDelegate(responder);
            delegate.accountUserEmail();
        }

        private function onResult_userEmail(event:* = null):void {

			// 取得されたメールアドレスを画面に表示する
			infoDoc.userMailLabel.text = event.result.email;

        }

        private function onFault_userEmail(event:* = null):void {
            Message.showErrorMessage(event);
        }
    }
}

