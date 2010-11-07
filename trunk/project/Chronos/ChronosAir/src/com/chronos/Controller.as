package com.chronos
{
	import com.adobe.cairngorm.control.FrontController;
	import com.chronos.air.event.DAOEvent;
	import com.chronos.air.event.ShinseiServiceEvent;
	import com.chronos.air.model.DAOCommand;
	import com.chronos.air.model.ShinseiServiceCommand;
	import com.chronos.air.sample.PersonCommand;
	import com.chronos.air.sample.PersonEvent;

	public class Controller extends FrontController
	{
		public function Controller()
		{
			super();

			addCommand(DAOEvent.OPEN_DATABASE, DAOCommand);
			addCommand(DAOEvent.SAVE_USER, DAOCommand);
			addCommand(DAOEvent.REMOVE_USER, DAOCommand);

			addCommand(ShinseiServiceEvent.LOGIN, ShinseiServiceCommand);	// ログイン
			addCommand(ShinseiServiceEvent.LOGOUT, ShinseiServiceCommand);


			// sample
			addCommand(PersonEvent.SAY_HELLO, PersonCommand);
			addCommand(PersonEvent.FILE_UPLOAD, PersonCommand);

		}

	}
}