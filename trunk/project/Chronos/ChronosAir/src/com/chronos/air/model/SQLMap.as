package com.chronos.air.model {
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;

	[Bindable]
	public class SQLMap
	{
		private static var sqlMapConfigFile:File;
		private static var sqlMapConfig:XML;
		private static var stream:FileStream;
		private static var sqlMapFile:Array = new Array();
		private static var sqlMap:Dictionary = new Dictionary();
		private static var baseDir:File;
		private static var baseDirPath:String = "C:/workspace/chronos/ChronosAir/src";
		private static var sqlMapConfigFileName:String = "sqlMapConfig.xml";

		private static var instance:SQLMap = null;

		public static function getInstance():SQLMap {
			if (instance == null) {
				baseDir = new File(baseDirPath);
				sqlMapConfigFile = baseDir.resolvePath(sqlMapConfigFileName);
				//trace("sqlMapConfigFile : " + sqlMapConfigFile.nativePath);
				readSqlMapConfig();
				instance = new SQLMap();
			}
			return instance;
		}

		public function getQuery(id:String):String {
			return sqlMap[id];
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
			stream = new FileStream();
			var tempSqlMapFile:File;
			var tempSqlMapXML:XML;

			for (var i:int=0; i < sqlMapFile.length; i++) {
				tempSqlMapFile = baseDir.resolvePath(sqlMapFile[i]);
				if (tempSqlMapFile.exists) {
					stream.open(tempSqlMapFile, FileMode.READ);
					tempSqlMapXML = XML(stream.readUTFBytes(stream.bytesAvailable));
					stream.close();

					var j:int = 0;
					for each (var sql:String in tempSqlMapXML.sql) {
						var id:String = tempSqlMapXML.sql[j].@id;
						//trace ("id : " + id + ", sql : " + sql);
						sqlMap[id] = sql;
						j++;
					}
				}
			}
		}
	}
}