package com.chronos.air.model {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.chronos.Constants;

	import flash.data.SQLConnection;
	import flash.filesystem.File;

	public class MainDAO implements ICommand {

		private var model:MainModel = MainModel.getInstance();
		private var sqlMap:SQLMap = SQLMap.getInstance();
		private var con:SQLConnection;
		private var file:File = File.userDirectory.resolvePath(Constants.DATABASE_FILE_PATH);

		// TABLE NAME
		private const TABLE_NAME_KINMUHYO:String = "kinmuhyo";

		// PARAMETER NAME
		//private static const PARAMETER_NAME_SEQ_NAME:String = ":seqName";

		public function execute(e:CairngormEvent):void {

			switch(e.type) {
			case MainEvent.OPEN_DATABASE:
				openDatabase();
				break;
			}
		}

		/** database 解放 */
		private function openDatabase():void {
			trace("sqlite path : " + file.nativePath);
			var isNewDB:Boolean = !file.exists;
			con = new SQLConnection();
			con.open(file);

			//if (isNewDB) {
				createDatabase();
			//}
			con.close();
		}

		/** database 生成 */
		private function createDatabase():void {
			SQLMap.execute(con, TABLE_NAME_KINMUHYO);

		}

	}
}