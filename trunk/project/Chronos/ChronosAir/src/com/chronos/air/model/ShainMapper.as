package com.chronos.air.model {

	import flash.utils.Dictionary;

	public class ShainMapper {

		private static const PARAMETER_NAME_ID:String 				= ":id";
		private static const PARAMETER_NAME_PASSWORD:String 		= ":password";
		private static const PARAMETER_NAME_SHAIN_MEI:String 		= ":shainMei";
		private static const PARAMETER_NAME_REMEMBER_ME:String 		= ":rememberMe";
		private static const PARAMETER_NAME_SHAIN_BANGO:String	= ":shainBango";

		public static function mapping(obj:Object):Shain {
			var mapped:Shain = new Shain();
			mapped.id = obj.id;
			mapped.password = obj.password;
			mapped.shainMei = obj.shainMei;
			mapped.rememberMe = obj.rememberMe;
			mapped.shainBango = obj.shainBango;

			return mapped;
		}

		public static function paramMapping(obj:Shain):Dictionary {
			var mapped:Dictionary = new Dictionary();
			(obj.id == null) 		 ? mapped[PARAMETER_NAME_ID] 		  = "" :mapped[PARAMETER_NAME_ID] = obj.id;
			(obj.password == null) 	 ? mapped[PARAMETER_NAME_PASSWORD] 	  = "" :mapped[PARAMETER_NAME_PASSWORD] = obj.password;
			(obj.shainMei == null) 	 ? mapped[PARAMETER_NAME_SHAIN_MEI]   = "" :mapped[PARAMETER_NAME_SHAIN_MEI] = obj.shainMei;
			mapped[PARAMETER_NAME_REMEMBER_ME] = obj.rememberMe;
			(obj.shainBango == null) ? mapped[PARAMETER_NAME_SHAIN_BANGO] = "" :mapped[PARAMETER_NAME_SHAIN_BANGO] = obj.shainBango;

			return mapped;
		}
	}
}