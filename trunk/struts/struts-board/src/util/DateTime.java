package util;

import java.util.Calendar;

/**
 * DateTime Class 사용예
 *
 *
 * <table>
 * <tr><td>올해는</td><td>DateTime.getYear()</td></tr>
 * <tr><td>이번달은		:DateTime.getMonth()</td></tr>
 * <tr><td>오늘은			:DateTime.getDay()</td></tr>
 * <tr><td>요일은			:DateTime.getDayOfWeek()</td></tr>
 * <tr><td>현재시간		:DateTime.getHour()</td></tr>
 * <tr><td>현재분			:DateTime.getMinute()</td></tr>
 * <tr><td>현재 초			:DateTime.getSecond()</td></tr>
 * <tr><td>현재 날짜		:DateTime.getDateString()</td></tr>
 * <tr><td>현재 날짜		:DateTime.getDateString(".")</td></tr>
 * <tr><td>현재 날짜		:DateTime.getDateString("/")</td></tr>
 * <tr><td>시간스트링		:DateTime.getTimeString()</td></tr>
 * <tr><td>TimeStamp		:DateTime.getTimeStampString()</td></tr>
 * <tr><td>DateTimeMin 	:DateTime.getDateTimeMin()</td></tr>
 * <tr><td>DateTimeString 	:DateTime.getDateTimeString()</td></tr>
 * <tr><td>윤년판단		:DateTime.checkEmbolism(2002)</td></tr>
 * <tr><td>일수 구하기		:DateTime.getMonthDate("2002","2")</td></tr>
 * </table>
 */

public class DateTime {

	public static String dateSep = "-";
	public static String timeSep = ":";
	public static String dateSep_1 = ".";

	private static final String[] day = {"일", "월", "화", "수", "목", "금", "토" };


	public DateTime() {}

	/**
	 *
	 * For example, String time = DateTime.getFormatString("yyyy-MM-dd HH:mm:ss");
	 *
	 * @param java.lang.String pattern  "yyyy, MM, dd, HH, mm, ss and more"
	 * @return formatted string representation of current day and time with  your pattern.
	 */
	public static int getNumberByPattern(String pattern) {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat (pattern, java.util.Locale.KOREA);
		String dateString = formatter.format(new java.util.Date());
		return Integer.parseInt(dateString);
	}



    /**
    * 현재날짜의 년도를 구하는 Method
    *
    * @param
    * @exception
    * @author
    */
	public static int getYear() { return getNumberByPattern("yyyy"); }

	/**
    * 현재날짜의 월을 구하는 Method
    *
    * @param
    * @exception
    * @author
    */
	public static int getMonth() { return getNumberByPattern("MM"); }

    /**
    * 현재날짜의 일자를 구하는 Method
    *
    * @param
    * @exception
    * @author
    */
    public static int getDay() { return getNumberByPattern("dd"); }

    /**
    * 주중 요일을 구하는 Method
    *
    * @param
    * @exception
    * @author
    */
    public static String getDayOfWeek() {
	    Calendar c = Calendar.getInstance();
	    return day[c.get(java.util.Calendar.DAY_OF_WEEK)-1];
	}

    /**
    * 현재 시각의 시간를 구하는 Method
    *
    * @param
    * @exception
    * @author
    */
    public static int getHour() {
		Calendar c = Calendar.getInstance();
		return c.get(Calendar.HOUR_OF_DAY);
	}

    /**
    * 현재 시각의 분을 구하는 Method
    *
    * @param
    * @exception
    * @author
    */
    public static int getMinute() {
	    Calendar c = Calendar.getInstance();
	    return c.get(Calendar.MINUTE);
	}

    /**
    * 현재시각의 초을 구하는 Method
    *
    * @param
    * @exception
    * @author
    */
    public static int getSecond() {
	    Calendar c = Calendar.getInstance();
	    return c.get(Calendar.SECOND);
	}

    /**
    * YYYY-MM-DD 형태의 스트링을 구하는 Method
    * @param pattern String
    * @exception
    * @author
    */
    public static String getDateString() {
    		return getYear() + "-" + getMonth() + "-" + getDay();
	}

	/**
    * YYYY-MM-DD 형태의 스트링을 Pattern에 의해 구하는 Method
    * Pattern 값에 따른 결과 반영
    * @param pattern String
    * @exception
    * @author
    */
    public static String getDateString(String pattern) {
    		return getYear() + pattern + getMonth() + pattern + getDay();
	}
    
	/**
    * HH:MI:SS 형태의 스트링을 구하는 Method
    *
    * @param
    * @exception
    * @author
    */
  	public static String getTimeString() {
	  	String hour = getHour() + "";
	    String min = getMinute() + "";
	    String sec = getSecond() + "";

	    if(hour.length() == 1) {
	      hour = "0" + hour;
	    }
	    if(min.length() == 1) {
	      min = "0" + min;
	    }
	    if(sec.length() == 1) {
	      sec = "0" + sec;
	    }

	    return hour + timeSep + min + timeSep + sec;


  	}

    /**
    * YYYY-MM-DD HH:MI:SS 형태의 스트링을 구하는 Method
    *
    * @param
    * @exception
    * @author
    */
  	public static String getTimeStampString() {
    	return getDateString("-") + " " + getTimeString();
    }

    /**
    * YYYYMMDDHHMI 형태의 스트링를 구하는 Method
    *
    * @param
    * @exception
    * @author
    */
  	public static String getDateTimeMin() {
	    String month = getMonth() + "";
	    String day = getDay() + "";
	    String hour = getHour() + "";
	    String min = getMinute() + "";

	    if(month.length() == 1) {
	      month = "0" + month;
	    }
	    if(day.length() == 1) {
	      day = "0" + day;
	    }
	    if(hour.length() == 1) {
	      hour = "0" + hour;
	    }
	    if(min.length() == 1) {
	      min = "0" + min;
	    }
	    return getYear()+""+month+""+day+""+hour+""+min;
	}

    /**
    * 년/월/일/시/분/초 스트링를 구하는 Method
    *
    * @param
    * @exception
    * @author
    */
  	public static String getDateTimeString() {
	    String month = getMonth() + "";
	    String day = getDay() + "";
	    String hour = getHour() + "";
	    String min = getMinute() + "";
	    String sec = getSecond() + "";

	    if(month.length() == 1) {
	      month = "0" + month;
	    }
	    if(day.length() == 1) {
	      day = "0" + day;
	    }
	    if(hour.length() == 1) {
	      hour = "0" + hour;
	    }
	    if(min.length() == 1) {
	      min = "0" + min;
	    }
	    if(sec.length() == 1) {
	      sec = "0" + sec;
	    }
	    return getYear()+""+month+""+day+""+hour+""+min + sec;
    }

	public static String getParseDateString(String dateTime, String pattern){
		if ( dateTime != null ){
			String year = dateTime.substring(0, 4);
			String month = dateTime.substring(4, 6);
			String day = dateTime.substring(6, 8);		
		
			return year + pattern + month + pattern + day;				
		} else {
			return "";	
		}	
	}


  	/**
   	* 주어진 년도가 윤년인지를 구하는 Method
   	*
   	* @param int year
   	* @exception
   	* @author
   	*/
  	public static boolean checkEmbolism(int year) {
	    int remain = 0;
	    int remain_1 = 0;
	    int remain_2 = 0;

	    remain = year % 4;
	    remain_1 = year % 100;
	    remain_2 = year % 400;

	    // the ramain is 0 when year is divided by 4;
	    if (remain == 0) {
	      // the ramain is 0 when year is divided by 100;
	      if (remain_1 == 0) {
	        // the remain is 0 when year is divided by 400;
	        if (remain_2 == 0) return true;
	        else return false;
	      } else  return true;
	    }
	    return false;
	  }
	   /**
	   * 주어진 년,월의 일수를 구하는 Method
	   *
	   * @param    String year, String month
	   * @exception
	   * @author
	   */
	  public static int getMonthDate(String year, String month) {
	     int [] dateMonth = new int[12];

	     dateMonth[0] = 31;
	     dateMonth[1] = 28;
	     dateMonth[2] = 31;
	     dateMonth[3] = 30;
	     dateMonth[4] = 31;
	     dateMonth[5] = 30;
	     dateMonth[6] = 31;
	     dateMonth[7] = 31;
	     dateMonth[8] = 30;
	     dateMonth[9] = 31;
	     dateMonth[10] = 30;
	     dateMonth[11] = 31;

	     if (checkEmbolism(Integer.parseInt(year))) { dateMonth[1] = 29; }

	     int day = dateMonth[Integer.parseInt(month) - 1];

	     return day;
	  }

}
