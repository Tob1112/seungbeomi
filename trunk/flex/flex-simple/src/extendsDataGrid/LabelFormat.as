package extendsDataGrid
{
	import mx.formatters.NumberFormatter;

	public class LabelFormat
	{
		public function LabelFormat()
		{
		}

		// 세자리마다 "."을 찍어준다.
		public static function moneyFormat(temp:String, precision:Number):String {
			var nf:NumberFormatter = new NumberFormatter();
			nf.useThousandsSeparator = true;
			nf.precision = precision;

			var result:String = nf.format(temp);

			if (result.charAt(0) == ".") {
				return "0" + result;
			} else if (result.substring(0,2) == "-.") {
				return "-0." + result.substring(2,result.length);
			} else {
				return result;
			}
		}

		//dayFormat 년,월,일 구분을 "-"로 설정
		public static function dayFormat(temp:String):String {
			if (temp == "null") return "";
			temp = temp.split("-").join("");
			return temp.substring(0,4) + "-" + temp.substring(4,6) + "-" + temp.substring(6,8) + temp.substring(8, temp.length);
		}
	}
}