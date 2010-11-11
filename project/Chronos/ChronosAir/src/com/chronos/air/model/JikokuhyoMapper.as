package com.chronos.air.model
{
	import flash.utils.Dictionary;

	public class JikokuhyoMapper
	{
		private static const PARAMETER_NAME_JIKOKU:String 		= ":jikoku";
		private static const PARAMETER_NAME_JIKOKUCHI:String 	= ":jikokuchi";

		public static function mapping(obj:Object):Jikokuhyo {
			var mapped:Jikokuhyo = new Jikokuhyo();
			mapped.jikoku = obj.jikoku;
			mapped.jikokuchi = obj.jikokuchi;

			return mapped;
		}

		public static function paramMapping(obj:Jikokuhyo):Dictionary {
			var mapped:Dictionary = new Dictionary();
			(obj.jikoku == null) 	? mapped[PARAMETER_NAME_JIKOKU] = "" 	: mapped[PARAMETER_NAME_JIKOKU] = obj.jikoku;
			(obj.jikokuchi == 0.0) 	? mapped[PARAMETER_NAME_JIKOKUCHI] = 0.0  : mapped[PARAMETER_NAME_JIKOKUCHI] = obj.jikokuchi;

			return mapped;
		}
	}
}