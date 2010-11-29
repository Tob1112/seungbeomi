package org.chronos.air.sample
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.chronos.air.util.Logger;

	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class PersonCommand implements ICommand
	{
		[Bindable] private var model:PersonModelLocator = PersonModelLocator.getInstance();
		private var view:Object;

		public function execute(e:CairngormEvent):void {
			var responder:Responder = null;
			var delegate:PersonDelegate = null;
			var person:Person = model.person;

			switch (e.type) {
			case PersonEvent.SAY_HELLO:
				view = PersonEvent(e).view as PersonMainView;
				responder = new Responder(sayHelloResultHandler, serviceFaultHandler);
				delegate = new PersonDelegate(responder);
				delegate.sayHello(person);
				break;
			case PersonEvent.FILE_UPLOAD:
				view = PersonEvent(e).view as PersonMainView;
				responder = new Responder(fileUploadResultHandler, serviceFaultHandler);
				delegate = new PersonDelegate(responder);
				delegate.fileUpload(model.fileUpDownLoad);
				break;
			}
		}

		private function sayHelloResultHandler(e:ResultEvent):void {
			//model.result = e.result.toString();
			//view.result.text = model.result;
			view.result.text = e.result.toString();
			Logger.log("result : " + e.result.toString());
		}

		private function fileUploadResultHandler(e:ResultEvent):void {
			var files:Array = model.uploadFiles;
			for (var i:int=0; i < files.length; i++) {
				if (files[i].name == e.result.toString()) {
					files[i].status = "finished";
					view.uploadFilesDataGrid.dataProvider = files;
					break;
				}
			}
			e.result.toString()
		}

		private function serviceFaultHandler(e:FaultEvent):void {
			Alert.show(e.fault.toString());
		}

	}
}