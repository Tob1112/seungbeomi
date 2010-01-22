package com.prms.business.commands.account {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.business.delegates.AccountDelegate;
    import com.prms.business.events.account.SaveAccountFormEvent;
    import com.prms.model.AccountModelLocator;
    import com.prms.util.Message;
    import com.prms.views.account.admin.SaveAccountAdmin;

    import mx.rpc.Responder;

    /**
     * 新規ユーザーを登録する
     */
    public class SaveAccountFormCommand implements ICommand {
        private var document:SaveAccountAdmin;
        private var model:AccountModelLocator = AccountModelLocator.getInstance();

        public function execute(event:CairngormEvent):void {
            document = (event as SaveAccountFormEvent).saveAccountDoc;
            var responder:Responder = new Responder(onResult_saveAdmin, onFault_saveAdmin);
            var delegate:AccountDelegate = new AccountDelegate(responder);
            delegate.saveAccountAdminForm((event as SaveAccountFormEvent).account);
        }

        private function onResult_saveAdmin(event:* = null):void {

        }

        private function onFault_saveAdmin(event:* = null):void {
            Message.showErrorMessage(event);
        }
    }
}