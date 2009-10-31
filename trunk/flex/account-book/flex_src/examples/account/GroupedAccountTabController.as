package examples.account {
    import mx.core.IMXMLObject;
    import mx.events.FlexEvent;

    public class GroupedAccountTabController implements IMXMLObject {
        private var view:GroupedAccountTab;

        public function GroupedAccountTabController() {
        }

        public function initialized(document:Object, id:String):void {
            view=document as GroupedAccountTab;
            view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(event:FlexEvent):void {
            //
        }
    }
}