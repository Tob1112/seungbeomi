package com.chronos.air.model
{
	import flash.utils.Dictionary;

	public class KinmuhyoMapper
	{
		private static const PARAMETER_NAME_NENGETSU:String 			= ":nengetsu";
		private static const PARAMETER_NAME_SHINSEI_BANGO:String 		= ":shinseiBango";
		private static const PARAMETER_NAME_SHINSEI_KUBUN:String 		= ":shinseiKubun";
		private static const PARAMETER_NAME_SHINSEI_JYOKYO:String 		= ":shinseiJokyo";
		private static const PARAMETER_NAME_SYOTEI_NISSU:String 		= ":syoteiNissu";
		private static const PARAMETER_NAME_SAGYO_NISSU:String 			= ":sagyoNissu";
		private static const PARAMETER_NAME_KEKKIN_NISSU:String 		= ":kekkinNissu";
		private static const PARAMETER_NAME_JITSUDO_JIKAN_GOKEI:String 	= ":jitsudoJikanGokei";
		private static const PARAMETER_NAME_SAGYO_GENBA:String 			= ":sagyoGenba";


		public static function mapping(obj:Object):Kinmuhyo {
			var mapped:Kinmuhyo = new Kinmuhyo();
			mapped.nengetsu = obj.nengetsu;
			mapped.shinseiBango = obj.shinseiBango;
			mapped.shinseiKubun = obj.shinseiKubun;
			mapped.shinseiJokyo = obj.shinseiJokyo;
			mapped.syoteiNissu = obj.syoteiNissu;
			mapped.sagyoNissu = obj.sagyoNissu;
			mapped.kekkinNissu = obj.kekkinNissu;
			mapped.jitsudoJikanGokei = obj.jitsudoJikanGokei;
			mapped.sagyoGenba = obj.sagyoGenba;

			return mapped;
		}

		public static function paramMapping(obj:Kinmuhyo):Dictionary {
			var mapped:Dictionary = new Dictionary();
			mapped[PARAMETER_NAME_NENGETSU] = obj.nengetsu;
			mapped[PARAMETER_NAME_SHINSEI_KUBUN] = obj.shinseiKubun;
			(obj.shinseiBango == null) 	 ? mapped[PARAMETER_NAME_SHINSEI_BANGO] = ""      : mapped[PARAMETER_NAME_SHINSEI_BANGO] = obj.shinseiBango;
			(obj.shinseiJokyo == null)   ? mapped[PARAMETER_NAME_SHINSEI_JYOKYO] = "" 	  : mapped[PARAMETER_NAME_SHINSEI_JYOKYO] = obj.shinseiJokyo;
			(obj.syoteiNissu == 0)       ? mapped[PARAMETER_NAME_SYOTEI_NISSU] = 0  	  : mapped[PARAMETER_NAME_SYOTEI_NISSU] = obj.syoteiNissu;
			(obj.sagyoNissu == 0)        ? mapped[PARAMETER_NAME_SAGYO_NISSU] = 0  		  : mapped[PARAMETER_NAME_SAGYO_NISSU] = obj.sagyoNissu;
			(obj.kekkinNissu == 0)       ? mapped[PARAMETER_NAME_KEKKIN_NISSU] = 0 		  : mapped[PARAMETER_NAME_KEKKIN_NISSU] = obj.kekkinNissu;
			(obj.jitsudoJikanGokei == 0) ? mapped[PARAMETER_NAME_JITSUDO_JIKAN_GOKEI] = 0 : mapped[PARAMETER_NAME_JITSUDO_JIKAN_GOKEI] = obj.jitsudoJikanGokei;
			(obj.sagyoGenba == null) 	 ? mapped[PARAMETER_NAME_SAGYO_GENBA] = "" 		  : mapped[PARAMETER_NAME_SAGYO_GENBA] = obj.sagyoGenba;

			return mapped;
		}
	}
}