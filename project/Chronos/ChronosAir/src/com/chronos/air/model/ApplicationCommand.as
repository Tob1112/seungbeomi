package com.chronos.air.model {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.chronos.Constants;
	import com.chronos.air.event.ApplicationEvent;
	import com.chronos.air.event.DAOEvent;
	import com.chronos.air.util.Logger;

	import flash.filesystem.File;

	public class ApplicationCommand implements ICommand {

		private var file:File = File.userDirectory.resolvePath(Constants.DATABASE_FILE_PATH);

		public function execute(e:CairngormEvent):void {
			switch (e.type) {
				case ApplicationEvent.INITIALIZE_APPLICATION:
					initializeApplication();
					break;
			}
		}

		/** アプリケーション初期化 */
		private function initializeApplication():void {
			createSystem();	// SYSTEMディレクトリ生成
			setModelData();	// モデルのデータを設定
		}

		/** システム生成 */
		private function createSystem():void {
			createSystemDirectory();	// SYSTEMディレクトリ生成
			copyDatabaseFileToUserDirectory() // Databaseファイル
		}

		/** SYSTEMディレクトリ生成 */
		private function createSystemDirectory():void {
			var systemDir:File = File.userDirectory.resolvePath(Constants.SYSTEM_DIRECTORY_PATH);
			if (!systemDir.exists) {
				systemDir.createDirectory(); // SYSTEM ディレクトリ生成
			}
		}

		/** database ファイルをSYSTEMディレクトリに置く */
		private function copyDatabaseFileToUserDirectory():void {
			var originalDataBasePath:String = Constants.ORIGINAL_DATABASE_FILE_PATH;
			var originalDataBase:File = File.applicationDirectory.resolvePath(originalDataBasePath);
			var isDatabaseInSystemDirectory:Boolean = !file.exists;

			if (isDatabaseInSystemDirectory) {
				Logger.log("sqlite path : " + file.nativePath);
				originalDataBase.copyTo(file, true);
			}
		}

		/** モデルにデータ設定 */
		private function setModelData():void {
			setCodeData();
			setKinmuhyoModelData();
		}

		/** コードデータ設定  */
		private function setCodeData():void {
			var event:DAOEvent = new DAOEvent(DAOEvent.FIND_CODE_DATA);
			event.dispatch();
		}

		/** 勤務表モデルのデータを設定 */
		private function setKinmuhyoModelData():void {
			var event:DAOEvent = new DAOEvent(DAOEvent.FIND_JIKOKUHYO);
			event.dispatch();
		}
	}
}