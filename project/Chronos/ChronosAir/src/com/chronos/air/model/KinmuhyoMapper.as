package com.chronos.air.model {

	import flash.utils.Dictionary;

	public class KinmuhyoMapper {

		private static const PARAMETER_NAME_NENGETSU:String 			= ":nengetsu";
		private static const PARAMETER_NAME_HIZUKE:String 				= ":hizuke";
		private static const PARAMETER_NAME_YASUMI_KUBUN:String 		= ":yasumiKubun";
		private static const PARAMETER_NAME_SHIGYO_JIKAN:String 		= ":shigyoJikan";
		private static const PARAMETER_NAME_SYURYO_JIKAN:String 		= ":syuryoJikan";
		private static const PARAMETER_NAME_KYUKEI_JIKAN:String 		= ":kyukeiJikan";
		private static const PARAMETER_NAME_JITSUDO_JIKAN:String 		= ":jitsudoJikan";
		private static const PARAMETER_NAME_SAGYO_NAIYO:String			= ":sagyoNaiyo";
		private static const PARAMETER_NAME_SYOTEI_NISSU:String 		= ":syoteiNissu";
		private static const PARAMETER_NAME_SAGYO_NISSU:String 			= ":sagyoNissu";
		private static const PARAMETER_NAME_KEKKIN_NISSU:String 		= ":kekkinNissu";
		private static const PARAMETER_NAME_TOTAL_JITSUDO_JIKAN:String 	= ":totalJitsudoJikan";

		public function mapping(obj:Object):Kinmuhyo {
			var mapped:Kinmuhyo = new Kinmuhyo();
			mapped.nengetsu = obj.nengetsu;
			mapped.hizuke = obj.hizuke;
			mapped.yasumiKubun = obj.yasumiKubun;
			mapped.shigyoJikan = obj.shigyoJikan;
			mapped.syuryoJikan = obj.syuryoJikan;
			mapped.kyukeiJikan = obj.kyukeiJikan;
			mapped.jitsudoJikan = obj.jitsudoJikan;
			mapped.sagyoNaiyo = obj.sagyoNaiyo;
			mapped.syoteiNissu = obj.syoteiNissu;
			mapped.sagyoNissu = obj.sagyoNissu;
			mapped.kekkinNissu = obj.kekkinNissu;
			mapped.totalJitsudoJikan - obj.totalJitsudoJikan;

			return mapped;
		}

		public function parameterMapping(obj:Kinmuhyo):Dictionary {
			var mapped:Dictionary = new Dictionary();
			mapped[PARAMETER_NAME_NENGETSU] = obj.nengetsu;
			(obj.hizuke == null)         ? mapped[PARAMETER_NAME_HIZUKE] = "" : mapped[PARAMETER_NAME_HIZUKE] = obj.hizuke;
			(obj.yasumiKubun == null)    ? mapped[PARAMETER_NAME_HIZUKE] = "" : mapped[PARAMETER_NAME_HIZUKE] = obj.yasumiKubun;
			(obj.shigyoJikan == 0)       ? mapped[PARAMETER_NAME_HIZUKE] = 0  : mapped[PARAMETER_NAME_HIZUKE] = obj.shigyoJikan;
			(obj.syuryoJikan == 0)       ? mapped[PARAMETER_NAME_HIZUKE] = 0  : mapped[PARAMETER_NAME_HIZUKE] = obj.syuryoJikan;
			(obj.kyukeiJikan == 0)       ? mapped[PARAMETER_NAME_HIZUKE] = 0  : mapped[PARAMETER_NAME_HIZUKE] = obj.kyukeiJikan;
			(obj.jitsudoJikan == 0)      ? mapped[PARAMETER_NAME_HIZUKE] = 0  : mapped[PARAMETER_NAME_HIZUKE] = obj.jitsudoJikan;
			(obj.sagyoNaiyo == null)     ? mapped[PARAMETER_NAME_HIZUKE] = "" : mapped[PARAMETER_NAME_HIZUKE] = obj.sagyoNaiyo;
			(obj.syoteiNissu == 0)       ? mapped[PARAMETER_NAME_HIZUKE] = 0  : mapped[PARAMETER_NAME_HIZUKE] = obj.syoteiNissu;
			(obj.sagyoNissu == 0)        ? mapped[PARAMETER_NAME_HIZUKE] = 0  : mapped[PARAMETER_NAME_HIZUKE] = obj.sagyoNissu;
			(obj.kekkinNissu == 0)       ? mapped[PARAMETER_NAME_HIZUKE] = 0  : mapped[PARAMETER_NAME_HIZUKE] = obj.kekkinNissu;
			(obj.totalJitsudoJikan == 0) ? mapped[PARAMETER_NAME_HIZUKE] = 0  : mapped[PARAMETER_NAME_HIZUKE] = obj.totalJitsudoJikan;

			return mapped;
		}
	}
}