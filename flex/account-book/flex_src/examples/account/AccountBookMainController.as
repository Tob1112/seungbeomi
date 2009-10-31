package examples.account {
    import examples.account.dto.TotalAccount;

    import flash.events.Event;

    import mx.collections.ArrayCollection;
    import mx.controls.Alert;
    import mx.core.IMXMLObject;
    import mx.events.FlexEvent;
    import mx.messaging.messages.ErrorMessage;
    import mx.rpc.AsyncResponder;
    import mx.rpc.AsyncToken;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    public class AccountBookMainController implements IMXMLObject {
        private var document:AccountBookMain;

        public function initialized(document:Object, id:String):void {
            this.document=AccountBookMain(document);
            this.document.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        public function creationCompleteHandler(event:Event):void {
            // 現在の年・月を取得
            var curDate:Date=new Date();
            document.model.txyear=curDate.fullYear;
            document.model.txmonth=curDate.month + 1;

            doFindAllData();
        }

        public function doFindAllData():void {
            var findEntriesToken:AsyncToken=document.accountBookService.findAccountEntries(document.model.txyear, document.model.txmonth);
            findEntriesToken.addResponder(new AsyncResponder(findEntriesListResultHandler, serviceCallFaultHandler));

            var totalAccountToken:AsyncToken=document.accountBookService.getTotalAccount(document.model.txyear, document.model.txmonth);
            totalAccountToken.addResponder(new AsyncResponder(setTotalPriceHandler, serviceCallFaultHandler));

            var findGroupedAccountToken:AsyncToken=document.accountBookService.findGroupedAccounts(document.model.txyear, document.model.txmonth);
            findGroupedAccountToken.addResponder(new AsyncResponder(function(e:ResultEvent, obj:Object=null):void {
                    var groups:ArrayCollection=e.result as ArrayCollection;
                    document.groupedAccountTab.model.groupedAccountList=groups;
                }, serviceCallFaultHandler));
        }

        private function findEntriesListResultHandler(e:ResultEvent, obj:Object=null):void {
            var accounts:ArrayCollection=e.result as ArrayCollection;
            document.dailyAccountTab.model.accounts=accounts;
        }

        private function setTotalPriceHandler(e:ResultEvent, obj:Object=null):void {
            var totalAccount:TotalAccount=e.result as TotalAccount;
            if (totalAccount != null) {
                document.model.setTotalPrice(int(totalAccount.totalprice));
            } else {
                document.model.setTotalPrice(0);
            }
        }

        private function serviceCallFaultHandler(e:FaultEvent, obj:Object=null):void {
            var error:ErrorMessage=ErrorMessage(e.message);
            var faultCode:String=error.faultCode;
            var faultString:String=error.faultString;
            var faultDetail:String=error.faultDetail;
            //var customInfo:String = error.extendedData['customInfo'] as String;
            Alert.show("faultCode : " + faultCode + "\nfaultString : " + faultString + "\nfaultDetail : " + faultDetail);
        }
    }
}