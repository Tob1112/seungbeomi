package suite.icontact {

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class IContactFormController implements IMXMLObject{

		private var view:IContactForm;
        [Bindable] public var model:IContactModelLocator = IContactModelLocator.getInstance();
		[Bindable] public var _contact:Contact;

		public function initialized(doc:Object, id:String):void {
			view = doc as IContactForm;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}

		public function creationCompleteHandler(e:FlexEvent):void {
			//view.label = _contact.contact_id > 0 ? _contact.first_name + ' ' + _contact.last_name : 'New Contact';
		}

		public function set contact(contact:Contact):void {
			_contact = contact;
			view.label = _contact.name;
		}
	}
}