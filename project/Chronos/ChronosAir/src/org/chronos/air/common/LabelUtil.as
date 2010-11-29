package org.chronos.air.common
{
	import org.chronos.Constants;

	public class LabelUtil
	{
		public static function nengetsuLabel(nengetsu:String):String {
			var results:Array = nengetsu.split("-");
			return results[0] + Constants.YEAR_JP + results[1] + Constants.MONTH_JP ;
		}

	}
}