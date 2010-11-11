package com.chronos.air.model {

	import flash.utils.Dictionary;

	public class KinmuhyoShosaiMapper {

		private static const PARAMETER_NAME_NENGETSU:String 			= ":nengetsu";
		private static const PARAMETER_NAME_HIZUKE:String 				= ":hizuke";
		private static const PARAMETER_NAME_YASUMI_KUBUN:String 		= ":yasumiKubun";
		private static const PARAMETER_NAME_SHIGYO_JIKAN:String 		= ":shigyoJikan";
		private static const PARAMETER_NAME_SHIGYO_JIKANCHI:String 		= ":shigyoJikanchi";
		private static const PARAMETER_NAME_SYURYO_JIKAN:String 		= ":syuryoJikan";
		private static const PARAMETER_NAME_SYURYO_JIKANCHI:String 		= ":syuryoJikanchi";
		private static const PARAMETER_NAME_KYUKEI_JIKAN:String 		= ":kyukeiJikan";
		private static const PARAMETER_NAME_JITSUDO_JIKAN:String 		= ":jitsudoJikan";
		private static const PARAMETER_NAME_SAGYO_NAIYO:String			= ":sagyoNaiyo";

		public static function mapping(obj:Object):KinmuhyoShosai {
			var mapped:KinmuhyoShosai = new KinmuhyoShosai();
			mapped.nengetsu = obj.nengetsu;
			mapped.hizuke = obj.hizuke;
			mapped.yasumiKubun = obj.yasumiKubun;
			mapped.shigyoJikan = obj.shigyoJikan;
			mapped.shigyoJikanchi = obj.shigyoJikanchi;
			mapped.syuryoJikan = obj.syuryoJikan;
			mapped.syuryoJikanchi = obj.syuryoJikanchi;
			mapped.kyukeiJikan = obj.kyukeiJikan;
			mapped.jitsudoJikan = obj.jitsudoJikan;
			mapped.sagyoNaiyo = obj.sagyoNaiyo;

			return mapped;
		}

		public static function parameterMapping(obj:KinmuhyoShosai):Dictionary {
			var mapped:Dictionary = new Dictionary();
			mapped[PARAMETER_NAME_NENGETSU] = obj.nengetsu;
			(obj.nengetsu == null)       ? mapped[PARAMETER_NAME_NENGETSU] = "" 	   : mapped[PARAMETER_NAME_NENGETSU] = obj.nengetsu;
			(obj.hizuke == null)         ? mapped[PARAMETER_NAME_HIZUKE] = "" 		   : mapped[PARAMETER_NAME_HIZUKE] = obj.hizuke;
			(obj.yasumiKubun == null)    ? mapped[PARAMETER_NAME_YASUMI_KUBUN] = ""    : mapped[PARAMETER_NAME_YASUMI_KUBUN] = obj.yasumiKubun;
			(obj.shigyoJikan == null)    ? mapped[PARAMETER_NAME_SHIGYO_JIKAN] = ""    : mapped[PARAMETER_NAME_SHIGYO_JIKAN] = obj.shigyoJikan;
			(obj.shigyoJikanchi == 0)    ? mapped[PARAMETER_NAME_SHIGYO_JIKANCHI] = 0  : mapped[PARAMETER_NAME_SHIGYO_JIKANCHI] = obj.shigyoJikanchi;
			(obj.syuryoJikan == null)    ? mapped[PARAMETER_NAME_SYURYO_JIKAN] = ""    : mapped[PARAMETER_NAME_SYURYO_JIKAN] = obj.syuryoJikan;
			(obj.syuryoJikanchi == 0)    ? mapped[PARAMETER_NAME_SYURYO_JIKANCHI] = 0  : mapped[PARAMETER_NAME_SYURYO_JIKANCHI] = obj.syuryoJikanchi;
			(obj.kyukeiJikan == 0)       ? mapped[PARAMETER_NAME_KYUKEI_JIKAN] = 0     : mapped[PARAMETER_NAME_KYUKEI_JIKAN] = obj.kyukeiJikan;
			(obj.jitsudoJikan == 0)      ? mapped[PARAMETER_NAME_JITSUDO_JIKAN] = 0    : mapped[PARAMETER_NAME_JITSUDO_JIKAN] = obj.jitsudoJikan;
			(obj.sagyoNaiyo == null)     ? mapped[PARAMETER_NAME_SAGYO_NAIYO] = "" 	   : mapped[PARAMETER_NAME_SAGYO_NAIYO] = obj.sagyoNaiyo;

			return mapped;
		}
	}
}