package {

    import flash.events.MouseEvent;

    import mx.core.IMXMLObject;
    import mx.events.FlexEvent;

    import org.chronos.model.locator.AuthorizationDataModelLocator;

    public class indexHandler implements IMXMLObject {

        private var view:index;
        [Bindable]
        public var model:AuthorizationDataModelLocator = AuthorizationDataModelLocator.getInstance();


        public function initialized(document:Object, id:String):void {
            view=document as index;
            view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(e:FlexEvent):void {
            view.logInButton.addEventListener(MouseEvent.CLICK, clickLogInButtonHandler);
            //IFocusManagerComponent(view.userName).setFocus();
        }

        private function clickLogInButtonHandler(e:MouseEvent):void {
            view.authenticationForm.visible=true;
        }
    }
}