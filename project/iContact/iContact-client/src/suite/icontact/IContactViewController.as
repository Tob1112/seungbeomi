package suite.icontact {
    import flash.events.MouseEvent;

    import mx.core.IMXMLObject;
    import mx.events.ChildExistenceChangedEvent;
    import mx.events.FlexEvent;

    import suite.Constants;

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
            view.iContactTabNavigator.addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, chileRemoveHandler);
            view.newContactBtn.addEventListener(MouseEvent.CLICK, clickNewContactBtnHandler);
            view.loginBtn.addEventListener(MouseEvent.CLICK, clickLoginBtnHandler);
            view.iContactDataGrid.addEventListener(MouseEvent.DOUBLE_CLICK, openContactHandler);
            view.iContactTabNavigator.addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, childRemoveHandler);

        }

        private function clickChangeStateBtnHandler(e:MouseEvent):void {
            view.changeStateBtn.label = view.changeStateBtn.label=="小" ? "大": "小";
            view.currentState = view.currentState=="small" ? "big" : "small";
        }

        private function chileRemoveHandler():void {
            if (view.iContactTabNavigator.numChildren == 1) {
                view.currentState = "small";
            }
        }

        private function clickNewContactBtnHandler(e:MouseEvent):void {
            //openTab(new Object());
            openContactHandler();
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

        // Double click
        private function openContactHandler(e:MouseEvent=null):void {
        	var contact:Object = e.target.data;
			trace("name : " + contact.NAME);

			view.currentState = Constants.BIG_STATE;
			if (view.changeStateBtn.label == Constants.SMALL_STATE_BUTTON_LABEL) {
				view.changeStateBtn.label = Constants.BIG_STATE_BUTTON_LABEL;
			}

			var children:Array = view.iContactTabNavigator.getChildren();
			var length:int = children.length;
			for (var i:int=0; i < length; i++) {
				if (children[i].contact.name == e.currentTarget.selectedItem) {
					view.iContactTabNavigator.selectedIndex = i;
					return;
				}
			}

			var form:IContactForm = new IContactForm();
			view.iContactTabNavigator.addChild(form);
			form.controller.contact = e.target.contact;
			view.iContactTabNavigator.selectedChild = form;

        }

        private function childRemoveHandler():void {
        	if (view.iContactTabNavigator.numChildren == 1) {
        		view.currentState = Constants.SMALL_STATE;
        	}
        }

    }
}

