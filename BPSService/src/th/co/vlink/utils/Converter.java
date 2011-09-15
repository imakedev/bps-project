package th.co.vlink.utils;
/**
 * @author Chatchai Pimtun
 *
 */
import java.sql.Timestamp;
import java.util.Date;

public class Converter {

	public static String DateToString(Object date){
		if(date == null){
			return null;
		}
		return ConvertDate.DateToString((Date)date);
	}
	public static Date StringToDate(Object strDate){
		if(strDate == null){
			return null;
		}
		return ConvertDate.StringToDate(strDate.toString());
	}
	public static String TimestampToString(Object time){
		if(time == null){
			return null;
		}
		return ConvertDate.TimestampToString((Timestamp)time);
	}
	public static  Timestamp StringToTimestamp(Object strDate){
		if(strDate == null){
			return null;
		}
		return ConvertDate.StringToTimestamp(strDate.toString());
	}
	
	public static Date toUtilDate(Object date){
		if(date == null){
			return null;
		}
		return ConvertDate.toUtilDate((Date)date);
	}
	
	public static String DoubleToString(Object doubleValue) {
		if(doubleValue == null){
			return null;
		}
		return NumberUtility.DoubleToString((Double)doubleValue);
	}
	public static Double StringToDouble(Object strDouble) {
		if(strDouble == null){
			return null;
		}
		return NumberUtility.StringToDouble(strDouble.toString());
	}

	public static String LongToString(Object longValue) {
		if(longValue == null){
			return null;
		}
		return NumberUtility.LongToString((Long)longValue);
	}
	public static Long StringToLong(Object strLong) {
		if(strLong == null || "".equals(strLong.toString())){
			return null;
		}
		return NumberUtility.StringToLong(strLong.toString());
	}
}
