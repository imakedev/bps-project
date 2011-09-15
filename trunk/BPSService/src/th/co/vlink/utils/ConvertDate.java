package th.co.vlink.utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
/**
 * @author Chatchai Pimtun
 *
 */
public class ConvertDate {

	private static final Locale thaiLocale = new Locale("th","TH");
	private static final Locale usLocale = new Locale("us","US");
	private static final String DateFormat  = "dd/MM/yyyy";
	private static final String TimestampFormat  = "dd/MM/yyyy HH:mm:ss.S";

	public static void calDate(){
		/*DateTimeFormatter fmt = DateTimeFormat.forPattern("dd/MM/yyyy"); 
		DateTime dt1 = fmt.parseDateTime(startDate);
		DateTime dt2 = fmt.parseDateTime(stopDate);*/
	}
	public static String DateToString(Date date){
		if (date == null)
		{
			return "";
		}
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DateFormat,usLocale);
		return simpleDateFormat.format(date);
	}
	
	public static Date StringToDate(String strDate){
		Date date = null;
		try {
			if (strDate == null || strDate.trim().equals(""))
			{	
				date = null;
			}else{
			 date = new SimpleDateFormat(DateFormat, usLocale).parse(strDate);
			}
	    } catch (Exception e) {
	    	date = null;
	    }
		
		return date;
	}
	
	public static Timestamp StringToTimestamp(String strDate){
		Date date = null;
		Timestamp timeStampDate = null;
		try {
			if (strDate == null || strDate.trim().equals(""))
			{	
				date = null;
			}else{
			 date = new SimpleDateFormat(TimestampFormat, usLocale).parse(strDate);
			 timeStampDate = new Timestamp(date.getTime());
			 
			}
	    } catch (Exception e) {
	    	date = null;
	    }
		
		return timeStampDate;
	}
	public static String TimestampToString(Timestamp date){
		if (date == null)
		{
			return "";
		}
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(TimestampFormat,usLocale);
		return simpleDateFormat.format(date);
	}
	
	public static Date toUtilDate(Date date){
		if(date != null){
			date = new Date(date.getTime());
		}
		return date;
	}
}
