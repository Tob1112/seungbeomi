package {

    import flash.events.MouseEvent;

    import mx.core.IMXMLObject;
    import mx.events.FlexEvent;
    import mx.events.IndexChangedEvent;

    import org.chronos.model.locator.AuthorizationDataModelLocator;

    public class indexHandler implements IMXMLObject {

        private var view:index;
        [Bindable]
        public var model:AuthorizationDataModelLocator = AuthorizationDataModelLocator.getInstance();


        public function initialized(document:Object, id:String):void {
            view = document as index;
            view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(e:FlexEvent):void {
            view.logInButton.addEventListener(MouseEvent.CLICK, clickLogInButtonHandler);   // login
            view.menuViews.addEventListener(IndexChangedEvent.CHANGE, changeMenuViewsBarHandler);    // change menuViewsBar
            //IFocusManagerComponent(view.userName).setFocus();
        }

        private function clickLogInButtonHandler(e:MouseEvent):void {
            view.authenticationForm.visible=true;
        }

        private function changeMenuViewsBarHandler(e:IndexChangedEvent):void {
            if (e.currentTarget.selectedChild.label == "Projects") {
            	view.menuViews.visible = false;
                view.projectsSubViewsBox.visible = true;
                view.projectsSubMenuViews.visible = true;
            } else {
            	view.menuViews.visible = true;
                view.projectsSubViewsBox.visible = false;
                view.projectsSubMenuViews.visible = false;
            }
        }
    }
}