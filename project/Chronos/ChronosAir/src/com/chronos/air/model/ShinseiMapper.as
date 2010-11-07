package com.chronos.air.model
{
	import flash.utils.Dictionary;

	public class ShinseiMapper
	{
		private static const PARAMETER_NAME_NENGETSU:String 			= ":nengetsu";
		private static const PARAMETER_NAME_SHINSEI_BANGO:String 		= ":shinseiBango";
		private static const PARAMETER_NAME_SHINSEI_KUBUN:String 		= ":shinseiKubun";
		private static const PARAMETER_NAME_SHINSEI_JYOKYO:String 		= ":shinseiJokyo";

		public function mapping(obj:Object):Shinsei {
			var mapped:Shinsei = new Shinsei();
			mapped.nengetsu = obj.nengetsu;
			mapped.shinseiBango = obj.shinseiBango;
			mapped.shinseiKubun = obj.shinseiKubun;
			mapped.shinseiJokyo = obj.shinseiJokyo;

			return mapped;
		}

		public function paramMapping(obj:Shinsei):Dictionary {
			var mapped:Dictionary = new Dictionary();
			mapped[PARAMETER_NAME_NENGETSU] = obj.nengetsu;
			mapped[PARAMETER_NAME_SHINSEI_KUBUN] = obj.shinseiKubun;
			(obj.shinseiBango == null) ?
				mapped[PARAMETER_NAME_SHINSEI_BANGO] = "" :
				mapped[PARAMETER_NAME_SHINSEI_BANGO] = obj.shinseiBango;
			(obj.shinseiJokyo == null) ?
				mapped[PARAMETER_NAME_SHINSEI_JYOKYO] = "" :
				mapped[PARAMETER_NAME_SHINSEI_JYOKYO] = obj.shinseiJokyo;

			return mapped;
		}
	}
}