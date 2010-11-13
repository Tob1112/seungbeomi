package com.chronos.air.model {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.chronos.Constants;
	import com.chronos.air.common.MessageId;
	import com.chronos.air.common.Messages;
	import com.chronos.air.event.DAOEvent;

	import flash.data.SQLConnection;
	import flash.filesystem.File;
	import flash.utils.Dictionary;

	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;

	public class DAOCommand implements ICommand {

		private var file:File = File.userDirectory.resolvePath(Constants.DATABASE_FILE_PATH);
		private var appModel:ApplicationModel = ApplicationModel.getInstance();
		private var kinmuhyoModel:KinmuhyoModel = KinmuhyoModel.getInstance();
		private var dao:DAO = DAO.getInstance();
		private var con:SQLConnection;

		// SQL PREFIX
		private static const PREFIX_SHAIN:String 						= "shain.";
		private static const PREFIX_KINMUHYO:String 					= "kinmuhyo.";
		private static const PREFIX_KINMUHYO_SHOSAI:String 				= "kinmuhyoShosai.";
		private static const PREFIX_JIKOKUHYO:String	 				= "jikokuhyo.";
		private static const PREFIX_CODE:String			 				= "code.";

		// FIND SQL ID
		private static const SQL_FIND_SHAIN:String						= PREFIX_SHAIN + "findShain";
		private static const SQL_FIND_KINMUHYO_LIST:String				= PREFIX_KINMUHYO + "findKinmuhyoList";
		private static const SQL_FIND_KINMUHYO_SHOSAI:String			= PREFIX_KINMUHYO_SHOSAI + "findKinmuhyoShosai";
		private static const SQL_FIND_MAX_NENGETSU:String				= PREFIX_KINMUHYO + "findMaxNengetsu";
		private static const SQL_FIND_JIKOKUHYO:String					= PREFIX_JIKOKUHYO + "findJikokuhyo";
		private static const SQL_FIND_CODE:String						= PREFIX_CODE + "findCode";
		private static const SQL_FIND_KINMUHYO:String					= PREFIX_KINMUHYO + "findKinmuhyo";


		// INSERT SQL ID
		private static const SQL_INSERT_SHAIN:String					= PREFIX_SHAIN + "insertShain";
		private static const SQL_INSERT_KINMUHYO:String					= PREFIX_KINMUHYO + "insertKinmuhyo";
		private static const SQL_INSERT_KINMUHYO_SHOSAI:String			= PREFIX_KINMUHYO_SHOSAI + "insertKinmuhyoShosai";

		// UPDATE SQL ID
		private static const SQL_UPDATE_SHAIN:String					= PREFIX_SHAIN + "updateShain";
		private static const SQL_UPDATE_KINMUHYO:String					= PREFIX_KINMUHYO + "updateKinmuhyo";
		private static const SQL_UPDATE_KINMUHYO_SHOSAI:String			= PREFIX_KINMUHYO_SHOSAI + "updateKinmuhyoShosai";

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
				case DAOEvent.SAVE_SHAIN:	// ユーザー情報保存
					saveShain();
					break;
				case DAOEvent.FIND_KINMUHYO_LIST:	// 勤務表リスト検索
					findKinmuhyoListAndSaikinKinmuhyo();
					break;
				case DAOEvent.FIND_MAX_NENGETSU:	// 勤務表年月最大値取得
					findMaxNengetsu();
					break;
				case DAOEvent.FIND_JIKOKUHYO:	// 時刻表検索
					findJikokuhyo();
					break;
				case DAOEvent.FIND_CODE_DATA:	// コードデータ検索
					findCodeData();
					break;
				case DAOEvent.SAVE_KINMUHYO:	// 勤務表保存
					saveKinmuhyo();
					break;
				case DAOEvent.FIND_KINMUHYO_SHOSAI:	// 勤務表詳細検索
					findKinmuhyoShosai();
					break;
				default:
					Messages.showError(MessageId.NOT_FOUND_OPERATION_ERROR);
			}
		}

		/** ユーザー情報保存 */
		private function saveShain():void {
			var shain:Shain = appModel.shain;
			con = new SQLConnection();
			con.open(file);
			var sqlId:String;
			var params:Dictionary = new Dictionary();

			params[PARAMETER_NAME_ID]	= shain.id;
			var isExist:Object = DAO.find(con, SQL_FIND_SHAIN, params);

			// 存在する場合、UPDATE
			if (isExist != null) {
				sqlId = SQL_UPDATE_SHAIN;
			// 存在しない場合、INSERT
			} else {
				sqlId = SQL_INSERT_SHAIN;
			}
			try {
				params = new Dictionary();	// パラメーター初期化
				params = ShainMapper.paramMapping(shain);
				DAO.execute(con, sqlId, params);
			} finally {
				con.close();
			}
		}

		/** 全申請リスト検索及び申請リストの中、最新勤務表情報取得 */
		public function findKinmuhyoListAndSaikinKinmuhyo():void {
			findKinmuhyoList();
			findSaikinKinmuhyo();
		}

		/** 勤務表リスト検索 */
		private function findKinmuhyoList():void {
			var saishinKinmuhyoNengetsu:String;				// 最新勤務表年月
			var kinmuhyo:Kinmuhyo;							// 勤務表
			var kinmuhyoShosai:KinmuhyoShosai;				// 勤務表詳細
			var kinmuhyoAC:ArrayCollection;					// 勤務表リスト
			var kinmuhyoShosaiMapper:KinmuhyoShosaiMapper;	// 勤務表詳細マップ
			var cursor:IViewCursor;							// カーソル

			con = new SQLConnection();
			con.open(file);

			try {
				// 勤務表リスト検索 ----------------------------------
				kinmuhyoAC = DAO.execute(con, SQL_FIND_KINMUHYO_LIST) as ArrayCollection;
				// 申請リストが存在する場合:
				if (kinmuhyoAC.length > 0) {
					cursor = kinmuhyoAC.createCursor();
					kinmuhyoModel.kinmuhyoAC.removeAll();

					for (; !cursor.afterLast; cursor.moveNext()) {
						kinmuhyo = KinmuhyoMapper.mapping(cursor.current);
						kinmuhyoModel.kinmuhyoAC.addItem(kinmuhyo);
					}
				}
			} finally {
				con.close();
			}
		}

		/** 最近勤務表取得 */
		private function findSaikinKinmuhyo():void {
			var kinmuhyoShosaiAC:ArrayCollection;			// 勤務表詳細
			con = new SQLConnection();
			con.open(file);
			try {
				// 勤務表が存在する場合
				if (kinmuhyoModel.kinmuhyoAC.length != 0) {
					kinmuhyoModel.kinmuhyo = kinmuhyoModel.kinmuhyoAC.getItemAt(0) as Kinmuhyo;
					var params:Dictionary = new Dictionary();
					params[PARAMETER_NAME_NENGETSU] = kinmuhyoModel.kinmuhyo.nengetsu
					kinmuhyoShosaiAC = DAO.execute(con, SQL_FIND_KINMUHYO_SHOSAI, params) as ArrayCollection;
					kinmuhyoModel.kinmuhyoShosaiAC = kinmuhyoShosaiAC;
				}
			} catch (e:Error) {
				Messages.showError(MessageId.SQL_ERROR, e);
			} finally {
				con.close();
			}
		}

		/** 勤務表年月最大値を取得 */
		private function findMaxNengetsu():void {
			con = new SQLConnection();
			con.open(file);

			try {
				var found:Object = DAO.find(con, SQL_FIND_MAX_NENGETSU) as Object;
				var nengetsu:String = found.nengetsu;
				if (nengetsu != null) {
					kinmuhyoModel.shinkiKinmuhyo = ShinkiKinmuhyo.getInstance();	// 新規勤務表取得
					kinmuhyoModel.shinkiKinmuhyo.nengetsu = nengetsu;
				}
			} finally {
				con.close();
			}
		}

		/** 時刻表検索 */
		private function findJikokuhyo():void {
			con = new SQLConnection();
			con.open(file);
			var jikokuhyoMap:Dictionary = new Dictionary();
			try {
				var jikokuhyoAC:ArrayCollection = DAO.execute(con, SQL_FIND_JIKOKUHYO) as ArrayCollection;
				kinmuhyoModel.jikokuhyoAC = jikokuhyoAC;
			} finally {
				con.close();
			}
		}

		/** コードデータ検索 */
		private function findCodeData():void {
			con = new SQLConnection();
			con.open(file);
			try {
				var codeAC:ArrayCollection = DAO.execute(con, SQL_FIND_CODE) as ArrayCollection;
				var cursor:IViewCursor = codeAC.createCursor();
				var obj:Object;
				var codeType:String;
				var yasumiKubunAC:ArrayCollection = kinmuhyoModel.yasumiKubunAC; // 休み区分
				var prefixYasumiKubun:String = "01";

				// 格モデルのコードデータに格納
				for (; !cursor.afterLast; cursor.moveNext()) {
					obj = cursor.current;
					codeType = String(obj.code).substr(0,2);
					if (codeType == prefixYasumiKubun) {
						yasumiKubunAC.addItem(cursor.current);
					}
				}
			} finally {
				con.close();
			}
		}

		/** 勤務表保存 */
		private function saveKinmuhyo():void {
			var isPersisted:Boolean = kinmuhyoModel.isPersisted;
			var kinmuhyo:Kinmuhyo;
			var kinmuhyoShosaiAC:ArrayCollection = new ArrayCollection();
			var kinmuhyoShosai:KinmuhyoShosai;
			var kinmuhyoMapper:KinmuhyoMapper = new KinmuhyoMapper();
			var params:Dictionary;
			var isExist:Object = null;
			var saveKinmuhyoSQL:String;
			var saveKinmuhyoShosaiSQL:String;
			var kinmuhyoAC:ArrayCollection;

			// 保存されていない場合、勤務表と勤務表詳細情報の保存処理を行う。
			if (!isPersisted) {
				con = new SQLConnection();
				con.open(file);
				try {
					kinmuhyo = kinmuhyoModel.kinmuhyo;	// 勤務表
					kinmuhyoShosaiAC = kinmuhyoModel.kinmuhyoShosaiAC;	// 勤務表詳細
					params = new Dictionary();

					// 該当年月の勤務表の存在確認
					params[PARAMETER_NAME_NENGETSU] = kinmuhyo.nengetsu;
					isExist = DAO.find(con, SQL_FIND_KINMUHYO, params);

					params = new Dictionary();
					params = KinmuhyoMapper.paramMapping(kinmuhyo);

					// 存在する場合：更新 -----------------------------------------------------
					if (isExist != null) {
						saveKinmuhyoSQL = SQL_UPDATE_KINMUHYO;
						saveKinmuhyoShosaiSQL = SQL_UPDATE_KINMUHYO_SHOSAI;
					// 存在しない場合：保存  --------------------------------------------------
					} else {
						saveKinmuhyoSQL = SQL_INSERT_KINMUHYO;
						saveKinmuhyoShosaiSQL = SQL_INSERT_KINMUHYO_SHOSAI;
					}

					con.begin();	// トランザクション開始

					// 勤務表保存
					DAO.execute(con, saveKinmuhyoSQL, params);

					// 勤務表詳細保存 : TODO バッチ処理
					var cursor:IViewCursor = kinmuhyoShosaiAC.createCursor();
					for (; !cursor.afterLast; cursor.moveNext()) {
						params = new Dictionary();
						kinmuhyoShosai = KinmuhyoShosaiMapper.mapping(cursor.current);
						params = KinmuhyoShosaiMapper.parameterMapping(kinmuhyoShosai);
						DAO.execute(con, saveKinmuhyoShosaiSQL, params);
					}

					// 勤務表リスト更新
					// TODO reloadKinmuhyoList(con);
					kinmuhyoAC = DAO.execute(con, SQL_FIND_KINMUHYO_LIST) as ArrayCollection;
					// 申請リストが存在する場合:
					if (kinmuhyoAC.length > 0) {
						cursor = kinmuhyoAC.createCursor();
						kinmuhyoModel.kinmuhyoAC.removeAll();

						for (; !cursor.afterLast; cursor.moveNext()) {
							kinmuhyo = KinmuhyoMapper.mapping(cursor.current);
							kinmuhyoModel.kinmuhyoAC.addItem(kinmuhyo);
						}
					}
					Messages.showMessage(MessageId.SAVE_SUCCESS);
					// TODO kinmuhyoModel.isPersisted = true;
					con.commit();		// トランザクション終了
				} catch (e:Error) {
					con.rollback();		// ロールバック
					Messages.showError(MessageId.SQL_ERROR + e);
					trace("ロールバック: " + e.getStackTrace());
				}finally {
					con.close();
				}
			}
		}

		private function reloadKinmuhyoList(con:SQLConnection):void {
			// findKinmuhyoList();
		}

		/** 年月で勤務表詳細取得 */
		private function findKinmuhyoShosai():void {
			var kinmuhyoShosaiAC:ArrayCollection;			// 勤務表詳細
			var kinmuhyoAC:ArrayCollection;					// 勤務表ArrayCollection
			var nengetsu:String = kinmuhyoModel.nengetsu;	// 検索用勤務表年月
			con = new SQLConnection();
			con.open(file);
			try {
				var params:Dictionary = new Dictionary();
				params[PARAMETER_NAME_NENGETSU] = nengetsu;
				kinmuhyoShosaiAC = DAO.execute(con, SQL_FIND_KINMUHYO_SHOSAI, params) as ArrayCollection;
				kinmuhyoModel.kinmuhyoShosaiAC.removeAll();	// 勤務表詳細全削除
				kinmuhyoModel.kinmuhyoShosaiAC = kinmuhyoShosaiAC;

				kinmuhyoAC = DAO.execute(con, SQL_FIND_KINMUHYO, params) as ArrayCollection;
				// 勤務表が存在する場合
				if (kinmuhyoAC.length != 0) {
					kinmuhyoModel.kinmuhyo = KinmuhyoMapper.mapping(kinmuhyoAC.getItemAt(0));	// 勤務表更新
				}
			} catch (e:Error) {
				Messages.showError(MessageId.SQL_ERROR, e);
			} finally {
				con.close();
			}
		}
	}
}