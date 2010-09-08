package com.icontact {

	import com.adobe.cairngorm.control.FrontController;
	import com.icontact.model.command.IContactCommand;
	import com.icontact.model.dao.IContactDaoCommand;
	import com.icontact.model.dao.IContactDaoEvent;
	import com.icontact.model.event.IContactEvent;

	public class Controller extends FrontController {

		public function Controller() {
			super();

			addCommand(IContactDaoEvent.OPEN_DATABASE, IContactDaoCommand);
            addCommand(IContactDaoEvent.SAVE_CONTACT, IContactDaoCommand);
            addCommand(IContactDaoEvent.DELETE_CONTACT, IContactDaoCommand);
            addCommand(IContactDaoEvent.GET_MAX_SEQUENCE, IContactDaoCommand);
            addCommand(IContactDaoEvent.AUTO_COMPLETE, IContactDaoCommand);

            addCommand(IContactEvent.LOGIN, IContactCommand);

            addCommand(IContactEvent.SYNC, IContactCommand);

		}

	}
}