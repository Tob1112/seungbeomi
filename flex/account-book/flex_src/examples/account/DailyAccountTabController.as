package examples.account {
    import examples.account.dto.Account;
    import examples.account.events.RecordUpdateWindowEvent;

    import flash.events.MouseEvent;

    import mx.core.IMXMLObject;
    import mx.events.FlexEvent;
    import mx.events.ListEvent;
    import mx.managers.PopUpManager;

    public class DailyAccountTabController implements IMXMLObject {
        private var view:DailyAccountTab;

        public function DailyAccountTabController() {
        }

        public function initialized(document:Object, id:String):void {
            view=document as DailyAccountTab;
            view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        public function creationCompleteHandler(event:FlexEvent):void {
            view.accountGrid.addEventListener(ListEvent.CHANGE, accountGridChangeHandler);
            view.insertButton.addEventListener(MouseEvent.CLICK, insertButtonClickHandler);
            view.updateButton.addEventListener(MouseEvent.CLICK, updateButtonClickHandler);
            view.deleteButton.addEventListener(MouseEvent.CLICK, deleteButtonClickHandler);
        }

        public function accountGridChangeHandler(event:ListEvent):void {
            if (view.accountGrid.selectedItem == null) {
                view.currentState="";
            } else {
                view.currentState="Selected";
            }
        }

        public function insertButtonClickHandler(event:MouseEvent):void {
            var insertWindow:RecordUpdateWindow=PopUpManager.createPopUp(view, RecordUpdateWindow, true) as RecordUpdateWindow;
            insertWindow.currentState="Insert";
            insertWindow.addEventListener(RecordUpdateWindowEvent.UPDATE_COMPLETE, recordUpdateWindowCompleteHandler);
            PopUpManager.centerPopUp(insertWindow);
        }

        public function updateButtonClickHandler(event:MouseEvent):void {
            var account:Account=Account(view.accountGrid.selectedItem);
            var updateWindow:RecordUpdateWindow=PopUpManager.createPopUp(view, RecordUpdateWindow, true) as RecordUpdateWindow;

            updateWindow.currentState="Update";
            updateWindow.addEventListener(RecordUpdateWindowEvent.UPDATE_COMPLETE, recordUpdateWindowCompleteHandler);

            updateWindow.model.account=account;

            PopUpManager.centerPopUp(updateWindow);
        }

        public function deleteButtonClickHandler(event:MouseEvent):void {
            var account:Account=Account(view.accountGrid.selectedItem);
            var deleteWindow:RecordUpdateWindow=PopUpManager.createPopUp(view, RecordUpdateWindow, true) as RecordUpdateWindow;

            deleteWindow.currentState="Delete";
            deleteWindow.addEventListener(RecordUpdateWindowEvent.UPDATE_COMPLETE, recordUpdateWindowCompleteHandler);

            deleteWindow.model.account=account;
            PopUpManager.centerPopUp(deleteWindow);
        }

        private function recordUpdateWindowCompleteHandler(event:RecordUpdateWindowEvent):void {
            // 未選択状態に遷移
            view.currentState="";

            var main:AccountBookMain=view.parentDocument as AccountBookMain;
            main.accountBookMainController.doFindAllData();
        }

    }
}