package com.chronos
{
	import com.adobe.cairngorm.control.FrontController;
	import com.chronos.air.model.MainDAO;
	import com.chronos.air.model.MainEvent;
	import com.chronos.air.sample.PersonCommand;
	import com.chronos.air.sample.PersonEvent;

	public class Controller extends FrontController
	{
		public function Controller()
		{
			super();

			addCommand(MainEvent.OPEN_DATABASE, MainDAO);



			// sample
			addCommand(PersonEvent.SAY_HELLO, PersonCommand);
			addCommand(PersonEvent.FILE_UPLOAD, PersonCommand);

		}

	}
}