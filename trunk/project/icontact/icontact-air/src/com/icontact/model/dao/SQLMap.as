package com.icontact.model.dao {

	import com.icontact.Constants;

	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.utils.Dictionary;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

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
			       	trace("sqlmap - key : " + key + ", value : " + value);
			       	sqlmap[key] = value;
			    	i++;
	            }

			}
			return instance;
		}

		static public function exist(sqlConnection:SQLConnection, id:String, pk:int):Boolean {
			try {
				var found:Boolean;
				var stmt:SQLStatement = new SQLStatement();
				stmt.sqlConnection = sqlConnection;
				stmt.text = sqlmap[id];
				stmt.parameters[":id"] = pk;
				trace("id : " + pk);
				stmt.execute();
				trace("find : " + stmt.text.replace(" |¥t", ""));
				(stmt.getResult().data == null) ? found = false: found = true;
				return found;
			} catch (e:Error) {
				trace(e.getStackTrace());
			} finally {

			}
			return null;
		}

		static public function deleteContact(sqlConnection:SQLConnection, id:String, pk:int):Boolean {
			try {
				var found:Boolean;
				var stmt:SQLStatement = new SQLStatement();
				stmt.sqlConnection = sqlConnection;
				stmt.text = sqlmap[id];
				stmt.parameters[":id"] = pk;
				stmt.execute();
				trace("delete : " + stmt.text.replace(" |¥t", ""));
				(stmt.getResult().data == null) ? found = false: found = true;
				return found;
			} catch (e:Error) {
				trace(e.getStackTrace());
			} finally {

			}
			return null;
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
				stmt.execute();
				trace("execute : " + stmt.text.replace("¥¥t*", ""));
				return new ArrayCollection(stmt.getResult().data);
			} catch (e:Error) {
				trace(e.getStackTrace());
			} finally {
				//sqlConnection.close();
			}
			return null;
		}

		static public function find(sqlConnection:SQLConnection, id:String, parameters:Dictionary=null):Object {
			try {
				var founds:ArrayCollection;
				var found:Object;
				var stmt:SQLStatement = new SQLStatement();
				stmt.sqlConnection = sqlConnection;
				stmt.text = sqlmap[id];
				if (parameters != null) {
					for (var key:Object in parameters) {
						trace("parameter : " + key + " = " + parameters[key]);
						stmt.parameters[key] = parameters[key];
					}
				}
				trace("execute : " + stmt.text.replace(" |¥t", ""));
				stmt.execute();
				founds = new ArrayCollection(stmt.getResult().data);

				if (founds.length == 1) {
					found = founds.getItemAt(0);
				} else {
					Alert.show("複数のデータが検索されました。");
					return 0;
				}

				return found;
			} catch (e:Error) {
				trace(e.getStackTrace());
			} finally {
				//sqlConnection.close();
			}
			return null;
		}
	}
}