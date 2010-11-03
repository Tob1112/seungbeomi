package com.chronos.air.sample
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	import mx.core.IMXMLObject;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.resources.ResourceBundle;

	import com.chronos.air.model.SQLMap;

	public class PersonMainController implements IMXMLObject
	{
		private var sqlMap:SQLMap = SQLMap.getInstance();

		private var view:PersonMainView;
		public var model:PersonModelLocator = PersonModelLocator.getInstance();

		private var fileRef:FileReference;
		[ResourceBundle("ApplicationResources")]
		private var resources:ResourceBundle;

		public function initialized(doc:Object, id:String):void {
			view = doc as PersonMainView;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			view.addEventListener(Event.CLOSE, closeHandler);
		}

		public function creationCompleteHandler(e:FlexEvent):void {
			view.summitButton.addEventListener(MouseEvent.CLICK, sayHelloHandler);
			view.fileUploadButton.addEventListener(MouseEvent.CLICK, fileUploadHandler);

			// Resource TEST
			trace("Resources Test ? " + resources.getString("test"));
			// Read XML
			//sqlMapFile = File.applicationStorageDirectory;
			//sqlMapFile = File.createTempDirectory();
			//sqlMapFile = File.desktopDirectory;
			sqlMapFile = new File("file:///C:/workspace/chronos/ChronosAir/src");
			sqlMapFile = sqlMapFile.resolvePath("sql-map-person.xml");
			trace("sqlMapFile path : " + sqlMapFile.nativePath);
			readXML();


		}

		// SAY HELLO ---------------------------------------------------------------------

		public function sayHelloHandler(e:MouseEvent):void {
			model.person = new Person();
			model.person.name = view.nameInputText.text;

			var event:PersonEvent = new PersonEvent(PersonEvent.SAY_HELLO, view);
			event.dispatch();

		}

		// FILE UPLOAD ---------------------------------------------------------------------

		public function fileUploadHandler(e:MouseEvent):void {
			fileRef = new FileReference();
			fileRef.browse();
			fileRef.addEventListener(Event.SELECT, fileSelectHandler);
			fileRef.addEventListener(CloseEvent.CLOSE, fileCompleteHandler);
		}

		private function fileSelectHandler(e:Event):void {
			var files:Array = model.uploadFiles;
			files.push({
				name:fileRef.name,
				size:formatFileSize(fileRef.size),
				status:"initial"
			});
			view.uploadFilesDataGrid.dataProvider = files;
			view.uploadFilesDataGrid.selectedIndex = files.length - 1 ;

			fileRef.load();

			for (var i:int=0; i < files.length; i++) {
				if (files[i].name == fileRef) {
					files[i].status = "loaded";
					view.uploadFilesDataGrid.dataProvider = files;
					break;
				}
			}
		}

		private function fileCompleteHandler(e:Event):void {
			fileRef = e.currentTarget as FileReference;
			var data:ByteArray = new ByteArray();
			fileRef.data.readBytes(data, 0, fileRef.data.length);

			model.fileUpDownLoad = new FileUpDownLoad();
			model.fileUpDownLoad.name = fileRef.name;
			model.fileUpDownLoad.data = data;

			var event:PersonEvent = new PersonEvent(PersonEvent.FILE_UPLOAD, view);
			event.dispatch();
		}

		private function formatFileSize(numSize:Number):String {
			var strReturn:String;
			numSize = Number(numSize/1000);
			strReturn = String(numSize.toFixed(1) + "KB");

			if (numSize > 1000) {
				numSize = numSize / 1000;
				strReturn = String(numSize.toFixed(1) + "MB");
				if (numSize > 1000) {
					numSize = numSize / 1000;
					strReturn = String(numSize.toFixed(1) + "GB");
				}
			}
			return strReturn;
		}

		// XML LOAD ---------------------------------------------------
		public var sqlMapFile:File;
		[Bindable] public var sqlMapXML:XML;
		public var stream:FileStream;

		private function readXML():void {
			stream = new FileStream();
			if (sqlMapFile.exists) {
				stream.open(sqlMapFile, FileMode.READ);
				sqlMapXMLData();
			} else {
				saveData();
			}
		}

		private function sqlMapXMLData():void {
			sqlMapXML = XML(stream.readUTFBytes(stream.bytesAvailable));
			stream.close();

			trace(sqlMap.getQuery("find1"));

			// view read xml data
			view.idTextInput.text = sqlMapXML.sql[0].@id;
			view.sqlTextArea.text = sqlMapXML.sql[0];
		}

		private function saveData():void {
			trace("save data");
			createXMLData();
			writeXMLData();
		}
		private function createXMLData():void {
			sqlMapXML = <sqlMap/>
			sqlMapXML.sql.@id = "findPersonById";
			sqlMapXML.sql = "select * from person";
		}
		private function writeXMLData():void {
			var outputString:String = '<?xml version="1.0" encoding="utf-8"?>\n';
			outputString += sqlMapXML.toXMLString();
			outputString = outputString.replace(/\n/g, File.lineEnding);
			stream = new FileStream();
			stream.open(sqlMapFile, FileMode.WRITE);
			stream.writeUTFBytes(outputString);
			stream.close();
		}
		private function closeHandler(e:Event):void {
			saveData();
		}
	}
}