package com.chronos.air.model {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.chronos.Constants;
	import com.chronos.air.common.MessageId;
	import com.chronos.air.common.Messages;
	import com.chronos.air.event.DAOEvent;
	import com.chronos.air.util.Logger;

	import flash.data.SQLConnection;
	import flash.filesystem.File;
	import flash.utils.Dictionary;

	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;

	public class DAOCommand implements ICommand {

		private var mainModel:MainModel = MainModel.getInstance();
		private var kinmuhyoModel:KinmuhyoModel = KinmuhyoModel.getInstance();
		private var dao:DAO = DAO.getInstance();
		private var con:SQLConnection;
		private var file:File = File.userDirectory.resolvePath(Constants.DATABASE_FILE_PATH);

		// SQL PREFIX
		private static const PREFIX_SHAIN:String 						= "shain.";
		private static const PREFIX_KINMUHYO:String 					= "kinmuhyo.";
		private static const PREFIX_KINMUHYO_SHOSAI:String 				= "kinmuhyoShosai.";
		private static const PREFIX_JIKOKUHYO:String	 				= "jikokuhyo.";

		// CREATE SQL ID
		private static const SQL_CREATE_SHAIN:String 					= PREFIX_SHAIN + "createShain";
		private static const SQL_CREATE_KINMUHYO:String 				= PREFIX_KINMUHYO + "createKinmuhyo";
		private static const SQL_CREATE_KINMUHYO_SHOSAI:String			= PREFIX_KINMUHYO_SHOSAI + "createKinmuhyoShosai";
		private static const SQL_CREATE_JIKOKUHYO:String				= PREFIX_JIKOKUHYO + "createJikokuhyo";

		// FIND SQL ID
		private static const SQL_FIND_SHAIN:String						= PREFIX_SHAIN + "findShain";
		private static const SQL_FIND_KINMUHYO_LIST:String				= PREFIX_KINMUHYO + "findKinmuhyoList";
		private static const SQL_FIND_KINMUHYO_SHOSAI:String			= PREFIX_KINMUHYO_SHOSAI + "findKinmuhyoShosai";
		private static const SQL_FIND_MAX_NENGETSU:String				= PREFIX_KINMUHYO + "findMaxNengetsu";
		private static const SQL_FIND_JIKOKUHYO:String					= PREFIX_JIKOKUHYO + "findJikokuhyo";

		// INSERT SQL ID
		private static const SQL_INSERT_SHAIN:String						= PREFIX_SHAIN + "insertShain";

		// UPDATE SQL ID
		private static const SQL_UPDATE_SHAIN:String						= PREFIX_SHAIN + "updateShain";

		// REMOVE SQL ID

		// PARAMETER NAME
		// SHAIN  PARAMETER
		private static const PARAMETER_NAME_ID:String 					= ":id";
		private static const PARAMETER_NAME_PASSWORD:String 			= ":password";
		private static const PARAMETER_NAME_SHAIN_MEI:String 			= ":shainMei";
		private static const PARAMETER_NAME_REMEMBER_ME:String 			= ":rememberMe";
		private static const PARAMETER_NAME_SHAIN_BANGO:String 			= ":shainBango";

		// KINMUHYO PARAMETER
		private static const PARAMETER_NAME_SHINSEI_BANGO:String 		= ":shinseiBango";
		private static const PARAMETER_NAME_SHINSEI_KUBUN:String 		= ":shinseiKubun";
		private static const PARAMETER_NAME_SHINSEI_JYOKYO:String 		= ":shinseiJokyo";
		private static const PARAMETER_NAME_SAGYO_NAIYO:String			= ":sagyoNaiyo";
		private static const PARAMETER_NAME_SYOTEI_NISSU:String 		= ":syoteiNissu";
		private static const PARAMETER_NAME_SAGYO_NISSU:String 			= ":sagyoNissu";
		private static const PARAMETER_NAME_KEKKIN_NISSU:String 		= ":kekkinNissu";
		private static const PARAMETER_NAME_JITSUDO_JIKAN_GOKEI:String 	= ":jitsudoJikanGokei";

		// KINMUHYO SHOSAI PARAMETER
		private static const PARAMETER_NAME_NENGETSU:String 			= ":nengetsu";
		private static const PARAMETER_NAME_HIZUKE:String 				= ":hizuke";
		private static const PARAMETER_NAME_YASUMI_KUBUN:String 		= ":yasumiKubun";
		private static const PARAMETER_NAME_SHIGYO_JIKAN:String 		= ":shigyoJikan";
		private static const PARAMETER_NAME_SHIGYO_JIKANCHI:String 		= ":shigyoJikanchi";
		private static const PARAMETER_NAME_SYURYO_JIKAN:String 		= ":syuryoJikan";
		private static const PARAMETER_NAME_SYURYO_JIKANCHI:String 		= ":syuryoJikanchi";
		private static const PARAMETER_NAME_KYUKEI_JIKAN:String 		= ":kyukeiJikan";
		private static const PARAMETER_NAME_JITSUDO_JIKAN:String 		= ":jitsudoJikan";

		// ETC
		private static const REMEMBER_ME:int = 1;
		private static const FORGET_ME:int   = 0;

		public function execute(e:CairngormEvent):void {
			switch(e.type) {
				case DAOEvent.OPEN_DATABASE:
					openDatabase();			// データーベース解放
					break;
				case DAOEvent.SAVE_SHAIN:	// ユーザー情報保存
					saveShain();
					break;
				case DAOEvent.FIND_KINMUHYO:	// 勤務表リスト検索
					findKinmuhyoListAndSaikinKinmuhyo();
					break;
				case DAOEvent.FIND_MAX_NENGETSU:	// 勤務表年月最大値取得
					findMaxNengetsu();
					break;
				case DAOEvent.FIND_JIKOKUHYO:	// 時刻表取得
					findJikokuhyo();
					break;
				default:
					Messages.showError(MessageId.NOT_FOUND_OPERATION_ERROR);
			}
		}

		/** database 解放 */
		private function openDatabase():void {
			//trace("sqlite path : " + file.nativePath);
			Logger.log("sqlite path : " + file.nativePath);
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
				DAO.create(con, SQL_CREATE_SHAIN);
				DAO.create(con, SQL_CREATE_KINMUHYO);
				DAO.create(con, SQL_CREATE_KINMUHYO_SHOSAI);
				DAO.create(con, SQL_CREATE_JIKOKUHYO);

				DAO.insertJikokihyo(con);
			} finally {
				con.close();
			}

		}

		/** ユーザー情報保存 */
		private function saveShain():void {
			var shain:Shain = mainModel.shain;
			con = new SQLConnection();
			con.open(file);
			var isExist:Boolean = false;
			var sqlId:String;
			var params:Dictionary = new Dictionary();

			isExist = DAO.exist(con, SQL_FIND_SHAIN, shain.id);

			params[PARAMETER_NAME_ID] = shain.id;
			params[PARAMETER_NAME_PASSWORD] = shain.password;
			params[PARAMETER_NAME_SHAIN_MEI] = shain.shainMei;
			params[PARAMETER_NAME_REMEMBER_ME] = shain.rememberMe;
			params[PARAMETER_NAME_SHAIN_BANGO] = shain.shainBango;

			// 存在する場合、UPDATE
			if (isExist) {
				sqlId = SQL_UPDATE_SHAIN;
			// 存在しない場合、INSERT
			} else {
				sqlId = SQL_INSERT_SHAIN;
			}
			try {
				DAO.execute(con, sqlId, params);
			} finally {
				con.close();
			}
		}

		/** ユーザー情報削除 */
		/*
		private function removeShain(id:String):void {
			var isExist:Boolean = false;
			var params:Dictionary = new Dictionary();
			con = new SQLConnection();
			con.open(file);

			isExist = DAO.exist(con, SQL_FIND_SHAIN, id);

			try {
				if (isExist) {
					params[PARAMETER_NAME_ID] = id;
					DAO.remove(con, SQL_REMOVE_SHAIN, id);
				}
			} finally {
				con.close();
			}
		}
		*/

		/** 全申請リスト検索及び申請リストの中、最新勤務表情報取得 */
		public function findKinmuhyoListAndSaikinKinmuhyo():void {
			var saishinKinmuhyoNengetsu:String;				// 最新勤務表年月
			var kinmuhyo:Kinmuhyo;							// 勤務表
			var kinmuhyoShosai:KinmuhyoShosai;				// 勤務表詳細
			var kinmuhyoAC:ArrayCollection;					// 勤務表リスト
			var kinmuhyoShosaiAC:ArrayCollection;			// 勤務表詳細
			var kinmuhyoMapper:KinmuhyoMapper;				// 勤務表パップ
			var kinmuhyoShosaiMapper:KinmuhyoShosaiMapper;	// 勤務表詳細マップ
			var cursor:IViewCursor;							// カーソル

			con = new SQLConnection();
			con.open(file);

			try {
				// 勤務表リスト検索 ----------------------------------
				kinmuhyoAC = DAO.execute(con, SQL_FIND_KINMUHYO_LIST);
				// 申請リストが存在する場合
				if (kinmuhyoAC.length > 0) {
					cursor = kinmuhyoAC.createCursor();
					kinmuhyoModel.kinmuhyoAC.removeAll();

					var isSaishinKinmuhyo:Boolean = true;
					kinmuhyoMapper = new KinmuhyoMapper();
					for (; !cursor.afterLast; cursor.moveNext()) {
						kinmuhyo = kinmuhyoMapper.mapping(cursor.current);
						// 最近申請年月取得
						if (isSaishinKinmuhyo) {
							saishinKinmuhyoNengetsu = kinmuhyo.nengetsu;
							isSaishinKinmuhyo = false;
						}
						kinmuhyoModel.kinmuhyoAC.addItem(kinmuhyo);
					}

					// 最近勤務表取得 ------------------------------------
					var parameters:Dictionary = new Dictionary();
					parameters[PARAMETER_NAME_NENGETSU] = saishinKinmuhyoNengetsu;

					kinmuhyoMapper = new KinmuhyoMapper();
					kinmuhyoAC = DAO.execute(con, SQL_FIND_KINMUHYO_SHOSAI, parameters);
					cursor = kinmuhyoAC.createCursor();
					kinmuhyoModel.kinmuhyoAC.removeAll();

					for (; !cursor.afterLast; cursor.moveNext()) {
						kinmuhyo = kinmuhyoMapper.mapping(cursor.current);
						kinmuhyoModel.kinmuhyoAC.addItem(kinmuhyo);
					}
				}
			} finally {
				con.close();
			}
		}

		/** 勤務表年月最大値を取得 */
		private function findMaxNengetsu():void {
			con = new SQLConnection();
			con.open(file);

			try {
				var nengetsu:String = DAO.find(con, SQL_FIND_MAX_NENGETSU) as String;
				if (nengetsu != null) {
					kinmuhyoModel.shinkiKinmuhyo.nengetsu = nengetsu;
				}
			} finally {
				con.close();
			}
		}

		private function findJikokuhyo():void {
			con = new SQLConnection();
			con.open(file);
			var jikokuhyoMap:Dictionary = new Dictionary();
			try {
				var jikokuhyoAC:ArrayCollection = DAO.execute(con, SQL_FIND_JIKOKUHYO) as ArrayCollection;
				kinmuhyoModel.jikokuhyoAC = jikokuhyoAC;
				/*
				var jikokuhyoMapper:JikokuhyoMapper = new JikokuhyoMapper();
				var jikokuhyo:Jikokuhyo = new Jikokuhyo();
				var cursor:IViewCursor = jikokuhyoAC.createCursor();
				for (; !cursor.afterLast; cursor.moveNext()) {
					jikokuhyo = jikokuhyoMapper.mapping(cursor.current);
					jikokuhyoMap[jikokuhyo.jikoku] = jikokuhyo.jikokuchi;
				}

				kinmuhyoModel.jikokuhyo = jikokuhyoMap;
				*/
			} finally {
				con.close();
			}
		}

	}
}