package suite.common {

	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.utils.Dictionary;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	import suite.Constants;

	[Bindable]
	public class SQLMap {

		static private var sqlmap:Dictionary = new Dictionary();

		static private var instance:SQLMap = null;

		static public function getInstance():SQLMap {
			if (instance == null) {
				instance = new SQLMap();

				// SQL Map
				var i:int = 0;
				for each (var sqlMap:String in Constants.SQL_MAP.sql) {
			       	var key:String = Constants.SQL_MAP.sql[i].@id;
			       	var value:Object = sqlMap;
			       	//trace("sqlmap - key : " + key + ", value : " + value);
			       	sqlmap[key] = value;
			    	i++;
	            }

			}
			return instance;
		}

		static public function execute(sqlConnection:SQLConnection, id:String, parameters:Dictionary=null):ArrayCollection {
			try {
				var stmt:SQLStatement = new SQLStatement();
				stmt.sqlConnection = sqlConnection;
				stmt.text = sqlmap[id];
				if (parameters != null) {
					for (var key:Object in parameters) {
						trace("parameter : " + key + " = " + parameters[key]);
						stmt.parameters[key] = parameters[key];
					}
				}
				trace("execute : " + stmt.text);
				stmt.execute();
				return new ArrayCollection(stmt.getResult().data);
			} catch (e:Error) {
				trace(e.getStackTrace());
			} finally {
				//sqlConnection.close();
			}
			return null;
		}
	}
}