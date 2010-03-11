package {

    import flash.events.MouseEvent;

    import mx.core.IMXMLObject;
    import mx.events.FlexEvent;

    import org.april27.authentication.AuthenticationEvent;
    import org.april27.model.locator.AuthorizationDataModelLocator;

    public class indexHandler implements IMXMLObject {

        private var view:index;
        [Bindable]
        public var model:AuthorizationDataModelLocator=AuthorizationDataModelLocator.getInstance();


        public function initialized(document:Object, id:String):void {
            view=document as index;
            view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(e:FlexEvent):void {
            //view.logInOutButton.addEventListener(MouseEvent.CLICK, clickLogInOutButtonHandler);
            //IFocusManagerComponent(view.userName).setFocus();
        }

        private function clickLogInOutButtonHandler(e:MouseEvent):void {
            view.logInOutButton.enabled=false;
            view.april27Views.visible=false;
            view.authenticationForm.visible=true;
        }
    }
}