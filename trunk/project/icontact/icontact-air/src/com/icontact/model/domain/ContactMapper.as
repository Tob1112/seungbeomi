package com.icontact.model.domain {

	import flash.utils.Dictionary;

	public class ContactMapper
	{
		// contacts table
		private static const PARAMETER_NAME_ID:String = ":id";
		private static const PARAMETER_NAME_NAME:String = ":name";
		private static const PARAMETER_NAME_PHONE:String = ":phone";
		private static const PARAMETER_NAME_EMAIL:String = ":email";
		private static const PARAMETER_NAME_ADDRESS:String = ":address";
		private static const PARAMETER_NAME_NOTES:String = ":notes";
		private static const PARAMETER_NAME_STATUS:String = ":status";

		public function mapping(obj:Object):Contact {
			var mapped:Contact = new Contact();
			mapped.id = obj.id;
			mapped.name = obj.name;
			mapped.phone = obj.phone;
			mapped.email = obj.email;
			mapped.address = obj.address;
			mapped.notes = obj.notes;
			mapped.status = obj.status;

			mapped.toString();

			return mapped;
		}

		public function parameterMapping(obj:Contact):Dictionary {
			var mapped:Dictionary = new Dictionary();
			mapped[PARAMETER_NAME_ID] = obj.id;
			(obj.name == null) ? mapped[PARAMETER_NAME_NAME] = "" : mapped[PARAMETER_NAME_NAME] = obj.name;
			(obj.phone == null) ? mapped[PARAMETER_NAME_PHONE] = "" : mapped[PARAMETER_NAME_PHONE] = obj.phone;
			(obj.email == null) ? mapped[PARAMETER_NAME_EMAIL] = "" : mapped[PARAMETER_NAME_EMAIL] = obj.email;
			(obj.address == null) ? mapped[PARAMETER_NAME_ADDRESS] = "" : mapped[PARAMETER_NAME_ADDRESS] = obj.address;
			(obj.notes == null) ? mapped[PARAMETER_NAME_NOTES] = "" : mapped[PARAMETER_NAME_NOTES] = obj.notes;
			(obj.status == null) ? mapped[PARAMETER_NAME_STATUS] = "" : mapped[PARAMETER_NAME_STATUS] = obj.status;

			return mapped;
		}
	}
}