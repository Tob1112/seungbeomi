package com.icontact.view {

	import com.icontact.Constants;
	import com.icontact.model.IContactModelLocator;
	import com.icontact.model.dao.IContactDaoEvent;
	import com.icontact.model.domain.Contact;

	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class IContactFormController implements IMXMLObject{

		private var view:IContactForm;
        [Bindable] public var model:IContactModelLocator = IContactModelLocator.getInstance();
		[Bindable] public var contact:Contact;

		public function initialized(doc:Object, id:String):void {
			view = doc as IContactForm;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}

		public function creationCompleteHandler(e:FlexEvent):void {
			view.saveButton.addEventListener(MouseEvent.CLICK, clickSaveButtonHandler);
			view.deleteButton.addEventListener(MouseEvent.CLICK, clickDeleteButtonHandler);
			view.cancelButton.addEventListener(MouseEvent.CLICK, clickCancelButtonHandler);
		}

		private function clickSaveButtonHandler(e:MouseEvent):void {
			if (isRequired()) {
				return;
			}
			if (isFormEmpty()) {
				return;
			}

			bindContactData();
			var icontactDaoEvent:IContactDaoEvent = new IContactDaoEvent(IContactDaoEvent.SAVE_CONTACT, this, contact);
			icontactDaoEvent.dispatch();
		}

		private function clickDeleteButtonHandler(e:MouseEvent):void {
			if (isRequired()) {
				return;
			}
			if (isFormEmpty()) {
				return;
			}

			var icontactDaoEvent:IContactDaoEvent = new IContactDaoEvent(IContactDaoEvent.DELETE_CONTACT, view, contact);
			icontactDaoEvent.dispatch();
		}

		private function clickCancelButtonHandler(e:MouseEvent):void {

			getSequence();
			view.controller.contact = clearContact();
		}

		private function getSequence():void {
			var icontactDaoEvent:IContactDaoEvent = new IContactDaoEvent(IContactDaoEvent.GET_MAX_SEQUENCE);
			icontactDaoEvent.dispatch();
		}

		private function isRequired():Boolean {
			var isOk:Boolean = false;
			var id:int = model.sequence;
			var name:String = view.txtIptName.text;
			if (id == 0 ||
				(name == null || name == "")) {
				isOk = true;
			}

			return isOk;
		}

		private function isFormEmpty():Boolean {
			var isEmpty:Boolean = false;
			if (view.txtIptName.text == "" &&
					view.txtIptEmail.text == "" &&
					view.txtIptPhone.text == "" &&
					view.txtAreaAddress.text == "" &&
					view.txtIptNotes.text == "") {
				isEmpty = true;
			}
			return isEmpty;
		}

		private function bindContactData():void {
			contact.id = model.sequence;
			contact.name = view.txtIptName.text;
			contact.email = view.txtIptEmail.text;
			contact.phone = view.txtIptPhone.text;
			contact.address = view.txtAreaAddress.text;
			contact.notes = view.txtIptNotes.text;
			contact.status = Constants.CODE_STATUS_ADD;
		}

		private function clearContact():Contact {
			var contact:Contact = new Contact();
			contact.id = model.sequence;
			contact.name = "";
			contact.phone = "";
			contact.email = "";
			contact.address = "";
			contact.notes = "";
			contact.status = "";

			return contact;
		}
	}
}