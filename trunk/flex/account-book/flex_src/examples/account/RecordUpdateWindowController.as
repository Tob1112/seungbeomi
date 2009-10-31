package examples.account {
    import examples.account.dto.Account;
    import examples.account.dto.FirstTitle;
    import examples.account.dto.SecondTitle;
    import examples.account.dto.ThirdTitle;
    import examples.account.dto.TitlesDto;
    import examples.account.events.RecordUpdateWindowEvent;

    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.collections.ItemResponder;
    import mx.controls.Alert;
    import mx.core.IMXMLObject;
    import mx.events.CloseEvent;
    import mx.events.FlexEvent;
    import mx.events.ListEvent;
    import mx.managers.PopUpManager;
    import mx.rpc.AsyncResponder;
    import mx.rpc.AsyncToken;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.validators.Validator;

    public class RecordUpdateWindowController implements IMXMLObject {
        private var view:RecordUpdateWindow;

        public function RecordUpdateWindowController() {
        }

        public function initialized(document:Object, id:String):void {
            view=document as RecordUpdateWindow;
            view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        public function creationCompleteHandler(event:Event):void {
            // 初期化を行います
            view.executeButton.addEventListener(MouseEvent.CLICK, executeButtonClickHandler);
            view.cancelButton.addEventListener(MouseEvent.CLICK, cancelButtonClickHandler);
            view.addEventListener(CloseEvent.CLOSE, closeButtonClickHandler);
            view.firstTitleCmb.addEventListener(ListEvent.CHANGE, firstTitleComboboxChangeHandler);

            var token:AsyncToken=view.accountBookService.findTitles();
            token.addResponder(new AsyncResponder(findTitlesResultHandler, findTitlesFaultHandler));
        }

        private function findTitlesResultHandler(event:ResultEvent, obj:Object=null):void {
            var titlesDto:TitlesDto=event.result as TitlesDto;
            view.model.firstTitleList=titlesDto.firstTitleList;
            view.model.secondTitleList=titlesDto.secondTitleList;
            view.model.thirdTitleList=titlesDto.thirdTitleList;

            // 大項目のコンボボックスの初期値を選択する
            var firstTitleId:int=view.model.account.firstTitle;
            var firstTitlesArray:Array=titlesDto.firstTitleList.source;
            var firstTitleSelectIndex:int=-1;

            for (var i:int; i < firstTitlesArray.length; i++) {
                if (firstTitlesArray[i].firstTitleId == firstTitleId) {
                    firstTitleSelectIndex=i;
                    break;
                }
            }
            view.firstTitleCmb.selectedIndex=firstTitleSelectIndex;

            // 大項目のコンボボックスの初期値を選択する
            var secondTitleId:int=view.model.account.secondTitle;
            var secondTitlesArray:Array=titlesDto.secondTitleList.source;
            var secondTitleSelectIndex:int=-1;

            for (var j:int; j < secondTitlesArray.length; j++) {
                if (secondTitlesArray[j].secondTitleId == secondTitleId) {
                    secondTitleSelectIndex=j;
                    break;
                }
            }
            view.secondTitleCmb.selectedIndex=secondTitleSelectIndex;

            // バリデータを有効にします
            view.validators.forEach(function(item:Object, index:int, array:Array):void {
                    item.enabled=true;
                });
        }

        private function findTitlesFaultHandler(event:FaultEvent, obj:Object=null):void {
            throw new Error("error on accountBookService.findTitles: " + event.message);
        }


        public function executeButtonClickHandler(event:MouseEvent):void {
            // 入力チェック: バリデータが検証NGなら何もしない
            var validatorResult:Array=Validator.validateAll(view.validators);
            if (validatorResult.length > 0) {
                return;
            }

            var state:String=view.currentState;

            // モード(状態で代用)によって処理振り分け
            switch (view.currentState) {
                case "Insert":
                    Alert.show("この記録を追加してよろしいですか？", "確認", Alert.OK | Alert.CANCEL, view, insertConfirmCallback);
                    break;
                case "Update":
                    Alert.show("この記録を訂正してよろしいですか？", "確認", Alert.OK | Alert.CANCEL, view, updateConfirmCallback);
                    break;
                case "Delete":
                    Alert.show("この記録を削除してよろしいですか？", "確認", Alert.OK | Alert.CANCEL, view, deleteConfirmCallback);
                    break;
                default:
                    throw new Error("currentState invalid!: " + view.currentState);
            }
        }

        private function insertConfirmCallback(event:CloseEvent):void {
            if (event.detail == Alert.OK) {
                doInsert();
            }
        }

        private function updateConfirmCallback(event:CloseEvent):void {
            if (event.detail == Alert.OK) {
                doUpdate();
            }
        }

        private function deleteConfirmCallback(event:CloseEvent):void {
            if (event.detail == Alert.OK) {
                doDelete();
            }
        }


        public function cancelButtonClickHandler(event:MouseEvent):void {
            PopUpManager.removePopUp(view);
        }

        public function closeButtonClickHandler(event:CloseEvent):void {
            PopUpManager.removePopUp(view);
        }

        private function doInsert():void {
            var newAccount:Account=new Account();

            newAccount.txdate=view.txdateField.selectedDate;
            newAccount.firstTitle=FirstTitle(view.firstTitleCmb.selectedItem).firstTitleId;
            newAccount.secondTitle=SecondTitle(view.secondTitleCmb.selectedItem).secondTitleId;
            newAccount.thirdTitle=view.thirdTitleCmb.text;
            newAccount.price=Number(view.priceTi.text);
            newAccount.version=1;

            var token:AsyncToken=view.accountBookService.doInsert(newAccount);
            token.addResponder(new ItemResponder(function(e:ResultEvent, obj:Object=null):void {
                    view.dispatchEvent(new RecordUpdateWindowEvent(RecordUpdateWindowEvent.UPDATE_COMPLETE));
                    PopUpManager.removePopUp(view);
                }, function(e:FaultEvent, obj:Object=null):void {
                    Alert.show("fail at getTotalAccount" + e.message);
                }));
        }

        private function doUpdate():void {
            // 更新用データセット
            var updatedRecord:Account=new Account();
            updatedRecord.accountId=view.model.account.accountId;
            updatedRecord.txdate=view.txdateField.selectedDate;
            updatedRecord.firstTitle=FirstTitle(view.firstTitleCmb.selectedItem).firstTitleId;
            updatedRecord.secondTitle=SecondTitle(view.secondTitleCmb.selectedItem).secondTitleId;
            updatedRecord.thirdTitle=view.thirdTitleCmb.text;
            updatedRecord.price=Number(view.priceTi.text);
            updatedRecord.version=view.model.account.version;

            var token:AsyncToken=view.accountBookService.doUpdate(updatedRecord);
            token.addResponder(new ItemResponder(doUpdateResultHandler, doUpdateFaultHandler));
        }

        private function doUpdateResultHandler(event:ResultEvent, obj:Object=null):void {
            view.dispatchEvent(new RecordUpdateWindowEvent(RecordUpdateWindowEvent.UPDATE_COMPLETE));
            PopUpManager.removePopUp(view);
        }

        private function doUpdateFaultHandler(event:FaultEvent, obj:Object=null):void {
            throw new Error("error on accountBookService.insert: " + event.message);
        }

        private function doDelete():void {
            var token:AsyncToken=view.accountBookService.doDelete(view.model.account);
            token.addResponder(new ItemResponder(doDeleteResultHandler, doDeleteFaultHandler));
        }

        private function doDeleteResultHandler(event:ResultEvent, obj:Object=null):void {
            view.dispatchEvent(new RecordUpdateWindowEvent(RecordUpdateWindowEvent.UPDATE_COMPLETE));
            PopUpManager.removePopUp(view);
        }

        private function doDeleteFaultHandler(event:FaultEvent, obj:Object=null):void {
            throw new Error("error on accountBookService.insert: " + event.message);
        }

        private function firstTitleComboboxChangeHandler(event:ListEvent):void {
            if (view.firstTitleCmb.selectedItem != null) {
                var firstTitleId:int=FirstTitle(view.firstTitleCmb.selectedItem).firstTitleId;

                view.model.secondTitleList.filterFunction=function(item:Object):Boolean {
                    return SecondTitle(item).firstTitleId == firstTitleId;
                }
            } else {
                view.model.secondTitleList.filterFunction=null;
            }

            // フィルタを適用
            view.model.secondTitleList.refresh();
        }
    }
}