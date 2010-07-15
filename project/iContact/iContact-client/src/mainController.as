package {
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	import mx.controls.Alert;
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	import suite.Constants;

	public class mainController implements IMXMLObject{

		private var view:main;

		public function initialized(doc:Object, id:String):void {
			view = doc as main;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			view.addEventListener(Event.CLOSE, closeHandler);
		}

		public function creationCompleteHandler(e:FlexEvent):void {
			readInitFile();
		}

		public function closeHandler(e:Event):void {
			writeInitFile();
		}

		// 初期化設定ファイルを読み込む
		private function readInitFile():void {
			// システムディレクトリ生成
			var systemDirPath:String = Constants.PROJECT_NAME + File.separator + Constants.SYSTEM_FOLDER_NAME;
			var systemDir:File = File.userDirectory.resolvePath(systemDirPath);
			if (!systemDir.exists) {
				systemDir.createDirectory();
			}

			var initFilePath:String = systemDirPath + File.separator + Constants.INIT_FILE_NAME;
			var initFile:File = File.userDirectory.resolvePath(initFilePath);
			if (initFile.exists) {
				trace("初期化ファイルが存在します。");
				var stream:FileStream = new FileStream();
				try {
					stream.open(initFile, FileMode.READ);
					var initData:String = stream.readMultiByte(stream.bytesAvailable, Constants.UTF8);
                    var initDataArray:Array = initData.split(Constants.NEW_LINE);
                    var initMap:Array = new Array();
                    for each (var data:String in initDataArray) {
                        var dataArr:Array = data.split(Constants.EQUAL);
                        initMap[dataArr[0]] = dataArr[1];
                    }

					view.icontactView.usernameTxtIpt.text = initMap[Constants.USERNAME];
					view.icontactView.passwordTxtIpt.text = initMap[Constants.PASSWORD];
					view.icontactView.rememberMeChkBox.selected
						= (initMap[Constants.REMEMBER_ME] = "true" ? true : false);

				} catch (e:Error) {
					Alert.show("初期化ファイル読み込みに失敗しました。\n" + e.message);
				} finally {

				}
			} else {
				trace("初期化ファイルが存在しません。");
			}
		}

		private function writeInitFile():void {

		}
	}
}