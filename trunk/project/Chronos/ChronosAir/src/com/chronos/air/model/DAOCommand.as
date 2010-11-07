package com.chronos.air.model {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.chronos.Constants;
	import com.chronos.air.event.DAOEvent;

	import flash.data.SQLConnection;
	import flash.filesystem.File;
	import flash.utils.Dictionary;

	public class DAOCommand implements ICommand {

		private var mainModel:MainModel = MainModel.getInstance();
		private var sqlMap:SQLMap = SQLMap.getInstance();
		private var con:SQLConnection;
		private var file:File = File.userDirectory.resolvePath(Constants.DATABASE_FILE_PATH);

		// SQL PREFIX
		private static const PREFIX_USER:String 				= "user.";
		private static const PREFIX_KINMUHYO:String 			= "kinmuhyo.";
		private static const PREFIX_SHINSEI:String 				= "shinsei.";

		// CREATE SQL ID
		private static const SQL_CREATE_USER:String 			= PREFIX_USER + "createUser";
		private static const SQL_CREATE_KINMUHYO:String 		= PREFIX_KINMUHYO + "createKinmuhyo";
		private static const SQL_CREATE_SHINSEI:String			= PREFIX_SHINSEI + "createShinsei";

		// FIND SQL ID
		private static const SQL_FIND_USER:String				= PREFIX_USER + "findUser";

		// INSERT SQL ID
		private static const SQL_INSERT_USER:String				= PREFIX_USER + "insertUser";

		// UPDATE SQL ID
		private static const SQL_UPDATE_USER:String				= PREFIX_USER + "updateUser";

		// REMOVE SQL ID
		private static const SQL_REMOVE_USER:String				= PREFIX_USER + "removeUser";

		// PARAMETER NAME
		// USER  PARAMETER
		private static const PARAMETER_NAME_ID:String = ":id";
		private static const PARAMETER_NAME_PASSWORD:String = ":password";
		private static const PARAMETER_NAME_REMEMBER_ME:String = ":rememberMe";

		// KINMUHYO  PARAMETER
		private static const PARAMETER_NAME_NENGETSU:String 			= ":nengetsu";
		private static const PARAMETER_NAME_HIZUKE:String 				= ":hizuke";
		private static const PARAMETER_NAME_YASUMI_KUBUN:String 		= ":yasumiKubun";
		private static const PARAMETER_NAME_SHIGYO_JIKAN:String 		= ":shigyoJikan";
		private static const PARAMETER_NAME_SYURYO_JIKAN:String 		= ":syuryoJikan";
		private static const PARAMETER_NAME_KYUKEI_JIKAN:String 		= ":kyukeiJikan";
		private static const PARAMETER_NAME_JITSUDO_JIKAN:String 		= ":jitsudoJikan";
		private static const PARAMETER_NAME_SAGYO_NAIYO:String			= ":sagyoNaiyo";
		private static const PARAMETER_NAME_SYOTEI_NISSU:String 		= ":syoteiNissu";
		private static const PARAMETER_NAME_SAGYO_NISSU:String 			= ":sagyoNissu";
		private static const PARAMETER_NAME_KEKKIN_NISSU:String 		= ":kekkinNissu";
		private static const PARAMETER_NAME_TOTAL_JITSUDO_JIKAN:String 	= ":totalJitsudoJikan";

		// SHINSEI  PARAMETER
		private static const PARAMETER_NAME_SHINSEI_BANGO:String 		= ":shinseiBango";
		private static const PARAMETER_NAME_SHINSEI_KUBUN:String 		= ":shinseiKubun";
		private static const PARAMETER_NAME_SHINSEI_JYOKYO:String 		= ":shinseiJokyo";

		// ETC
		private static const REMEMBER_ME:int = 1;
		private static const FORGET_ME:int = 0;

		public function execute(e:CairngormEvent):void {

			switch(e.type) {
				case DAOEvent.OPEN_DATABASE:
					openDatabase();			// データーベース解放
					break;
				case DAOEvent.SAVE_USER:	// ユーザー情報保存
					saveUser(mainModel.user);
					break;
				case DAOEvent.REMOVE_USER:	// ユーザー情報削除
					removeUser(mainModel.user.id);
					break;
			}
		}

		/** database 解放 */
		private function openDatabase():void {
			trace("sqlite path : " + file.nativePath);
			var isNewDB:Boolean = !file.exists;
			con = new SQLConnection();
			con.open(file);

			if (isNewDB) {
				createDatabase();
			}
			con.close();
		}

		/** database 生成 */
		private function createDatabase():void {
			con = new SQLConnection();
			con.open(file);
			try {
				SQLMap.create(con, SQL_CREATE_USER);
				SQLMap.create(con, SQL_CREATE_KINMUHYO);
				SQLMap.create(con, SQL_CREATE_SHINSEI);
			} finally {
				con.close();
			}

		}

		/** ユーザー情報保存 */
		private function saveUser(user:User):void {
			con = new SQLConnection();
			con.open(file);
			var isExist:Boolean = false;
			var sqlId:String;
			var params:Dictionary = new Dictionary();

			isExist = SQLMap.exist(con, SQL_FIND_USER, user.id);

			params[PARAMETER_NAME_ID] = user.id;
			params[PARAMETER_NAME_PASSWORD] = user.password;
			params[PARAMETER_NAME_REMEMBER_ME] = user.rememberMe;

			//  存在する場合、UPDATE
			if (isExist) {
				sqlId = SQL_UPDATE_USER;
			} else {
				sqlId = SQL_INSERT_USER;
			}

			try {
				SQLMap.execute(con, sqlId, params);
			} finally {
				con.close();
			}
		}

		/** ユーザー情報削除 */
		private function removeUser(id:String):void {
			var isExist:Boolean = false;
			var params:Dictionary = new Dictionary();
			con = new SQLConnection();
			con.open(file);

			isExist = SQLMap.exist(con, SQL_FIND_USER, id);

			try {
				if (isExist) {
					params[PARAMETER_NAME_ID] = id;
					SQLMap.remove(con, SQL_REMOVE_USER, id);
				}
			} finally {
				con.close();
			}
		}
	}
}