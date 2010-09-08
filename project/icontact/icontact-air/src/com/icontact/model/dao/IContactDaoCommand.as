package com.icontact.model.dao {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.icontact.Constants;
	import com.icontact.model.IContactModelLocator;
	import com.icontact.model.domain.Contact;
	import com.icontact.model.domain.ContactMapper;
	import com.icontact.view.IContactForm;
	import com.icontact.view.IContactView;

	import flash.data.SQLConnection;
	import flash.filesystem.File;
	import flash.utils.Dictionary;

	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;

	public class IContactDaoCommand implements ICommand{

		private var model:IContactModelLocator = IContactModelLocator.getInstance();
		private var view:Object;
		private var sqlmap:SQLMap = SQLMap.getInstance();
		private var sqlConnection:SQLConnection;

		// sequence table
		private static const PARAMETER_NAME_SEQ_NAME:String = ":seqName";
		private static const PARAMETER_NAME_ID:String = ":id";
		// users table
		private static const PARAMETER_NAME_ACCOUNT:String = ":account";
		private static const PARAMETER_NAME_USERNAME:String = ":username";
		private static const PARAMETER_NAME_PASSWORD:String = ":password";
		// contacts table
		private static const PARAMETER_NAME_NAME:String = ":name";
		private static const PARAMETER_NAME_PHONE:String = ":phone";
		private static const PARAMETER_NAME_EMAIL:String = ":email";
		private static const PARAMETER_NAME_ADDRESS:String = ":address";
		private static const PARAMETER_NAME_NOTES:String = ":notes";
		private static const PARAMETER_NAME_STATUS:String = ":status";

		private static const PARAMETER_NAME_AUTOCOMPLETE:String = ":autocomplete";

        private var file:File = File.userDirectory.resolvePath(Constants.DATABASE_FILE_PATH);

		public function execute(e:CairngormEvent):void {
			var contact:Contact;
			if (IContactDaoEvent(e).contact != null) {
				contact = IContactDaoEvent(e).contact as Contact;
			}
			switch (e.type) {
			case IContactDaoEvent.OPEN_DATABASE:
				openDatabase();
				break;
			case IContactDaoEvent.SAVE_CONTACT:
				saveContactHandler(contact);
				break;
			case IContactDaoEvent.DELETE_CONTACT:
				view = IContactDaoEvent(e).view as IContactForm;
				deleteContactHandler(contact);
				break;
			case IContactDaoEvent.GET_MAX_SEQUENCE:
				getSequence();
				break;
			case IContactDaoEvent.AUTO_COMPLETE:
				view = IContactDaoEvent(e).view as IContactView;
				autoComplete();
				break;
			}
		}

		private function openDatabase():void {
            trace("sqlite path : " + file.nativePath);
            var isNewDB:Boolean = !file.exists;
            sqlConnection = new SQLConnection();
            sqlConnection.open(file);

            if (isNewDB) {
                createDatabase();
            }
            findAll();
            sqlConnection.close();
		}

		private function createDatabase():void {

			SQLMap.execute(sqlConnection, "createSequenceTable");
			SQLMap.execute(sqlConnection, "createUsersTable");
			SQLMap.execute(sqlConnection, "createContactsTable");

			var parameters:Dictionary = new Dictionary();
			parameters[PARAMETER_NAME_SEQ_NAME] = "icontactSeq";
			parameters[PARAMETER_NAME_ID] = 1;
			SQLMap.execute(sqlConnection, "insertSequence", parameters);
			parameters = new Dictionary(); // dictionary
			parameters[PARAMETER_NAME_ACCOUNT] = "son";
			parameters[PARAMETER_NAME_PASSWORD] = "sonpw";
			parameters[PARAMETER_NAME_USERNAME] = "seungbeomi";
			SQLMap.execute(sqlConnection, "insertUsers", parameters);

			var mapper:ContactMapper = new ContactMapper();
			parameters = mapper.parameterMapping(defaultContact());
			SQLMap.execute(sqlConnection, "insertContact", parameters);
        }

		private function findAll():void {
			trace("findAll");
			var results:ArrayCollection = SQLMap.execute(sqlConnection, "findAll");
			// TODO mapping

			var mapper:ContactMapper = new ContactMapper();
			var cursor:IViewCursor = results.createCursor();
			model.contactAC.removeAll();

			var mapped:Contact;
			for (; !cursor.afterLast; cursor.moveNext()) {
				mapped = mapper.mapping(cursor.current);
				model.contactAC.addItem(mapped);
			}
		}

		// SAVE
		private function saveContactHandler(contact:Contact):void {
			// find contact
			var found:Boolean;
			var id:int = contact.id;
			sqlConnection = new SQLConnection();
            sqlConnection.open(file);
			found = SQLMap.exist(sqlConnection, "findContact", id);

			var mapper:ContactMapper = new ContactMapper();
			// found true -> update
			if (found) {
				// update
				var parameters:Dictionary = new Dictionary();
				parameters = mapper.parameterMapping(contact);
				model.contactAC = SQLMap.execute(sqlConnection, "updateContact", parameters);
			// found false -> insert
			} else {
				// insert
				var parameters:Dictionary = new Dictionary();
				parameters = mapper.parameterMapping(contact);
				model.contactAC = SQLMap.execute(sqlConnection, "insertContact", parameters);

				// update sequence
				updateSequence(sqlConnection, contact.id);
			}

			findAll();
			sqlConnection.close();
		}

		// DELETE
		private function deleteContactHandler(contact:Contact):void {
			// find contact
			var found:Boolean;
			var pk:int = contact.id;
			sqlConnection = new SQLConnection();
            sqlConnection.open(file);
			found = SQLMap.exist(sqlConnection, "findContact", pk);

			if (found) {
				SQLMap.deleteContact(sqlConnection, "deleteContact", pk);
				IContactForm(view).controller.contact = clearContact();
				findAll();
			} else {
				//return;
			}
			sqlConnection.close();
			// clear form

		}

		private function autoComplete():void {
			var founds:ArrayCollection = new ArrayCollection();
			var results:ArrayCollection;
			var cursor:IViewCursor;
			var autocomplete:String = model.autocompleteText;
			var mapper:ContactMapper = new ContactMapper();
			var mapped:Contact;

			sqlConnection = new SQLConnection();
            sqlConnection.open(file);

			var parameters:Dictionary = new Dictionary();
			parameters[PARAMETER_NAME_AUTOCOMPLETE] = autocomplete + "%";

            results = SQLMap.execute(sqlConnection, "autoComplete", parameters);

            if (results != null && results.length > 0) {
				cursor = results.createCursor();
				for (; !cursor.afterLast; cursor.moveNext()) {
					mapped = mapper.mapping(cursor.current);
					founds.addItem(mapped);
				}

            	IContactView(view).controller.contacts = founds;
            }

            sqlConnection.close();
		}

		private function getSequence():void {
			var found:int; // sequence
			sqlConnection = new SQLConnection();
            sqlConnection.open(file);

            var parameters:Dictionary = new Dictionary();
			parameters[PARAMETER_NAME_SEQ_NAME] = Constants.SEQUENCE_NAME;

            found = SQLMap.find(sqlConnection, "getSequence", parameters).id as int;
            model.sequence = found + 1;
		}

		private function updateSequence(sqlConnection:SQLConnection, id:int):void {
			var parameters:Dictionary = new Dictionary();
			parameters[PARAMETER_NAME_SEQ_NAME] = Constants.SEQUENCE_NAME;
			parameters[PARAMETER_NAME_ID] = id;

			SQLMap.execute(sqlConnection, "updateSequence", parameters);
		}

		private function defaultContact():Contact {
			var contact:Contact = new Contact();
			contact.id = 1;
			contact.name = "son";
			contact.phone = "08035345232";
			contact.email = "seungbeomi@gmail.com";
			contact.address = "pusan";
			contact.notes = "note";
			contact.status = "A";

			return contact;
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