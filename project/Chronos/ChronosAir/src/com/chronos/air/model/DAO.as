package com.chronos.air.model {
	import com.chronos.air.common.MessageId;
	import com.chronos.air.common.Messages;

	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;

	import mx.collections.ArrayCollection;

	[Bindable]
	public class DAO
	{
		private static var sqlMapConfigFile:File;
		private static var sqlMapConfig:XML;
		private static var stream:FileStream;
		private static var sqlMapFile:Array = new Array();
		private static var sqlMap:Dictionary = new Dictionary();
		private static var baseDir:File;
		private static var baseDirPath:String = "/";
		private static var sqlMapConfigFileName:String = "SqlMapConfig.xml";

		private static var instance:DAO = null;

		public static function getInstance():DAO {
			try {
				if (instance == null) {
					//baseDir = new File(baseDirPath);
					//sqlMapConfigFile = baseDir.resolvePath(sqlMapConfigFileName);
					sqlMapConfigFile = File.applicationDirectory.resolvePath(sqlMapConfigFileName);
					//trace("sqlMapConfigFile : " + sqlMapConfigFile.nativePath);
					readSqlMapConfig();
					instance = new DAO();
				}
			} catch(e:Error) {
				trace(e.message);
			}
			return instance;
		}

		public static function getQuery(sqlId:String):String {
			return sqlMap[sqlId];
		}

		// private method --------------------------------------------------------------------

		private static function readSqlMapConfig():void {
			stream = new FileStream();
			if (sqlMapConfigFile.exists) {
				stream.open(sqlMapConfigFile, FileMode.READ);
				//readSqlMapFile();
				sqlMapConfig = XML(stream.readUTFBytes(stream.bytesAvailable));
				stream.close();

				for (var i:int=0; i < sqlMapConfig.sqlMap.length() ; i++) {
					var key:String = sqlMapConfig.sqlMap[i].@resource;
					sqlMapFile[i] = key;
				}
				createSqlMap();
			}
		}

		private static function createSqlMap():void {
			var tempSqlMapFile:File;
			var tempSqlMapXML:XML;

			stream = new FileStream();

			for (var i:int=0; i < sqlMapFile.length; i++) {
				//tempSqlMapFile = baseDir.resolvePath(sqlMapFile[i]);
				tempSqlMapFile = File.applicationDirectory.resolvePath(sqlMapFile[i]);
				if (tempSqlMapFile.exists) {
					stream.open(tempSqlMapFile, FileMode.READ);
					tempSqlMapXML = XML(stream.readUTFBytes(stream.bytesAvailable));
					stream.close();

					var j:int = 0;
					for each (var sql:String in tempSqlMapXML.sql) {
						var sqlId:String = tempSqlMapXML.sql[j].@id;
						//trace ("\nsqlId : " + sqlId + "\nsql : " + sql);
						sqlMap[sqlId] = sql;
						j++;
					}
				}
			}
		}

		// ------------------------------------------------
		// テーブル生成
		public static function create(con:SQLConnection, sqlId:String):void {
			try {
				var stmt:SQLStatement = new SQLStatement();
				stmt.sqlConnection = con;
				stmt.text = sqlMap[sqlId];
				stmt.execute();
			} catch (e:Error) {
				Messages.showError(MessageId.SQL_ERROR, e);
				trace(e.getStackTrace());
			}
		}

		static public function execute(con:SQLConnection, sqlId:String, parameters:Dictionary=null):ArrayCollection {
			try {
				var stmt:SQLStatement = new SQLStatement();
				stmt.sqlConnection = con;
				stmt.text = sqlMap[sqlId];
				trace("execute - " + stmt.text);
				if (parameters != null) {
					for (var key:Object in parameters) {
						trace("parameter - " + key + " = " + parameters[key]);
						stmt.parameters[key] = parameters[key];
					}
				}
				stmt.execute();
				return new ArrayCollection(stmt.getResult().data);
			} catch (e:Error) {
				Messages.showError(MessageId.SQL_ERROR, e);
				trace(e.getStackTrace());
			} finally {
				//sqlConnection.close();
			}
			return null;
		}

		// 存在確認
		public static function exist(con:SQLConnection, sqlId:String, pk:String):Boolean {
			var found:Boolean;
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = con;

			try {
				stmt.text = sqlMap[sqlId];
				stmt.parameters[":id"] = pk;
				trace("execute - " + stmt.text);
				trace("parameter - " + pk);
				stmt.execute();
				(stmt.getResult().data == null) ? found = false: found = true;
				return found;
			} catch (e:Error) {
				Messages.showError(MessageId.SQL_ERROR, e);
				trace(e.getStackTrace());
			} finally {

			}
			return null;
		}

		// データ確認
		static public function find(sqlConnection:SQLConnection, sqlId:String, parameters:Dictionary=null):Object {
			try {
				var founds:ArrayCollection;
				var found:Object;
				var stmt:SQLStatement = new SQLStatement();
				stmt.sqlConnection = sqlConnection;
				stmt.text = sqlMap[sqlId];
				trace("execute - " + stmt.text);
				if (parameters != null) {
					for (var key:Object in parameters) {
						trace("parameter - " + key + " = " + parameters[key]);
						stmt.parameters[key] = parameters[key];
					}
				}
				trace("execute : " + stmt.text.replace(" |¥t", ""));
				stmt.execute();
				founds = new ArrayCollection(stmt.getResult().data);

				if (founds.length == 1) {
					found = founds.getItemAt(0);
				} else {
					Messages.showError(MessageId.OVER_DATA_FOUND_ERROR);
					return 0;
				}
				return found;
			} catch (e:Error) {
				Messages.showError(MessageId.SQL_ERROR, e);
				trace(e.getStackTrace());
			}
			return null;
		}

		// データ削除
		public static function remove(sqlConnection:SQLConnection, sqlId:String, pk:String):Boolean {
			try {
				var found:Boolean;
				var stmt:SQLStatement = new SQLStatement();
				stmt.sqlConnection = sqlConnection;
				stmt.text = sqlMap[sqlId];
				stmt.parameters[":id"] = pk;
				stmt.execute();
				trace("execute - " + stmt.text.replace(" |\t", ""));
				(stmt.getResult().data == null) ? found = false: found = true;
				return found;
			} catch (e:Error) {
				Messages.showError(MessageId.SQL_ERROR, e);
				trace(e.getStackTrace());
			}
			return null;
		}

		// sql idのprefixを利用し、fine sqlを生成
		private static function createSqlSupport(prefix:String, mode:String):String {
			return prefix + "." + mode + prefix.charAt(0).toUpperCase() + prefix.substr(1);
		}

		/** パラメーターからPK取得 */
		private static function getPk(parameters:Dictionary):String {
			var found:String = "";
			for (var key:Object in parameters) {
				if (key == ":id") {
					found = parameters[key];
					break;
				}
			}
			return found;
		}
	}
}