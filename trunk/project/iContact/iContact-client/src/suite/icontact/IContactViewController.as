package suite.icontact {
    import flash.events.MouseEvent;

    import mx.core.IMXMLObject;
    import mx.events.ChildExistenceChangedEvent;
    import mx.events.FlexEvent;

    public class IContactViewController implements IMXMLObject {

        private var view:IContactView;
        [Bindable] public var model:IContactModelLocator = IContactModelLocator.getInstance();

        public function initialized(doc:Object, id:String):void {
            view = doc as IContactView;
            view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        public function creationCompleteHandler(e:FlexEvent):void {
            // イベント登録
            registerEvent();
        }

        private function registerEvent():void {
            view.changeStateBtn.addEventListener(MouseEvent.CLICK, clickChangeStateBtnHandler);
            view.iContactNavigator.addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, chileRemoveHandler);
            view.newContactBtn.addEventListener(MouseEvent.CLICK, clickNewContactBtnHandler);
            view.loginBtn.addEventListener(MouseEvent.CLICK, clickLoginBtnHandler);
        }

        private function clickChangeStateBtnHandler(e:MouseEvent):void {
            view.changeStateBtn.label = view.changeStateBtn.label=="小" ? "大": "小";
            view.currentState = view.currentState=="small" ? "big" : "small";
        }

        private function chileRemoveHandler():void {
            if (view.iContactNavigator.numChildren == 1) {
                view.currentState = "small";
            }
        }

        private function clickNewContactBtnHandler(e:MouseEvent):void {
            openTab(new Object());
        }

        private function openTab(contact:Object):void {
            view.currentState = "big";
            if(view.changeStateBtn.label=="小") {
                view.changeStateBtn.label = "大";
            }
        }

        // LOGIN
        private function clickLoginBtnHandler(e:MouseEvent):void {
            var user:User = new User();
            user.username = view.usernameTxtIpt.text;
            user.password = view.passwordTxtIpt.text;
            model.user = user;
            var iContactEvent:IContactEvent = new IContactEvent(IContactEvent.LOGIN, view);
            iContactEvent.dispatch();
        }

    }
}

