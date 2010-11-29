package org.chronos.air.model {
	import org.chronos.air.common.MessageId;
	import org.chronos.air.common.Messages;
	import org.chronos.air.util.Logger;

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
				throw new Error(e.message);
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
						//Logger.debug ("\nsqlId : " + sqlId + "\nsql : " + sql);
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
				throw new Error(e.getStackTrace());
			}
		}

		static public function execute(con:SQLConnection, sqlId:String, parameters:Dictionary=null):Object {
			try {
				var stmt:SQLStatement = new SQLStatement();
				stmt.sqlConnection = con;
				stmt.text = sqlMap[sqlId];
				Logger.log("execute - " + stmt.text);
				if (parameters != null) {
					for (var key:Object in parameters) {
						Logger.log("parameter - " + key + " = '" + parameters[key] + "'");
						stmt.parameters[key] = parameters[key];
					}
				}
				stmt.execute();
				return new ArrayCollection(stmt.getResult().data);
			} catch (e:Error) {
				Messages.showError(MessageId.SQL_ERROR, e);
				throw new Error(e.getStackTrace());
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
				Logger.log("execute - " + stmt.text);
				Logger.log("parameter - '" + pk + "'");
				stmt.execute();
				(stmt.getResult().data == null) ? found = false: found = true;
				return found;
			} catch (e:Error) {
				Messages.showError(MessageId.SQL_ERROR, e);
				throw new Error(e.getStackTrace());
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
				Logger.log("execute - " + stmt.text);
				if (parameters != null) {
					for (var key:Object in parameters) {
						Logger.log("parameter - " + key + " = '" + parameters[key] + "'");
						stmt.parameters[key] = parameters[key];
					}
				}
				stmt.execute();
				founds = new ArrayCollection(stmt.getResult().data);

				if (founds.length == 1) {
					found = founds.getItemAt(0);
				} else {
					//Messages.showError(MessageId.OVER_DATA_FOUND_ERROR);
					return null;
				}
				return found;
			} catch (e:Error) {
				Messages.showError(MessageId.SQL_ERROR, e);
				throw new Error(e.getStackTrace());
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
				Logger.log("execute - " + stmt.text.replace(" |\t", ""));
				(stmt.getResult().data == null) ? found = false: found = true;
				return found;
			} catch (e:Error) {
				Messages.showError(MessageId.SQL_ERROR, e);
				throw new Error(e.getStackTrace());
			}
			return null;
		}

	}
}