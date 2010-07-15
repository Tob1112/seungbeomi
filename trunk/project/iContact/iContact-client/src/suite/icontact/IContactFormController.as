package suite.icontact {

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class IContactFormController implements IMXMLObject{

		private var view:IContactForm;
        [Bindable] public var model:IContactModelLocator = IContactModelLocator.getInstance();

		public function initialized(doc:Object, id:String):void {
			view = doc as IContactForm;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}
	}
}